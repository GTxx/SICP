#lang racket

;; exercise 1.41
(define (double f)
  (lambda (x) (f (f x))))

(define (inc x)
  (+ 1 x))

(define test (((double (double double)) inc) 5))