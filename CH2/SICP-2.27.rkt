#lang racket

;;exercise 2.27
(define (reverse lst)
  (cond ((null? lst) '()) 
        ((not (pair? lst)) lst)
        (else (append (reverse (cdr lst)) (list (reverse (car lst)))))))

;test
 (reverse '(1 2 3))
;'(3 2 1)
 (reverse '(1 2 (3)))
;'((3) 2 1)
 (reverse '(1 2 (3) ()))
;'(() (3) 2 1)
 (reverse '(1 2 (3 2) ()))
;'(() (2 3) 2 1)
  (reverse '(() 1 () 2 (3 (4 5)) ()))
;'(() ((5 4) 3) 2 () 1 ())