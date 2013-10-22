####练习2.1
把`make-rat`改成这样就行：
```racket
(define (make-rat n d)
  (let ((g (gcd n d)))
    (let ((n1 (/ n g))
          (d1 (/ d g)))
      (if (negative? d1)
          (cons (- n1) (- d1))
          (cons n1 d1)))))
```
Racket里面自带了gcd，节省了自己写的时间。  
而且这里还有一个比较有意思的地方，如果分子是0，分母不为0，那么gcd求出来的是分母，所以最后化简得到的是0/1。  
为了显示有理数，用到了`display`函数，`display`可以打印字符串，racket还提供了`print`函数，`print`则会把打印对象打印出来。 
```racket
(display "/")
```
打印出来的就是``/``
但是
```racket
(print "/")
```
打印出来的是`"/"`

我写的`make-rat`还有个问题，分母可以是0，这个是完全能构造出来的，而且还能参与计算。算是一个漏洞吧！  

####练习2.2
这个问题可以分为4层，如下：

1. midpoint-segment

2. make-segment start-segment end-segment

3. make-point x-point y-point  

4. cons car cdr

第4层是基础的函数，由racket给出。

第3层是point的构造函数和选择函数，用到了第4层的函数。

第2曾是segment的构造函数和选择函数，用到了第3 4曾的函数。

第1层是segment的操作函数，用到了第2 3层的函数。

####练习2.3
要写一个矩形的表示，需要用到练习2.2的成果，Racket有这种机制了。
首先在SICP-2.02.rkt中加入：
```racket
(provide make-point x-point y-point 
         make-segment start-segment end-segment)
```
这样就将上面的函数导出了。

然后在SICP-2.02.rkt加入：
```racket
(require "SICP-2.02.rkt")
```
就可以引用SICP-2.02.rkt中写好的函数了。

这个题目还要求用2种方式表示矩形，我就偷个懒吧，只写一种表示形式，用矩形的两条有向边描述矩形，
```racket
(define (make-rect s1 s2)		;;用有向边组成矩形
  (cons s1 s2))

(define (w-rect rect) (car rect))	;;提取第一条边

(define (h-rect rect) (cdr rect))	;;提取第二条边
```

####练习2.4
这个题目突破了以往的认识，用函数（过程）也能表示数据结构。
```racket
(define (cons x y)
  (lambda (m) (m x y)))

(define (car z)
  (z (lambda (p q) p)))

(define (cdr z)
  (z (lambda (p q) q)))
```
`cons`函数将两个变量放进了一个匿名函数中，为了取出`x`和`y`，需要调用函数`m`。

car函数把m替换成函数
```racket 
(lambda (p q) p)
```
这个匿名函数接收两个参数p q，并返回p，所以car作用于`(cons x y)`,可以返回x。  
利用1.1.5的替换模型，也可以很容易看出来为什么car能提取出x。
```racket
(car (cons 1 2))				                  ;; 利用car提取(cons 1 2)的前一个元素1
(car (lambda (m) (m 1 2)))		          	;; 用cons的定义替换cons
((lambda (m) (m 1 2)) (lambda (p q) p))		;; 用car的定义替换car
((lambda (p q) p) 1 2)				            ;; m用(lambda (p q) p)替换
1						                              ;;得到结果1
```
至于cdr，跟car类似，我们只要写一个函数，接受2个参数，并返回后一个参数即可:
```racket
(lambda (p q) q)
```
####练习2.5
这个题目有点问题，如果a b是小数或者是负数，那乘积2^a*3^b就不是整数了。而且还没法计算出a b。

我这里就把a b限制成0和正整数。

racket已经提供了指数函数，(expt a b)表示a的b次方

####练习2.6
one就是`(add-1 zero)`,为：
```racket
(lambda (f) (lambda (x) (f x)))
```
one跟zero的差别就是对x多了一次f处理，可以猜一下，two应该是：
```racket
(lambda (f) (lambda (x) (f (f x))))
```
tow就是对x做了2次f处理。如果用替换模型，结果也确实如此。

按照这个模型，用church计数方法的整数n应该有n个f:
```racket
(lambda (f) (lambda (x) (f (f ... (f (f x))))
```
题目提出要实现church计数的加法，两个church计数相加就是f函数的次数相加：  
`(add n1 n2)`
例如one和two相加，就是要把`(f x) + (f (f x))`弄成 `(f (f (f x)))`。  
可以看到，如果能把`(f x)`中的`x`换成`(f (f x))`就可以了。而
```racket
(f (f x))
= ((lambda (x) (f (f x))) x) 
= (((lambda (f) 
    (lambda (x) (f (f x)))) f) x) = ((two f) x)
```
那要把n2加到n1上，就是 
```racket
(f ((two f) x)) = ((one f) ((two f) x))
```
最后加上f和x的参数，就成了：
```racket
(lambda (f) (lambda (x) ((one f) ((two f) x))))
```
所以church计数的加法就是
```racket
(define (add n1 n2)
  (lambda (f) (lambda (x) ((n1 f) ((n2 f) x)))))
```
此外，还有个有意思的地方，如果用one作用与一个函数，将返回：
```racket
(lambda (x) (f x))
```
如果用two作用与一个函数，将返回：
```racket
(lambda (x) (f (f x)))
```
那这些church计数其实可以用于生成函数的重复，类似练习1.43的`(repeat f)`，*太神奇了！！牛逼！！*

还可以再扩展一下，构造church计数的乘法。按照church计数的规律，乘法就是f函数的次数相乘。
例如
```racket
(mul two tow)
```
结果应该有4个f：
```racket
(lambda (f) (lambda (x) (f(f(f(f x))))))
```
可以看到，对于`(mul n1 n2)`,只要令n1的参数f等于n2的`(lambda (x) (f (f ...(f x)))))`就可以了。
所以这样构造church乘法：
```racket
(define (mul n1 n2)
  (lambda (f) (n1 (n2 f))))
```
