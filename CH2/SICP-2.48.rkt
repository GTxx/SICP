#lang racket

(provide make-segment start-segment end-segment)
(require "SICP-2.46.rkt")
;;exercise 2.48
(define (make-segment v-st v-end)
  (cons v-st v-end))
(define (start-segment seg)
  (car seg))

(define (end-segment seg)
  (cdr seg))