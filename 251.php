<?php
if ($_POST['start']) {
	file_put_contents("cc", "start");
	file_put_contents("poll_status", "");
}
if ($_POST['stop']) {
	file_put_contents("cc", "false");
	file_put_contents("poll_status", "");
}
?>
<html>
<head>
<meta http-equiv="refresh" content="1">
</head>
<body>
<p style="font-size: 10em; color: red"><?php echo file_get_contents("poll_status");?></p>
<form method="post">
<button type="submit" name="start" value="true">Start</button>
<button type="submit" name="stop" value="true">Stop</button>
</form>
<p>
<?php
if (trim(file_get_contents("cc")) == "false") {
	echo "Inactive";
} else {
	echo "Active";
}
?>
</p>
<p>There is an issue if the following number is less than 80: <?php echo file_get_contents("poll_amount");?></p>
</body>
</html>

