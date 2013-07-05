#lang racket

;; exercise 1.19

(define (fib n)
  (define (fib-iter a b p q m)
    (if (= m 0)
        b
        (if (even? m)
            (fib-iter a b (+ (* p p) (* q q)) (+ (* 2 p q) (* q q)) (/ m 2))
            (fib-iter (+ (* b q) (* a q) (* a p))
                      (+ (* b p) (* a q))
                      p q (- m 1)))))
  (fib-iter 1 0 0 1 n))