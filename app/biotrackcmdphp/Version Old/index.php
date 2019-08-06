<!DOCTYPE html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
</head>
<body>

<?php

	include ('BioTrackCmd.php');

	$cmd = new BioTrackCmd ('192.168.0.172');

	echo '<table border=1>';

	echo '<tr>';
	echo '	<th>userId</th>';
	echo '	<th>userName</th>';
	echo '	<th>userPassword</th>';
	echo '	<th>userPrivilege</th>';
	echo '	<th>userCardNumber</th>';
	echo '	<th>userEnabled</th>';
	echo '</tr>';

	foreach ($cmd->get_users() as $user)
	{
		echo '<tr>';
		echo '	<td>'.$user['userId'].'</td>';
		echo '	<td>'.$user['userName'].'</td>';
		echo '	<td>'.$user['userPassword'].'</td>';
		echo '	<td>'.$user['userPrivilege'].'</td>';
		echo '	<td>'.$user['userCardNumber'].'</td>';
		echo '	<td>'.$user['userEnabled'].'</td>';
		echo '</tr>';
	}

	echo '</table>';




	echo '<table border=1>';

	
	echo '<th>logUserId</th>';
	echo '<th>logVerifyMode</th>';
	echo '<th>logInOutMode</th>';
	echo '<th>logYear</th>';
	echo '<th>logMonth</th>';
	echo '<th>logDay</th>';
	echo '<th>logHour</th>';
	echo '<th>logMinute</th>';
	echo '<th>logSecond</th>';
	echo '<th>logWorkCode</th>';

	foreach ($cmd->get_log() as $log)
	{
		echo '<tr>';
			echo '<td>'.$log['logUserId'].'</td>';
			echo '<td>'.$log['logVerifyMode'].'</td>';
			echo '<td>'.$log['logInOutMode'].'</td>';
			echo '<td>'.$log['logYear'].'</td>';
			echo '<td>'.$log['logMonth'].'</td>';
			echo '<td>'.$log['logDay'].'</td>';
			echo '<td>'.$log['logHour'].'</td>';
			echo '<td>'.$log['logMinute'].'</td>';
			echo '<td>'.$log['logSecond'].'</td>';
			echo '<td>'.$log['logWorkCode'].'</td>';
		echo '</tr>';
	}

	echo '</table>';

?>

</body>
</html>
