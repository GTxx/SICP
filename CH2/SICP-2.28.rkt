#lang racket

;;exercise 2.28

(define (fringe lst)
  (cond ((null? lst) lst)
        ((not (pair? lst)) (list lst))
        (else (append (fringe (car lst)) (fringe (cdr lst))))))


;;test
 (fringe '((1 2) () (3) ()))
;'(1 2 3)