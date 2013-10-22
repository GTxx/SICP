####练习1.40
函数已经在书中有了，拿过来用就行。

####练习1.41
(((double (double double)) inc) 5) 返回21，相当与调用了2^2^2次inc

####练习1.42
这个题目倒是很简单，但是值得一提的是，原来racket里面也提供了compose，而且居然还能组合多变量的函数，只要函数的返回保持一致就行，还提供了一个只能组合单参数函数的compose1。
不得不说racket的compose牛逼。

####练习1.43
除了用练习1.42提供的compose，也可以写成这样：
```racket
(define (repeat f n)
  (if (= n 1)
      f
      (lambda (x) (f ((repeat f (- n 1)) x))))) ;;最后一行就是compose
````
最后一行其实就是compose，可以看一下compose的定义：
```racket
(define (compose f g)
  (lambda (x) (f (g x))))
````
compose组合了函数f和函数g，并让g对x作用，然后再让f对g(x)的值作用。


为了提高效率，还可以把repeat改成迭代方式。如下：
```racket
(define (repeat-iter f n)
  (define (iter f-res k)
    (if (= k n)
        f-res
        (iter (lambda (x) (f (f-res x))) (+ 1 k))))
  (iter f 1))
```
这个题目需要产生n个f的重复，f(f(f(...)))，写成迭代方式的repeate-iter,在迭代中用f-res表示里面的k个f迭代。

####练习1.44
多次平滑可以写成：
```racket
(define (multi-smooth smooth f k)  (repeat (smooth f) k)
````
####练习1.45
这个题目提出了一个问题，就是有些函数必须要做多次平均阻尼才能收敛，那么对于x的n次方，x^n=y,要做多少次阻尼，才能收敛并得到一个解。

需要这么一些辅助的函数

1. 不动点计算，在练习1.36中已经有，
2. 平均阻尼的函数，这个在1.36也有，但是当时是直接用的，没有写成函数，如果要做多次阻尼，最好用repeat实现，
3. 刚才提到的repeat函数，可以生成对指定函数重复多次的函数，
4. 最后一个是怎么判断收敛，因为在方程给出前，肯定是不知道要做多少次阻尼才能收敛，所以要有一个收敛准则，但是这个收敛准则很难，所以就算了，直接手工判断。

还有一个要注意的地方，按照不动点的定义，多次阻尼是重复加上y求平均，例如2次阻尼，是
[[f(y)+y]/2 + y]/2
所以用repeat的时候，应该对average-damp做重复，而不是对(average-damp f)做重复，所以应该写成：
```racket
((repeat average-damp n) f)
```
举个例子，当n=2时，用重复了2次的average-damp对10求值，
```racket
((repeat average-damp 2) f) 10)
```
等价与：
```racket 
((ave (ave f)) 10)
```
首先，最里面的(ave f)返回一个函数，(f(x)+x)/2,令这个函数为：
`g(x)=(f(x)+x)/2`,
接着外面的ave对g(x)产生作用，返回一个函数：
`(g(x)+x)/2`，
这个函数就是（把x换成y）
`[[f(y)+y]/2 + y]/2`
满足多次阻尼的定义。

我一开始把这个地方写错了，写成了：
```racket
(repeat (average-damp f n)
```
这样的结果是把阻尼重新代入给y，例如两次阻尼的值是：
`[f([f(y)+y]/2) + [f(y)+y]/2]/2`
这就完全错了。

BTW：average-damp其实跟练习1.37的无穷连分式特别像，也可以用repeat解决无穷连分式的问题。如下
```racket
(define (inf-f n)
  (define (fn x) (/ 1.0 (+ 1 x)))
  ((repeat fn n) 0))
```
用repeat对fn重复n次，其含义就是，对fn(x)的结果重新计算fn，这样就得到了多次连分式，再将x=0，就得到了可以得到符合练习1.37条件的解。如下：
```racket
> (inf-f 15)
0.6180344478216819
```
这个解就是黄金分割值的倒数。

####练习1.46
书中1.1.7的开平方和1.3.3的不动点其实都是迭代式改进的过程，所以可以统一起来。可以写成这样：
```racket
(define (iterative-improve good-enough? improve)
  (define (iter guess)
    (let ((res (improve guess)))
      (if (good-enough? guess res)
          res
          (iter res))))
  iter)
```
这个函数iterative-improve返回的是另一个函数iter，iter接受一个猜想值，按照improve更新猜测值，逐步收敛到good-enough?

开平方可以写成：
```racket
(define (new-sqrt x)
  (define tolerance 0.001)
  (define (good-enough? a b)
    (< (abs (- a b)) tolerance))
  (define (improve y)
    (/ (+ (/ x y) y) 2.0))
  ((iterative-improve good-enough? improve) 1.0))
```
利用新的开平方函数，求2的开平方：
```racket
> (new-sqrt 2)
1.4142135623746899
```
不动点函数也可以利用iterative-improve写成：
```racket
(define (new-fixed-point f first-guess)
  (define tolerance 0.001)
  (define (good-enough? a b)
    (< (abs (- a b)) tolerance))
  ((iterative-improve good-enough? f) first-guess))
```
求f(x)=1+1/x的不动点
```racket
> (new-fixed-point (lambda (x) (+ 1 (/ 1 x))) 2.0)
1.6181818181818182
```
