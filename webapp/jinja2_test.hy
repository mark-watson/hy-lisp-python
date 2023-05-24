#!/usr/bin/env hy

(import flask [Flask render_template request])

(setv app (Flask "Flask and Jinja2 test"))

(defn [(.route app "/")]
  index []
    (render_template "template1.j2"))

(defn [(.route app "/response" :methods ["POST"])]
  response []
    (setv name (request.form.get "name"))
    (print name)
    (render_template "template1.j2" :name name))

(app.run)

