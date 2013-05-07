#lang racket/base

(provide replace-pen-references)
(require racket/match)


;; replace-pen-references: sexp -> sexp
;; This is meant to remove the references to "pens" in the documentation
;; as WeScheme does not currently support them.
(define (replace-pen-references an-sexp)
  (remove-outline-pen-note
   (remove-or-c-pen-color-contract 
    (remove-pen-or-color-references 
     (sexp-normalize an-sexp)))))


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


;; weak-string-match: string -> (sexp -> boolean)
;; Returns a function that reports when x and y are the same, modulo
;; whitespace.
(define (weak-string-match x)
  (lambda (y)
    (string=? (regexp-replace* #px"\\s+" x " ")
              (regexp-replace* #px"\\s+" (sexp->string y) " "))))


(define (sexp->string an-sexp)
  (apply string-append
         (reverse
          (let loop ([an-sexp an-sexp]
                     [acc '()])
            (match an-sexp
              [(list tag (list '@ attrs ...) children ...)
               (foldl loop acc children)]
              [(list tag children ...)
               (foldl loop acc children)]
              [(? string?)
               (cons an-sexp acc)]
              [else
               acc])))))


;; sexp-normalize: sexp -> sexp
;; Normalize adjacent strings so they're joined together.
;; Meant to make the processing a little more robust.
(define (sexp-normalize an-sexp)
  (define (walk elts)
    (match elts
      [(list (and X (? string?))
             (and Y (? string?))
             rest ...)
       (walk (cons (string-append X Y) rest))]
      [(list f r ...)
       (cons f (walk r))]
      [(list)
       '()]))
  (let loop ([an-sexp an-sexp])
    (match an-sexp
      [(list tag (list '@ attrs ...) children ...)
       (list* tag (list* '@ attrs) (walk (map loop children)))]
      [(list tag children ...)
       (list* tag  (walk (map loop children)))]
      [(? string?)
       an-sexp]
      [else
       an-sexp])))





(define (remove-outline-pen-note an-sexp)
  (define (walk elts)
    (match elts
      [(list "Note that when the "
             (list 'span _ "mode")
             " is "
             _
             (list 'span _ "outline")
             " or " 
             (list 'span _ "\"outline\"")
             (? (weak-string-match ", the shape may draw outside of its bounding box and thus parts of the image may disappear when it is cropped. See "))
             (list 'a _ ...)
             " (in the "
             _
             (? (weak-string-match ") for a more careful explanation of the ramifications of this fact."))
             rest ...)
       (walk rest)]
      [(list f r ...)
       (cons f (walk r))]
      [(list)
       '()]))

  (match an-sexp
    [(list tag (list '@ attrs ...) children ...)
     (list* tag (list* '@ attrs) 
            (walk (map remove-outline-pen-note children)))]
    [(list tag children ...)
     (list* tag (walk (map remove-outline-pen-note children)))]
    [(? string?)
     (cond
      [(string=? an-sexp "pen-or-color")
       "color"]
      [else
       an-sexp])]
    [else
     an-sexp]))
