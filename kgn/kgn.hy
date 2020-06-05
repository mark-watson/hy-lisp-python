#!/usr/bin/env hy

(import os)
(import sys)
(import [pprint [pprint]])
(require [hy.contrib.walk [let]])

(import [textui [select-entities get-query]])
(import spacy)

(setv nlp-model (spacy.load "en"))

(defn entities-in-text [s]
  (setv doc (nlp-model s))
  (setv ret {})
  (for
    [[ename etype] (lfor entity doc.ents [entity.text entity.label_])]
    
    (if (in etype ret)
        (setv (get ret etype) (+ (get ret etype) [ename]))
        (assoc ret etype [ename])))
  ret)
        

(print (entities-in-text "Bill Clinton, Mexico, IBM, Bill Gates, Pepsi, Canada, John Smith, Google"))

(setv query "")

(defn kgn []
  (while
    True
    (let [query (get-query)
          emap {}]
      (if (or (= query "quit") (= query "q"))
          (break))
      (setv elist (entities-in-text query))
)))
