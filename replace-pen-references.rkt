#lang racket/base

(provide replace-pen-references)
(require racket/match)


;; replace-pen-references: sexp -> sexp
;; This is meant to remove the references to "pens" in the documentation
;; as WeScheme does not currently support them.
(define (replace-pen-references an-sexp)
  (match an-sexp
    [(list tag (list '@ attrs ...) children ...)
     (list* tag (list* '@ attrs) (map replace-pen-references children))]
    [(list tag children ...)
     (list* tag (map replace-pen-references children))]
    [(? string?)
     (cond
      [(string=? an-sexp "pen-or-color")
       "color"]
      [else
       an-sexp])]
    [else
     an-sexp]))
