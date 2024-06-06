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
        $sql = "DELETE FROM carts WHERE user_id = ? AND product_id = ?";
        $stmt = $conn->prepare($sql);
        if ($stmt) {
            $stmt->bind_param("ii", $userId, $productId);
            if ($stmt->execute()) {
                echo "Cart item deleted successfully";
            } else {
                echo "Error deleting cart item: " . $stmt->error;
            }
            $stmt->close();
        } else {
            echo "Error preparing SQL statement: " . $conn->error;
        }
    } else {
        echo "Invalid input";
    }
} else {
    echo "Invalid request method";
}

$conn->close();
?>
