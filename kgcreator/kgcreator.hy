#!/usr/bin/env hy

(import [os [scandir]])
(import [os.path [splitext exists]])

(import [data2neo4j [Data2Neo4j]])
(import [data2rdf [Data2Rdf]])

(defn process-directory [directory-name output-rdf output-cypher]
  (with [frdf (open output-rdf "w")]
    (with [fcypher (open output-cypher "w")]
      (with [entries (scandir directory-name)]
        (for [entry entries]
          ;;(print entry.path)
          (setv [_ file-extension] (splitext entry.name))
          (if (= file-extension ".txt")
              (do
                (setv check-file-name (+ (cut entry.path 0 -4) ".meta"))
                (if (exists check-file-name)
                    (process-file entry.path check-file-name frdf fcypher)
                    (print "Warning: no .meta file for" entry.path
                           "in directory" directory-name)))))))))

(defn process-file [txt-path meta-path frdf fcypher]
  (defn read-data [text-path meta-path]
    (with [f (open text-path)] (setv t1 (.read f)))
    (with [f (open meta-path)] (setv t2 (.read f)))
    [t1 t2])

  (setv [txt meta] (read-data txt-path meta-path))
  (print txt meta)
  (Data2Rdf txt meta frdf)
  (Data2Neo4j txt meta fcypher))
        
(defn read-dataXX [text-path meta-path]
  (with [f (open text-path)] (setv t1 (.read f)))
  (with [f (open meta-path)] (setv t2 (.read f)))
  [t1 t2])


(process-directory "test_data" "output.rdf" "output.cypher")
