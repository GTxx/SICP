#lang racket

;;exercise 2.53

(list 'a 'b 'c)

(list (list 'george))

(cdr '((x1 x2) (x3 x4)))

(cadr '((x1 x2) (x3 x4)))

(pair? (car '(a short list)))

(memq 'red '((red shoes) (blue socks)))

(memq 'red '(red shoes blue socks))