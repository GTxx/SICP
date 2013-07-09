#lang racket

;;exercise 1.28

(define (mr-expmod base exp m)
  (define (rec rem-base rem-mod rem-exp)
    (cond ((= rem-exp 0) (remainder rem-mod m))
          ((= rem-exp 1) (remainder (* rem-base rem-mod) m))
          (else (let ((remainder-rem-base-square (remainder (* rem-base rem-base) m)))
                  (if (and (= remainder-rem-base-square 1) (not (= rem-base 1)) (not (= rem-base (- m 1))))
                      0
                      (if (even? rem-exp)
                          (rec remainder-rem-base-square rem-mod (/ rem-exp 2))
                          (rec remainder-rem-base-square (remainder (* rem-mod rem-base) m) (/ (- rem-exp 1) 2))))))))
  (rec base 1 exp))

(define (mr-test n)
  (define (try-it a)
    (if (= (mr-expmod a (- n 1) n) 1)
        true
        (begin (print a) false)))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((mr-test n) (fast-prime? n (- times 1)))
        (else false)))