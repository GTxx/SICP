#lang racket

;; exercise 1.16
(define (f-expt b n)
  (define (expt-iter m b2 brem)
    (if (= m 1)
        (* b2 brem)
        (if (even? m)
            (expt-iter (/ m 2) (* b2 b2) brem)
            (expt-iter (- m 1) b2 (* brem b)))))
  (expt-iter n b 1))