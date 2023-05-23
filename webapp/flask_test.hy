#!/usr/bin/env hy

;; snippet by HN user volent:

(import flask [Flask])
(setv app (Flask "Flask test"))
(defn [(.route app "/")] index [] "Hello World !")
(app.run)

