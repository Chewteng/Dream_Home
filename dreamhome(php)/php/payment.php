<?php
error_reporting(0);

$email = $_GET['email'];
$mobile = $_GET['mobile'];
$name = $_GET['name'];
$amount = $_GET['amount'];
$bookid = $_GET['bookid'];

$api_key = 'd588b903-ec80-4158-bdb5-b99f1d50c11f';
$host = 'https://billplz-staging.herokuapp.com/api/v3/bills';
$collection_id = 'kqzcf0ld';

$data = array(
            'collection_id' => $collection_id,
            'email' => $email,
            'mobile' => $mobile,
            'name' => $name,
            'amount' => $amount * 100,
            'description' => 'Payment for booking ID '.$bookid,
            'callback_url' => "http://yitengsze.com/cteng/return_url",
            'redirect_url' => "http://yitengsze.com/cteng/php/payment_update.php?userid=$email&mobile=$mobile&amount=$amount&bookid=$bookid"
            
);

$process = curl_init($host );
curl_setopt($process, CURLOPT_HEADER, 0);
curl_setopt($process, CURLOPT_USERPWD, $api_key . ":");
curl_setopt($process, CURLOPT_TIMEOUT, 30);
curl_setopt($process, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($process, CURLOPT_SSL_VERIFYHOST, 0);
curl_setopt($process, CURLOPT_SSL_VERIFYPEER, 0);
curl_setopt($process, CURLOPT_POSTFIELDS, http_build_query($data) );

$return = curl_exec($process);
curl_close($process);

$bill = json_decode($return, true);

header("Location: {$bill['url']}");

?>

    
