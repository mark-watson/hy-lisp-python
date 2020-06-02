#!/usr/bin/env hy

(import json)
(import os)
(import sys)
(import [pprint [pprint]])
(import requests)

(setv query (get sys.argv 1)) ;; "select ?s ?p ?o { ?s ?p ?o } limit 2"

(setv endpoint "https://query.wikidata.org/bigdata/namespace/wdq/sparql")


;; Construct a request
(setv params { "query" query "format" "json"})

;; Call the API
(setv response (requests.get endpoint :params params))

(setv json-data (response.json))
(pprint json-data)
