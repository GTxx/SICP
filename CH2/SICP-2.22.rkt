#lang racket

;;excercise 2.22
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things) (cons (* (car things) (car things)) answer))))
  (iter items '()))

(define (square-list1 items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things) (cons answer (* (car things) (car things))))))
  (iter items '()))

;;test
(square-list '(1 2 3)  )
(square-list1 '(1 2 3)  )