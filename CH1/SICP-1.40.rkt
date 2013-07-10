#lang racket

;; exersice 1.40
(define dx 0.0001)
(define (deriv f)
  (lambda (x) (/ (- (f (+ x dx))
                    (f x))
                 dx)))
  
(define (newton-transform f)
  (lambda (x) (- x (/ (f x) ((deriv f) x)))))
  
(define (newton-method f x)
  (fixed-point (newton-transform f) x))
  
(define (cubic a b c)
  (lambda (x) 
    (+ c (* b x) (* a x x) (* x x x))))

(define test (newton-method (cubic 1 2 3) 1.0))

;; fixed point
(define tolerance 0.0001)

(define (fixed-point f x)
  (define (close-enough? a b)
    (< (abs (- a b)) tolerance))
  (define (try guess)
    (let ((res (f guess)))
      (if (close-enough? res guess)
          res
          (try res))))
  (try x))