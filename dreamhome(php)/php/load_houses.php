<?php
error_reporting(0);
include_once ("dbconnect.php");
$type = $_POST['type'];
$address = $_POST['address'];

if (isset($type)){
    if ($type == "Recent"){
        $sql = "SELECT * FROM SALE ORDER BY DATE DESC lIMIT 20";    
    }else{
        $sql = "SELECT * FROM SALE WHERE TYPE LIKE '%$type%'";    
    }
}else{
    $sql = "SELECT * FROM SALE ORDER BY DATE DESC lIMIT 20";    
}
if (isset($address)){
   $sql = "SELECT * FROM SALE WHERE ADDRESS LIKE  '%$address%'";
}


$result = $conn->query($sql);

if ($result->num_rows > 0)
{
    $response["houses"] = array();
    while ($row = $result->fetch_assoc())
    {
        $houselist = array();
        $houselist["id"] = $row["ID"];
        $houselist["name"] = $row["NAME"];
        $houselist["address"] = $row["ADDRESS"];
        $houselist["price"] = $row["PRICE"];
        $houselist["quantity"] = $row["QUANTITY"];
        $houselist["room"] = $row["ROOM"];
        $houselist["broom"] = $row["BROOM"];
        $houselist["cpark"] = $row["CARPARK"];
        $houselist["area"] = $row["AREA"];
        $houselist["type"] = $row["TYPE"];
        $houselist["description"] = $row["DESCRIPTION"];
        $houselist["latitude"] = $row["LATITUDE"];
        $houselist["longitude"] = $row["LONGITUDE"];
        $houselist["url"] = $row["URL"];
        $houselist["contact"] = $row["CONTACT"];
        $houselist["imagename"] = $row["IMAGENAME"];
        $houselist["book"] = $row["BOOK"];
        $houselist["date"] = $row["DATE"];
        array_push($response["houses"], $houselist);
    }
    echo json_encode($response);
}
else
{
    echo "No Houses!";
}
?>