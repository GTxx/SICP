#lang racket

;; exercise 1.36
(define tolerance 0.001)

(define (fixed-point f x)
  (define (close-enough? a b)
    (< (abs (- a b)) tolerance))
  (define (try guess)
    (let ((next (/ (+ guess (f guess)) 2)))
      (begin (print next) (newline))
      (if (close-enough? next guess)
          next
          (try next))))
  (try x))