#!/bin/bash

DATABASE_NAME="theater_sales"

# delete the existing theaters data
mysql "$DATABASE_NAME" -e "SET FOREIGN_KEY_CHECKS = 0; TRUNCATE TABLE Theaters;"

# insert theaters data
mysql "$DATABASE_NAME" -e "INSERT INTO Theaters (theater_name, location) VALUES ('Cinema City', 'Medford'), ('Regal', 'Seattle');"

echo "'theaters' data inserted successfully."

# delete the existing movies data
mysql "$DATABASE_NAME" -e "SET FOREIGN_KEY_CHECKS = 0; TRUNCATE TABLE Movies;"

# insert movies data
mysql "$DATABASE_NAME" -e "INSERT INTO Movies (movie_title, genre) VALUES ('Caddo Lake', 'Mystery'), ('Inception', 'Sci-Fi');"

echo "'movies' data inserted successfully."

# delete the existing sales data
mysql "$DATABASE_NAME" -e "SET FOREIGN_KEY_CHECKS = 0; TRUNCATE TABLE Sales;"

# insert sales data
mysql "$DATABASE_NAME" -e "INSERT INTO Sales (theater_id, movie_id, sale_date, amount_sold) VALUES 
(1, 1, '2024-10-30', 195.00),
(1, 2, '2024-10-30', 125.00),
(2, 1, '2024-10-30', 250.00),
(2, 2, '2024-10-30', 75.00),
(1, 1, '2024-10-30', 50.00),
(1, 2, '2024-10-31', 170.00),
(2, 1, '2024-10-31', 210.00),
(2, 2, '2024-10-31', 90.00),
(1, 2, '2024-10-31', 10.00),
(2, 1, '2024-10-31', 65.00);"

echo "'sales' data inserted successfully."