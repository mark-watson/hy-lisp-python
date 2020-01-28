(defn Data2Rdf [meta-data entities fout]
  (print "ENTITIES:" entities)
  (print "META DATA:" meta-data)
  (for [[value abreviation] entities]
    (print "ZZ" abreviation value)
    (if (in abreviation e2umap)
      (.write fout (+ "<" meta-data ">\t" (get e2umap abreviation) "\t" "\"" value "\"" "\n"))))
  )

(setv e2umap {
  "ORG" "<https://schema.org/Organization>"
  "LOC" "<https://schema.org/location>"
  "GPE" "<https://schema.org/location>"
  "NORP" "<https://schema.org/nationality>"
  "PRODUCT" "<https://schema.org/Product>"
  "PERSON" "<https://schema.org/Person>"
})
