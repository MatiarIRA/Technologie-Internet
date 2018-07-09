<?php if(isset($_GET['source'])) die(highlight_file(__FILE__, 1));?>
<?php
	// Create connection
	$conn = new mysqli("www-ens", "erfaniam_web", "iamp110E", "erfaniam_ift3225_bd");
	// Check connection
	if ($conn->connect_error) {die("Connection failed: " . $conn->connect_error);} 
?>

