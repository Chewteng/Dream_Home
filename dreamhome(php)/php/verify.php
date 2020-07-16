<?php
error_reporting(0);
include_once("dbconnect.php");
$useremail = $_GET['email'];

$sql = "UPDATE USER SET VERIFY = '1' WHERE EMAIL = '$useremail'";
if($conn -> query($sql) === TRUE){
    echo "You are verified.<br>";
    echo "You now can login to your account.";
}else{
    echo "error";
}

$conn -> close();
?>