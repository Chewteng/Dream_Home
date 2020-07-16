<?php
error_reporting(0);
include_once ("dbconnect.php");
$name = $_POST['name'];
$email = $_POST['email'];
$phone = $_POST['phone'];
$password = sha1($_POST['password']);
$encoded_string = $_POST["encoded_string"];
$decoded_string = base64_decode($encoded_string);

$sqlinsert = "INSERT INTO USER(NAME,EMAIL,PASSWORD,PHONE,CREDIT,VERIFY) VALUES ('$name','$email','$password','$phone','0','0')";

if ($conn->query($sqlinsert) === true)
{
    $path = '../profileimages/'.$email.'.jpg';
    file_put_contents($path, $decoded_string);
    sendEmail($email);
    echo "Success for Registration";
}
else
{
    echo "Failed for Registration";
}


function sendEmail($useremail) {
    $to      = $useremail; 
    $subject = 'Verification for Registration in DreamHome'; 
   
    $message = 'WELCOME TO DREAM HOME!
    Thank you for signing up on our system. Please click on the link below to verify your email.
    http://yitengsze.com/cteng/php/verify.php?email='.$useremail; 
    $headers = 'From: noreply@dreamhome.com' . "\r\n" . 
    'Reply-To: '.$useremail . "\r\n" . 
    'X-Mailer: PHP/' . phpversion(); 
    mail($to, $subject, $message, $headers); 
}


?>

