#lang racket

;;exersice 2.61
(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< x (car set)) (cons x set))
        ((= x (car set)) set)
        (else (cons (car set) (adjoin-set x (cdr set))))))

;test
(adjoin-set 1 '(1 2 3))
(adjoin-set 1 '(0 2 3))