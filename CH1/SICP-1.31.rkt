#lang racket

;; exersice 1.31
(define (product a b next term)
  (if (> a b)
      1
      (* (term a)
         (product (next a) b next term))))

(define (product-iter a b next term)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* result (term a)))))
  (iter a 1))

(define (cal-pi a b)
  (define (next a) (+ a 2))
  (define (term a) (/ (* a (+ a 2.0))
                      (* (+ a 1.0) (+ a 1.0))))
  (* 4 (product-iter a b next term)))