<?php
error_reporting(0);
include_once("dbconnect.php");
$email = $_POST['email'];
$sql = "SELECT * FROM USER WHERE EMAIL = '$email' AND VERIFY = '$verify'";

function newpassword(){
    $randpass = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@$%&*_';
    return substr(str_shuffle($randpass),0,8);
}

$pass = newpassword();
$temppass= sha1($pass);

$sql = "UPDATE USER SET PASSWORD='$temppass' WHERE EMAIL= '$email' ";
    
$sqls = "SELECT * FROM USER WHERE EMAIL = '$email' AND VERIFY = '1'";
$result = $conn->query($sqls);
    
if($result->num_rows>0 && $conn->query($sql)===TRUE){
    sendEmail($email,$pass);
    echo "Success in sending email!";
}else{
    echo"Failed in sending email!";
}


function sendEmail($useremail,$userpassword) {
    $to      = $useremail; 
    $subject = 'Verification for Reset Password in DreamHome'; 
    $message = 'Your new password is: '.$userpassword. "\nPlease use this new password as your login password.";  
    $headers = 'From: noreply@dreamhome.com.my' . "\r\n" . 
    'Reply-To: '.$useremail . "\r\n" . 
    'X-Mailer: PHP/' . phpversion(); 
    mail($to, $subject, $message, $headers); 
}
?>