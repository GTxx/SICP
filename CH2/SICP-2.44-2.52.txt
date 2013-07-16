练习2.44

这个题目最麻烦的是painter实际上没有实现，所以这些代码没法运行。
(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))	;;生成更小的up-splite
        (below painter (beside smaller smaller)))))	;;把painter放在下面，两个small并肩放在painter上面

练习2.45

同样是没法运行。

练习2.46
这个就是2.1节的内容，用分层的设计方法来做抽象，某一曾改动了不会影响上层。

练习2.47
要求构造框架和框架的选择函数。
框架由3个向量。
这个也是复习了2.1节的内容

练习2.48
构造线段和线段的选择函数。
又是在复习2.1节的内容。

练习2.49
segment->painter函数已经在书中给出了。可以直接拿过来用。比较有意思的是segment-painter和frame-coord-map都用了闭包（程序设计上的闭包，跟SICP所说的数学上的闭包不一样）。
segment->painter闭合了frame，这样只要创建一个针对特定frame的函数，就可以对任意的vect做映射了。
frame-coord-map闭合了segment-lst,这样对同一个segment-lst，可以用多个frame做图。

还要完成的是draw-line函数，这个函数的作用就是把(segment->painter segment-list)中的segment->list画在框架frame中。

不过这个地方需要注意的是，for-each不会返回值，for-each在racket里面已经有了，在2.33也已经实现过一次，for-each跟map类似，也是对list中的各个元素作用，但是不返回列表，只是产生一些效果。

为了把画画得到的东西存储下来，必须要用到副作用了，也就是在draw-line加入副作用。这里直接简单点，用一个全局变量来保存draw-line的结果。---试了一下这个方法，特别不好用，还不如用函数式的方法。我把segment-painter改了，直接返回线段的序列。

改动后：
(define (segment->painter seg-lst)
  (lambda (frame)
    (map (lambda (seg)							;;直接映射到另一个segment list
           (make-segment ((frame-coord-map frame) (start-segment seg))
                         ((frame-coord-map frame) (end-segment seg))))
              seg-lst)))

(define (draw-to-bitmap width height painter file)
  (let ((target (make-bitmap width height)))						;;racket的画图
    (let ((dc (new bitmap-dc% (bitmap target)))
          (coord-map-painting (painter (make-frame (make-vect 0 0) 
                                                   (make-vect (- width 1) 0) 		;;实际画图是0-widht-1
                                                   (make-vect 0 (- height 1))))))
      (for-each (lambda (segment)
                  (send dc draw-line (xcor-vect (start-segment segment))
                        (ycor-vect (start-segment segment))
                        (xcor-vect (end-segment segment))
                        (ycor-vect (end-segment segment))))
                coord-map-painting)
      (send target save-file file 'png))))
      (send target save-file file 'png))))

练习2.50

练习2.51
书中给出的beside，最后是
(lambda (frame)
    (paint-up frame)
    (paint-down frame))
这个是利用了paint的副作用，我要是这么写，就只能返回(paint-down frame)了。

因为我的画家返回的是线段的列表，所以最后也简单，只要把上下部分append就好：
(lambda (frame)
        (append (paint-up frame)
                (paint-down frame))

从练习2.44到2.51，最能体现的就是闭包和抽象的力量。这些例子中，所有的painter计算结果还是一个painter，特别利于扩展。抽象则是采用了2.1的设计思想，对数据和数据操作分层。--擦，画家程序要是直接让我搞，肯定搞不出来。



