#lang racket

;; exercise 2.13

(require "SICP-2.12.rkt")
(require "SICP-2.07.rkt")
(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval one (add-interval (div-interval one r1)
                                    (div-interval one r2)))))

;;test
(define r1 (make-interval 5.1 5.2))
(define r2 (make-interval 1.1 1.3))
(par1 r1 r2)
(par2 r1 r2)

(define r3 (make-center-percent 1 0.1))
(define r4 (make-center-percent 3 0.1))

(define res3 (par1 r3 r4))
(define res4 (par2 r3 r4))
res3
res4
(center res3) (percent res3)
(center res4) (percent res4)