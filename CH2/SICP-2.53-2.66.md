####练习2.53
这个题目没什么好说的，比较基础。
```
> (list 'a 'b 'c)
'(a b c)
> (list (list 'george))
'((george))
> (cdr '((x1 x2) (x3 x4)))
'((x3 x4))
> (cadr '((x1 x2) (x3 x4)))
'(x3 x4)
> (pair? (car '(a short list)))
#f
> (memq 'red '((red shoes) (blue socks)))
#f
> (memq 'red '(red shoes blue socks))
'(red shoes blue socks)
```
####练习2.54
equal?计算两个列表是否相等。
首先给出退出条件，当两个列表中有一个是空表时，用eq?判断两个列表是否相等，如果都是空表，则返回#t,如果有一个表非空表，则返回#f

递归分2种，两个比较的元素为符号，这时候用eq?测量是否相等，如果相等则递归处理(cdr lst)，如果不等，那么两个列表不同，直接返回#f.
另一种情况两个元素为列表，这时候用equal?测量是否相等，如果相等则递归处理(cdr lst)，如果不等，那么两个列表不同，直接返回#f.

其他情况直接返回#f.

####练习2.55
单引号是quote的语法糖，'a相当与(quote a)
```
> (quote a)
'a
```
再在前面加上一个引号，相当与保留这个列表。
```
> '(quote a)
''a
```
所以(car ''a)等价于(car '(quote a)) = (car (list 'quote 'a))='quote
```
> (car ''a)
'quote
```
####练习2.56
这个就是按照书上的提示来写。

####练习2.57
要扩充到任意多个和数和乘数。
根据书上的提示，要将多个和数看成2部分，第一个和数和剩下的和数。
例如：
```racket
(+ 1 2 3)
```
可以分解为
```racket
(+ 1 (+ 2 3))
```
求导的时候，先对第一个和数求导，然后对剩下的和数之和求导。所以获取剩下的和数可以这样：
```racket
(define (augend exp) 
  (if (null? (cdddr exp))	;;如果不存在第三个和数
      (caddr exp)		;;直接返回第二个和数。
      (cons '+ (cddr exp))))	;;把从2个开始的和数全部放到另一个加法表达式中。
```
乘法也是类似。
```racket
(define (multiplicand exp) 
  (if (null? (cdddr exp))
      (caddr exp)
      (cons '* (cddr exp))))
```
####练习2.58
a）
由于求导规则不变。只要改动选择函数 构造函数 判断函数。
由于只有2个参数，所以简化了不少。
sum?函数用于判断表达式是否是加法，由于+放在中间，需要改变成如下：
```racket
(define (sum? exp) (and (pair? exp) (eq? (cadr exp) '+)))
```
加法的构造函数和选择函数也必须改变：
```racket
(define (make-sum x y) 
  (cond ((and (number? x) (number? y)) (+ x y))
        ((number=? x 0) y)
        ((number=? y 0) x)
        (else (list x '+ y))))		;;变成中缀，+放中间

(define (addend exp) (car exp))		;;加数在表达式最前面
(define (augend exp) (caddr exp))	;;被加数不变
```
乘法也要做相应改动：
```racket
(define (product? exp) (and (pair? exp) (eq? (cadr exp) '*))) 	;;*放中间

(define (make-product x y) 
  (cond ((and (number? x) (number? y)) (* x y))
        ((or (number=? x 0) (number=? y 0)) 0)
        ((number=? x 1) y)
        ((number=? y 1) x)
        (else (list x '* y))))					;;变成中缀形式

(define (multiplier exp) (car exp))				;;乘数在表达式最前面
(define (multiplicand exp) (caddr exp))
```
b）如果换成多个和数、乘数，并且利用乘法优先级高于加法，不用括号。其实也能做。

以题目中给出的表达式来看
(x + 3 * (x + y + 3))
x是addend，后面的3 * (x + y + 3)就是augend。

乘法类似，如果是
(x * y * z)
那么x是multiplier, (y * z)是multipliand.

所以通过改动构造函数和选择函数可以做到，对于多个和数和乘数的处理，可以参考2.57

这里还有一个瑕疵，因为对构造函数没有改动，所以对多个项目的和(或者乘)，得到的结果又变成2个参数了
```
> (deriv '((x * x) + x * 3 + x * y) 'x)
'((x + x) + ((x * y) + (3 + x * y)))
```
这个例子可以看到，本来是3个和数，但是结果变成1个加上2个的和了。

（这个例子又一次表现出抽象的力量，只要有构造函数和选择函数，其实就不用在意底层用了哪种数据结构）

####练习2.59

####练习2.60
element-of-set?效率变低了。

adjoin-set效率更高，直接额把元素加到集合就行。

union效率更高，只要把两个列表合并就行。

intersection求集合的交集复杂了，因为有重复的元素，直接比较会出错。例如：
```
> (intersection-set '(1 2 2 3) '(1 4 2 1 5))
'(1 2 2)
> (intersection-set '(1 4 2 1 5) '(1 2 2 3))
'(1 2 1)
```
交换了两个集合后，结果不一样，这是错的。

为了解决这个问题，应该在比较后删除已经比较的元素。
```racket
(define (remove-ele s ele)
  (define (ite pre set)
    (cond ((null? set) pre)
          ((equal? ele (car set))
           (ite pre (cdr set)))
          (else (ite (append pre (list (car set))) (cdr set)))))
  (ite '() s))

(define (intersection-set s1 s2)
  (cond ((or (null? s1) (null? s2)) '())
        ((element-of-set? (car s1) s2)
         (cons (car s1) (intersection-set (cdr s1) (remove-ele s2 (car s1)))))	;;删除已经加入并集的元素
        (else (intersection-set (cdr s1) s2))))
```
####练习2.61
插入的元素x，按照随机来看，平均的插入步数是set长度的一半。
```racket
(define (adjoin-set x set)
  (cond ((null? set) (list x))					;;set为空集合，则返回x的集合。
        ((< x (car set)) (cons x set))				;;如果x比car set小，那么把x放入集合的前面
        ((= x (car set)) set)					;;如果重复，则不放入set
        (else (cons (car set) (adjoin-set x (cdr set))))))	;;更大，则放到cdr set中去
```
####练习2.62
求集合的并集也可以利用排序：
```racket
(define (union-set s1 s2)
  (cond ((null? s1) s2)
        ((null? s2) s1)
        ((< (car s1) (car s2)) (cons (car s1) (union-set (cdr s1) s2)))
        ((= (car s1) (car s2)) (cons (car s1) (union-set (cdr s1) (cdr s2))))
        (else (cons (car s2) (union-set s1 (cdr s2))))))
```
####练习2.63
这个题目问两种方法会不会产生不同的结果，但是从我看来，以及代码运行的结果，都是一样的。
a）结果一样
b）我怎么感觉步数也是一样的，唯一的区别就是tree->list1可以并行计算，在这种情况下实际计算时间可以减少。

####练习2.64
a)
(partial-tree eles n) 能计算出eles列表的前n个元素的(cons 平衡2叉树。剩下的)

为了得到整个平衡2叉树，可以分别计算出左平衡2叉树，右平衡2叉树，然后跟根entry生成一个树。

例如，对于10长度的有序列表，
(partial-tree eles 10)
可以得到
(cons left-tree rem)
left-tree是eles前4个元素组成的平衡2叉树。

而(car rem)就是树的entry

然后对(cdr rem)使用partial-tree,可以得到右平衡2叉树。
(partial-tree (cdr rem) 5)

b)
以o(n)增长，我猜！

####练习2.65
这个题目没想到什么好的方法，只好用最粗暴的方法了。
先求出交集和并集，然后转化成列表，再转化成平衡2叉树。
但是这么做不能满足o(n)的要求。

####练习2.66
这个又不好搞了，这里只好随便写了一个不完整的。
