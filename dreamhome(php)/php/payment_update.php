<?php
error_reporting(0);
include_once("dbconnect.php");

$userid = $_GET['userid'];
$mobile = $_GET['mobile'];
$amount = $_GET['amount'];
$bookid = $_GET['bookid'];
$newcr = $_POST['newcr'];

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
        
       $sqlfav = "SELECT FAVOURITE.HOUSEID, FAVOURITE.HQUANTITY, SALE.PRICE FROM FAVOURITE INNER JOIN SALE ON FAVOURITE.HOUSEID = SALE.ID WHERE FAVOURITE.EMAIL = '$userid'";
       
        $favresult = $conn->query($sqlfav);
        if ($favresult->num_rows > 0)
        {
        while ($row = $favresult->fetch_assoc())
        {
            $houseid = $row["HOUSEID"];
            $hq = $row["HQUANTITY"];
            
            $sqlinsertfavhistory = "INSERT INTO FAVHISTORY(EMAIL,BOOKID,BILLID,HOUSEID,HQUANTITY) VALUES ('$userid','$bookid','$receiptid','$houseid','$hq')";
            $conn->query($sqlinsertfavhistory);
            
            $selecthouse = "SELECT * FROM SALE WHERE ID = '$houseid'";
                $houseresult = $conn->query($selecthouse);
                if ($houseresult-> num_rows > 0)
                {
                    while ($rowh = $houseresult -> fetch_assoc ())
                    {
                        $housequantity = $rowh["QUANTITY"];
                        $bookquan = $rowh["BOOK"];
                        $newquantity = $housequantity - $hq;
                        $newbook = $bookquan + $hq;
                        $sqlupdate = "UPDATE SALE SET QUANTITY = '$newquantity', BOOK = '$newbook' WHERE ID = '$houseid'";
                        $conn->query($sqlupdate);
                    }
                }
            
        }
        
       $sqldelete = "DELETE FROM FAVOURITE WHERE EMAIL = '$userid'";
       $sqlinsert = "INSERT INTO PAYMENT(BOOKID,BILLID,USERID,TOTAL) VALUES ('$bookid','$receiptid','$userid','$amount')";
       
       $sqlupdatesc = "UPDATE USER SET CREDIT = '$newcr' WHERE EMAIL = '$userid' ";
       
       $conn->query($sqldelete);
       $conn->query($sqlinsert);
       $conn->query($sqlupdatesc);
       
    }
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
<tr><td>Booking ID</td><td>'.$bookid.'</td></tr>
<tr><td>Receipt ID</td><td>'.$receiptid.'</td></tr>
<tr><td>Date </td><td>'.date("d/m/Y").'</td></tr>
<tr><td>Time </td><td>'.date("h:i a").'</td></tr>
            </table>
            <br><p>
            <center>Receipt has been email to '.$userid.'</center></p><br><br>
            <br><p><center>Press back button to continue our service.</center></p>
            <p><center>Thank You!</center></p></tr></td></table></body>';

    } else{
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



