#lang racket

; exercise 2.45
(define (split big-op small-op)
  (define (rec painter n)
    (if (= n 0)
        painter
        (let ((smaller (rec painter (- n 1))))
          (big-op painter (small-op smaller smaller)))))
  rec)

(define right-split (split beside below))

(define up-split (split below beside))