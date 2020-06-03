(import [sqlite3 [connect version Error ]])

(setv *db-path* "kgn_hy_cache.db")

(defn create-db []
  (try
    (setv conn (connect *db-path*))
    (print version)
    (setv cur (conn.cursor))
    (cur.execute "CREATE TABLE dbpedia (query string  PRIMARY KEY ASC, result string)")
    (conn.close)
    (except [e Exception] (print e))))

(defn save-query-results-dbpedia [query result]
  (try
    (setv conn (connect *db-path*))
    (setv cur (conn.cursor))
    (print "save query and result:")
    (setv sql (.format
                "insert into dbpedia (query, result) values (\"{}\", \"{}\");"
                query result))
    (print ["sql:" sql])
    (cur.execute sql)
    (conn.commit)
    (conn.close)
    (except [e Exception] (print e))))
 
(defn fetch-result-dbpedia [query]
  (setv results [])
  (try
    (setv conn (connect *db-path*))
    (setv cur (conn.cursor))
    (print "check is query is cached:")
    (setv sql (.format "select result from dbpedia where query = \"{}\";" query))
    (print ["sql:" sql])
    (cur.execute sql)
    (setv results (cur.fetchall))
    (conn.close)
    (except [e Exception] (print e)))
  (lfor result results (first result)))
 

(create-db)
(save-query-results-dbpedia "q1" "r1")
(print (fetch-result-dbpedia "q1"))
(print (fetch-result-dbpedia "q1notthere"))
