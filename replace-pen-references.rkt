#lang racket/base

(provide replace-pen-references)
(require racket/match)


;; replace-pen-references: sexp -> sexp
;; This is meant to remove the references to "pens" in the documentation
;; as WeScheme does not currently support them.
(define (replace-pen-references an-sexp)
  (remove-or-c-pen-color-contract 
   (remove-pen-or-color-references an-sexp)))


(define (remove-pen-or-color-references an-sexp)
  (match an-sexp
    [(list tag (list '@ attrs ...) children ...)
     (list* tag (list* '@ attrs) (map remove-pen-or-color-references children))]
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


(define (remove-or-c-pen-color-contract an-sexp)
  (define (walk elts)
    (match elts
      [(list (list 'span _ "(")
             (list 'span _ (list 'a _ "or/c"))
             _
             (list 'span _ (list 'a _ "pen?"))
             _
             (and X (list 'span _ (list 'a _ "image-color?")))
             (list 'span _ ")")
             rest ...)
       (list* X (walk rest))]
      [(list f r ...)
       (cons f (walk r))]
      [(list)
       '()]))

  (match an-sexp
    [(list tag (list '@ attrs ...) children ...)
     (list* tag (list* '@ attrs) 
            (walk (map remove-or-c-pen-color-contract children)))]
    [(list tag children ...)
     (list* tag (walk (map remove-or-c-pen-color-contract children)))]
    [(? string?)
     (cond
      [(string=? an-sexp "pen-or-color")
       "color"]
      [else
       an-sexp])]
    [else
     an-sexp]))
