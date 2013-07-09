#lang racket

;; exersice 1.39

(define (tan-cf x k)
  (define (n k x)
    (if (= k 1)
        x
        (* x x)))
  (define (d k) (+ (* 2 (- k 1)) 1))
  (define (rec start)
    (if (= start k)
        0
        (/ (n start x) (- (d start) (rec (+ 1 start))))))
  (rec 1))

(define (tan-cf x k) (cont-frac n d k x))