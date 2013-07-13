#lang racket

;;exercise 2.29
; make-mobile make-branch
(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

;; a) define left-branch right-branch branch-length branch-structure
(define (left-branch mobile)
  (car mobile))
(define (right-branch mobile)
  (car (cdr mobile)))

(define (branch-length branch)
  (car branch))
(define (branch-structure branch)
  (car (cdr branch)))

;; b) define total-weight
(define (total-weight structure)
  (if (pair? (branch-structure structure))
      (* (branch-length structure) 
         (+ (total-weight (left-branch (branch-structure structure)))
            (total-weight (right-branch (branch-structure structure)))))
      (* (branch-length structure) (branch-structure structure))))

;; b) define balance?
(define (balance? mobile)
  (= (total-weight (left-branch mobile)) 
     (total-weight (right-branch mobile))))

;;test
(define 2-str (make-mobile (make-branch 10 10) (make-branch 5 (make-mobile (make-branch 1 2)
                                                                           (make-branch 2 3)))))

(total-weight (right-branch 2-str))

(balance? 2-str)