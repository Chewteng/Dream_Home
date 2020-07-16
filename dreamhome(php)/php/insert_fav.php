<?php
error_reporting(0);
include_once ("dbconnect.php");
$email = $_POST['email'];
$houseid = $_POST['houseid'];
$userquantity = $_POST['quantity'];


$sqlsearch = "SELECT * FROM FAVOURITE WHERE EMAIL = '$email' AND HOUSEID= '$houseid'";

$result = $conn->query($sqlsearch);
if ($result->num_rows > 0) {
    while ($row = $result ->fetch_assoc()){
        $housequantity = $row["HQUANTITY"];
    }
    $housequantity = $housequantity + $userquantity;
    $sqlinsert = "UPDATE FAVOURITE SET HQUANTITY = '$housequantity' WHERE HOUSEID = '$houseid' AND EMAIL = '$email'";
    
}else{
    $sqlinsert = "INSERT INTO FAVOURITE(EMAIL,HOUSEID,HQUANTITY) VALUES ('$email','$houseid','$userquantity')";
}


if ($conn->query($sqlinsert) === true)
{
    
    $sqlquantity = "SELECT * FROM FAVOURITE WHERE EMAIL = '$email'";

    $resultq = $conn->query($sqlquantity);
    if ($resultq->num_rows > 0) {
    $quantity = 0;
    while ($row = $resultq ->fetch_assoc()){
        $quantity = $row["HQUANTITY"] + $quantity;
        }
    }

    $quantity = $quantity;
    echo "success,".$quantity;
}
else
{
    echo "failed";
}

?>