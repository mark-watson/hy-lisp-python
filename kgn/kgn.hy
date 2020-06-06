#!/usr/bin/env hy

(import os)
(import sys)
(import [pprint [pprint]])
(require [hy.contrib.walk [let]])

(import [textui [select-entities get-query]])
(import [kgnutils [dbpedia-get-entities-by-name]])

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
        

(print (entities-in-text "Bill Clinton, Canada, IBM, San Diego, Florida, Great Lakes, Bill Gates, Pepsi, John Smith, Google"))

(setv entity-type-to-type-uri
      {"PERSON" "<http://dbpedia.org/ontology/Person>"
       "GPE" "<http://dbpedia.org/ontology/Place>"
       "ORG" "<http://dbpedia.org/ontology/Organisation>"
       })

(setv short-comment-to-uri {})

(defn shorten-comment [comment uri]
  (setv sc (+ (cut comment 0 70) "..."))
  (assoc short-comment-to-uri sc uri)
  sc)

;;(defn short-comment-to-uri-and-comment [user-prompt entities]
  
(setv query "")

(defn kgn []
  (while
    True
    (let [query (get-query)
          emap {}]
      (if (or (= query "quit") (= query "q"))
          (break))
      (setv elist (entities-in-text query))
      (setv people-found-on-dbpedia [])
      (setv places-found-on-dbpedia [])
      (setv organizations-found-on-dbpedia [])
      (global short-comment-to-uri)
      (setv short-comment-to-uri {})
      (for [key elist]
        (print (get elist key))
        (setv type-uri (get entity-type-to-type-uri key))
        (for [name (get elist key)]
          (setv dbp (dbpedia-get-entities-by-name name type-uri))
          (print "+ dbp:") (pprint dbp)
          (for [d dbp]
            (setv short-comment (shorten-comment (second (second d)) (second (first d))))
            (print "+ short-comment") (print short-comment)
            (if (= key "PERSON")
                (.extend people-found-on-dbpedia [(+ name  " || " short-comment)]))
            (if (= key "GPE")
                (.extend places-found-on-dbpedia [(+ name  " || " short-comment)]))
            (if (= key "ORG")
                (.extend organizations-found-on-dbpedia [(+ name  " || " short-comment)])))))
      (setv user-selected-entities
            (select-entities
              people-found-on-dbpedia
              places-found-on-dbpedia
              organizations-found-on-dbpedia))
      (pprint user-selected-entities)
      (setv uri-list [])
      (for [entity (get user-selected-entities "entities")]
        (setv short-comment (cut entity (+ 4 (.index entity " || "))))
        (.extend uri-list [(get short-comment-to-uri short-comment)]))
      (print "+ uri-list:") (print uri-list)
      )))

;; (pprint (dbpedia-get-entities-by-name "Bill Gates" "<http://dbpedia.org/ontology/Person>"))

(kgn)