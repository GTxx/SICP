#lang racket

;;exercise 2.05
(define (cons a b)
  (* (expt 2 a) (expt 3 b)))

(define (ln z base)
  (define (iter res ex)
    (if (= (remainder ex base) 0)
        (iter (+ res 1) (/ ex base))
        res))
  (iter 0 z))

(define (car z)
  (ln z 2))

(define (cdr z)
  (ln z 3))