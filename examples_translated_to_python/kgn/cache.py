from hy.core.language import first
from sqlite3 import connect, version, Error
import json
from os import getenv
hyx_XasteriskXdb_pathXasteriskX = '{}/.kgn_hy_cache.db'.format(getenv('HOME'))


def create_db():
    try:
        conn = connect(hyx_XasteriskXdb_pathXasteriskX)
        print(version)
        cur = conn.cursor()
        cur.execute(
            'CREATE TABLE dbpedia (query string  PRIMARY KEY ASC, data json)')
        _hy_anon_var_1 = conn.close()
    except Exception as e:
        _hy_anon_var_1 = print(e)
    return _hy_anon_var_1


def save_query_results_dbpedia(query, result):
    try:
        conn = connect(hyx_XasteriskXdb_pathXasteriskX)
        cur = conn.cursor()
        cur.execute('insert into dbpedia (query, data) values (?, ?)', [
            query, json.dumps(result)])
        conn.commit()
        _hy_anon_var_3 = conn.close()
    except Exception as e:
        _hy_anon_var_3 = print(e)
    return _hy_anon_var_3


def fetch_result_dbpedia(query):
    results = []
    conn = connect(hyx_XasteriskXdb_pathXasteriskX)
    cur = conn.cursor()
    cur.execute('select data from dbpedia where query = ? limit 1', [query])
    d = cur.fetchall()
    if len(d) > 0:
        results = json.loads(first(first(d)))
        _hy_anon_var_5 = None
    else:
        _hy_anon_var_5 = None
    conn.close()
    return results


create_db()

