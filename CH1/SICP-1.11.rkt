#lang racket
;; exercise 1.11

(define (fn n)
  (cond ((< n 3) n)
        (else (+ (fn (- n 1)) (* 2 (fn (- n 2))) (* 3 (fn (- n 3)))))))

(define (fn1 n)
  (define (rec a b c count)
    (cond ((< n 3) n)
          ((= count n) a)
          (else (rec (+ a (* 2 b) (* 3 c)) a b (+ count 1)))))
  (rec 2 1 0 2))