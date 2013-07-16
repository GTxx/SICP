#lang racket

(require "SICP-2.49.rkt") ;draw-to-bitmap
(require "SICP-2.47.rkt") ;;make-frame
(require "SICP-2.46.rkt") ;;vect
(provide transform-painter)
;;exercise 2.50
(define (transform-painter painter origin corner1 corner2)
  (lambda (frame)
    (let ((m (frame-coord-map frame)))
      (let ((new-origin (m origin)))
        (painter (make-frame new-origin
                             (sub-vect (m corner1) new-origin)
                             (sub-vect (m corner2) new-origin)))))))

(define (flip-vert painter)
  (transform-painter painter 
                     (make-vect 0 1)
                     (make-vect 1 1)
                     (make-vect 0 0)))
(define (flip-horiz painter)
  (transform-painter painter
                     (make-vect 1 0)
                     (make-vect 0 0)
                     (make-vect 1 1)))
(define (flip-180 painter)
  (transform-painter painter
                     (make-vect 1 1)
                     (make-vect 0 1)
                     (make-vect 1 0)))
(define (flip-270 painter)
  (transform-painter painter
                     (make-vect 0 1)
                     (make-vect 1 1)
                     (make-vect 0 0)))
;;test
;;(draw-to-bitmap 100 100 (flip-vert wave) "test5.png")
    (draw-to-bitmap 100 100 (flip-horiz wave) "test6.png")
(draw-to-bitmap 100 100 (flip-180 wave) "test7.png")
(draw-to-bitmap 100 100 (flip-270 wave) "test8.png")