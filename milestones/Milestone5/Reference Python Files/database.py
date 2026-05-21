# IMPORTANT: All SQL-related logic must be confined to this file.
# Students will not receive credit for this project if SQL code or database logic is found outside of database.py.
# Usage example for interfacing with the database:
#    from database import *
#    data_from_select = Database.select(query, (value_1, value_2, ..., value_n))

import os
import pymysql.cursors

# Environment variables for database connectivity. These should be set securely in your project's environment settings.
db_host = os.environ["DB_HOST"]
db_username = os.environ["DB_USER"]
db_password = os.environ["DB_PASSWORD"]
db_name = os.environ["DB_NAME"]


class Database:
    """
    Provides static methods to handle common database operations.

    Methods:
        delete(query, values=None): Execute a DELETE SQL command.
        insert(query, values=None, many_entities=False): Execute an INSERT SQL command.
        select(query, values=None, fetch=True): Execute a SELECT SQL command and optionally fetch results.
        update(query, values=None): Execute an UPDATE SQL command.
    """

    def connect(self, close_connection=False):
        """
        Establishes a connection to the database using predefined environment variables.

        Args:
            close_connection (bool): If True, the connection will be closed immediately after being established.

        Returns:
            The database connection object if close_connection is False, otherwise True on successful connection.

        Raises:
            ConnectionError: If the connection to the database fails.
        """
        try:
            conn = pymysql.connect(host=db_host, port=3306, user=db_username, password=db_password,
                                   db=db_name, charset="utf8mb4", cursorclass=pymysql.cursors.DictCursor)
            print(f"Connected to database {db_name}")
            return conn if not close_connection else True
        except ConnectionError as err:
            print(f"Failed to connect to the database: {err}")
            if close_connection:
                conn.close()
            raise

    def get_response(self, query, values=None, fetch=False, many_entities=False, type=None):
        """
        Executes a SQL query with optional values and fetches results if requested.

        Args:
            query (str): SQL query string to be executed.
            values (tuple, optional): Parameters to be used with the query.
            fetch (bool): If True, fetches and returns the query results.
            many_entities (bool): If True, executes the query for many records.

        Returns:
            The result of the query if fetch is True; None otherwise.
        """
        connection = self.connect()
        cursor = connection.cursor()
        try:
            if values:
                if type=="Proc":
                    cursor.callproc(query, values)
                cursor.executemany(query, values) if many_entities else cursor.execute(query, values)
            else:
                cursor.execute(query)
            if fetch:
                return cursor.fetchall()
        finally:
            connection.commit()
            cursor.close()
            connection.close()

    @staticmethod
    def select(query, values=None, fetch=True):
        return Database().get_response(query, values=values, fetch=fetch)

    @staticmethod
    def insert(query, values=None, many_entities=False):
        return Database().get_response(query, values=values, many_entities=many_entities)

    @staticmethod
    def update(query, values=None):
        return Database().get_response(query, values=values)

    @staticmethod
    def delete(query, values=None):
        return Database().get_response(query, values=values)

    @staticmethod
    def callprocedure(sql_stored_component, parameters, fetch=False):
        return Database.get_response(sql_stored_component, values=parameters, type="Proc", fetch=fetch)

    # TODO: Implement additional methods to facilitate further data manipulation as required by your application.


class Query:
    """
    The implementation of triggers, functions, and procedures related to the project can be executed directly 
    from MySQL Workbench connected to your RDS instance, as they do not require user parameters and are activated 
    by predefined queries. All calls to these components should be handled through this class.
    """

    # TODO: Create all your queries or calls to your sql stored components here
    pass

class Tables:
    # TODO: Create here all the constants for your table descriptors
    pass