####练习1.34
```racket
(define (f g)
  (g 2))
```
试了一下，如果运行：
(f f)
返回错误：
```racket
> (f f)
. . application: not a procedure;

 expected a procedure that can be applied to arguments
  given: 2
  arguments...:
   2
```
这个问题应该在于(f f)产生了一个(f 2)的过程，然后根据f函数的定义，(f 2)进一步产生了一个(2 2)的过程，因为2是一个数值，不是一个过程，所以(2 2)运行不了。

####练习1.35

不动点：
x=1+1/x，
进一步转化为
x^2-x-1=0
这个方程的正数解就是黄金分割率。

按照tolerance=0.001，得到的黄金分割率如下：
```racket
> (fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0)
1.6181818181818182
```
####练习1.36
不使用阻尼的方法：
```racket
> (fixed-point (lambda (x) (/ (log 1000) (log x))) 2.0)
9.965784284662087
3.004472209841214
6.279195757507157
3.759850702401539
5.215843784925895
4.182207192401397
4.8277650983445906
4.387593384662677
4.671250085763899
4.481403616895052
4.6053657460929
4.5230849678718865
4.577114682047341
4.541382480151454
4.564903245230833
4.549372679303342
4.559606491913287
4.552853875788271
4.557305529748263
4.554369064436181
4.556305311532999
4.555028263573554
4.555870396702851
4.555870396702851
```
阻尼方法 收敛速度要快很多。
```racket
> (fixed-point (lambda (x) (/ (log 1000) (log x))) 2.0)
5.9828921423310435
4.922168721308343
4.628224318195455
4.568346513136242
4.5577305909237005
4.555909809045131
4.555599411610624
4.555599411610624
```
####练习1.37
收敛到精度为0.0001需要k=15，得到的结果是：
1.6180327868852458

####练习1.38 和 练习1.39
跟前面的连分式计算差不多。
1.39要引入多引入一个x，计算不同的角度。