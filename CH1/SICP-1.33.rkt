#lang racket

;; exersice 1.33
(define (filtered-accumulate filter combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (if (filter a)
            (iter (next a) (combiner (term a) result))
            (iter (next a) result))))
  (iter a null-value))

;; sum prime from a to b
(define (sum-prime a b)
  (filtered-accumulate prime? + 0 (lambda (x) x) a (lambda (x) (+ 1 x)) b))

;; sum GCD(n,m)=1 a<m<b
(define (gcd a b)
  (if (= (remainder a b) 0)
      b
      (gcd b (remainder a b))))

(define (gcd-1? a b)
  (= 1 (gcd a b)))
(define (sum-gcd n)
  (filtered-accumulate (lambda (x) (= 1 (gcd n x))) * 1 (lambda (x) x) 2 (lambda (x) (+ 1 x)) (- n 1)))
  
;; exercise 1.22-1.23
(define (divides? a b)
  (= (remainder a b) 0))

(define (find-divisor n test-divisor fn)
  (cond ((> (* test-divisor test-divisor) n) n)
        ((divides? n test-divisor) test-divisor)
        (else (find-divisor n (fn test-divisor) fn))))

(define (smallest-divisor n)
  (find-divisor n 2 (lambda (x) (+ 1 x))))

(define (prime? n)
  (= (smallest-divisor n) n))

