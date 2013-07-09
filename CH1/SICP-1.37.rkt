#lang racket

;; exercise 1.37

(define (cont-frac n d k)
  (define (rec start)
    (if (= k start)
        0
        (/ (n start) (+ (d start) (rec (+ 1 start))))))
  (rec 1))

(define (cont-frac-iter n d k)
  (define (iter frac cnt)
    (if (= cnt 1)
        (/ (n cnt) (+ (d cnt) frac))
        (iter (/ (n cnt) (+ (d cnt) frac)) (- cnt 1))))
  (iter 0 k))

(define test (/ 1 (cont-frac-iter (lambda (i) 1.0) (lambda (i) 1.0) 15)))