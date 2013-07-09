#lang racket

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

(define (search-for-primes n num)
  (define (rec start acc cnt)
    (cond ((= cnt 0) acc)
          ((prime? start) (rec (+ 1 start) `(,start ,@acc) (- cnt 1)))
          (else (rec (+ 1 start) acc cnt))))
  (rec n `() num))

;; exersice 1.23 
(define (next-divisor n)
  (if (= n 2) 3 (+ n 2)))

(define (fast-smallest-divisor n)
  (find-divisor n 2 next-divisor))

(define (fast-prime? n)
  (= (fast-smallest-divisor n) n))

(define (fast-search-for-primes n num)
  (define (rec start acc cnt)
    (cond ((= cnt 0) acc)
          ((fast-prime? start) (rec (+ 1 start) `(,start ,@acc) (- cnt 1)))
          (else (rec (+ 1 start) acc cnt))))
  (rec n `() num))