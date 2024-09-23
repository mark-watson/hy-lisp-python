#!/usr/bin/env hy

(import os [scandir])
(import os.path [splitext exists])
(import spacy)

;; To load data file from the web (only need to do this once per Pyhton env):
;;     python -m spacy download en_core_web_sm

(setv nlp-model (spacy.load "en_core_web_sm"))

(defn find-entities-in-text [some-text]
  (defn clean [s]
    (.strip (.replace s "\n" " ")))
  (let [doc (nlp-model some-text)]
    (map list (lfor entity doc.ents [(clean entity.text) entity.label_]))))

(defn data2Rdf [meta-data entities fout]
  (for [[value abbreviation] entities]
    (when (in abbreviation e2umap)
      (.write fout (+ "<" meta-data ">\t" (get e2umap abbreviation) "\t" "\"" value "\"" " .\n")))))

(setv e2umap {
  "ORG" "<https://schema.org/Organization>"
  "LOC" "<https://schema.org/location>"
  "GPE" "<https://schema.org/location>"
  "NORP" "<https://schema.org/nationality>"
  "PRODUCT" "<https://schema.org/Product>"
  "PERSON" "<https://schema.org/Person>"})

(defn process-directory [directory-name output-rdf]
  (with [frdf (open output-rdf "w")]
    (with [entries (scandir directory-name)]
      (for [entry entries]
        (setv [_ file-extension] (splitext entry.name))
        (when (= file-extension ".txt")
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

  (let [[txt meta] (read-data txt-path meta-path)
        entities (find-entities-in-text txt)
        entities ;; only operate on a few entity types
        (lfor [e t] entities
              :if (in t ["NORP" "ORG" "PRODUCT" "GPE" "PERSON" "LOC"])
              [(modify-entity-names e) t])]
    (data2Rdf meta entities frdf)))

(process-directory "test_data" "output.rdf")
