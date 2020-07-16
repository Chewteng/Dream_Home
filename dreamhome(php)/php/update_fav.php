<?php
error_reporting(0);
include_once("dbconnect.php");

$email = $_POST['email'];
$houseid = $_POST['houseid'];
$quantity = $_POST['quantity'];

$sqlupdate = "UPDATE FAVOURITE SET HQUANTITY = '$quantity' WHERE EMAIL = '$email' AND HOUSEID = '$houseid'";

if ($conn->query($sqlupdate) === true)
{
    echo "success";
}
else
{
    echo "failed";
}
    
$conn->close();
?>