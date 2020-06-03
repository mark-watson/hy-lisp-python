#!/usr/bin/env hy

(import json)
(import os)
(import sys)
(import [pprint [pprint]])
(import requests)
(require [hy.contrib.walk [let]])

(setv query (get sys.argv 1)) ;; "select ?s ?p ?o { ?s ?p ?o } limit 2"

(setv endpoint "https://query.wikidata.org/bigdata/namespace/wdq/sparql")

(defn do-query [query]
  ;; Construct a request
  (setv params { "query" query "format" "json"})

  ;; Call the API
  (setv response (requests.get endpoint :params params))

  (setv json-data (response.json))
  (pprint json-data)

  (setv vars (get (get json-data "head") "vars"))
  (print "vars:")
  (pprint vars)

  (setv results (get json-data "results"))
  (pprint results)


  (if (in "bindings" results)
      (let [bindings (get results "bindings")]
        (pprint bindings)
        (lfor binding bindings
              (lfor var vars
                    [var (get (get binding var) "value")])))
      []))

(pprint (do-query query))
