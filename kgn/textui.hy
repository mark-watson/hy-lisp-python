(import [PyInquirer [style_from_dict Token prompt Separator]])

(import [pprint [pprint]])
(require [hy.contrib.walk [let]])

(defn select-entities [people organizations]
  (let [choices []]
    (.append choices (Separator "- People -"))
    (for [person people]
      (.append choices { "name" (.join " " person) }))
    (.append choices (Separator "- Organizations -"))
    (for [org organizations]
      (.append choices { "name" (.join " " org) }))
    (setv questions
          [
           {
            "type" "checkbox"
            "qmark" "😃"
            "message" "Select entitites to process"
            "name" "entitities"
            "choices" choices
            }
           ]
          )
    (prompt questions)))

(defn get-query []
  (get
    (prompt [{"type" "input"
              "name" "query"
              "message" "Enter a list of entities"}])
    "query"))

;(print
;  (select-entities
;    [["Bill 1" "Micosoft founder.."]
;     ["Bill 2" "Frontiesman and hunter.."]]
;    [["IBM" "International Business Machines"]]))

;(print (get-query))
