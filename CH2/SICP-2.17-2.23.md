####练习2.17
racket中已经自带了last函数。

####练习2.18
racket中已经自带了reverse函数

####练习2.19
coin-valuesa列表中元素顺寻的改变不会影响cc函数的结果。

我感觉之所以不会影响结果，因为cc函数对所有的结果都遍历了，得到了所有可能解，所以结果都是一样的。、

####练习2.20

####练习2.21

####练习2.22
从前往后计算，当前值会放在answer的最前面，当计算下一个元素的时候，就把结果放在前一个结果前面了。

第二个函数会返回这样的结果：

```racket
> (square-list1 '(1 2 3))
'(((() . 1) . 4) . 9)
```

因为(cons answer (square (car things))),answer是列表，而后面的平方是一个数值。

####练习2.23
这个题目没什么，但是发现一个问题，就是lambda的过程部分，可以分成多个表达式，并且能够顺序执行。
```racket
(lambda (x)  (newline) (display x))
```
注意到 (newline) (display x)是分开的2个表达式。