#lang racket

;; exercise 1.17
(define (double x) (+ x x))

(define (halve x) (/ x 2))

(define (fast-mul a b)
  (if (= b 1) a
      (if (even? b)
          (fast-mul (double a) (halve b))
          (+ a (fast-mul a (- b 1))))))