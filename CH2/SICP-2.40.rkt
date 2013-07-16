#lang racket

(provide flatmap enumerate-interval unique-pairs)
(require "SICP-2.33.rkt")
;;exersice 2.40
(define (flatmap proc seq)
  (accumulate append null (map proc seq)))

(define (enumerate-interval a b)
  (if (> a b)
      null
      (cons a (enumerate-interval (+ a 1) b))))

(define (unique-pairs n)
  (flatmap (lambda (x) 
             (map (lambda (y) (list y x)) 
                  (enumerate-interval 1 (- x 1)))) 
           (enumerate-interval 1 n)))

(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

(define (prime-pair? pair)
  (prime? (+ (car pair) (cadr pair))))

(define (prime-sum-pairs n)
  (map make-pair-sum 
       (filter prime-pair?
              (unique-pairs n))))
;;prime?
(define (divides? a b)
  (= (remainder a b) 0))

(define (find-divisor n test-divisor fn)
  (cond ((> (* test-divisor test-divisor) n) n)
        ((divides? n test-divisor) test-divisor)
        (else (find-divisor n (fn test-divisor) fn))))

(define (smallest-divisor n)
  (find-divisor n 2 (lambda (x) (+ 1 x))))

(define (prime? n)
  (= (smallest-divisor n) n))
                  
;;test
(enumerate-interval 1 4)

(unique-pairs 4)