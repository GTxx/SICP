#lang racket

;;exercise 2.35
(require "SICP-2.33.rkt")

(define (count-leave t)
  (accumulate (lambda (x y)
                (cond ((null? x) y);;'() is not a leave
                      ((not (pair? x)) (+ 1 y)) 
                      (else (+ (count-leave x) y))))
              0
              t))

(define (count-leave-map t)
  (accumulate +
              0
              (map (lambda (sub-t)
                     (if (not (pair? sub-t));; '() is a leave 
                         1
                         (count-leave-map sub-t))) t)))

;test
(define test (count-leave '((1 (1 2)) (2 3) ())))

(define test1 (count-leave-map '((1 (1 2)) (2 3) ())))