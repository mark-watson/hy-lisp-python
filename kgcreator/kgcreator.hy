#!/usr/bin/env hy

(import [os [scandir]])
(import [os.path [splitext exists]])

(import [data2neo4j [Data2Neo4j]])
(import [data2rdf [Data2Rdf]])
(import [text2semantics [find-entities-in-text]])

(defn process-directory [directory-name output-rdf]
  (with [frdf (open output-rdf "w")]
    (with [entries (scandir directory-name)]
      (for [entry entries]
        ;;(print entry.path)
        (setv [_ file-extension] (splitext entry.name))
        (if (= file-extension ".txt")
            (do
              (setv check-file-name (+ (cut entry.path 0 -4) ".meta"))
              (if (exists check-file-name)
                  (process-file entry.path check-file-name frdf)
                  (print "Warning: no .meta file for" entry.path
                         "in directory" directory-name))))))))

(defn process-file [txt-path meta-path frdf]
  
  (defn read-data [text-path meta-path]
    (with [f (open text-path)] (setv t1 (.read f)))
    (with [f (open meta-path)] (setv t2 (.read f)))
    [t1 t2])
  
  (defn modify-entity-names [ename]
    (.replace ename "the " ""))
  
  (setv [txt meta] (read-data txt-path meta-path))
  (print txt meta)
  (setv entities (find-entities-in-text txt))
  (setv entities ;; only operate on a few entity types
        (lfor [e t] entities
              :if (in t ["NORP" "ORG" "PRODUCT" "GPE" "PERSON" "LOC"])
              [(modify-entity-names e) t]))
  (Data2Rdf meta entities frdf))
        


(process-directory "test_data" "output.rdf")

;;(setv v [["European" "NORP"] ["Portuguese" "NORP"] ["Banco Espirito Santo SA" "ORG"] ["last\nweek" "DATE"] ["Banco Espirito\n" "ORG"] ["December" "DATE"] ["The Wall\nStreet Journal" "ORG"] ["Thursday" "DATE"] ["Banco Espirito Santo's" "ORG"] ["Coke" "PRODUCT"] ["IBM" "ORG"] ["Canada" "GPE"] ["France" "GPE"] ["the Australian Broadcasting Corporation" "ORG"] ["Australian Broadcasting Corporation" "ORG"] ["Story" "PERSON"] ["Frank Munoz" "PERSON"] ["the Australian Writers Guild" "ORG"] ["the American University" "ORG"]])
