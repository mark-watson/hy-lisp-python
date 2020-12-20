from postgres_lib import connection_and_cursor, query


def test_postgres_lib():
    [conn, cursor] = connection_and_cursor('hybook', 'markw')
    query(cursor, 'CREATE TABLE people (name TEXT, email TEXT);')
    conn.commit()
    query(cursor, "INSERT INTO people VALUES ('Mark',  'mark@markwatson.com')")
    query(cursor, "INSERT INTO people VALUES ('Kiddo', 'kiddo@markwatson.com')"
        )
    conn.commit()
    query(cursor, 'SELECT * FROM people')
    print(cursor.fetchall())
    query(cursor, 'UPDATE people SET name = %s WHERE email = %s', [
        'Mark Watson', 'mark@markwatson.com'])
    query(cursor, 'SELECT * FROM people')
    print(cursor.fetchall())
    query(cursor, 'DELETE FROM people  WHERE name = %s', ['Kiddo'])
    query(cursor, 'SELECT * FROM people')
    print(cursor.fetchall())
    query(cursor, 'DROP TABLE people;')
    conn.commit()
    return conn.close()


test_postgres_lib()

