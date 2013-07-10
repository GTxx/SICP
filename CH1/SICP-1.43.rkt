#lang racket

;; exercise 1.43

(define (repeat f n)
  (if (= n 1)
      f
      (lambda (x) (f ((repeat f (- n 1)) x)))))

(define (repeat1 f n)
  (if (= n 1)
      f
      (compose f (repeat f (- n 1)))))

(define (repeat-iter f n)
  (define (iter f-res k)
    (if (= k n)
        f-res
        (iter (lambda (x) (f (f-res x))) (+ 1 k))))
  (iter f 1))

(define (square x) (* x x))
(define test ((repeat square 2) 5))