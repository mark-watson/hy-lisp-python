#!/usr/bin/env hy

;; library text2semantics: convert text to structured NLP data

(import spacy)

(setv nlp-model (spacy.load "en"))

(defn find-entities-in-text [some-text]
  (defn clean [s]
    (.strip (.replace s "\n" " ")))
  (setv doc (nlp-model some-text))
  (map list (lfor entity doc.ents [(clean entity.text) entity.label_])))
 
;;(for [e (find-entities-in-text "President George Bush went to Mexico and he had a very good meal")]
;;  (print e))
;;(print (find-entities-in-text "Lucy threw a ball to Bill and he caught it"))
