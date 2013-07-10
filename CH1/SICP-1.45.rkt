#lang racket

;; exercise 1.45
(define (expy y n)
  (define (iter res k)
    (if (= k n)
        res
        (iter (* res y) (+ k 1))))
  (iter 1 0 ))

(define (average-damp f) 
  (lambda (x) (/ (+ (f x) x) 2.0)))

(define (repeat f n)
  (define (iter f-res k)
    (if (= k n)
        f-res
        (iter (lambda (x) (f (f-res x))) (+ k 1))))
  (iter f 1))

(define (repeat1 f n )
  (if (= n 1)
      f
      (f (repeat1 f (- n 1)))))

(define (fixed-point-enhance1 f n-average)
  (define tolerance 0.0001)
  (define (close-enough? g1 g2)
    (< (abs (- g1 g2)) tolerance))
  (define (try guess)
    (let ((res ((repeat (average-damp f) n-average) guess)))
      (if (close-enough? res guess)
          res
          (try res))))
  (try 1.0))

(define (fixed-point-enhance f )
  (define tolerance 0.0001)
  (define (close-enough? g1 g2)
    (< (abs (- g1 g2)) tolerance))
  (define (try guess)
    (let ((res (f guess)))
      (print res) (newline)
      (if (close-enough? res guess)
          res
          (try res))))
  (try 1.0))

(define (expn x n)
  (lambda (y) (/ x (expy y (- n 1)))))

(define test (fixed-point-enhance  ((repeat average-damp 2) (expn 3 4))))

(define (inf-f n)
  (define (fn x) (/ 1.0 (+ 1 x)))
  ((repeat fn n) 0))
