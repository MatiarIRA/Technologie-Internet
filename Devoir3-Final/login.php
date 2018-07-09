<?php
// Start the session
session_start();

if($_SERVER['REQUEST_METHOD']=='POST'){
  include 'config_conn.php';
  if (isset($_POST['login'])) {
  if (empty($_POST['Surnom']) || empty($_POST['Mot_de_passe'])) {
	echo "<script>alert('Remplissez tous les champs svp!'); parent.location='login.php'</script>";

  }
  else
  {

  $surnom= $_POST['Surnom'];
  $mp= $_POST['Mot_de_passe'];
  
  $resultCS = mysqli_query($conn,"Select Surnom from adherents where Surnom='".$surnom."'")or die(mysqli_error($conn));

  $resultCMP = mysqli_query($conn,"Select * from adherents where Mot_de_passe='".$mp."' AND Surnom='".$surnom."'")or die(mysqli_error($conn));

  if(mysqli_num_rows($resultCS)==0){
	  echo "<script>alert('Vous etes pas inscrit! Veuillez vous inscrire!'); parent.location='login.php'</script>";
  }elseif (mysqli_num_rows($resultCMP)==0){	
	  echo "<script>alert('Nom d`utilisateur ou mot de passe est invalide'); parent.location='login.php'</script>";	
  }else{
	  $usager = mysqli_fetch_array($resultCMP);
	  $_SESSION["ID_A"] = $usager['ID_A'];
	  $_SESSION["Prenom"] = $usager['Prenom'];
	  $_SESSION["Nom"] = $usager['Nom'];
	  $_SESSION['Role'] = $usager['Role'];
	  header("location: home.php");
	  }
  }
}
include 'close_bd.php';
}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
    <title>Login/Inscription</title>
    <link href="clubSportif.css" rel="stylesheet" type="text/css" style="screen"/>      
    <script src="https://code.jquery.com/jquery-1.12.4.js" type="text/javascript"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js" type="text/javascript"></script>
    <script>
			$(document).ready(function() {
    				$("#signupBtn").click(function(){
				parent.location='signup.php';   
     				});
			});
    </script>
</head>
<body id="log">
    <header>
	<a href="http://www-ens.iro.umontreal.ca/~erfaniam/login.php"><img src= "https://www.publicationsports.com/cache/image/37/f9/57a57e6e3dd0f.png" alt="Cepsum logo" height="50"/></a>    			
    </header>

	<div id="login">
	  <h4> Connectez-vous </h4>
	  <form method="post" action="<?PHP $_PHP_SELF ?>" class="loginForm">
	      
	      <fieldset>
		  <input type="text" name="Surnom" placeholder="Votre surnom"/>
		  <br/><br/>
		  <input type="password" name="Mot_de_passe" placeholder="Votre mot de passe"/>
		  <br/><br/>       
		  <input name="login" tabindex="13" type="submit" value="Log in"  style="width: 165px"/>
		  <br/><br/>
		  <input id="signupBtn" tabindex="13" type="button" value="S'inscrire " style="width: 165px; height: 30px"/>
	      </fieldset>
	  </form>
	</div>

      
</body>
</html>