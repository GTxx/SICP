#lang racket

;;exercise 2.23

(define (for-each proc lst)
  (if (null? lst)
      null
      (begin (proc (car lst)) 
             (for-each proc  (cdr lst)))))

;;test
(for-each (lambda (x)  (newline) (display x)) '( 1 2 3))