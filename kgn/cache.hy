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
    (print "save query and result:")
    (setv sql (.format
                "insert into dbpedia (query, data) values (\"{}\", \"{}\");"
                query (json.dumps result)))
    (print ["sql:" sql "\n\njson.dumps result:" (json.dumps result)])
    (cur.execute "insert into dbpedia (query, data) values (?, ?)" [query (json.dumps result)])
    (conn.commit)
    (conn.close)
    (except [e Exception] (print e))))
 
(defn fetch-result-dbpedia [query]
  (setv results [])
  ;;(try
    (setv conn (connect *db-path*))
    (setv cur (conn.cursor))
    (print "check is query is cached:")
    ;; select json_extract(data, '$.name') from countries;
    ;;(setv sql (.format "select json_extract(result, '$.result') from dbpedia where query = \"{}\";" query))
    ;;(setv sql (.format "select result from dbpedia where query = \"{}\";" query))
    (print ["query:" query])
  (cur.execute "select data from dbpedia where query = ? limit 1" [query])
  (setv d (cur.fetchall))
  (print "d:") (print d)
  (if (> (len d) 0)
      (setv results (json.loads (first (first d)))))
    (conn.close)
    ;;(except [e Exception] (print e)))
  (print results)
  results)
  ;;(lfor result results (first result)))
 

(create-db)

