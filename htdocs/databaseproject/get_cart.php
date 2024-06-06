<?php
// Database connection parameters
$servername = "localhost";
$username = "root"; // Replace with your database username
$password = ""; // Replace with your database password
$dbname = "dbproject";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Get user ID from the request (assuming it's passed as a parameter)
$userId = $_GET['userId'];

// Fetch cart items for the user
$query = "SELECT products.id, products.title, products.description, products.image_url, products.price
          FROM carts
          INNER JOIN products ON carts.product_id = products.id
          WHERE carts.user_id = $userId";

$result = mysqli_query($conn, $query);

if ($result) {
    // Fetch rows and store them in an array
    $cartItems = array();
    while ($row = mysqli_fetch_assoc($result)) {
        $cartItems[] = $row;
    }

    // Return cart items as JSON response
    echo json_encode($cartItems);
} else {
    // Handle query execution error
    echo "Failed to fetch cart items: " . mysqli_error($conn);
}

// Close database connection
mysqli_close($conn);
?>
