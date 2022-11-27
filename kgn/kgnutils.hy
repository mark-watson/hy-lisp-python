#!/usr/bin/env hy

(import sparql [dbpedia-sparql])
(import colorize [colorize-sparql])

(import pprint [pprint])

(defn dbpedia-get-entities-by-name [name dbpedia-type]
  (setv sparql
        (.format "select distinct ?s ?comment {{ ?s ?p \"{}\"@en . ?s <http://www.w3.org/2000/01/rdf-schema#comment>  ?comment  . FILTER  (lang(?comment) = 'en') . ?s <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> {} . }} limit 15" name dbpedia-type))
  (print "Generated SPARQL to get DBPedia entity URIs from a name:")
  (print (colorize-sparql sparql))
  (dbpedia-sparql sparql))

;;(pprint (dbpedia-get-entities-by-name "Bill Gates" "<http://dbpedia.org/ontology/Person>"))

(defn first [a-list]
  (get a-list 0))

(defn second [a-list]
  (get a-list 1))
