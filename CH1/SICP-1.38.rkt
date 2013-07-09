#lang racket

;; exercise 1.38
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

(define (d-e i)
  (let ((rem (remainder i 3)))
    (cond ((= rem 1) 1)
          ((= rem 0) 1)
          (else (* 2 (+ 1 (/ (- i 2) 3)))))))

(define test (+ 2 (cont-frac-iter (lambda (i) 1.0) 
                             d-e
                             19)))