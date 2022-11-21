#!/usr/bin/env hy

(import argparse os)
(import spacy neuralcoref)

;; To load data file from the web (only need to do this once per Pyhton env):
;;     python -m spacy download en_core_web_sm

(setv nlp2 (spacy.load "en_core_web_sm"))
(neuralcoref.add_to_pipe nlp2)

(defn coref-nlp [some-text]
  (setv doc (nlp2 some-text))
  { "corefs" doc._.coref_resolved
    "clusters" doc._.coref_clusters
    "scores" doc._.coref_scores})
