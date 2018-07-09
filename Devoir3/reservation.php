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
    <body id="J">
    	<header class="headerAdh">
    		<?php
			// Echo session variables that were set on previous page
			echo "Bonjour <span>" .$_SESSION["Prenom"]." ".$_SESSION["Nom"]."</span>";
			if(strcmp($_SESSION["Role"],"G")==0){
				echo "ADMIN";
			}
			?>	
    	</header>
    	<nav>
            <ul>
                <li><a href="home.php">Accueil</a></li>
                <li><a class="selection" href="reservation.php"> Faire une reservation </a></li>
                <li><a href="historique.php"> Historique </a></li>
                <li><a href="login.php"> Se deconnecter </a></li>
                <li><a href="APropos.xhtml">propos</a></li>
            </ul>
        </nav>
    	
       	<div>
	
	<?php
		include 'config_conn.php';	
		$ter = "Select * from terrain";
		$resTer = mysqli_query($conn, $ter);
	?>
<!-- SECTION DE LA RESERVATION ............................................ -->
	<form method="POST" action="<?PHP $_PHP_SELF ?>">
	<fieldset>

	<legend>Reservation</legend>
	<label>Choisir un terrain: </label>		
        	<select name = "ter" id="ter">	
		<?php
			echo "<option>LES TERRAINS</option>";			
			while($range = mysqli_fetch_assoc($resTer)){
				$ID_T = $range['ID_T'];
				$nomT = $range['Nom_ter'];
						echo "<option>".$ID_T."-".$nomT."</option>";           	
			}
		?>
		</select>

	<!--p>Une reservation est permit seulement pendant les Mardis pour reserver un terrain le lendeman soit Mercredi</p>
	label>Date: </label>
	<input required='required' type='text' size='10' placeholder='AAAA/MM/JJ' name='date' id='date'/-->
	<label>   heures: </label>
	<select name="hours" id="h">
		<option>6h - 7h</option>
		<option>7h - 8h</option>
		<option>8h - 9h</option>
		<option>9h - 10h</option>
		<option>10h - 11h</option>
		<option>11h - 12h</option>
		<option>12h - 13h</option>
		<option>13h - 14h</option>
		<option>14h - 15h</option>
		<option>15h - 16h</option>
		<option>16h - 17h</option>
		<option>17h - 18h</option>
		<option>18h - 19h</option>
		<option>19h - 20h</option>
		<option>20h - 21h</option>
	</select>
	<br/>
	<input type="submit" name="sub1" value="Submit"/>
	</fieldset>
	</form>
<br/><br/>
<!-- SECTION DE L'ANNULATION ............................................ -->

<form id="cancel" method="POST" action="<?PHP $_PHP_SELF ?>">
	<fieldset>
		<legend>Annuler la reservation</legend>
		<table border="1">
			<thead>Votre reservation:</thead>
			<tr><th>C</th><th>Terrain</th><th>Date de reservation</th><th>Heures</th></tr>
			<tr>
			<td><input type="checkbox" id="choose" name="test" value="chkBox" form="cancel"/></td>
			<?php
			$today = date('Y-m-d');
			$tmr= date('Y-m-d', strtotime($today . ' + 1 days'));
			/*
			if(strcmp($_SESSION["Role"],"G")==0){
				echo "<label>Choisir un adherent: </label>";
				echo "<select name ='adherent' id='adh'>";
					echo "<option>LES ADHERENTS</option>";
					$adh = "Select * from adherents";
					$resAdh = mysqli_query($conn, $adh);			
					while($range = mysqli_fetch_assoc($resAdh)){
						$ID_A = $range['ID_A'];
						$prenomAdh = $range['Prenom'];
						$nomAdh = $range['Nom'];
								echo "<option>".$ID_A."-".$nomAdh."-".$prenomAdh."</option>";           	
					}
				echo "</select>";
			}*/
			$reserveInfo = mysqli_query($conn,"select * from reservation where ID_RA='".$_SESSION['ID_A']."'   AND Date_R='".$tmr."'")or die(mysqli_error($conn));
			$resInfo = mysqli_fetch_assoc($reserveInfo);
			$idT = $resInfo['ID_RT'];

			$reqTer = mysqli_query($conn,"select * from terrain where ID_T = '".$idT."'")or die(mysqli_error($conn));
			$resReqTer = mysqli_fetch_assoc($reqTer);
						
			if(strcmp($tmr,$resInfo['Date_R'])==0){
				echo "<td>".$resReqTer['Nom_ter']."</td><td>".$tmr."</td><td>".$resInfo['Hour_R']."</td>";
			}
			?> 
			</tr>
		</table>
		<input type="submit" name="sub2" value="Annuler"/>
	</fieldset>
</form>

	<?php
	if($_SERVER['REQUEST_METHOD']=='POST'){
		if (isset($_POST['sub1'])) {
			$hour=($_POST['hours']);
			$ter=($_POST['ter']);
			$terArr = (explode("-",$ter));
			$nomT= $terArr[1];
			$ID_T= $terArr[0];		
			$currentDay = date('l');
			$currentDate = date('Y-m-d H:i:s');
			$dateRes= date('Y-m-d', strtotime($currentDate. ' + 1 days'));


			$permit = mysqli_query($conn,"select * from reservation where ID_RA='".$_SESSION["ID_A"]."'")or die(mysqli_error($conn));
			$terrainLibre = mysqli_query($conn,"select * from reservation where ID_RT='".$ID_T."' AND HOUR_R='".$hour."'")or die(mysqli_error($conn));
	//Date_R, Hour_R, Date_RD, ID_RA, ID_RT
			
			if(strcmp($currentDay,"Monday")!=0){ //.......................................CHANGER LE JOUR ICI ET A ADMIN_RESERVE.........................$$$$$$$$$$$$$
				echo "<script>alert('Vous ne pouvez reserver un terrain qu`aux mardis!'); parent.location='reservation.php'</script>";
			
			}elseif($permit->num_rows != 0){						
					echo "<script>alert('Vous avez deja reserve un terrain!'); parent.location='reservation.php'</script>";
			}elseif($terrainLibre->num_rows != 0){			
					echo "<script>alert('Le terrain n`est pas disponible pour cette hours'); parent.location='reservation.php'</script>";
			}else{
				mysqli_query($conn,"SET FOREIGN_KEY_CHECKS = 0");
				mysqli_query($conn,"insert into reservation(Date_R,Hour_R,Date_RD,ID_RA,ID_RT) value ('".$dateRes."','".$hour."','".$currentDate."','".$_SESSION["ID_A"]."','".$ID_T."')")
				or die(mysqli_error($conn));
				mysqli_query($conn,"SET FOREIGN_KEY_CHECKS = 1");
				echo "<script>alert('Votre reservation est fait pour le terrain ".$nomT." entre ".$hour." pour demain ".$dateRes."'); parent.location='reservation.php'</script>";
			}
		}else if(isset($_POST['sub2'])){
			if ($_POST['test'] == 'chkBox'){
				$cancelRes = mysqli_query($conn,"delete from reservation where ID_RA='".$_SESSION["ID_A"]."'")or die(mysqli_error($conn));
				echo "<script>alert('Votre reservation est annulee!'); parent.location='reservation.php'</script>";		
			}
		}
	}
	?>
	
	</div>

    </body>
</html>