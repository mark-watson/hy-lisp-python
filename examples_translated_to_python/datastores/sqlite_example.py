from sqlite_lib import create_db, connection, query


def test_sqlite_lib():
    dbpath = ':memory:'
    create_db(dbpath)
    conn = connection(':memory:')
    query(conn, 'CREATE TABLE people (name TEXT, email TEXT);')
    print(query(conn,
        "INSERT INTO people VALUES ('Mark', 'mark@markwatson.com')"))
    print(query(conn,
        "INSERT INTO people VALUES ('Kiddo', 'kiddo@markwatson.com')"))
    print(query(conn, 'SELECT * FROM people'))
    print(query(conn, 'UPDATE people SET name = ? WHERE email = ?', [
        'Mark Watson', 'mark@markwatson.com']))
    print(query(conn, 'SELECT * FROM people'))
    print(query(conn, 'DELETE FROM people  WHERE name=?', ['Kiddo']))
    print(query(conn, 'SELECT * FROM people'))
    return conn.close()


test_sqlite_lib()

