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
    <body id="G">
    	<header class="headerAdmin">
    		<?php
			// Echo session variables that were set on previous page
			echo "Bonjour <span>" .$_SESSION["Prenom"]." ".$_SESSION["Nom"]."</span>";
			echo "ADMIN";
			?>	
    	</header>
    	<nav>
            <ul>
                <li><a href="home.php">Accueil</a></li>
                <li><a class="selection" href="admin_reserve.php"> Faire une reservation </a></li>
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
<!-- SECTION DE LA VERFICATION DES TERRAINS DISPONIBLES ................... -->
	<form method="POST" action="<?PHP $_PHP_SELF ?>">
	<fieldset>
	<legend>Terrains Disponibles</legend>
		<label> Entre les heures: </label>
	<select name="startHour" id="sh">
		<option>6</option>
		<option>7</option>
		<option>8</option>
		<option>9</option>
		<option>10</option>
		<option>11</option>
		<option>12</option>
		<option>13</option>
		<option>14</option>
		<option>15</option>
		<option>16</option>
		<option>17</option>
		<option>18</option>
		<option>19</option>
		<option>20</option>
	</select>
	<label> et: </label>
	<select name="endHour" id="eh">
		<option>7</option>
		<option>8</option>
		<option>9</option>
		<option>10</option>
		<option>11</option>
		<option>12</option>
		<option>13</option>
		<option>14</option>
		<option>15</option>
		<option>16</option>
		<option>17</option>
		<option>18</option>
		<option>19</option>
		<option>20</option>
		<option>21</option>
	</select>
	<input type='submit' name='sub3' value='Soumettre'/>
	</fieldset>
	</form>
	<?php
	if($_SERVER['REQUEST_METHOD']=='POST'){
		if(strcmp(date('l'),"Thursday")!=0){ //--------------------------------------------------------------------------------------------------------CHANGE DAY
				echo "<script>alert('Vous ne pouvez reserver un terrain qu`aux mardis!'); parent.location='admin_reserve.php'</script>";
		}else if (isset($_POST['sub3'])) {
			$sh = $_POST['startHour'];
			$eh = $_POST['endHour'];
			$ish = (int)$sh;
			$ieh = (int)$eh;
			if($ish>$ieh){
				echo "<script>alert('L`heure de debut doit etre inferieur que celle de fin!'); parent.location='admin_reserve.php'</script>";
			}else{
			for($i=$ish; $i<=$ieh; $i++){
				$j=$i+1;
				$hourR = $i."h - ".$j."h";
echo $hourR; echo"<br/>";
				$resInfo = mysqli_query($conn,"select * from reservation where Hour_R='".$hourR."'")or die(mysqli_error($conn));
				$resRange = mysqli_fetch_assoc($resInfo);
				$idT = $resRange['ID_RT'];
echo $idT;
				$terInfo = mysqli_query($conn,"select * from terrain where ID_T='".$idT."'")or die(mysqli_error($conn));
				$terRange = mysqli_fetch_assoc($terInfo);
				$terNom = $terRange['Nom'];
				if($terInfo){
				echo $terNom;
}

			}
			}
		}
	}
	?>

<!-- SECTION DE LA RESERVATION ............................................ -->
	<form method="POST" action="<?PHP $_PHP_SELF ?>">
	<fieldset>

	<legend>Reservation</legend>
	
