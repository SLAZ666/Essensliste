<?php
	$mysqli = new mysqli("localhost", "", "", "");
	if ($mysqli->connect_errno) {
		echo "Failed to connect to MySQL: " . $mysqli->connect_error;
		die;
	}
	$mysqli->set_charset("utf8");
?>