#lang scribble/manual

@title{WeScheme Internal Documentation}

@section{Embedding WeScheme in other web pages}
We've been running an experiment to embed WeScheme within other web pages.

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