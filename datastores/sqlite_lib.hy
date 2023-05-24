(import sqlite3)

(defn create-db [db-file-path] ;; db-file-path can also be ":memory:"
  (setv conn (sqlite3.connect db-file-path))
  (print version)
  (conn.close))

(defn connection [db-file-path] ;; db-file-path can also be ":memory:"
  (sqlite3.connect db-file-path))

(defn query [conn sql [variable-bindings None]]
  (setv cur (conn.cursor))
  (if variable-bindings
    (cur.execute sql variable-bindings)
    (cur.execute sql))
  (cur.fetchall))

  