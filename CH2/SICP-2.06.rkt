#lang racket

;;exercise 2.06
(define zero (lambda (f) (lambda (x) x)))

(define (add1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

(define (add n1 n2)
  (lambda (f) (lambda (x) ((n1 f) ((n2 f) x)))))

(define (mul n1 n2)
  (lambda (f) (n1 (n2 f))))

(define one (add1 zero))

(define two (add one one))

(define four (mul two two))
;;test 
(define test ((two (lambda (x) (* x x))) 3))

(define test1 ((four (lambda (x) (+ 1 x))) 0))