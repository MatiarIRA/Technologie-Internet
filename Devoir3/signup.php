<?php
if($_SERVER['REQUEST_METHOD']=='POST'){
include 'config_conn.php';
if(isset($_POST['signup'])){
$nom= $_POST['nom'];
$prenom= $_POST['prenom'];
$surnom= $_POST['surnom'];
$mp1= $_POST['mp1'];
$mp2= $_POST['mp2'];
}
if($nom== null || $prenom == null || $surnom== null || $mp1==null || $mp2==null){
	echo "<script>alert('Remplissez tous les champs svp!'); parent.location='signup.php'</script>";
}

if($mp1 != $mp2){
	echo "<script>alert('Les mots de passes sont pas identique! Reessayez!'); parent.location='signup.php'</script>";
}

//check name
$resultCN = mysqli_query($conn,"Select Surnom from adherents where Prenom='".$prenom."' And Nom='".$nom."'")or die(mysqli_error($conn));
 
$resultCS = mysqli_query($conn,"Select Surnom from adherents where Surnom='".$surnom."'")or die(mysqli_error($conn));

//echo $chkSnm ;
$num_rows = mysqli_num_rows($resultCN);
//echo $num_rows;

if(mysqli_num_rows($resultCN)==0){
	if(mysqli_num_rows($resultCS)==0){
		$req = mysqli_query($conn,"insert into adherents(Nom,Prenom,Surnom,Mot_de_passe,role) value ('".$nom."','".$prenom."','".$surnom."','".$mp2."','J')")or die(mysqli_error($conn));
		echo "<script>alert('Inscription est complete!'); parent.location='login.php'</script>";
	}else{
		echo "<script>alert('Ce surnom a ete deja choisi! Choisissez un autre svp!'); parent.location='signup.php'</script>";
	}
}else{
	$chkSnm = mysqli_result($resultCS, 0);	
	echo "<script>alert('Vous etes deja inscrit sous surnom de ".$surnom."'); parent.location='signup.php'</script>";	
}
	
include 'close_bd.php';
}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
    <link href="clubSportif.css" rel="stylesheet" type="text/css" style="screen"/>      
    <script src="https://code.jquery.com/jquery-1.12.4.js" type="text/javascript"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js" type="text/javascript"></script>
    <script type="text/javascript" src="ps.js"></script>
<title>S'INSCRIRE</title>
</head>

<body>
    <header class="signin" >
	    <a href="http://www-ens.iro.umontreal.ca/~erfaniam/login.php"><img src= "https://www.publicationsports.com/cache/image/37/f9/57a57e6e3dd0f.png" alt="Cepsum logo" height="50"/></a>   			
    </header>
    <form method="post" action="<?PHP $_PHP_SELF ?>" class="singupForm">
        <fieldset>
            <caption>Veuillez remplire le formulaire ci-dessous</caption><br/><br/>
            <input type="text" name="nom" size="25" placeholder="Votre nom"/><br/><br/>
            <input type="text" name="prenom" size="25" placeholder="Votre prenom"/><br/><br/>
            <input type="text" name="surnom" size="25" placeholder="Votre surnom"/><br/><br/>
            <input type="text" name="mp1" size="25" placeholder="Entrer un mot de passe"/><br/><br/>
            <input type="text" name="mp2" size="25" placeholder="R&eacute;entrer le mot de passe"/><br/><br/>
            <input name="signup" tabindex="10" type="submit" value="Enregistrer" style="width: 175px"/></td>
        </fieldset>
    </form>

</body>

</html>
