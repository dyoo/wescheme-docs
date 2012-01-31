#lang scribble/manual

@(require "scribble-helper.rkt")
@(require "embed-wescheme.rkt")

@inject-css{fullpage.css}
@inject-javascript{easyXDM.min.js}
@inject-javascript{json2.min.js}

@title{WeScheme Embedding Documentation}



@section{Introduction}

WeScheme can be embedded as an iframe within other web pages.  As a
few examples:

@itemize[

@item{@embed-wescheme[#:pid "champ-neigh-stoop-sinew-overt"]}

@item{@embed-wescheme[#:pid "kiosk-brook-cover-diner-smoky"
                      #:height 700]}

@item{@embed-wescheme[#:interactions-text "(+ 1 2 3)"
                      #:hide-header? #t
                      #:hide-footer? #t
                      #:hide-definitions? #t]}
]






@section{Parameters}

The openEditor supports several parameters that are applicable in
embedded mode.

@itemize[
@item{publicId: the public id of the program to be embedded.}
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

Add more features to the embedded WeScheme instance: have it use
@tt{postMessage} and do things like @tt{break}, @tt{run}, etc, so it's
a better citizen of the Web.  We should be able to send and receive
values from an embedded WeScheme instance easily.