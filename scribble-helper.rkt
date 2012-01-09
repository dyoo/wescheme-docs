#lang racket

(require scribble/core
         scribble/html-properties
         scriblib/render-cond
         racket/match
         (for-syntax "extract-docstring.rkt"))


(define-syntax (racket-inject-doc stx)
  (syntax-case stx ()
    [(_ binding)
     (begin
       (define an-sxml (extract-doc-sexp/id #'binding))
       (with-syntax ([an-sxml an-sxml])
         (syntax/loc stx
           (sxml->element 'an-sxml))))]))

         
(define (sxml->element an-sxml)
  (match an-sxml
    [(list tag-name (list '@ (list attr-name attr-value) ...) children ...)
     (define tag-attr (alt-tag (symbol->string tag-name)))
     (define attrs-attr (attributes (map cons attr-name attr-value)))
     (define content (map sxml->element children))
     (make-element (make-style #f (list tag-attr attrs-attr))
                   content)]
    
    [(list '& 'nbsp)
     " "]
    [(list '& sym)
     sym]
    [(list tag-name children ...)
     (define tag-attr (alt-tag (symbol->string tag-name)))
     (define content (map sxml->element children))
     (make-element (make-style #f (list tag-attr))
                   content)]
    [(? symbol?)
     an-sxml]
    
    [(? string?)
     an-sxml]))

