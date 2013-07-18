#lang racket

;exercise 2.54
(define (equal? lst1 lst2)
  (cond ((or (null? lst1) (null? lst2)) (eq? lst1 lst2))
        ((and (not (pair? (car lst1))) (not (pair? (car lst2))))
         (and (eq? (car lst1) (car lst2))
              (equal? (cdr lst1) (cdr lst2))))
        ((and (pair? (car lst1)) (pair? (car lst2)))
         (and (equal? (car lst1) (car lst2))
              (equal? (cdr lst1) (cdr lst2))))
        (else #f)))

;test
;(equal? '(a b (c)) '(a b (c) d))
;(equal? '(a b (c)) '(a b (c)))
;(equal? null null)


