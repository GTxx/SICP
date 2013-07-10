#lang racket

;; exersice 2.1

;add-rat sub-rat mul-rat div-rat
(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y)) (* (denom x) (numer y))) (* (denom x) (denom y))))

(define (sub-rat x y)
  (make-rat (- (* (numer x) (denom y)) (* (denom x) (numer y))) (* (denom x) (denom y))))

(define (mul-rat x y)
  (make-rat (* (numer x) (numer y)) (* (denom x) (denom y))))

(define (div-rat x y)
  (make-rat (* (numer x) (denom y)) (* (denom x) (numer y))))

;make-rat numer denom
(define (numer x)  (car x))

(define (denom x)  (cdr x))

(define (make-rat n d)
  (let ((g (gcd n d)))
    (let ((n1 (/ n g))
          (d1 (/ d g)))
      (if (negative? d1)
          (cons (- n1) (- d1))
          (cons n1 d1)))))

;print-rat
(define (print-rat x)
  (newline)
  (print (numer x)) (display "/") (print (denom x)))

;;test
 (define a (make-rat -2 0))
 (define b
    (make-rat 1 3))
 (print-rat (add-rat a b))