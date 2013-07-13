#lang racket

;;exercise 2.17
(define (last-pair lst)
  (if (null? (cdr lst))
      (car lst)
      (last-pair (cdr lst))))

;;test
(last-pair '(1 2 3))
(last-pair '(1 2 (1) (1 2)))