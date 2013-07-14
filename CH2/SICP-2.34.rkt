#lang racket

;;exercise 2.34
(require "SICP-2.33.rkt")

(define (horner-eval x c-s)
  (accumulate (lambda (this-coeff higher-term)
                (+ this-coeff (* x higher-term)))
              0
              c-s))

(define test (horner-eval 2 (list 1 3 0 5 0 1)))