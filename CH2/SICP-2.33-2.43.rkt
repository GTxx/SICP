练习2.33
注意到accumulate中op的计算形式
(op (car sequence)
          (accumulate op initial (cdr sequence)))))

op接收两个参数，一个是序列头，一个是递归结果。所以在用accumulate重新定义map append length时，要注意对序列头的处理。

例如，用accumulate定义map时，应该用p对序列头做处理，然后跟递归结果拼接成一个序列。
(define (map p sequence)
  (accumulate (lambda (x y) (cons (p x)			;;用p处理序列头x，然后跟递归结果y拼接。
                                  y)) null sequence))

我这边里还翻了一个错误，在append和length函数中，我都对x做了一次判断是否为null，其实没必要，因为accumulate已经对序列做了一次是否为null的判断，所以x不可能是null，判断这里没有任何意义。

练习2.34

练习2.35
这里为什么要加上一个map，不加map也是可以算出来的:
(define (count-leave t)
  (accumulate (lambda (x y)
                (cond ((null? x) y)			;;如果序列头为空，则结果是递归结果，如果这一行去掉，则会把空表也当作一个叶子
                      ((not (pair? x)) (+ 1 y)) 	;;如果是单元素，则加1
                      (else (+ (count-leave x) y))))	;;如果序列头也是序列，则对其做计算count-leave
              0
              t))

既然题目里有map，那先用map求出各个子树的节点数，然后相加：
(define (count-leave-map t)
  (accumulate +
              0
              (map (lambda (sub-t)
                     (if (not (pair? sub-t))
                         1
                         (count-leave-map sub-t))) t)))

不过这样完全不符合信号流的结构，因为accumulate调用了count-leave-map。可能还有更符合信号流的

练习2.36

练习2.37

练习2.38
这里的fold-left用了迭代方式，但是fold-right（accumulate）不太好用迭代方式，因为accumulate是左边的元素对右边所有元素做操作，所以如果要写成迭代方式，既要先把前面的元素全部存下来。

而且fold-left可以直接写成迭代方式，书上的有点弄的拐弯抹角。
(define (fold-left1 op initial sequence)
  (if (null? sequence)
      initial
      (fold-left1 op (op initial (car sequence)) (cdr sequence))))

这几个表达是的值是：
(fold-left / 1 (list 1 2 3))		;; (/ (/ (/ 1 1) 2) 3) 
1/6

(fold-right / 1 (list 1 2 3))		;;(/ 1 (/ 2 (/ 3 1)))
3/2

(fold-left list null (list 1 2 3))	;;(list (list (list null 1) 2) 3)
'(((() 1) 2) 3)

(fold-right list null (list 1 2 3))	;;(list 1 (list 2 (list 3 null)))
'(1 (2 (3 ())))

这个练习提还问了op怎么才能使得fold-left fold-right结果一样，应该是op的两个数可以交换才行。(op a b)==(op b a)，例如乘法.

练习2.39
fold-left是把结果跟左边元素计算，然后再递归，要反过来，只需要cons右边结果和左边结果
(define (reverse1 seq)
  (fold-left (lambda (x y) (cons y x)) null seq))

fold-left是把结果跟左边元素跟右边的结果计算，所以只需要把右边算好的reverse结果跟左边值用append连起来
(define (reverse2 seq)
  (fold-right (lambda (x y) (append y (list x))) null seq))

练习2.40
unique-pairs跟书中的没什么区别，可以直接拿flat-map实现：
(define (unique-pairs n)
  (flatmap (lambda (x) 
             (map (lambda (y) (cons y x))		;; 
                  (enumerate-interval 1 (- x 1)))) 	;;
           (enumerate-interval 1 n)))

练习2.41
这个问题跟2.40类似，可以先 生成 3个的序列，然后在用过滤器得到所有满足条件的序列。

举个例子，对于n=4，生成的三个数字的序列如下：
> (unique-thri 4)
'((1 2 3) (1 2 4) (1 3 4) (2 3 4))

生成3个序列的序列，可以复用前面的unique-pairs，可以先生成序对，(i j),然后对每个序列，找出所有的k<i,然后组合到(i j)上。
并且注意到，找k也可以用unique-pairs找.

(unique i)可以生成所有满足条件的(k i),然后组合(k i) (i j),可以这样：
(cons (car (i j)) '(i j))

所以函数如下：
(define (unique-thri n)
  (flatmap (lambda (i)					;; 
             (map (lambda (k) (cons (car k) i)) 	;;组合成三元素序列
                  (unique-pairs (car i)))) 		;;生成小于i的2元素序列
           (unique-pairs n)))				;;先生成所有满足条件的2元素

练习2.42
要把没有定义的部分补充完整，有3处：
empty-board
(safe? k position)
(adjoin-position new-row k rest-of-queens)

首先，因为flatmap的处理对象是序列，所以可以判断(queen-cols (- k 1))肯定是一个序列的形式，并且序列中每个元素存储的是一个k-1列的有效皇后位置。
然后，当k=0的时候，(queen-cols 0)是(list empty-board),这里也可以看到(queen-cols k)确实是列表形式，这里可以自己构造一下(queen-cols k)的形式，可以用列表的形式存储每个有效的皇后位置，例如：
(queen-cols 0)=(list ())

(queen-cols 1)=(list '(1) '(2) '(3) ... (8))

所以empty-board就是'()。

根据(queen-cols k)的这个形式,(adjoin-position new-row k rest-of-queens)就是在列表上加上new-row。最简单的方式，用列表承载皇后的位置，例如第一列皇后位于第2行，第二列皇后位于第4行，那么就是(4 2)，第三列皇后位于第3行，就是(3 4 2).
(define (adjoin-position new-row k rest-of-queens)
  (cons new-row rest-of-queens))

(define empty-board '())

(define empty-board '())

safe?其实就是检查横向，左上 左下是否跟已经放置好的皇后重复，safe?函数如下：
(define (safe? k position)
  (define (safe-row? row)
    (null? (filter (lambda (x) (= x row)) (cdr position)))) ;;there is queen in the same row
  
  (define (safe-up-left? row col pos)
    (cond ((or (<= row 0) (<= col 0)) #t)
          ((= row (car pos)) #f) ;;queen in the same row and same col
          (else (safe-up-left? (- row 1) (- col 1) (cdr pos)))))
  
  (define (safe-down-left? row col pos)
    (cond ((or (> row 8) (<= col 0)) #t)
          ((= row (car pos)) #f)
          (else (safe-down-left? (+ row 1) (- col 1) (cdr pos)))))
  
  (and (safe-row? (car position)) 
       (safe-up-left? (- (car position) 1) (- k 1) (cdr position))		;;注意要从前一列开始判断(k-1)
       (safe-down-left? (+ (car position) 1) (- k 1) (cdr position))))

我感觉这个题目一点信息也不给我，让我单独做，我肯定一时半会搞不出来。

练习2.43
之所以时间长，是因为每次对(enumerate-interval 1 board-size)做flatmap，都要重新计算一次(queen-cols (- k 1))。

2.42中的代码，计算(queen-cols 8)需要计算1次(queen-cols 7)，依次类推，只要分别计算1次(queen-cols 8)...(queen-cols 1) (queen-cols 0)就行了

但是嵌套顺序颠倒后，当board-size等于8，需要的计算8次(queen-cols 7)。

每次(queen-cols 7)又需要计算8次(queen-col 6)，依次类推，计算量成8的指数倍增长。
