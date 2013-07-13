#lang racket

;;exersice 2.20
(define (odd-even a)
  (if (odd? a) odd? even?))

(define (same-parity a . lst)
  (let ((fn (odd-even a)))
    (define (iter res lstt)
      (if (null? lstt)
          res
          (if (fn (car lstt))
              (iter `(,@res ,(car lstt) ) (cdr lstt))
              (iter res (cdr lstt)))))
    (iter (list a) lst)))

;;test
(same-parity 1 2 3 4 5)

 (same-parity 2 2 3 4 5)
