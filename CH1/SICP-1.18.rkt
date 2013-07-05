#lang racket

;; exercise 1.18

(define (double x) (+ x x))

(define (halve x) (/ x 2))

(define (f-mul a b )
  (define (f-iter a2 arem n)
    (if (= n 1) (+ a2 arem)
        (if (even? n)
            (f-iter (double a2) arem (halve n))
            (f-iter a2 (+ arem a2) (- n 1)))))
  (f-iter a 0 b))