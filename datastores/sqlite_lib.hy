(import [sqlite3 [connect version Error ]])

(defn create-db [db-file-path] ;; db-file-path can also be ":memory:"
  (setv conn (connect db-file-path))
  (print version)
  (conn.close))

(defn connection [db-file-path] ;; db-file-path can also be ":memory:"
  (connect db-file-path))

(defn query [conn sql &optional variable-bindings]
  (setv cur (conn.cursor))
  (if variable-bindings
    (cur.execute sql variable-bindings)
    (cur.execute sql))
  (cur.fetchall))

  