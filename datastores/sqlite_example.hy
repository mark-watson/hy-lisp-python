#!/usr/bin/env hy

;;(import sqlite-lib [create-db connection query])
(import sqlite3)

(defn query [conn sql &optional [variable-bindings None]]
(print variable-bindings)
  (setv cur (conn.cursor))
  (if variable-bindings
    (cur.execute sql variable-bindings)
    (cur.execute sql))
  (cur.fetchall))

(defn test_sqlite-lib []
  (setv conn (sqlite3.connect "test.db"))
  (query conn "CREATE TABLE people (name TEXT, email TEXT);")
  (print
    (query conn "INSERT INTO people VALUES ('Mark', 'mark@markwatson.com')"))
  (print
    (query conn "INSERT INTO people VALUES ('Kiddo', 'kiddo@markwatson.com')"))
  (print
    (query conn "SELECT * FROM people"))
  (print
    (query conn "UPDATE people SET name = ? WHERE email = ?"
      ["Mark Watson" "mark@markwatson.com"]))
  (print
    (query conn "SELECT * FROM people"))
  (print
    (query conn "DELETE FROM people  WHERE name=?" ["Kiddo"]))
    (print
    (query conn "SELECT * FROM people"))
  (conn.close))

(test_sqlite-lib)