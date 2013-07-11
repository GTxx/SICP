#lang racket

(provide make-point x-point y-point 
         make-segment start-segment end-segment )
;; exercise 2.2

;;point
;;make-point x-point y-point   
(define (make-point x y)
  (cons x y))

(define (x-point p) (car p))

(define (y-point p) (cdr p))

;; print-point
(define (print-point p)
  (newline) (display "(") (display (x-point p)) (display ".") (display (y-point p)) (display ")"))

;;segment
;;make-segment start-segment end-segment
(define (make-segment s e)
  (cons s e))

(define (start-segment segment)
  (car segment))

(define (end-segment segment)
  (cdr segment))


;;midpoint-segment
(define (midpoint-segment se)
  (make-point (/ (+ (x-point (start-segment se)) (x-point (end-segment se))) 2)
              (/ (+ (y-point (start-segment se)) (y-point (end-segment se))) 2)))

;;test
(define (test)
  (print-point (midpoint-segment (make-segment (make-point 1 5) (make-point 3 4)))))
              