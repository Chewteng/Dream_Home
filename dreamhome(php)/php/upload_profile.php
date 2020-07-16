<?php
//error_reporting(0);
$email = $_POST['email'];
$encoded_string = $_POST["encoded_string"];
$decoded_string = base64_decode($encoded_string);

$path = '../profileimages/'.$email.'.jpg';

if(isset($encoded_string)){
       if (file_put_contents($path, $decoded_string)){
             echo 'success';
       }else{
            echo 'failed';
       }
}else{
    echo "failed";
}



?>