<?php 

# local database credentials
$host = 'theater_sales';
$db = 'theater_db';
$user = 'root';
$pass = '';

try {
    // prompt the user for a date
    $dateInput = readline("Enter a date (YYYY-MM-DD): ");

    // validate the date format
    if (!DateTime::createFromFormat('Y-m-d', $dateInput)) {
        echo "Invalid date format. Please try again.\n";
        exit;
    }

    // create a database connection
    $pdo = new PDO("mysql:host=$host;dbname=$db", $user, $pass);
    
    // prepare the SQL statement
    $query = $pdo->prepare("
        Select theater_name, sum(sales.amount_sold) as total
        FROM Sales sales
        JOIN Theaters theaters ON sales.theater_id = theaters.theater_id
        WHERE sales.sale_date = :sale_date
        GROUP BY sales.theater_id
        ORDER BY total DESC
        LIMIT 1
    ");

    // bind parameters and execute
    $query->bindParam(':sale_date', $dateInput);
    $query->execute();

    // fetch the results
    $result = $query->fetch(PDO::FETCH_ASSOC);

    if ($result) {
        echo "The {$result['theater_name']} theater had the most sales on {$dateInput} with a total of {$result['total_sales']}.";
    } else {
        echo "No sales for {$dateInput}. Try 2024-10-30 or 2024-10-31.";
    }
} catch (PDOException $e) {
    echo "Error: " . $e->getMessage() . "\n";
}

?>