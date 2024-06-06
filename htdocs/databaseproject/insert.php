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

if( isset($_POST["email"])){

    $email= $_POST["email"];

}
else return;

if( isset($_POST["password"])){

    $password= $_POST["password"];

}
else return;


$query= "INSERT INTO `reg`(`email`, `password`) VALUES ('$email','$password')";

$exe=mysqli_query($con,$query);

$arr=[];

if ($exe)
{
    $arr["success"]="true";
}
else
{
    $arr["success"]= "false";  
}


print(json_encode($arr));

?>