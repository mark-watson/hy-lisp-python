from sqlite3 import connect, version, Error


def create_db(db_file_path):
    conn = connect(db_file_path)
    print(version)
    return conn.close()


def connection(db_file_path):
    return connect(db_file_path)


def query(conn, sql, variable_bindings=None):
    cur = conn.cursor()
    cur.execute(sql, variable_bindings) if variable_bindings else cur.execute(
        sql)
    return cur.fetchall()

