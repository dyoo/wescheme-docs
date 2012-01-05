#lang racket/base
(require setup/xref
         scribble/xref
         racket/match
         (planet neil/html-parsing:1:2)
         "tree-cursor.rkt")


(provide extract-doc-sexp/id
         extract-doc-sexp/tag
         doc-sexp->string)


(define xref (load-collections-xref))


(define (extract-doc-sexp/id id [phase #f])
  (define a-tag (xref-binding->definition-tag xref id phase))  
  (unless a-tag
    (error 'extract-docstring "Unable to locate documentation"))

  (extract-doc-sexp/tag a-tag))


(define (extract-doc-sexp/tag a-tag)  
  (define-values (path anchor)
    (xref-tag->path+anchor xref a-tag))
  
  (unless (and path anchor)
    (error 'extract-docstring "Unable to find specific-enough documentation"))
    
  ;; KLUDGE AHEAD
  ;; I would love to know if there's a better way to extract the documentation.
  ;; As it is, I'm treating the HTML output as ground truth.
  
  ;; Here's the basic idea: we find the anchor, rewind to the last known SIntrapara,
  ;; then play things forward until we hit the next anchor (or we hit the end of the document).
  ;; It's atrocious, but I don't think I have a good
  ;; alternative at this time.
  
  (define sxml (call-with-input-file path html->xexp))
  (define my-cursor (sexp->cursor sxml))
  (define cursor-at-anchor
    (navigate-to-anchor my-cursor anchor))
  (unless cursor-at-anchor
    (error 'extract-docstring "Unable to locate documentation"))
  
  (define-values (content-up-to-anchor at-docs) 
    (up-to-sintrapara-or-svinsetflow anchor cursor-at-anchor))
  
  ;; At this point, we just walk right, starting from the signature,
  ;; past the docs, till we hit another anchored node.
  (cons 'div
        (append content-up-to-anchor
   
                (cond [(cursor-right? at-docs)
                       (let loop ([c (cursor-right at-docs)])
                         (cond
                           [(has-anchor? (cursor-node c))
                            '()]
                           [(cursor-right? c)
                            (cons (cursor-node c)
                                  (loop (cursor-right c)))]
                           [else
                            (list (cursor-node c))]))]
                      [else
                       '()]))))

;; finds the points where the signature and the documentation begin.
(define (up-to-sintrapara-or-svinsetflow anchor c)
  (define at-documentation-start (let loop ([c c])
                                   (match (cursor-node c)
                                     [(list 'div (list '@ (list 'class "SIntrapara"))
                                            elts ...)
                                      c]
                                     [(list 'blockquote (list '@ (list 'class "SVInsetFlow"))
                                            elts ...)
                                      c]
                                     [(list 'p elts ...)
                                      c]
                                     [else
                                      (loop (cursor-succ c))])))
  ;; We want to capture the material at the anchor as well.
  (define content-up-to-anchor
    (reverse
     (let loop ([c at-documentation-start])
       (cond [(has-anchor? (cursor-node c) anchor)
              (list (cursor-node c))]
             [else
              (cons (cursor-node c)
                    (loop (cursor-left c)))]))))
  (values content-up-to-anchor at-documentation-start))


;; Focuses the cursor or the anchor with the given name.
(define (navigate-to-anchor c anchor)
  (match (cursor-node c)
    [(list 'a (list '@  (list 'name (? (lambda (x)
                                         (equal? anchor x))))))
     c]
    [else
     (cond [(cursor-succ? c)
            (navigate-to-anchor (cursor-succ c) anchor)]
           [else
            #f])]))


;; Produces true if we've got an anchor.
(define (has-anchor? sexp (-name #f))
  (let loop ([cursor (sexp->cursor sexp)])
    (match (cursor-node cursor)
      [(list 'a (list '@  (list 'name (and name
                                           (? (lambda (name)
                                                (if -name
                                                    (equal? name -name)
                                                    #t)))))))
       #t]
      [else
       (cond [(cursor-succ? cursor)
              (loop (cursor-succ cursor))]
             [else
              #f])])))


(define (doc-sexp->string sexp)
  (define op (open-output-string))
  (let loop ([sexp sexp])
    (match sexp
      [(list 'tr  body ...)
       (for-each loop body)
       (newline op)]
      [(list 'th body ...)
       (for-each loop body)
       (newline op)]
      [(list 'div body ...)
       (for-each loop body)
       (newline op)]
      [(list '@ rest ...)
       (void)]
      [(list element-name body ...)
       (for-each loop body)]
      [(? string?)
       (display sexp op)]
      [(? char?)
       (display sexp op)]
      [(? symbol?)
       (display (translate-symbol sexp) op)]
      [else
       (error 'doc-sexp->string "Unexpected value: ~s" sexp)]))
  (get-output-string op))
    


(define (translate-symbol sexp)
  (case sexp
    [(nbsp) " "]
    [(rarr) "->"]
    [(rsquo) "'"]
    [(ldquo) "``"]
    [(rdquo) "''"]
    [(ndash) "-"]
    [else
     (error 'translate-symbol "Don't know how to translate ~s" sexp)]))



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