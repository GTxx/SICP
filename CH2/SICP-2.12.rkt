#lang racket

;;exercise 2.12
(require "SICP-2.07.rkt")
(provide make-center-percent center  percent)
(define (make-center-percent c p)
  (make-interval (- c (* (abs c) p))
                 (+ c (* (abs c) p))))

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2.0))

(define (percent i)
  (/ (/ (- (upper-bound i) (lower-bound i)) 2.0) 
     (abs (center i))))
