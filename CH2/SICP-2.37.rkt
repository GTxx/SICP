#lang racket

;;exersice 2.37
(require "SICP-2.33.rkt" "SICP-2.36.rkt")
(define (dot-product v w)  (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v)
  (map (lambda (w) (dot-product v w)) m))

(define (transpose mat)
  (accumulate-n cons null mat))

(define (matrix-*-matrix mat1 mat2)
  (let ((col (transpose mat2)))
    (map (lambda (v) (matrix-*-vector col v)) mat1)))
  
;;test
(define mat '((1 2) (3 4)))
(define mat2 '((9 10) (11 12)))
(define vec1 '(5 6))
(define vec2 '(7 8))

(dot-product vec1 vec2)
(matrix-*-vector mat vec1)
(transpose mat)
(matrix-*-matrix mat mat2)