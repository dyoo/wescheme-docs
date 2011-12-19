#lang racket/base

(provide extract-docstring)

(define (extract-docstring id)
  (define binding-info (identifier-label-binding id))
  (unless binding-info
    (error 'extract-docstring "Unable to locate binding information using identifier-label-binding"))
  binding-info)