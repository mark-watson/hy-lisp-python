#!/usr/bin/env hy

(import [flask [Flask render_template request]])

(setv app (Flask "Flask and Jinja2 test"))

(with-decorator (app.route "/")
  (defn index []
    (render_template "template1.j2")))

(with-decorator (app.route "/response" :methods ["POST"])
  (defn response []
    (setv name (request.form.get "name"))
    (print name)
    (setv result request.form)
    (print result)
    (render_template "template1.j2" :name name)))

(app.run)

