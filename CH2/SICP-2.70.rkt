#lang racket

(require "SICP-2.69.rkt");generate-huffman
(require "SICP-2.68.rkt");encode
(require "SICP-2.67.rkt");decode

(define ht (generate-huffman-tree '((a 2) (na 16) (boom 1) (sha 3) (get 2) (yip 9) (job 2) (wah 1))))

(define en (encode '(get a job sha na  na na na na na na get a job sha na na na na na na wah yip yip yip yip yip yip 
                         sha boom) ht))


(define de (decode en ht))