<?php

$hostname = "db-barvyovy.nocp.vs.csint.cz";
$username = "hodnoceni";
$password = "hodnoceni";
$db = "reviews";


$dbconnect= new mysqli($hostname,$username,$password,$db);

if ($dbconnect->connect_error) {
  die("Database connection failed: " . $dbconnect->connect_error);
}

if(isset($_POST['submit'])) {
  $reviewer_name=$_POST['reviewer_name'];
  $star_rating=$_POST['star_rating'];
  $details=$_POST['details'];

  $query = "INSERT INTO user_review (reviewer_name, star_rating, details)
  VALUES ('$reviewer_name', '$star_rating', '$details')";

    if (!mysqli_query($dbconnect, $query)) {
        die('Chyba, posouzení se neuložilo..');
    } else {
      echo "Díky ;)";
    }

}

?>

