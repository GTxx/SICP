#lang racket

(require "SICP-2.63.rkt")
(provide list->tree)
;;exercise 2.64
(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree eles n)
  (if (= n 0)
      (cons '() eles)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree eles left-size)))
          (let ((left-tree (car left-result))
                (non-left-tree (cdr left-result))
                (right-size (- n 1 left-size)))
            (let ((this-entry (car non-left-tree))
                  (right-result (partial-tree (cdr non-left-tree) right-size)))
              (let ((right-tree (car right-result))
                     (remainder (cdr right-result)))
                    (cons (make-tree this-entry left-tree right-tree)
                          remainder))))))))