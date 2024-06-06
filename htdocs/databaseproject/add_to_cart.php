<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "dbproject";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $userId = isset($_POST['userId']) ? (int)$_POST['userId'] : null;
    $productId = isset($_POST['productId']) ? (int)$_POST['productId'] : null;

    if ($userId !== null && $productId !== null) {
        $sql = "INSERT INTO carts (user_id, product_id) VALUES (?, ?)";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("ii", $userId, $productId);

        if ($stmt->execute()) {
            echo "Product added to cart successfully";
        } else {
            echo "Error adding product to cart: " . $conn->error;
        }

        $stmt->close();
    } else {
        echo "Invalid input";
    }
} else {
    echo "Invalid request method";
}

$conn->close();
?>
