#lang racket

(provide accumulate)
;; exercise 2.33
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

;map
(define (map p sequence)
  (accumulate (lambda (x y) (cons (p x)
                                  y)) null sequence))

;append
(define  (append lst1 lst2)
  (accumulate (lambda (x y) 
                (if (null? x)
                    y
                    (cons x y))) lst2 lst1))

;length
(define (length lst)
  (accumulate (lambda (x y) (+ (if (null? x) 0 1) y)) 0 lst))

;test
(map (lambda (x) (* x x)) '(1 2 3)) 

(append '(1 2) '(3 4))

(length '(1 2 3))
