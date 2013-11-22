#lang racket
(define (make-monitor f)
  (let ((call-num 0))
    (define (dispatch m)
      (cond ((eq? m 'how-many-calls) call-num)
            ((eq? m 'reset-count) (set! call-num 0))
            (else (begin (set! call-num (+ 1 call-num))
                         (f m)))))
    dispatch))