#lang racket

(require "SICP-2.33.rkt")
(provide fold-left fold-left1 fold-right)
;;exercise 2.38
(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest)) (cdr rest))))
  (iter initial sequence))

(define (fold-left1 op initial sequence)
  (if (null? sequence)
      initial
      (fold-left1 op (op initial (car sequence)) (cdr sequence))))

(define (fold-right op initial sequence)
  (accumulate op initial sequence))
;;test
(fold-left / 1 (list 1 2 3))

(fold-left1 / 1 (list 1 2 3))

(fold-right / 1 (list 1 2 3))

(fold-left list null (list 1 2 3))

(fold-right list null (list 1 2 3))

(fold-left * 1 (list 1 2 3))

(fold-right * 1 (list 1 2 3))
