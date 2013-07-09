#lang racket

;; exercise 1.35
(define tolerance 0.0001)

(define (fixed-point f x)
  (define (close-enough? a b)
    (< (abs (- a b)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? next guess)
          next
          (try next))))
  (try x))