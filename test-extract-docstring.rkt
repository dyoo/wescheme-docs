#lang racket
(require "extract-docstring.rkt")
(require (for-label racket/base))
(extract-docstring #'list)