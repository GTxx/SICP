#lang racket
(define (m-thrisqrt x)
  (define (good-enough? guess guess1)
    (< (abs (- guess guess1)) 0.001))
  (define (improve guess)
    (/ (+ (/ x (* guess guess)) (* 2 guess)) 3))
  (define (thri-iter guess guess1)
    (if (good-enough? guess guess1)
        guess
        (thri-iter (improve guess) guess)))
  (thri-iter 1.0 2.0))