(import [sqlite3 [connect version Error ]])
(import json)

(setv *db-path* "kgn_hy_cache.db")

(defn create-db []
  (try
    (setv conn (connect *db-path*))
    (print version)
    (setv cur (conn.cursor))
    (cur.execute "CREATE TABLE dbpedia (query string  PRIMARY KEY ASC, data json)")
    (conn.close)
    (except [e Exception] (print e))))

(defn save-query-results-dbpedia [query result]
  (try
    (setv conn (connect *db-path*))
    (setv cur (conn.cursor))
    (cur.execute "insert into dbpedia (query, data) values (?, ?)" [query (json.dumps result)])
    (conn.commit)
    (conn.close)
    (except [e Exception] (print e))))
 
(defn fetch-result-dbpedia [query]
  (setv results [])
  (setv conn (connect *db-path*))
  (setv cur (conn.cursor))
  (cur.execute "select data from dbpedia where query = ? limit 1" [query])
  (setv d (cur.fetchall))
  (if (> (len d) 0)
      (setv results (json.loads (first (first d)))))
  (conn.close)
  results)
 
(create-db)

