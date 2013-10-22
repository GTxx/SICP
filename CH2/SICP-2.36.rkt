#lang racket

(provide accumulate-n)
(require "SICP-2.33.rkt")
;;exercise 2.36
(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      null
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))

;test
(accumulate-n + 0 '((1 2 3) ( 4 5 6)))
;'(5 7 9)