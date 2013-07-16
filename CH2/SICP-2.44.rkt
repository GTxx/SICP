#lang racket

(require "SICP-2.51.rkt") ;below beside
(require "SICP-2.49.rkt") ;draw-to-bitmap
;;exercise 2.44

(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
        (below painter (beside smaller smaller)))))

;;test
;(draw-to-bitmap 100 100 (up-split wave 4) "test10.png")

