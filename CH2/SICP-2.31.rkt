#lang racket

;;exercise 2.31
(define (tree-map proc tree)
  (map (lambda (subtr)
         (cond ((null? subtr) '())
               ((not (pair? subtr)) (proc subtr))
               (else (tree-map proc subtr)))) tree))

;test
(define (square-tree tr) (tree-map (lambda (x) (* x x)) tr))

(square-tree '(1 2 3 (1 2) ()))