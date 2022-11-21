#!/usr/bin/env hy

(import coref-nlp-lib [coref-nlp])

;; tests:
(print (coref-nlp "President George Bush went to Mexico and he had a very good meal"))
(print (coref-nlp "Lucy threw a ball to Bill and he caught it"))
