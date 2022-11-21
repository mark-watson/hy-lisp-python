(import kivy.app [App])
(import kivy.uix.boxlayout [BoxLayout])
(import kivy.uix.button [Button])
(import kivy.uix.textinput [TextInput])
(import kivy.uix.label [Label])

;; TBD use code from NLP chapter in book

(defclass NlpApp [App]
  (defn build [self]
    (setv box-layout (BoxLayout :orientation "vertical"))
    (setv text-input (TextInput :font-size 40 :height 40 :size_hint_y 52))
    (setv prompt-label (Label :text "Enter text for Natural Language Processing:"
                              :size_hint_y 10 )) ;; :color [0.41 0.42 0.74 1]
                              ;;:background_color [0.9 0.9 0.9]))
    (setv output-label (Label :text "" :size_hint_y 120))
    (setv p-button (Button :text "Process" :size_hint_y 10))
    (.add-widget box-layout prompt-label)
    (.add-widget box-layout text-input)
    (.add-widget box-layout p-button)
    (.add-widget box-layout output-label)
    box-layout))

(.run (NlpApp))
