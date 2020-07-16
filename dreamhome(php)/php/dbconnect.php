<?php
$servername = "localhost";
$username = "yitengsz_teng0316";
$password = "nCEGWP1UL~XS";
$dbname = "yitengsz_cteng";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
 die("Connection failed: " . $conn->connect_error);
}
?>