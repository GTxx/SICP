####练习2.24
结果是一个列表：(1 (2 (3 4)))
```
> (list 1 (list 2 (list 3 4)))
'(1 (2 (3 4)))
```
####练习2.25
```
> (car (cdr (car (cdr (cdr '(1 3 (5 7) 9))))))
7
> (car (car '((7))))
7
> (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr '(1 (2 (3 (4 (5 (6 7))))))))))))))))))
7
```
####练习2.26
```
> (define x (list 1 2 3))
> (define y (list 4 5 6))
> (append x y)
'(1 2 3 4 5 6)
> (cons x y)
'((1 2 3) 4 5 6)
> (list x y)
'((1 2 3) (4 5 6))
```
####练习2.27
需要反转所有的元素，包括子列表中的元素。

列表由car和cdr两部分组成，如果对car和cdr都做反转，然后再(append cdr car),就可以得到结果了。

递归的退出条件是处理非列表元素，这时候直接返回自身即可。
```racket
(define (reverse lst)
  (cond ((not (pair? lst)) lst)		;;如果不是列表，就直接返回
        (else (append (reverse (cdr lst)) (list (reverse (car lst)))))))	;;如果是列表，就返回cdr和car逆序后的拼接
```
还有一个比较有意思的地方，空表并不被认为是pair，所以在处理到最后一个cdr，肯定是'(),这时候就直接返回自身了：
```
> (pair? '())
#f
```
####练习2.28
这个还是要对car和cdr都做递归处理。
```racket
(define (fringe lst)
  (cond ((null? lst) lst)					;;
        ((not (pair? lst)) (list lst))				;;如果不是列表，并且也不是null返回包含这个单元素的列表。
        (else (append (fringe (car lst)) (fringe (cdr lst))))))	;;把car和cdr的处理结果拼接起来
```
这个函数的一个问题在于对null节点没法处理。
例如:
```
> (fringe '((1 2) () (3) ()))
'(1 2 3)
```
fringe函数把里面的空表'()都去掉了。这是因为append对空表的处理方式就是去掉了。

####练习2.29
这个题目又体现除了分层设计的思想优点。底层函数更改，只要修改构造和提取函数就行了。

d）如果改成cons，那么只要修改 right-branch  branch-structure就行：
```racket
(define (right-branch mobile)
  (cdr mobile)))

(define (branch-structure branch)
  (cdr branch))
```
分层如下：

* balance?

* total-weight

* make-mobile make-branch (构造函数)left-branch right-branch branch-length branch-structure（提取函数）

* cons list

####练习2.30
直接定义square-tree,可以参考前面的scale-tree。当然还是map方式最好，很多地方不用反复考虑。

这里值的一提的是，跟2.27的对比，2.27是要求tree的反树，就是说
((1 2) (3 4))变成((4 3) (2 1))

```racket
(define (reverse lst)
  (cond ((null? lst) '()) 
        ((not (pair? lst)) lst)
        (else (append (reverse (cdr lst)) (list (reverse (car lst)))))))
```
注意最后一行代码，用了append去组合两个递归返回的结果，但是square-tree和scale-tree用的是cons。
这是为什么呢？
因为当(cons lst atom)得到的是这么个结果(lst . atom)，这是一个序对，不是一个列表，例如:
'((1 2) . 3)

反过来(cons lst atom)，得到的是(atom lst),这就是一个列表了，例如：
```
> (cons 3 '(1 2) )
'(3 1 2)
```

可见cons计算并不是可交换的。所以今后在写代码时，注意cons的使用，如果是正常顺序组装，可以用cons，如果是反过来组装，用append，形式如下：
(apppend lst (list atom))

例如
```
> (append '(1 2) (list 3))
'(1 2 3)
```

####练习2.31
这里的处理函数只能接收一个变量。
```racket
(define (square-tree tr) (tree-map (lambda (x) (* x x)) tr))
```
####练习2.32
求序列的子集合。
(a b c...)的子集合可以划分为包含a的集合，和不包含a的集合。
所以最后一行应该是
```racket
(append rest (map (lambda (sub-rest) (cons (car s) sub-rest)) rest))
```
