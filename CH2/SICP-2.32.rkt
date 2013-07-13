#lang racket

;;test
(define (subsets s)
  (if (null? s)
      (list null)
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (sub-rest) (cons (car s) sub-rest)) rest)))))

 (subsets '(1 2 3))
;'(() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3))
 (subsets '(1 2 3 ()))
;'(() (()) (3) (3 ()) (2) (2 ()) (2 3) (2 3 ()) (1) (1 ()) (1 3) (1 3 ()) (1 2) (1 2 ()) (1 2 3) (1 2 3 ()))