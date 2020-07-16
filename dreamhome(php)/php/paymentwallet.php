<?php
error_reporting(0);
include_once("dbconnect.php");

$userid = $_POST['userid'];
$amount = $_POST['amount'];
$bookid = $_POST['bookid'];
$newcr = $_POST['newcr'];
$receiptid = "storewallet";

$sqlfav = "SELECT FAVOURITE.HOUSEID, FAVOURITE.HQUANTITY, SALE.PRICE FROM FAVOURITE INNER JOIN SALE ON FAVOURITE.HOUSEID = SALE.ID WHERE FAVOURITE.EMAIL = '$userid'";
       
        $favresult = $conn->query($sqlfav);
        if ($favresult->num_rows > 0)
        {
        while ($row = $favresult->fetch_assoc())
        {
            $houseid = $row["HOUSEID"];
            $hq = $row["HQUANTITY"];
            $pr = $row["PRICE"];
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
                        $sqlupdatequan = "UPDATE SALE SET QUANTITY = '$newquantity', BOOK = '$newbook' WHERE ID = '$houseid'";
                        $conn->query($sqlupdatequan);
                    }
                }
            
        }
        
       $sqldelete = "DELETE FROM FAVOURITE WHERE EMAIL = '$userid'";
       $sqlinsert = "INSERT INTO PAYMENT(BOOKID,BILLID,USERID,TOTAL) VALUES ('$bookid','$receiptid','$userid','$amount')";
       $sqlupdatesc = "UPDATE USER SET CREDIT = '$newcr' WHERE EMAIL = '$userid' ";
       $conn->query($sqldelete);
       $conn->query($sqlinsert);
       $conn->query($sqlupdatesc);
       echo "Success pay with DreamHome wallet";
    }else{
       echo "Failed pay with DreamHome wallet";
    }
    
?>