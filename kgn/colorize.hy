(import io [StringIO])

;; Utilities to add ANSI terminal escape sequences to colorize text.
;; note: the following 5 functions return string values that then need to
;;       be printed.

(defn blue [s] (.format "{}{}{}" "\033[94m" s "\033[0m"))
(defn red [s] (.format "{}{}{}" "\033[91m" s "\033[0m"))
(defn green [s] (.format "{}{}{}" "\033[92m" s "\033[0m"))
(defn pink [s] (.format "{}{}{}" "\033[95m" s "\033[0m"))
(defn bold [s] (.format "{}{}{}" "\033[1m" s "\033[0m"))

(defn tokenize-keep-uris [s]
  (.split s))

(defn colorize-sparql [s]
  (setv tokens
        (tokenize-keep-uris
          (.replace (.replace s "{" " { ") "}" " } ")))
  (setv ret (StringIO)) ;; ret is an output stream for a string buffer
  (for [token tokens]
    (when (> (len token) 0)
        (if (= (get token 0) "?")
            (.write ret (red token))
            (if (in
                  token
                  ["where" "select" "distinct" "option" "filter"
                    "FILTER" "OPTION" "DISTINCT" "SELECT" "WHERE"])
                (.write ret (blue token))
                (if (= (get token 0) "<")
                    (.write ret (bold token))
                    (.write ret token)))))
    (when (not (= token "?"))
        (.write ret " ")))
  (.seek ret 0)
  (.read ret))

;;(print (colorize-sparql "select ?s ?p  where {?s ?p <http://dbpedia.org/schema/Person>}."))
