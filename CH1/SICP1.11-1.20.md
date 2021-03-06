####练习1.11
搞定函数f(n)=f(n-1)+2f(n-2)+f(n-3)的递归版本和迭代版本。
可以参照1.2.2小节的fib迭代函数。

####练习1.12
求帕斯卡三角形的元素。
用f(n,m)表示n行，第m个元素，则f(n,m)=f(n-1,m)+f(n-1,m-1)
用递归可以搞定，不过我没想到怎么转化为迭代模式。

因为帕斯卡三角形的递归方法求值会重复求值，所以效率不太理想，例如求f(5,3),递归过程中对f(3,2)要计算2次。

为了提高效率，可以把以前计算的f(n,m)值都存储起来，如果参数重复，就直接取出来。书中已经给出了解决方法，可以参见3.27.这里用hash表来存储以前计算过的元素。
```racket
(define (memory fn)
  (let ((h (make-hash)))
    (lambda (n m)
      (if (hash-has-key? h (list n m))
          (hash-ref h (list n m))
          (let ((res (fn n m)))
            (print (list n m))              	;;如果要计算，打印一次
            (hash-set! h (list n m) res)	;;将已经计算过的值存入hash表中
            res))))) 

(define psk-mem 
  (memory (lambda (n m)					;;memory形成一个闭包，可以从hash表取出曾经算过的值。
            (cond ((or (= n m) (= m 1)) 1)
                  (else (+ (psk-mem (- n 1) (- m 1))	;;如果计算过(n-1,m-1)的值，就可以直接取出来，不用重复计算。
                           (psk-mem (- n 1) m)))))))
```
```racket
> (psk-mem 1 1) ;;首先计算f(1 1),由于从来没有计算过，所以
'(1 1)1
> (psk-mem 5 3) ;;计算f(5,3),由于f(1,1)已经计算过，所以这里就没有重复计算了。
'(3 1)'(2 1)'(2 2)'(3 2)'(4 2)'(3 3)'(4 3)'(5 3)6
> (psk-mem 6 3) ;;计算f(6,3),由于前面大量元素都已经算过了，只需要计算 (4 1) (5 2) (6 3) 3个元素即可。
'(4 1)'(5 2)'(6 3)10
```
####练习1.13
用数学归纳法可以证明。
伽马应该是1-5^0.5，因为伽马小于1，在fib(n->无穷大)时趋近0。
所以当n趋近无穷大，fib(n)=(1+5^0.5)^n

####练习1.14
有100 50 25 10 5 1美分的币值，现在有n美元，求有多少种币值的组合。
书中已经给出了答案，用递归可以解决这个问题，这个问题可以分为2部分，不用其中一种币值的组合数，以及扣掉一个币值后的组合数。
这个练习题要求给出空间和时间效率。
因为是树形递归，所以空间效率就是树的深度，也就是o(n+5),也就是o(n).
时间效率就是树的叶子数目，这个我没想出来怎么求，应该跟fib函数的时间效率类似，是某个数的指数。

####练习1.15

a)p调用的次数？

p由sine调用，而sine在角度大于0.1时会调用p，所以当角度为12.15时，调用次数为12.15/3^x<0.1,x>=5,所以p要调用5次

b)时间和空间效率？

时间效率是log3(a/0.1)，空间效率也是log3(a/0.1)

####练习1.16
要用迭代方式实现快速求幂。
```racket
;; exercise 1.16
(define (f-expt b n)
  (define (expt-iter m b2 brem)			;;把b的平方放在b2中，把当m为奇数多出来的b放在brem中
    (if (= m 1)
        (* b2 brem)
        (if (even? m)
            (expt-iter (/ m 2) (* b2 b2) brem)
            (expt-iter (- m 1) b2 (* brem b)))))
  (expt-iter n b 1))
```
####练习1.17 练习1.18
这两个跟求幂的差不多，就不记录了。

####练习1.19
Tpq 当2次计算的p= p*p + q*q, q=2pq+q*q

####练习1.20
应用序求了4次remainder。
正则序先不求值，而是展开。
(gcd 206 40)的展开没有remainder的计算。并进入(gcd 40 (rem 206 40))
(gcd 40 (rem 206 40))的展开在(= b 0)做了一次rem计算，并展开为:
```racket
(gcd (rem 206 40) 
     (rem 40 (rem 206 40)))
```
b=(rem 40 (rem 206 40))),在(= b 0)处做了2次rem计算。并展开为:
```racket
(gcd (rem 40 (rem 206 40)) 
     (rem (rem 206 40) 
          (rem 40 (rem 206 40))))
```
b=(rem (rem 206 40) 
          (rem 40 (rem 206 40)))),在(= b 0)处做了4次rem计算。并展开为:
```racket
(gcd (rem (rem 206 40) 
          (rem 40 (rem 206 40)))
     (rem (rem 40 (rem 206 40)) 
          (rem (rem 206 40) 
               (rem 40 (rem 206 40)))))
```
在(= b 0)处做了7次rem计算。这时候b=0成立，返回a，a还要计算4次rem。

综上所述，一共要1+2+4+7+4=18次rem计算。
