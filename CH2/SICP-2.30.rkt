#lang racket

;exercise 2.30
(define (square-tree tr)
  (cond ((null? tr) null)
        ((not (pair? tr)) (* tr tr))
        (else (cons (square-tree (car tr)) (square-tree (cdr tr))))))

(define (square-tree-map tr)
  (map (lambda (sub-tr)
         (cond ((null? sub-tr) null)
               ((not (pair? sub-tr)) (* sub-tr sub-tr))
               (else (square-tree-map sub-tr)))) tr))
;test
(square-tree '(1 2 (3) (())))
(square-tree-map '(1 2 3 (1 2) ()))