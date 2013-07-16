#lang racket

(require "SICP-2.50.rkt")
(require "SICP-2.49.rkt") ;draw-to-bitmap
(require "SICP-2.46.rkt") ;;vect
(provide  below beside)
;;exercise 2.51
(define (below painter1 painter2)
  (let ((split-point (make-vect 0 0.5)))
    (let ((paint-up (transform-painter painter2
                               split-point
                               (make-vect 1 0.5)
                               (make-vect 0 1)))
          (paint-down (transform-painter painter1
                                 (make-vect 0 0)
                                 (make-vect 1 0)
                                 split-point)))
      (lambda (frame)
        (append (paint-up frame)
                (paint-down frame))))))

(define (beside p1 p2)
  (let ((split-point (make-vect 0.5 0)))
    (let ((p-left (transform-painter p1 
                                    (make-vect 0 0)
                                    split-point
                                    (make-vect 0 1)))
          (p-right (transform-painter p2
                                      split-point
                                      (make-vect 1 0)
                                      (make-vect 0.5 1))))
      (lambda (frame)
        (append (p-left frame)
                (p-right frame))))))

;;test
(draw-to-bitmap 100 100 (below wave wave) "test9.png")