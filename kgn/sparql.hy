#!/usr/bin/env hy

(import json)
(import requests)
(require [hy.contrib.walk [let]])

(import [cache [fetch-result-dbpedia save-query-results-dbpedia]])

(setv wikidata-endpoint "https://query.wikidata.org/bigdata/namespace/wdq/sparql")
(setv dbpedia-endpoint "https://dbpedia.org/sparql")

(defn do-query-helper [endpoint query]
  ;; check cache:
  (setv cached-results (fetch-result-dbpedia query))
  (if (> (len cached-results) 0)
      (let ()
        (print "Using cached query results")
        (eval cached-results))
      (let ()
        ;; Construct a request
        (setv params { "query" query "format" "json"})
        
        ;; Call the API
        (setv response (requests.get endpoint :params params))
        
        (setv json-data (response.json))
        
        (setv vars (get (get json-data "head") "vars"))
        
        (setv results (get json-data "results"))
        
        (if (in "bindings" results)
            (let [bindings (get results "bindings")
                  qr
                  (lfor binding bindings
                        (lfor var vars
                              [var (get (get binding var) "value")]))]
              (save-query-results-dbpedia query qr)
              qr)
            []))))

(defn wikidata-sparql [query]
  (do-query-helper wikidata-endpoint query))

(defn dbpedia-sparql [query]
  (do-query-helper dbpedia-endpoint query))

;;(print (dbpedia-sparql "select ?s ?p ?o { ?s ?p ?o } limit 4"))
