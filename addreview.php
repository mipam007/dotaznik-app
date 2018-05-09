<?php

$hostname = "DATABASE_SERVICE_NAME";
$username = "MYSQL_USER";
$password = "MYSQL_PASSWORD";
$db = "MYSQL_DATABASE";

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

