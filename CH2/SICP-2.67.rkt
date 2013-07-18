#lang racket

(provide symbols left-branch right-branch leaf?
         make-code-tree make-leaf weight
         decode)
;;exercise 2.67 huffman
(define (make-leaf symbol weight)
  (list 'leaf symbol weight))
(define (symbol-leaf leaf)
  (cadr leaf))
(define (weight-leaf leaf)
  (caddr leaf))
(define (leaf? leaf)
  (eq? 'leaf (car leaf)))

(define (make-code-tree left right)
  (list left right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

(define (left-branch tree)
  (car tree))
(define (right-branch tree)
  (cadr tree))
(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))
(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
        '()
        (let ((next-branch (choose-branch (car bits) current-branch)))
          (if (leaf? next-branch)
              (cons (symbol-leaf next-branch) (decode-1 (cdr bits) tree))
              (decode-1 (cdr bits) (choose-branch (car bits) current-branch))))))
  (decode-1 bits tree))

(define (choose-branch bit branch)
  (cond ((= bit 1) (left-branch branch))
        ((= bit 0) (right-branch branch))
        (else (error "bad bit"))))

;test
(define sample-tree
  (make-code-tree (make-leaf 'a 4)
                  (make-code-tree (make-leaf 'b 2)
                                  (make-code-tree (make-leaf 'd 1)
                                                  (make-leaf 'c 1)))))

;(decode '(0 1 1 0 0 1 0 1 0 1 1 1 0) sample-tree)