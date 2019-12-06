#!/usr/bin/env hy

(import [sqlite-lib [create-db connection query]])

(defn test_sqlite-lib []
  (setv dbpath ":memory:")
  (create-db dbpath)
  (setv conn (connection ":memory:"))
  (query conn "CREATE TABLE people (name TEXT, email TEXT);")
  (print
    (query conn "INSERT INTO people VALUES ('Mark', 'mark@markwatson.com')"))
  (print
    (query conn "INSERT INTO people VALUES ('Kiddo', 'kiddo@markwatson.com')"))
  (print
    (query conn "SELECT * FROM people"))
  (conn.close))

(test_sqlite-lib)