#lang racket

;; exersice 1.29

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (sum-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ result (term a)))))
  (iter a 0))

(define (simpson a b fn dx)
  (define (term x)
    (+ (fn x) (* 4 (fn (+ x dx))) (fn (+ x dx dx))))
  (define (add-2dx x) (+ x dx dx))
  (* (sum-iter term a add-2dx b) dx 1/3))
  ;;(* (sum-iter term a add-2dx b) dx 1/3))

