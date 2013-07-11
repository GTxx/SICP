#lang racket
;;exercise 2.07
(provide make-interval upper-bound lower-bound
         sub-interval add-interval mul-interval div-interval )

;; make-interval upper-bound lower-bound
(define (make-interval a b) (cons a b))

(define (upper-bound x) (cdr x))

(define (lower-bound x) (car x))

;;sub-interval
(define (sub-interval x y)
  (add-interval x
                (make-interval (- (upper-bound y))
                               (- (lower-bound y)))))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (upper-bound y)))
        (p2 (* (lower-bound x) (lower-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (mul-interval x (make-interval (/ 1.0 (upper-bound y))
                                 (/ 1.0 (lower-bound y)))))

(define (mul-interval-9-cond x y)
  (let ((a (lower-bound x))
        (b (upper-bound x))
        (c (lower-bound y))
        (d (upper-bound y)))
    (cond ((>= a 0)
           (cond ((>= c 0) 
                  (make-interval (* a c) (* b d)))
                 ((and (<  c 0) (>= d 0)) 
                  (make-interval (* b c) (* b d)))
                 ((< d 0) 
                  (make-interval (* b d) (* a c)))))
          ((and (< a 0) (>= b 0))
           (cond ((>= c 0) 
                  (make-interval (* a d) (* b d)))
                 ((and (<  c 0) (>= d 0)) 
                  (make-interval (min (* a d) (* b c)) (max (* b d) (* a c))))
                 ((< d 0) 
                  (make-interval (* b c) (* a c)))))
          ((< b 0)
           (cond ((>= c 0) 
                  (make-interval (* b d) (* a c)))
                 ((and (<  c 0) (>= d 0)) 
                  (make-interval (* b d) (* b c)))
                 ((< d 0) 
                  (make-interval (* b d) (* a c))))))))
;;test

(define test (sub-interval (make-interval 1 2) (make-interval 3 4)))

(mul-interval-9-cond (make-interval 1 2) (make-interval -5 4))

(mul-interval-9-cond (make-interval 1 2) (make-interval -5 -85))

 (mul-interval-9-cond (make-interval -11 2) (make-interval -5 -85))

 (mul-interval-9-cond (make-interval -11 -22) (make-interval -5 -85))

 (mul-interval-9-cond (make-interval -11 -22) (make-interval -5 85))
