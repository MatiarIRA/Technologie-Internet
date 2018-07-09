<?php
include('login.php');

if(isset($_SESSION['login_user'])){
header("location: profile.php");
}
?>
<!DOCTYPE html>
<html>
	<head>
		<title>Cepsum</title>
		<link href="style.css" rel="stylesheet" type="text/css">
	</head>
	<body>
		<div id="main">
			<h1>Ouverture d'une session</h1>
			<div id="login">
				<h2>Connectez-vous</h2>
				<form action="" method="post">
					<br/>
					<label>Nom d'utilisateur :</label>
					<input id="name" name="username" placeholder="username" type="text">
					<br/>
					<br/>
					<label>Mot de passe :</label>
					<input id="password" name="password" placeholder="**********" type="password">
					<br/>
					<br/>
					<input name="submit" type="submit" value=" Login ">
					<span><?php echo $error; ?></span>
				</form>
			</div>
		</div>
	</body>
</html>

