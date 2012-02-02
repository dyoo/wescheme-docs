#lang racket/base

(require net/uri-codec
         racket/match
         scribble/html-properties
         scribble/core)

(provide embed-wescheme)



;; helper functions for embedding internal instances of WeScheme.
(define (embed-wescheme #:id (id #f)
                        #:pid (pid #f)
                        #:width (width "90%")
                        #:height (height 500)

                        #:interactions-text (interactions-text #f)
                        #:warn-on-exit? (warn-on-exit? #f)
                        #:hide-header? (hide-header? #f)
                        #:hide-footer? (hide-footer? #t)
                        #:hide-definitions? (hide-definitions? #f)
                        #:auto-run? (auto-run? #f))

  (define pid-or-interactions-alist-chunk
    (cond
     [pid
      `(publicId . ,pid)]
     [interactions-text
      `(interactionsText . ,interactions-text)]
     [else
      (error 'embed-wescheme "#:pid or #:interactions-text must be provided")]))

  (define (maybe-add-option y/n name)
    (if y/n
        `((,name . "true"))
        `((,name . "false"))))

  (define encoded-alist
    (parameterize ([current-alist-separator-mode 'amp])
      (alist->form-urlencoded
       `(,pid-or-interactions-alist-chunk
         ,@(maybe-add-option warn-on-exit? 'warnOnExit)
         ,@(maybe-add-option hide-header? 'hideHeader)
         ,@(maybe-add-option hide-footer? 'hideFooter)
         ,@(maybe-add-option hide-definitions? 'hideDefinitions)
         ,@(maybe-add-option auto-run? 'autorun)))))
  (splice
   (list (sxml->element
          `(iframe
            (@ (src
                ,(string-append "http://www.wescheme.org/openEditor?"
                                encoded-alist))
               ,@(if id
                     `((id ,(symbol->string id)))
                     '())
               (width ,(dimension->string width))
               (height ,(dimension->string height)))))

         ;; TODO: add the JavaScript code to add the appropriate JavaScript binding

         )))


;; dimension->string: (U number string) -> string
;; Translate a dimension into a string.
(define (dimension->string dim)
  (cond
   [(number? dim)
    (number->string dim)]
   [(string? dim)
    dim]
   [else
    (error 'dimension->string "Don't know how to translate ~e to a dimension" dim)]))

;; sxml->element: sxml -> element
;; Embeds HTML content into a Scribble document
(define (sxml->element an-sxml)
  (match an-sxml
    [(list '& 'nbsp)
     'nbsp]
    [(list '& sym)
     sym]

    [(list tag-name (list '@ (list attr-name attr-value) ...) children ...)
     (tagged->element tag-name attr-name attr-value children)]
    
    [(list tag-name children ...)
     (tagged->element tag-name '() '() children)]

    [(? symbol?)
     an-sxml]
    
    [(? string?)
     an-sxml]

    [(? char?)
     (string an-sxml)]))

(define (tagged->element tag-name attr-names attr-values children)
  (define tag-attr (alt-tag (symbol->string tag-name)))
  (define attrs-attr (attributes (map cons attr-names attr-values)))
  (define content (map sxml->element children))
  (make-element (make-style #f (list tag-attr attrs-attr))
                content))