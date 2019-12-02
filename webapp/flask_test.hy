#!/usr/bin/env hy

;; snippet by HN user volent:

(import [flask [Flask]])
(setv app (Flask "Flask test"))
(with-decorator (app.route "/")
  (defn index []
    "Hello World !"))
(app.run)

