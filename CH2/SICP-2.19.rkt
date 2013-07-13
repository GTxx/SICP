#lang racket

;;exercise 2.19
(define (cc amount coin-values)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else (+ (cc amount (except-first-denomination coin-values))
                 (cc (- amount (first-denomination coin-values))
                     coin-values)))))

(define (cc1 amount coin-values res)
  (cond ((= amount 0) (begin (print res) (newline) 1))
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else (+ (cc1 amount (except-first-denomination coin-values) res)
                 (cc1 (- amount (first-denomination coin-values))
                      coin-values
                      `(,(first-denomination coin-values) ,@res))))))

(define (no-more? coin-values)
  (null? coin-values))

(define (except-first-denomination coin-values)
  (cdr coin-values))

(define (first-denomination coin-values)
  (car coin-values))