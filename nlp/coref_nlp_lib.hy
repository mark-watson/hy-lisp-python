#!/usr/bin/env hy

(import argparse os)
(import spacy neuralcoref)

(setv nlp2 (spacy.load "en"))
(neuralcoref.add_to_pipe nlp2)

(defn coref-nlp [some-text]
  (setv doc (nlp2 some-text))
  { "corefs" doc._.coref_resolved
    "clusters" doc._.coref_clusters
    "scores" doc._.coref_scores})
