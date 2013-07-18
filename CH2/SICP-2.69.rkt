#lang racket
(require "SICP-2.67.rkt")
(require "SICP-2.68.rkt")
(provide generate-huffman-tree)
(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge leaf-set) 
    (if (null? (cdr leaf-set))
        (car leaf-set)
        (let ((current-tree (make-code-tree (car leaf-set) (cadr leaf-set))))
          (successive-merge (adjoin-set current-tree (cddr leaf-set))))))

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))
(define (make-leaf-set pairs)
  (define (ite result pairs)
    (if (null? pairs)
        result
        (ite (adjoin-set (make-leaf (car 
                                 (car pairs))
                                (cadr (car pairs))) result) (cdr pairs))))
  (ite '() pairs))

;test
(make-leaf-set '((a 1) (b 3) (c 2)))

(define h-tree (generate-huffman-tree '((a 4) (b 3) (c 2) (d 1))))

(define en (encode '( a b c d a b c) h-tree))
(define de (decode en h-tree))