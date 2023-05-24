#!/usr/bin/env hy

(import postgres-lib [connection-and-cursor query])

(defn test-postgres-lib []
  (setv [conn cursor] (connection-and-cursor "hybook" "markw"))
  (query cursor "CREATE TABLE people (name TEXT, email TEXT);")
  (conn.commit)
  (query cursor "INSERT INTO people VALUES ('Mark',  'mark@markwatson.com')")
  (query cursor "INSERT INTO people VALUES ('Kiddo', 'kiddo@markwatson.com')")
  (conn.commit)
  (query cursor "SELECT * FROM people")
  (print (cursor.fetchall))
  (query cursor "UPDATE people SET name = %s WHERE email = %s"
      ["Mark Watson" "mark@markwatson.com"])
  (query cursor "SELECT * FROM people")
  (print (cursor.fetchall))
  (query cursor "DELETE FROM people  WHERE name = %s" ["Kiddo"])
  (query cursor "SELECT * FROM people")
  (print (cursor.fetchall))
  (query cursor "DROP TABLE people;")
  (conn.commit)
  (conn.close))

(test-postgres-lib)
