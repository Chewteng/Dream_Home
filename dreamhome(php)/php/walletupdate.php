<?php
error_reporting(0);
include_once("dbconnect.php");

$userid = $_GET['userid'];
$mobile = $_GET['mobile'];
$amount = $_GET['amount'];
$newcr = $_GET['newcredit'];

$data = array(
        'id' => $_GET['billplz']['id'],
        'paid_at' => $_GET['billplz']['paid_at'],
        'paid' => $_GET['billplz']['paid'],
        'x_signature' => $_GET['billplz']['x_signature'],
    );
    
$paidstatus = $_GET['billplz']['paid'];
if($paidstatus == "true"){
    $paidstatus = "Success";
}else{
    $paidstatus = "Failed";
}
$receiptid = $_GET['billplz']['id'];
$signing = '';
foreach ($data as $key => $value){
    $signing.= 'billplz'.$key . $value;
    if($key === 'paid'){
        break;
    } else{
        $signing .= '|';
    }
}

$signed = hash_hmac('sha256', $signing, 'S-jZEYiDn7GpT-HfSaxNphVw');
if($signed === $data['x_signature']){
    if ($paidstatus == "Success"){
    $sqlinsert = "INSERT INTO WALLET(BILLID,USERID,TOTAL) VALUES ('$receiptid','$userid','$amount')";
       $sqlupdatesc = "UPDATE USER SET CREDIT = '$newcr' WHERE EMAIL = '$userid' ";
       $conn->query($sqlupdatesc);
       $conn->query($sqlinsert);
    
        echo '<br><br><style>
                body {
                    background-image: url("http://yitengsze.com/cteng/receiptimage/images.jpg");
                    background-repeat: no-repeat;
                    background-attachment: fixed;  
                    background-size: cover;
                    }
                img {
                    display: block;
                    margin-left: auto;
                    margin-right: auto;
                    }
                table {
                table-layout:auto;
                }
            </style>
</head>
<body>
<a href="default.asp">
<img src="http://yitengsze.com/cteng/receiptimage/tick.png" style="width:90px;height:90px;">
</a>
<div>
<h2><br><center>Amount Paid: RM '.$amount.'</center></h2>
<h2><center>Paid to DreamHome</center></h2>
<br>
<table border=1 width=85% align=center>
<tr><td>Receipt ID</td><td>'.$receiptid.'</td></tr>
<tr><td>New Wallet Balance</td><td>RM '.$newcr.'</td></tr>
<tr><td>Date </td><td>'.date("d/m/Y").'</td></tr>
<tr><td>Time </td><td>'.date("h:i a").'</td></tr>
            </table>
            <br><p>
            <center>Receipt has been email to '.$userid.'</center></p><br><br>
            <br><p><center>Press back button to continue our service.</center></p>
            <p><center>Thank You!</center></p></tr></td></table></body>';

    
}else{
    echo '<br><br><style>
                body {
                    background-image: url("http://yitengsze.com/cteng/receiptimage/images.jpg");
                    background-repeat: no-repeat;
                    background-attachment: fixed;  
                    background-size: cover;
                    }
                img {
                    display: block;
                    margin-left: auto;
                    margin-right: auto;
                    }
                table {
                table-layout:auto;
                }
            </style>
</head>
<body>
<a href="default.asp">
<img src="http://yitengsze.com/cteng/receiptimage/fail.png" style="width:100px;height:100px;">
</a>
<div>
<h2><br><center>Oops!! Something Went Wrong</center></h2>
<p style="color:grey" align=center>Your Payment was Declined.</p>
<br>
<table border=1 width=85% align=center>
<tr><td>Date </td><td>'.date("d/m/Y").'</td></tr>
<tr><td>Time </td><td>'.date("h:i a").'</td></tr>
            </table>
            <br>
            <br><br><br>
            <br><p><center>Press back button to continue our service.</center></p>
            <p><center>Thank You!</center></p></tr></td></table></body>';
    }
}
?>


