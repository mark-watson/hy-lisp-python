(import [pdfminer.high_level [extract_text]])
(import re)

(defn p2t [s]
  (setv text (extract_text s))
  (.replace
    (.replace
      (.replace
        (.replace 
          (re.sub "([\d])" "" text)
          "  "
          " ")
        "()"
        "")
      ".."
      ".")
    "\n.\n"
    "\n"))


# (print (p2t "Sales force - Multi-Hop Knowledge Graph Reasoning with Reward Shaping.pdf"))

