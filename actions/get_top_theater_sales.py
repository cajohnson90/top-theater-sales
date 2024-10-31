import mysql.connector
from datetime import datetime

"""
    Print the theater with top sales on a specific date.
    Args:
        date_str - the specified date
"""
def get_theater_sales(dates_str: str):
    try:
        # create the database connection
        connection = mysql.connector.connect(
            host="localhost",
            database="theater_sales",
            user="root"
        )

        # prepare the SQL statement
        cursor = connection.cursor()
        query = """
            Select theater_name, sum(sales.amount_sold) as total
            FROM Sales sales
            JOIN Theaters theaters ON sales.theater_id = theaters.theater_id
            WHERE sales.sale_date = %s
            GROUP BY sales.theater_id
            ORDER BY total DESC
            LIMIT 1
        """
        
        # bind parameters and execute the query
        cursor.execute(query, (dates_str,) )
        result = cursor.fetchone()

        # print the results
        if result:
            print(f"The {result[0]} theater had the most sales on {dates_str} with a total of ${result[1]:.2f}.")
        else:
            print(f"No sales for {dates_str}. Try 2024-10-30 or 2024-10-31.")

    except mysql.connector.Error as err:
        print(f"Error: {err}")

    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()

if __name__ == "__main__":
    date_input = None
    while True:
        try:
            # prompt the user for a date
            date_input = input("Enter a date (YYYY-MM-DD): ")

            # validate the input
            if not bool(datetime.strptime(date_input, '%Y-%m-%d')):
                raise ValueError()
            break
        except ValueError:
            print("Invalid date format. Please try again.")
    get_theater_sales(date_input)