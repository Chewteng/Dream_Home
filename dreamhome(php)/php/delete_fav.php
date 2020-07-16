<?php
error_reporting(0);
include_once("dbconnect.php");
$email = $_POST['email'];
$houseid = $_POST['houseid'];

if (isset($_POST['houseid'])){
    $sqldelete = "DELETE FROM FAVOURITE WHERE EMAIL = '$email' AND HOUSEID='$houseid'";
}else{
    $sqldelete = "DELETE FROM FAVOURITE WHERE EMAIL = '$email'";
}

    if ($conn->query($sqldelete) === TRUE){
       echo "success";
    }else {
        echo "failed";
    }
?>