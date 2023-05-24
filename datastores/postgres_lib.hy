(import psycopg2 [connect])

(defn connection-and-cursor [dbname username]
  (setv conn (connect :dbname dbname :user username))
  (setv cursor (conn.cursor))
  [conn cursor])

(defn query [cursor sql [variable-bindings None]]
  (if variable-bindings
    (cursor.execute sql variable-bindings)
    (cursor.execute sql)))

