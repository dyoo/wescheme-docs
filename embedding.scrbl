#lang scribble/manual
@(require "embed-wescheme.rkt")

@title{WeScheme Embedding Documentation}

@section{Embedding WeScheme in other web pages}

WeScheme can be embedded as an iframe within other web pages.

@embed-wescheme[#:id 'first
                #:pid "horde-koala-camel-knife-lurid"
                #:hide-header? #t
                #:hide-footer? #t
                #:width "100%"
                #:auto-run? #t]


The openEditor supports several parameters that are applicable in
embedded mode.

@itemize[
@item{hideHeader: hides the header.  Set to 'true' to hide.}
@item{hideFooter: hides the footer.  Set to 'true' to hide.}
@item{hideDefinitions: hides the definitions pane}
@item{autorun: runs the definitions window if set to 'true'}
@item{warnOnExit: set this to 'false' so the editor doesn't yell when
you exit the page.}
@item{interactionsText: if defined, its value will be used for the
interactions pane.}
]




@section{TODO}

Add more features to the embedded WeScheme instance: have it respond
to @tt{postMessage} and do things like @tt{break}, @tt{run}, etc...