(import PyInquirer [style_from_dict Token prompt Separator])

(import pprint [pprint])

(defn select-entities [people places organizations]
  (setv choices [])
  (.append choices (Separator "- People -"))
  (for [person people]
    (.append choices { "name" person }))
  (.append choices (Separator "- Places -"))
  (for [place places]
    (.append choices { "name" place }))
  (.append choices (Separator "- Organizations -"))
  (for [org organizations]
    (.append choices { "name" org }))
  (setv questions
        [
         {
          "type" "checkbox"
          "qmark" "😃"
          "message" "Select entitites to process"
          "name" "entities"
          "choices" choices
          }
         ]
        )
  (prompt questions))

(defn get-query []
  (get
    (prompt [{"type" "input"
              "name" "query"
              "message" "Enter a list of entities:"}])
    "query"))

