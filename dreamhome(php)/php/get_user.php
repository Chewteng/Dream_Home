<?php
error_reporting(0);
include_once("dbconnect.php");
$email = $_POST['email'];

$sql = "SELECT * FROM USER WHERE EMAIL = '$email'";
$result = $conn->query($sql);
if ($result->num_rows > 0) {
    while ($row = $result ->fetch_assoc()){
        echo "success,".$row["NAME"].",".$row["PHONE"].",".$row["EMAIL"].",".$row["CREDIT"].",".$row["DATEREG"];
    }
}else{
    echo "failed,null,null,null,null,null";
}