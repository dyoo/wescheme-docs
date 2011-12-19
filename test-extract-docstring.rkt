#lang racket/base
(require "extract-docstring.rkt")
(require (for-label racket/base))


#;(display (doc-sexp->string
            (extract-doc-sexp/id #'make-hasheqv-placeholder)))


(define names (namespace-mapped-symbols (module->namespace 'racket/base)))


(for ([n names])
  (display (doc-sexp->string (extract-doc-sexp/id (list 'racket/base n)))))