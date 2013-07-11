#lang racket

;;exercise 2.06
(define zero (lambda (f) (lambda (x) x)))

(define (add1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

(define (add n1 n2)
  (lambda (f) (lambda (x) ((n1 f) ((n2 f) x)))))

(define one (add1 zero))

(define two (add one one))

;;test 
(define test ((two (lambda (x) (* x x))) 3))