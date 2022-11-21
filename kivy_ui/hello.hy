(import kivy.app [App])
(import kivy.uix.button [Button])

(defclass HelloApp [App]
  (defn build [self]
    (Button :text "Hello Hy!")))

(.run (HelloApp))
