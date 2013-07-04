#lang racket

;;this function is to get sqrt of x
(define (m-sqrt x)
  (define (good-enough? guess guess1)
    (< (abs (- guess guess1)) 0.001))
  (define (improve guess)
    (/ (+ guess (/ x guess)) 2))
  (define (sqrt-iter guess guess1)
    (if (good-enough? guess guess1)
        guess
        (sqrt-iter (improve guess) guess)))
  (sqrt-iter 1.0 2.0))



