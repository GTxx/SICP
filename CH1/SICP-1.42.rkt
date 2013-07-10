#lang racket

;;exercise 1.42
(define (compose f g)
  (lambda (x) (f (g x))))

(define (square x) (* x x))
(define (inc x) (+ 1 x))