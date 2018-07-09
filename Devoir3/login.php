<?php
// Start the session
session_start();

if($_SERVER['REQUEST_METHOD']=='POST'){
include 'config_conn.php';



$surnom= $_POST['Surnom'];
$mp= $_POST['Mot_de_passe'];
if($surnom== null || $mp==null){
	echo "<script>alert('Remplissez tous les champs svp!'); parent.location='login.php'</script>";
}

$resultCS = mysqli_query($conn,"Select Surnom from adherents where Surnom='".$surnom."'")or die(mysqli_error($conn));

$resultCMP = mysqli_query($conn,"Select * from adherents where Mot_de_passe='".$mp."' AND Surnom='".$surnom."'")or die(mysqli_error($conn));

if(mysqli_num_rows($resultCS)==0){
	echo "<script>alert('Vous etes pas inscrit! Veuillez vous inscrire!'); parent.location='login.php'</script>";
}elseif (mysqli_num_rows($resultCMP)==0){
	echo "<script>alert('Mot de passe ou Surnom n est pas bon! Veuillez reessayer!'); parent.location='login.php'</script>";	
}else{
	$usager = mysqli_fetch_array($resultCMP);
	$_SESSION["ID_A"] = $usager['ID_A'];
	$_SESSION["Prenom"] = $usager['Prenom'];
	$_SESSION["Nom"] = $usager['Nom'];
	$_SESSION['Role'] = $usager['Role'];
    echo "<script>parent.location='home.php'</script>";
}
include 'close_bd.php';
}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
    <title>SE CONNECTER/INSCRIRE</title>
    <link href="clubSportif.css" rel="stylesheet" type="text/css" style="screen"/>      
    <script src="https://code.jquery.com/jquery-1.12.4.js" type="text/javascript"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js" type="text/javascript"></script>
    <script type="text/javascript" src="ps.js"></script>
</head>
<body>
    <header class="login">
	<a href="http://www-ens.iro.umontreal.ca/~erfaniam/login.php"><img src= "https://www.publicationsports.com/cache/image/37/f9/57a57e6e3dd0f.png" alt="Cepsum logo" height="50"/></a>    			
    </header>
    <form method="post" action="<?PHP $_PHP_SELF ?>" class="loginForm">
        <fieldset>
            <input type="text" name="Surnom" placeholder="Votre surnom"/><br/>
            <input type="text" name="Mot_de_passe" placeholder="Votre mot de passe"/><br/>       
            <input name="login" tabindex="13" type="submit" value="Log in" id="login" style="width: 165px"/><br/>
            <input name="signup" tabindex="13" type="button" value="S'inscrire " id="signup" style="width: 165px"/>
        </fieldset>
    </form>
</body>
</html>