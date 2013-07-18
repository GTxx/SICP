#lang racket

;;exersice 2.66
(define (make-record key re)
  (cons key re))
(define (key record)
  (car record))

(define (lookup gven-key set)
  (cond ((null? set) false)
        ((= given-key (key (entry set))) (entry set))
        ((= given-key (key (entry set))) (lookup given-key (left-tree set)))
        (else (lookup given-key (right-tree set)))))