#lang racket

;;exercise 2.21

(define (square-list1 items)
  (if (null? items)
      '()
      (cons (* (car items) (car items)) (square-list1 (cdr items)))))

(define (square-list2 items)
  (map (lambda (x) (* x x)) items))

;test
(square-list1 '( 1 2 3 ))
(square-list2 '( 1 2 3 ))