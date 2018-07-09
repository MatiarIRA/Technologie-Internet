<?php
session_start();
?>
<?xml version="1.0" encoding="UTF-8"?>
<!--Auteur: Mohammad Hossein ERFANIAN AZMOUDEH-->
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
		<title>Club Sportif</title>
		<link href="clubSportif.css" rel="stylesheet" type="text/css" style="screen" />
        
    </head>
    <body>
    	<header>
    		<?php
			// Echo session variables that were set on previous page
			echo "Bonjour <span>" .$_SESSION["Prenom"]." ".$_SESSION["Nom"]."</span>";
			?>	
    	</header>
    	<nav>
            <ul>
                <li><a class="selection" href="adherents.php">Accueil</a></li>
                <li><a href="reservation.php"> Faire une reservation </a></li>
                <li><a href="Historique.php"> Historique </a></li>
                <li><a href="quipeut.xhtml"> Qui peut le faire? </a></li>
                <li><a href="APropos.xhtml">ÃƒÆ’Ã¢â€šÂ¬ propos</a></li>
            </ul>
        </nav>
    	
    	<h1 id="page">Choisissez un terrain</h1>
    	<div>
//	<form method="POST">
//	<fieldset>
	<?php
		// Create connection
		$conn=mysql_connect("www-ens","erfaniam_web","iamp110E")or die("Connection failed: ".mysql_error());
		mysql_select_db("erfaniam_ift3225_bd",$conn) or die("Database does not exists.");
			
		$ter = "Select * from terrain";
		$resTer = mysql_query($ter ) or die($ter ."<br/><br/>".mysql_error());
		$conn->close();
	?>
/*
	<select id="terrains" name="terrain">
	<?php
		echo "<option>LES TERRAINS</option>";			
		while($range = mysql_fetch_assoc($resTer)){
			$nomT = $range['Nom_ter'];
			$etat = $range['Etat'];
            		echo "<option value='".$nomT."'>". $nomT." >>> ".$etat."</option>";
		}
	?>
	</select>
	<p><input type="submit" value="Sumbit my choice"/></p>
	</fieldset>
	</form>
	<?php if issset($_POST['terrain']): $test=$_POST['terrain'] 

	echo $test; ?>
*/		
     	</div>
    	<footer style="left: 8px; top: 243px">
            <b><img src= "http://www-labs.iro.umontreal.ca/~lapalme/DIRO_LOGO/WEB%20%26%20Screen/15_DIRO_LOGO_RGB.png" alt="Diro logo" height="30"/></b>
        </footer>    
    </body>
</html>