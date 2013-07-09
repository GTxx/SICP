#lang racket

;;exercise 1.24

(define (expmod base exp m)
  (define (rec rem-base rem-mod rem-exp)
    (cond ((= rem-exp 0) (remainder rem-mod m))
          ((= rem-exp 1) (remainder (* rem-base rem-mod) m))
          (else (if (even? rem-exp)
                    (rec (remainder (* rem-base rem-base) m) rem-mod (/ rem-exp 2))
                    (rec (remainder (* rem-base rem-base) m) (remainder (* rem-mod rem-base) m) (/ (- rem-exp 1) 2))))))
  (rec base 1 exp))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

(define (search-for-primes n num)
  (define (rec start acc cnt)
    (cond ((= cnt 0) acc)
          ((fast-prime? start 20) (rec (+ 1 start) `(,start ,@acc) (- cnt 1)))
          (else (rec (+ 1 start) acc cnt))))
  (rec n `() num))