#!/usr/bin/env hy

(import json)
(import os)
(import sys)
(import [pprint [pprint]])
(import requests)
(require [hy.contrib.walk [let]])

;;(setv query (get sys.argv 1)) ;; "select ?s ?p ?o { ?s ?p ?o } limit 2"

(setv wikidata-endpoint "https://query.wikidata.org/bigdata/namespace/wdq/sparql")
(setv dbpedia-endpoint "https://dbpedia.org/sparql")

(defn do-query-helper [endpoint query]
  ;; Construct a request
  (setv params { "query" query "format" "json"})

  ;; Call the API
  (setv response (requests.get endpoint :params params))

  (setv json-data (response.json))

  (setv vars (get (get json-data "head") "vars"))

  (setv results (get json-data "results"))

  (if (in "bindings" results)
      (let [bindings (get results "bindings")]
        (lfor binding bindings
              (lfor var vars
                    [var (get (get binding var) "value")])))
      []))

(defn wikidata-sparql [query]
  (do-query-helper wikidata-endpoint query))

(defn dbpedia-sparql [query]
  (do-query-helper dbpedia-endpoint query))

;;(pprint (wikidata-sparql query))
;;(pprint (dbpedia-sparql query))
