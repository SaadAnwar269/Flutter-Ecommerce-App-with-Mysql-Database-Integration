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

if (isset($_POST["email"])) {
    $email = $_POST["email"];
} else {
    echo json_encode(["success" => "false", "message" => "Email is required"]);
    return;
}

if (isset($_POST["password"])) {
    $password = $_POST["password"];
} else {
    echo json_encode(["success" => "false", "message" => "Password is required"]);
    return;
}


$query = "SELECT `password` FROM `reg` WHERE `email` = ?";
$stmt = $con->prepare($query);
$stmt->bind_param("s", $email);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    // Assuming passwords are stored as plain text
    if ($password === $row['password']) {
        echo json_encode(["success" => "true", "message" => "Login successful"]);
    } else {
        echo json_encode(["success" => "false", "message" => "Invalid password"]);
    }
} else {
    echo json_encode(["success" => "false", "message" => "Invalid email"]);
}

$stmt->close();
mysqli_close($con);
?>
