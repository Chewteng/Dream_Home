<?php
error_reporting(0);
include_once ("dbconnect.php");
$email = $_POST['email'];


if (isset($email)){
   $sql = "SELECT SALE.ID, SALE.TYPE, SALE.NAME, SALE.PRICE, SALE.QUANTITY, FAVOURITE.HQUANTITY FROM SALE INNER JOIN FAVOURITE ON FAVOURITE.HOUSEID = SALE.ID WHERE 
   FAVOURITE.EMAIL = '$email'";
}

$result = $conn->query($sql);

if ($result->num_rows > 0)
{
    $response["favourite"] = array();
    while ($row = $result->fetch_assoc())
    {
        $favlist = array();
        $favlist["id"] = $row["ID"];
        $favlist["type"] = $row["TYPE"];
        $favlist["name"] = $row["NAME"];
        $favlist["price"] = $row["PRICE"];
        $favlist["quantity"] = $row["QUANTITY"];
        $favlist["hquantity"] = $row["HQUANTITY"];
        $favlist["yourprice"] = round(doubleval($row["PRICE"])*(doubleval($row["HQUANTITY"])),2)."";
        array_push($response["favourite"], $favlist);
    }
    echo json_encode($response);
}
else
{
    echo "Favourite List Empty";
}
?>