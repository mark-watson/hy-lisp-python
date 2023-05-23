(import pdfminer.high_level [extract_text])

;; May 23, 2023: I removed old code to remove unwanted text after calling pdfminer.
;; For now, I am just using pdfminer as-is.

(defn pdf2text [s]
  (extract_text s))

(print (pdf2text "Sales force - Multi-Hop Knowledge Graph Reasoning with Reward Shaping.pdf"))

