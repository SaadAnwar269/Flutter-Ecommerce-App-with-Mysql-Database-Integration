<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "dbproject";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$data = json_decode(file_get_contents('php://input'), true);

if (isset($data['userId']) && isset($data['username']) && isset($data['Daddress']) && isset($data['Baddress']) && isset($data['gender'])) {
    $userId = intval($data['userId']);
    $username = $conn->real_escape_string($data['username']);
    $Daddress = $conn->real_escape_string($data['Daddress']);
    $Baddress = $conn->real_escape_string($data['Baddress']);
    $gender = $conn->real_escape_string($data['gender']);

    $sql = "INSERT INTO profile (userId, username, Daddress, Baddress, gender)
            VALUES ($userId, '$username', '$Daddress', '$Baddress', '$gender')
            ON DUPLICATE KEY UPDATE username='$username', Daddress='$Daddress', Baddress='$Baddress', gender='$gender'";

    if ($conn->query($sql) === TRUE) {
        echo json_encode(['success' => true]);
    } else {
        echo json_encode(['success' => false, 'error' => $conn->error]);
        error_log('Insert/Update Error: ' . $conn->error);  // Log error to server logs
    }
} else {
    echo json_encode(['success' => false, 'error' => 'Invalid input']);
    error_log('Invalid input: ' . json_encode($data));  // Log invalid input data
}

$conn->close();
?>
