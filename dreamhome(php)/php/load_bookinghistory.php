<?php
error_reporting(0);
include_once ("dbconnect.php");
$bookid = $_POST['bookid'];

   $sql = "SELECT SALE.ID, SALE.NAME, SALE.PRICE, SALE.QUANTITY, FAVHISTORY.HQUANTITY FROM SALE INNER JOIN FAVHISTORY
   ON FAVHISTORY.HOUSEID = SALE.ID WHERE FAVHISTORY.BOOKID = '$bookid'";

$result = $conn->query($sql);

if ($result->num_rows > 0)
{
    $response["bookhistory"] = array();
    while ($row = $result->fetch_assoc())
    {
        $bookinglist = array();
        $bookinglist["id"] = $row["ID"];
        $bookinglist["name"] = $row["NAME"];
        $bookinglist["price"] = $row["PRICE"];
        $bookinglist["hquantity"] = $row["HQUANTITY"];
        array_push($response["bookhistory"], $bookinglist);
    }
    echo json_encode($response);
}
else
{
    echo "No Booking History!";
}
?>