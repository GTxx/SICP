#lang racket

(provide make-vect xcor-vect ycor-vect add-vect sub-vect scale-vect)
;; exercise 2.46

;; make-vect xcor-vect ycor-vect
(define (make-vect x y)
  (cons x y))

(define (xcor-vect v)
  (car v))

(define (ycor-vect v)
  (cdr v))

;; add-vect sub-vect scale-vect
(define (add-vect v1 v2)
  (make-vect (+ (xcor-vect v1) (xcor-vect v2))
             (+ (ycor-vect v1) (ycor-vect v2))))

(define (sub-vect v1 v2)
  (make-vect (- (xcor-vect v1) (xcor-vect v2))
             (- (ycor-vect v1) (ycor-vect v2))))

(define (scale-vect v k)
  (make-vect (* (xcor-vect v) k)
             (* (ycor-vect v) k)))

;;test
(define v1 (make-vect 1 2))

(define v2 (make-vect 2 3))

;(add-vect v2 v1)
;(sub-vect v2 v1)
;(scale-vect v1 4)