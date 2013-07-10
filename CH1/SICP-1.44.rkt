#lang racket

;; exercise 1.44

(define (smooth f)
  (lambda (x)
    (/ (+ (f x) (f (+ x dx)) (f (- x dx)))3)))

(define (multi-smooth smooth f k)  (repeat (smooth f) k)