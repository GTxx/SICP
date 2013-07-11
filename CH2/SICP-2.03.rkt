#lang racket

(require "SICP-2.02.rkt")

;;exercise 2.3
;;make-rect w-rect h-rect
(define (make-rect s1 s2)
  (cons s1 s2))

(define (w-rect rect) (car rect))

(define (h-rect rect) (cdr rect))

;;perimeter area
(define (segment-length segment)
  (let ((start (start-segment segment))
        (end (end-segment segment)))
    (let ((x-dif (- (x-point start) (x-point end)))
          (y-dif (- (y-point start) (y-point end))))
      (sqrt (+ (* x-dif x-dif) (* y-dif y-dif))))))

(define (w-length rect)
  (segment-length (w-rect rect)))
(define (h-length rect)
  (segment-length (h-rect rect)))

(define (perimeter rect)
  (* 2 (+ (w-length rect) (h-length rect))))
(define (area rect)
  (* (w-length rect) (h-length rect)))

;;test
(define r (make-rect (make-segment (make-point 0 0) (make-point 3 0))
                     (make-segment (make-point 0 0) (make-point 0 4))))