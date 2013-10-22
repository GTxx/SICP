####练习1.1
```racket
> 10
10
> (+ 5 3 4)
12
> (- 9 1)
8
> (/ 6 2)
3
> (+ (* 2 4) (- 4 6))
6
> (define a 3)
> (define b (+ a 1))
> (+ a b (* a b))
19
> (= a b)
#f
> (if (and (> b a) (< b (* a b)))
a
b)
3
> (cond ((= a 4) 6)
((= b 4) (+ 6 7 a))
(else 25))
16
> (+ 2 (if (> b a) b a))
6
> (* (cond ((> a b) a)
((< a b) b)
(else -1))
(+ a 1))
16
```
这里面涉及到了真假。
Scheme里面有专门的false，这个跟CLISP不一样，CLISP里没有专门的false，直接用'()和nil表示假和空表；而scheme用#f表示假，空表则是'() null
表达式：
(eq? null '())
在scheme下的值为
#t
表达式
(eq nil '())
在clisp下的值为
T
这个表达式：
(if '()  1 0)
在scheme下的值是1，但是在clisp中的值是0.

####练习1.2
```racket
(/ (+ 5 4 (- 2 (- 3 (+ 6 4/5))))
   (* 3 (- 6 2) (- 2 7)))
```
####练习1.3
```racket
(define (bigger2 a b c)
  (if (<= a b)
    (if (<= a c) (+ b c)
        (+ a b))
    (if (<= b c) (+ a c)
        (+ a b ))))
```
####练习1.4
```racket
(define (fn a b)
  ((if (> b 0) + -) a b ))
```
这个函数根据b的正负返回加法+和减法-，在CLISP中，也可以这么干，但是必须显式地把函数指出来。在CLISP下，函数如下：
```racket
(defun fn (a b) (funcall (if (> b 0) #'+ #'-) a b))
```
对函数的返回必须在前面加上#‘，调用的使用，必须使用funcall调用#’+ 或#‘-

####练习1.5

 这个题目是判断解释器在采用应用序和正则序时，对同一个表达是会产生什么结果。

两个过程分别是：
```racket
(define (p) (p))
(define (test x y)
  (if (= x 0)
  0
  y))
```
第一个过程p是一个递归过程，p调用了自身，而且没有设置退出条件，所以一旦递归，就会不停地递归。

第二个过程test，当x为0，则返回0，否则返回y。

求值的表达式为：
```racket
> (test 0 (p))
```
如果是应用序，会先对整个表达式的所有元素求值，因为(P)会陷入死循环，那这个表达式也在等待(p)调用结束，所以也挂死了。

如果是正则序，因为不需要先计算(p)，所以结果是0.

稍微扩展一点，LISP中还有一些特殊形式，不管是应用序，也不需要对所有的元素求值。

这些特殊形式包括cond if or and。

如果是直接对test过程的内部表达式求值，是可以得到结果的。
```racket
> (if (= 0 0)
     0
     (p))
0
```
结果就是0，说明解释器没有对(p)求值。

另外的or and也很好理解，跟其他语言的or and一样，利用这种从前到后的求值顺序，可以构造短路特性。

####练习1.6
```racket
(define (new-if pre then els)
  (cond (pre then)
            (else els)))
(define (sqrt-iter guess x)
    (new-if (> guess x)
                guess
                (sqrt-iter (+ guess 1) x)))
```
这个还是scheme的应用序，如果用自己定义的过程，scheme解释器会直接对所有元素求值，这样不管条件是否成立，都会对sqrt-iter求值。而且因为没法退出，这个表达式将不停求值，永远得不到结果。并且这个还要不停创建过程，所以会耗尽所有存储空间。

####练习1.7

对于很小的数，如果开根号就已经比0.001小，误差会比较大，假设正确的解为x，那么设计的解在(x-0.001,x+0.001)之间。

对于比较大的数，因为scheme有一定的计算精度限制，当0.001相比正确解很小时，scheme的计算精度和0.001是一个量级的，就会出现永远也到不了0.001，陷入无穷调用。

改成前后两个值比较，可以解决大数的问题，但是解决不了小数的问题。

####练习1.8

写一个用牛顿法求立方根的函数。

这个跟求平方根的差不多，不过这里提到了库诶用1.3.4的技术写一个通用的牛顿法，这个要用到高阶函数。到了后面再说吧！

####练习1.9

在递归上，scheme跟一些语言不一样，当在尾递归时，scheme消耗的存储空间跟调用的函数次数不成正比。

以这个题目的两个过程（函数）为例。
```racket
(define (+ a b)
  (if (= a 0)
      b
      (inc (+ (dec a) b))))

(define (+ a b)
  (if (= a 0)
      a
      (+ (dec a) (inc b))))
```
这里有3点，1、scheme可以重新定义函数，包括内置的+函数也能重新定义，2、第二个+函数是迭代的，虽然调用了自己，但是整个状态是可以完全由+ 的两个参数传递，所以解释器只需要维护两个参数，不许要记录下以前的调用状态。3、dec和inc函数在racket里是没有的。

####练习1.10
```racket
#lang racket
(define (a x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (a (- x 1)
                 (a x (- y 1))))))
```
(f n)是2*n

(g n)；当n=0， g(0)=0，当n>0 ,g(n)=2^n

(h n)是2的n-1个2的指数，(h 0)=0, (h 1)=2^0=1, h(2) = 2^2=4, h(3)=2^2^2=16 

 