#!/usr/bin/env hy

(import [flask [Flask render_template request make-response]])

(setv app (Flask "Flask and Jinja2 test"))

(with-decorator (app.route "/")
  (defn index []
    (setv cookie-data (request.cookies.get "hy-cookie"))
    (print "cookie-data:" cookie-data)
    (setv a-response (render_template "template1.j2" :name cookie-data))
    a-response))

(with-decorator (app.route "/response" :methods ["POST"])
  (defn response []
    (setv name (request.form.get "name"))
    (print name)
    (setv a-response (make-response (render-template "template1.j2" :name name)))
    (a-response.set-cookie "hy-cookie" name)
    a-response))

(app.run)

