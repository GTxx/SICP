#lang racket

;;exercise 2.59
(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (adjoin x set)
  (if (element-of-set? x set)
      set
      (cons x set)))

(define (intersection-set s1 s2)
  (cond ((or (null? s1) (null? s2)) '())
        ((element-of-set? (car s1) s2)
         (cons (car s1) (intersection-set (cdr s1) s2)))
        (else (intersection-set (cdr s1) s2))))

(define (union-set s1 s2)
  (cond ((null? s1) s2)
        ((null? s2) s1)
        ((element-of-set? (car s1) s2)
         (union-set (cdr s1) s2))
        (else 
         (cons (car s1) (union-set (cdr s1) s2)))))

;;test
(element-of-set? 'a '(a b c))
(adjoin 'a '(b c))
(intersection-set '(1 2 3) '(1 4 5))
(union-set '(1 2 3) '(2 3 4))