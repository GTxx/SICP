#lang racket

;exercise 1.12
; n: the nth row
; m: the mth element in nth row
(define (psktri n m)
  (cond ((or (= m 1) (= n m)) 1)
        (else (+ (psktri (- n 1) m) (psktri (- n 1) (- m 1))))))


(define (memory fn)
  (let ((h (make-hash)))
    (lambda (n m)
      (if (hash-has-key? h (list n m))
          (hash-ref h (list n m))
          (let ((res (fn n m)))
            (print (list n m))
            (hash-set! h (list n m) res)
            res))))) 

(define psk-mem 
  (memory (lambda (n m)
            (cond ((or (= n m) (= m 1)) 1)
                  (else (+ (psk-mem (- n 1) (- m 1))
                           (psk-mem (- n 1) m)))))))