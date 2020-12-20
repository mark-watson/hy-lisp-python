from psycopg2 import connect


def connection_and_cursor(dbname, username):
    conn = connect(dbname=dbname, user=username)
    cursor = conn.cursor()
    return [conn, cursor]


def query(cursor, sql, variable_bindings=None):
    return cursor.execute(sql, variable_bindings
        ) if variable_bindings else cursor.execute(sql)

