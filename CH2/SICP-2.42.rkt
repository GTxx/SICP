#lang racket

(require "SICP-2.40.rkt")
;;exercise 2.42
(define (queen board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (position) (safe? k position))
         (flatmap (lambda (rest-of-queens)
                    (map (lambda (new-row)
                           (adjoin-position new-row k rest-of-queens)) 
                         (enumerate-interval 1 board-size)))
                  (queen-cols (- k 1))))))
  (queen-cols board-size))

(define (adjoin-position new-row k rest-of-queens)
  (cons new-row rest-of-queens))
(define empty-board '())
(define (safe? k position)
  (define (safe-row? row)
    (null? (filter (lambda (x) (= x row)) (cdr position)))) ;;there is queen in the same row
  
  (define (safe-up-left? row col pos)
    (cond ((or (<= row 0) (<= col 0)) #t)
          ((= row (car pos)) #f) ;;queen in the same row and same col
          (else (safe-up-left? (- row 1) (- col 1) (cdr pos)))))
  
  (define (safe-down-left? row col pos)
    (cond ((or (> row 8) (<= col 0)) #t)
          ((= row (car pos)) #f)
          (else (safe-down-left? (+ row 1) (- col 1) (cdr pos)))))
  
  (and (safe-row? (car position)) 
       (safe-up-left? (- (car position) 1) (- k 1) (cdr position))
       (safe-down-left? (+ (car position) 1) (- k 1) (cdr position))))

(define (filter predic seq)
  (cond ((null? seq) null)
        ((predic (car seq)) (cons (car seq) (filter predic (cdr seq))))
        (else (filter predic (cdr seq)))))

;;test
(define test-safe? (list (safe? 3 '(1 1 3))
                         (safe? 3 '(1 3 5))
                         (safe? 3 '(1 2 3))
                         (safe? 3 '(1 3 2))))