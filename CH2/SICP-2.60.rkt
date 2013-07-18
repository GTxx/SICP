#lang racket

;;exercise
(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (adjoin x set)
      (cons x set))

(define (remove-ele s ele)
  (define (ite pre set)
    (cond ((null? set) pre)
          ((equal? ele (car set))
           (ite pre (cdr set)))
          (else (ite (append pre (list (car set))) (cdr set)))))
  (ite '() s))

(define (intersection-set s1 s2)
  (cond ((or (null? s1) (null? s2)) '())
        ((element-of-set? (car s1) s2)
         (cons (car s1) (intersection-set (cdr s1) (remove-ele s2 (car s1)))))
        (else (intersection-set (cdr s1) s2))))

(define (union-set s1 s2)
  (append s1 s2))

;;test
(element-of-set? 'a '(b a b c))
(adjoin 'a '( a b c))
(adjoin 'a '(  b c))
(intersection-set '(1 2 2 3) '(1 4 2 1 5))
(union-set '(1 2 3) '(2 3 4))