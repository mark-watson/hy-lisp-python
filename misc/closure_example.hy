#!/usr/bin/env hy

;; Note: this is the only use of the let macro in this book, as of January 2021.
;; I like to use the let macro except for one issue: auto-converting Hy to Python produces
;; unattractive Python code if the let macro is used.

(require [hy.contrib.walk [let]])

(let [x 1]
  (defn increment []
    (setv x (+ x 1))
    x))

(print (increment))
(print (increment))
(print (increment))
