#lang racket

(require "SICP-2.63.rkt")
(require "SICP-2.64.rkt")
;; exercise 2.65
(define (empty-tree? tree)
  (null?  tree))

(define (element-of-set? x s)
  (cond ((null? s) false)
        ((=  x (entry s)) true)
        ((< x (entry s)) (element-of-set? x (left-tree s)))
        ((> x (entry s)) (element-of-set? x (right-tree s)))))

(define (adjoin-set x s)
  (cond ((empty-tree? s) (make-tree x '() '()))
        ((= x (entry s)) s)
        ((< x (entry s)) (make-tree  (entry s)
                                     (adjoin-set x (left-tree s)) 
                                     (right-tree s)))
        ((> x (entry s)) (make-tree  (entry s) 
                                     (left-tree s)
                                     (adjoin-set x (right-tree s))))))
(define (union s1 s2)
  (if (empty-tree? s1) 
      (if (empty-tree? s2) null s2)
      (if (empty-tree? s2) 
          s1
          (let ((new-s2 (adjoin-set (entry s1) s2)))
            (if (empty-tree? (left-tree s1))
                (if (empty-tree? (right-tree s1)) 
                    new-s2
                    (union (right-tree s1) new-s2))
                (let ((nnew-s2 (union (left-tree s1) new-s2)))
                  (if (empty-tree? (right-tree s1))
                      nnew-s2
                      (union (right-tree s1) nnew-s2))))))))

(define (union-set s1 s2)
  (list->tree (tree->list1 (union s1 s2))))

(define (intersection-1 s1 s2)
  (cond ((or (empty-tree? s1) (empty-tree? s2)) '())
        ((element-of-set? (entry s1) s2)
         (make-tree (entry s1) (intersection (left-tree s1) s2) (intersection (right-tree s1) s2)))
        (else (list->tree (append (tree->list1 (intersection-1 (left-tree s1) s2))
                                  (tree->list1 (intersection-1 (right-tree s1) s2)))))))
(define (intersection s1 s2)
  (list->tree (tree->list1 (intersection-1 s1 s2))))
;;test

;; 1 2 3 4 5 6 7
(define test-tree (make-tree 1 '() 
                             (make-tree 2 '()
                                        (make-tree 3 '()
                                                   (make-tree 4 '()
                                                              (make-tree 5 '()
                                                                         (make-tree 6 '()
                                                                                    (make-tree 7 '() '()))))))))
;; 1 3 5 7 9
(define test-tree1 (make-tree 7 (make-tree 3 (make-tree 1 '() '())
                                          (make-tree 5 '() '()))
                             (make-tree 9 '() (make-tree 11 '() '()))))
(union-set test-tree '())
(intersection-1 test-tree '())
(union-set test-tree test-tree1)
(intersection-1 test-tree test-tree1)