<!-- RESERVATION PAR ADMIN ............................................ -->

			<label>Choisir un adherent: </label>
			<select name ='adherent' id='adh'>    //name adherent
			<?php
				echo "<option>LES ADHERENTS</option>";
				$adh = "Select * from adherents";
				$resAdh = mysqli_query($conn, $adh);			
				while($range = mysqli_fetch_assoc($resAdh)){
					$ID_A = $range['ID_A'];
					$prenomAdh = $range['Prenom'];
					$nomAdh = $range['Nom'];
							echo "<option>".$ID_A."-".$nomAdh."-".$prenomAdh."</option>";           	
				}
			
		?>
		</select>

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
	<input required='required' type='text' size='10' placeholder='AAAA/MM/JJ' name='date' id='date'/-->
	<label>   Heures: </label>
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
<!-- SECTION DE L'ANNULATION ............................................ -->
<form id="cancel" method="POST" action="<?PHP $_PHP_SELF ?>">
	<fieldset>
		<legend>Annuler une reservation</legend>
		<table border="1">
			<thead>Les reservations:</thead>
			<tr><th>C</th><th>Adherent</th><th>Terrain</th><th>Date de reservation</th><th>Heures</th></tr>
			
			<?php
			$today = date('Y-m-d');
			$tmr= date('Y-m-d', strtotime($today . ' + 1 days'));
			
			$reserveInfo = mysqli_query($conn,"select * from reservation where Date_R='".$tmr."'")or die(mysqli_error($conn));
			
			

			while($resInfo = mysqli_fetch_assoc($reserveInfo)){
				$idT = $resInfo['ID_RT'];
				$idA = $resInfo['ID_RA'];
				$reqTer = mysqli_query($conn,"select * from terrain where ID_T = '".$idT."'")or die(mysqli_error($conn));
				$resReqTer = mysqli_fetch_assoc($reqTer);
				$reqAdh = mysqli_query($conn,"select * from adherents where ID_A = '".$idA."'")or die(mysqli_error($conn));
				$resReqAdh = mysqli_fetch_assoc($reqAdh);
						
				if(strcmp($tmr,$resInfo['Date_R'])==0){
					echo "<tr><td><input type='checkbox' name='checkbox[]' value='".$resReqAdh['ID_A']."' form='cancel'/></td><td>".$resReqAdh['Prenom']." ".$resReqAdh['Nom']."</td><td>".$resReqTer['Nom_ter']."</td><td>".$tmr."</td><td>".$resInfo['Hour_R']."</td></tr>";
				}
			}
			?> 
			
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

			$adh=($_POST['adherent']);
			$adhArr = (explode("-",$adh));
			$prenomAdh= $adhArr[2];
			$nomAdh= $adhArr[1];
			$ID_A= $adhArr[0];	

			$currentDay = date('l');
			$currentDate = date('Y-m-d H:i:s');
			$dateRes= date('Y-m-d', strtotime($currentDate. ' + 1 days'));


			$permit = mysqli_query($conn,"select * from reservation where ID_RA='".$ID_A."' AND Date_R='".$dateRes."'")or die(mysqli_error($conn));
			$terrainLibre = mysqli_query($conn,"select * from reservation where ID_RT='".$ID_T."' AND HOUR_R='".$hour."'")or die(mysqli_error($conn));
	//Date_R, Hour_R, Date_RD, ID_RA, ID_RT
	//Verfier le jour ..............................................................................................................................................................		
			if(strcmp($currentDay,"Thursday")!=0){
				echo "<script>alert('Vous ne pouvez reserver un terrain qu`aux mardis!'); parent.location='admin_reserve.php'</script>";
			
			}elseif($permit->num_rows != 0){
				$resPermit = mysqli_fetch_assoc($permit);
				$terrain = mysqli_query($conn,"select * from terrain where ID_T='".$resPermit['ID_RT']."'")or die(mysqli_error($conn));
				$resTerrain = mysqli_fetch_assoc($terrain);
						
					echo "<script>alert('une reservation est deja attribue a ".$prenomAdh." ".$nomAdh." pour le terrain ".$resTerrain['Nom_ter']." entre ".$resPermit['Hour_R']." pour demain ".$resPermit['Date_R']."'); parent.location='admin_reserve.php'</script>";
			}elseif($terrainLibre->num_rows != 0){			
					echo "<script>alert('Le terrain n`est pas disponible pour cette hours'); parent.location='admin_reserve.php'</script>";
			}else{
				mysqli_query($conn,"SET FOREIGN_KEY_CHECKS = 0");
				mysqli_query($conn,"insert into reservation(Date_R,Hour_R,Date_RD,ID_RA,ID_RT) value ('".$dateRes."','".$hour."','".$currentDate."','".$ID_A."','".$ID_T."')")
				or die(mysqli_error($conn));
				mysqli_query($conn,"SET FOREIGN_KEY_CHECKS = 1");
				echo "<script>alert('Reservation attribue a ".$prenomAdh." ".$nomAdh." pour le terrain ".$nomT." entre ".$hour." pour demain ".$dateRes."'); parent.location='admin_reserve.php'</script>";
			}

		}else if(isset($_POST['sub2'])){
		//$countRes = mysqli_query($conn,"select count(*) from reservation where Date_R='".$dateRes."'")or die(mysqli_error($conn));
		//$row = $countRes->fetch_row();
		//$counter = $row[0];

		$checkbox = $_POST['checkbox'];

		for($i=0;$i<count($checkbox);$i++){
			$del_id = $checkbox[$i];				
				$cancelRes = mysqli_query($conn,"delete from reservation where ID_RA='".$del_id."'")or die(mysqli_error($conn));
						
			}
			// if successful redirect to admin_reserve.php .........................................................................................changer partout...........
			if($cancelRes){
			echo "<script>alert('Annulation est fait!')</script><meta http-equiv=\"refresh\" content=\"0;URL=admin_reserve.php\">";
			}
			
		}
	}
	?>
	
	</div>  
    </body>
</html>