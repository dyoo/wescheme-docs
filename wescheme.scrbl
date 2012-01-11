#lang scribble/manual

@(require "scribble-helper.rkt")
@(require (for-label 2htdp/image
                     (only-in htdp/image
                              image=?
                              color-list->image)
                     (only-in racket/base
                              pair?)

                     (only-in lang/htdp-advanced
                              * + - / < <= = =~
                              > >= abs acos add1
                              andmap angle append
                              asin atan boolean=?
                              boolean? build-list
                              caaar caadr caar cadar cadddr
                              caddr cadr car cdaar cdadr
                              cdar cddar cdddr
                              cddr cdr
                              ceiling char->integer
                              char-alphabetic?
                              char-ci<=?
                              char-ci<?
                              char-ci=?
                              char-ci>=?
                              char-ci>?
                              char-downcase
                              char-lower-case?
                              char-numeric?
                              char-upcase
                              char-upper-case?
                              char-whitespace?
                              char<=?
                              char<?
                              char=?
                              char>=?
                              char>?
                              char?
                              complex?
                              conjugate
                              cons
                              cons?
                              cos
                              cosh
                              current-seconds
                              denominator
                              e
                              eighth
                              empty
                              empty?
                              eof
                              eof-object?
                              eq?
                              equal?
                              equal~?
                              eqv?
                              error
                              even?
                              exact->inexact
                              exp
                              expt
                              false
                              false?
                              fifth
                              first
                              floor
                              foldl
                              format
                              fourth
                              gcd
                              identity
                              imag-part
                              inexact->exact
                              inexact?
                              integer->char
                              integer?
                              lcm
                              length
                              list
                              list*
                              list->string
                              list-ref
                              log
                              magnitude
                              make-posn
                              make-string
                              map
                              max
                              member
                              memq
                              memv
                              min
                              modulo
                              negative?
                              not
                              null
                              null?
                              number->string
                              number?
                              numerator
                              odd?
                              pi
                              positive?
                              posn-x
                              posn-y
                              posn?
                              quotient
                              random
                              rational?
                              real-part
                              real?
                              remainder
                              rest
                              reverse
                              round
                              second
                              seventh
                              sgn
                              sin
                              sinh
                              sixth
                              sqr
                              sqrt
                              string
                              string->list
                              string->number
                              string->symbol
                              string-append
                              string-ci<=?
                              string-ci<?
                              string-ci=?
                              string-ci>=?
                              string-ci>?
                              string-copy
                              string-length
                              string-ref
                              string<=?
                              string<?
                              string=?
                              string>=?
                              string>?
                              string?
                              struct?
                              sub1
                              substring
                              symbol->string
                              symbol=?
                              symbol?
                              tan
                              third
                              true
                              zero?)))

@title{WeScheme documentation}



@section{World programming and Images}


@racket-inject-docs[make-color
                    empty-scene
                    scene+line
                    place-image
                    place-image/align
                    put-pinhole
                    circle
                    star
                    radial-star
                    star-polygon
                    overlay
                    polygon
                    rectangle
                    regular-polygon
                    rhombus
                    square
                    triangle
                    right-triangle
                    isosceles-triangle
                    ellipse
                    line
                    add-line
                    overlay
                    overlay/xy
                    overlay/align
                    underlay
                    underlay/xy
                    underlay/align
                    beside
                    beside/align
                    above
                    above/align
                    rotate
                    scale
                    scale/xy
                    crop
                    frame
                    flip-horizontal
                    flip-vertical
                    text
                    text/font
                    bitmap/url
                    image?
                    image=?
                    image-width
                    image-height

                    image->color-list
                    color-list->image

                    image-baseline
                    mode?
                    image-color?
                    x-place?
                    y-place?
                    angle?
                    side-count?
                    step-count?]


@section{Basic operations}
