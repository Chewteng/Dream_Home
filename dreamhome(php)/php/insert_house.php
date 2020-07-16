<?php
error_reporting(0);
include_once ("dbconnect.php");
$id = $_POST['id'];
$name = ucwords($_POST['name']);
$address = $_POST['address'];
$price = $_POST['price'];
$quantity = $_POST['quantity'];
$room = $_POST['room'];
$broom = $_POST['broom'];
$cpark = $_POST['cpark'];
$area = $_POST['area'];
$type = $_POST['type'];
$description = $_POST['description'];
$latitude = $_POST['latitude'];
$longitude = $_POST['longitude'];
$url = $_POST['url'];
$contact = $_POST['contact'];
$encoded_string = $_POST["encoded_string"];
$decoded_string = base64_decode($encoded_string);
$imagename = $id;


$path = '../homeimage/'.$imagename.'.jpg';

$sqlinsert = "INSERT INTO SALE(ID,NAME,ADDRESS,PRICE,QUANTITY,ROOM,BROOM,CARPARK,AREA,TYPE,DESCRIPTION,LATITUDE,LONGITUDE,URL,CONTACT,IMAGENAME,BOOK) 
VALUES ('$id','$name','$address','$price','$quantity','$room','$broom','$cpark','$area','$type','$description','$latitude','$longitude','$url','$contact','$imagename.jpg','0')";

if ($conn->query($sqlinsert) === true)
{
    if (file_put_contents($path, $decoded_string)){
        echo 'success';
    }else{
        echo 'failed';
    }
}
else
{
    echo "failed";
}

?>