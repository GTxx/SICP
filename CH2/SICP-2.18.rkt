#lang racket

;;exercise 2.18
(define (reverse lst)
  (if (null? (cdr lst))
      (list (car lst))
      (append (reverse (cdr lst)) (list (car lst)))))

;;test
(reverse '(1 2 3) )

 (reverse '(1 2 3 (1 2)) )
