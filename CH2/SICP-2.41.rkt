#lang racket

(require "SICP-2.40.rkt")
;;exercise 2.41
(define (unique-thri n)
  (flatmap (lambda (i) 
             (map (lambda (y) (cons  y i)) 
                  (enumerate-interval 1 (- (car i) 1)))) 
           (unique-pairs n)))

(define (eq-s? lst s)
  (= (+ (car lst) (cadr lst) (caddr lst)) s))

(define (thri-eq-s n s)
  (filter (lambda (lst) (eq-s? lst s))
          (unique-thri n)))
;;test
(define test (unique-thri 4))
(define test1  (thri-eq-s 10                          20))