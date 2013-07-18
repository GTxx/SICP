#lang racket

(require "SICP-2.67.rkt")
(provide encode)
;exercise 2.68
(define (encode-symbol symbol tree)
  (if (member symbol (symbols tree))
      (cond ((leaf? tree) '()) 
            ((member symbol (symbols (left-branch tree))) (cons 1 (encode-symbol symbol (left-branch tree))))
            ((member symbol (symbols (right-branch tree))) (cons 0 (encode-symbol symbol (right-branch tree)))))
            
      (error "not in tree")))

(define (encode message tree)
  (if (null? message) '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))
;test
(define sample-tree
  (make-code-tree (make-leaf 'a 4)
                  (make-code-tree (make-leaf 'b 2)
                                  (make-code-tree (make-leaf 'd 1)
                                                  (make-leaf 'c 1)))))
(encode '(b a d b b a a) sample-tree)