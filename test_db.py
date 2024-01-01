import psycopg2
import pytest

# Database parameters for connection
db_params = {
    'dbname': 'postgres',
    'user': 'postgres',
    'password': 'mysecretpassword',
    'host': 'postgres'
}

@pytest.fixture(scope="module")
def db_connection():
    conn = psycopg2.connect(**db_params)
    yield conn
    conn.close()

@pytest.fixture(scope="module")
def db_cursor(db_connection):
    cursor = db_connection.cursor()
    yield cursor
    cursor.close()

def test_basic_query(db_connection):
    """
    This test checks if a basic SQL query works as expected.
    """
    cur = db_connection.cursor()
    cur.execute("SELECT 1;")
    result = cur.fetchone()
    assert result[0] == 1, "Basic query did not return expected result."

def test_create_table(db_cursor, db_connection):
    db_cursor.execute("CREATE TABLE IF NOT EXISTS test_table (id serial PRIMARY KEY, name varchar (50) NOT NULL);")
    db_connection.commit()

def test_alter_table(db_cursor, db_connection):
    db_cursor.execute("ALTER TABLE test_table ADD COLUMN age int;")
    db_connection.commit()

def test_insert_data(db_cursor, db_connection):
    db_cursor.execute("INSERT INTO test_table (name, age) VALUES ('Test Name', 30);")
    db_connection.commit()

def test_select_data(db_cursor):
    db_cursor.execute("SELECT * FROM test_table WHERE name = 'Test Name';")
    result = db_cursor.fetchone()
    assert result is not None, "No data found in test_table"
    assert result[1] == 'Test Name', "Data retrieved is not as expected"
    assert result[2] == 30, "Age value is not as expected"

def test_update_data(db_cursor, db_connection):
    db_cursor.execute("UPDATE test_table SET age = 31 WHERE name = 'Test Name';")
    db_connection.commit()

    db_cursor.execute("SELECT age FROM test_table WHERE name = 'Test Name';")
    result = db_cursor.fetchone()
    assert result[0] == 31, "Age value was not updated"

def test_delete_data(db_cursor, db_connection):
    db_cursor.execute("DELETE FROM test_table WHERE name = 'Test Name';")
    db_connection.commit()

    db_cursor.execute("SELECT * FROM test_table WHERE name = 'Test Name';")
    result = db_cursor.fetchone()
    assert result is None, "Data was not deleted"

def test_drop_table(db_cursor, db_connection):
    db_cursor.execute("DROP TABLE test_table;")
    db_connection.commit()
