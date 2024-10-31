#!/bin/bash

MYSQL_USER="root"
DATABASE_NAME="theater_sales"

# create theater_sales database
mysql -u "$MYSQL_USER" -e "CREATE DATABASE IF NOT EXISTS $DATABASE_NAME;" 

if [ $? -eq 0 ]; then
    echo "Database '$DATABASE_NAME' created successfully."
else
    echo "Error creating database '$DATABASE_NAME'."
fi

# create theaters table
mysql "$DATABASE_NAME" -e "CREATE TABLE IF NOT EXISTS Theaters (
    theater_id INT AUTO_INCREMENT PRIMARY KEY,
    theater_name VARCHAR(25),
    location VARCHAR(25)
);"

echo "Table 'theaters' created successfully."

# create movies table
mysql "$DATABASE_NAME"  -e "CREATE TABLE IF NOT EXISTS Movies (
    movie_id INT AUTO_INCREMENT PRIMARY KEY,
    movie_title VARCHAR(50),
    genre VARCHAR(50)
);"

echo "Table 'movies' created successfully."

# create sales table
mysql "$DATABASE_NAME" -e "CREATE TABLE IF NOT EXISTS Sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    theater_id INT,
    movie_id INT,
    sale_date DATE,
    amount_sold DECIMAL(10, 2),
    FOREIGN KEY (theater_id) REFERENCES Theaters(theater_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);"

echo "Table 'sales' created successfully."
