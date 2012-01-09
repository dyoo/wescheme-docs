#lang scribble/manual

@(require "scribble-helper.rkt")
@(require (for-label 2htdp/image
                     2htdp/universe
                     (only-in htdp/image
                              image=?
                              color-list->image)))

@title{WeScheme documentation}



@section{World programming and Images}
@racket-inject-doc[big-bang]

@racket-inject-doc[make-color]
@racket-inject-doc[empty-scene]
@racket-inject-doc[scene+line]
@racket-inject-doc[place-image]
@racket-inject-doc[place-image/align]
@racket-inject-doc[put-pinhole]
@racket-inject-doc[circle]
@racket-inject-doc[star]
@racket-inject-doc[radial-star]
@racket-inject-doc[star-polygon]
@racket-inject-doc[overlay]
@racket-inject-doc[polygon]
@racket-inject-doc[rectangle]
@racket-inject-doc[regular-polygon]
@racket-inject-doc[rhombus]
@racket-inject-doc[square]
@racket-inject-doc[triangle]
@racket-inject-doc[right-triangle]
@racket-inject-doc[isosceles-triangle]
@racket-inject-doc[ellipse]
@racket-inject-doc[line]
@racket-inject-doc[add-line]
@racket-inject-doc[overlay]
@racket-inject-doc[overlay/xy]
@racket-inject-doc[overlay/align]
@racket-inject-doc[underlay]
@racket-inject-doc[underlay/xy]
@racket-inject-doc[underlay/align]
@racket-inject-doc[beside]
@racket-inject-doc[beside/align]
@racket-inject-doc[above]
@racket-inject-doc[above/align]
@racket-inject-doc[rotate]
@racket-inject-doc[scale]
@racket-inject-doc[scale/xy]
@racket-inject-doc[crop]
@racket-inject-doc[frame]
@racket-inject-doc[flip-horizontal]
@racket-inject-doc[flip-vertical]
@racket-inject-doc[text]
@racket-inject-doc[text/font]
@racket-inject-doc[bitmap/url]
@; video-url is our own thing
@; image-url, open-image-url is our own thing
@racket-inject-doc[image?]
@racket-inject-doc[image=?]
@racket-inject-doc[image-width]
@racket-inject-doc[image-height]

@racket-inject-doc[image->color-list]
@racket-inject-doc[color-list->image]

@racket-inject-doc[image-baseline]
@racket-inject-doc[mode?]
@racket-inject-doc[image-color?]
@racket-inject-doc[x-place?]
@racket-inject-doc[y-place?]
@racket-inject-doc[angle?]
@racket-inject-doc[side-count?]
@racket-inject-doc[step-count?]
