#lang racket/base
(require "extract-docstring.rkt")
#;(require (for-label racket/base))


#;(display (doc-sexp->string
            (extract-doc-sexp/id #'make-hasheqv-placeholder)))


(define names (namespace-mapped-symbols (module->namespace 'racket/base)))


#;(for ([n names])

  (displayln n)
  (displayln "-----------")
  (with-handlers ([exn:fail? (lambda (exn)
                               (displayln "Cannot find documentation")
                               (read-line))])
  (display (doc-sexp->string (extract-doc-sexp/id (list 'racket/base n))))))

;; Current bugs
;; make-immutable-hash, ...
;; free-identifier=?
;; syntax-taint
;; module-compiled-exports
;; read-char
;; port-display-handler
;; port-write-handler
;; port-file-identity
;; string->bytes/utf-8
;; lambda
;; case-lambda
;; local-expand/capture-lifts
;; local-transformer-expand
;; sequence-generate*
;; thread-send
;; rename-file-or-directory
;; hash->list
;; current-subprocess-custodian-mode
;; new-apply-proc
;; file

