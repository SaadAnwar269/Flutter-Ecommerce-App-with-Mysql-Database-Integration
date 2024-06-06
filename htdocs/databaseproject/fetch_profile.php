<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "dbproject";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Get the userId from the query parameters
$userId = isset($_GET['userId']) ? intval($_GET['userId']) : 0;

$sql = "SELECT * FROM profile WHERE userId = $userId";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // Output data of each row
    $profile = $result->fetch_assoc();
    echo json_encode($profile);
} else {
    echo json_encode(new stdClass()); // Return an empty object instead of an empty array
}

$conn->close();
?>
