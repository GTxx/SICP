#lang racket

(require "SICP-2.38.rkt")

(define (reverse1 seq)
  (fold-left1 (lambda (x y) (cons y x)) null seq))

(define (reverse2 seq)
  (fold-right (lambda (x y) (append y (list x))) null seq))

;;test

(reverse1 '(1 2 3 4))

(reverse2 '(1 2 3 4))