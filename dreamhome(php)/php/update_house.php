<?php
error_reporting(0);
include_once("dbconnect.php");

$id = $_POST['id'];
$name = ucwords($_POST['name']);
$address = $_POST['address'];
$price = $_POST['price'];
$quantity = $_POST['quantity'];
$type = $_POST['type'];
$area = $_POST['area'];
$room = $_POST['room'];
$broom = $_POST['broom'];
$cpark = $_POST['cpark'];
$description = $_POST['description'];
$latitude = $_POST['latitude'];
$longitude = $_POST['longitude'];
$url = $_POST['url'];
$contact = $_POST['contact'];
$encoded_string = $_POST["encoded_string"];
$decoded_string = base64_decode($encoded_string);

$path = '../homeimage/'.$id.'.jpg';

$sqlupdate = "UPDATE SALE SET NAME = '$name', ADDRESS = '$address', PRICE = '$price', QUANTITY = '$quantity', TYPE = '$type', AREA = '$area', 
             ROOM = '$room', BROOM = '$broom', CARPARK = '$cpark', DESCRIPTION = '$description', LATITUDE = '$latitude', LONGITUDE = '$longitude',
             url = '$url', CONTACT = '$contact' WHERE ID = '$id'";
             
if ($conn->query($sqlupdate) === true)
{
    if(isset($encoded_string)){
        file_put_contents($path, $decoded_string);
    }
    echo "success";
}
else
{
    echo "failed";
}
    
$conn->close();
?>