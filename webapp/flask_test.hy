#!/usr/bin/env hy

;; snippet by HN user volent and modifed for
;; Hy 0.26.0 with a comment from stackoverflow user plokstele:

(import flask [Flask])
(setv app (Flask "Flask test"))
(defn [(.route app "/")] index [] "Hello World !")
(app.run)

