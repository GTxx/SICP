#lang racket

;;exercise 1.46

(define (iterative-improve good-enough? improve)
  (define (iter guess)
    (let ((res (improve guess)))
      (if (good-enough? guess res)
          res
          (iter res))))
  iter)

(define (new-sqrt x)
  (define tolerance 0.001)
  (define (good-enough? a b)
    (< (abs (- a b)) tolerance))
  (define (improve y)
    (/ (+ (/ x y) y) 2.0))
  ((iterative-improve good-enough? improve) 1.0))

(define (new-fixed-point f first-guess)
  (define tolerance 0.001)
  (define (good-enough? a b)
    (< (abs (- a b)) tolerance))
  ((iterative-improve good-enough? f) first-guess))