#!/usr/bin/env hy

;;(import argparse os)

(import spacy)

(setv nlp-model (spacy.load "en_core_web_sm"))

(defn nlp [some-text]
  (setv doc (nlp-model some-text))
  (setv entities (lfor entity doc.ents [entity.text entity.label_]))
  (setv j (doc.to_json))
  (setv (get j "entities") entities)
  j)
 
;; tests:
;;(print (nlp "President George Bush went to Mexico and he had a very good meal"))
;;(print (nlp "Lucy threw a ball to Bill and he caught it"))
