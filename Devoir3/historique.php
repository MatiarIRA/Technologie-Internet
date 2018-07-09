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
		<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
		<script>
			$(document).ready(function() {
				var cell = $("td");
				cell = shuffle(cell);
				updateGrid(cell);
				alert("Vous devez choisir une case a bouger!");
				deplace = 0;
				$("#count").text(deplace + "");
			});
		</script>
        
    </head>
    <body id=<?php if(strcmp($_SESSION["Role"],"G")==0){echo "G";}else{echo "J";} ?>>
    	<header>
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
                 <?php
					if(strcmp($_SESSION["Role"],"G")==0){
						echo "<li><a  href='admin_reserve.php'> Faire une reservation </a></li>";
					}else{
						echo "<li><a  href='reservation.php'> Faire une reservation </a></li>";
					}
				?>
                <li><a class="selection" href="historique.php"> Historique </a></li>
                <li><a href="login.php"> Se deconnecter </a></li>
                <li><a href="APropos.xhtml">propos</a></li>
            </ul>
        </nav>
    	
    	<div>
	
	<?php
		include 'config_conn.php';
	?>
	<form method="POST" action="<?PHP $_PHP_SELF ?>" >
	<?php
	if(strcmp($_SESSION["Role"],"G")==0){	
		echo "<fieldset>";
		echo "<legend>Verifier historique d'un adherent</legend>";
				echo "<label>Choisir un adherent: </label>";
				echo "<select name ='adherent' id='adh'>";    //name adherent
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
			echo "<label> Choisir parmis les Mercredis du mois current:</label>";
				echo "<select name ='chooseDay' id='day'>";    //name adherent
				$firstDay = date('Y-m-01');
				$currentDay = date('Y-m-d');	
				$i = 1;	
		
					while($currentDay > $firstDay){
						$currentDay = date('Y-m-d', strtotime($currentDate. ' - '.$i.' days'));
						$i++;
						$timestamp = strtotime($currentDay);
						if(strcmp(date("l", $timestamp),"Wednesday")==0){
							echo "<option>".$currentDay."</option>"; 
						}          	
					}		
			echo "</select>";
			echo "<br/>";
			echo "<input type='submit' name='sub' value='Soumettre'/>";
			echo "</fieldset>";
	}			
	?>	
	</form>
    <table border="1">
    <tr><th>R</th><th>Adherent</th><th>Nom du terrain</th><th>Date de reservation</th><th>Heures</th><th>Reservation a ete fait a</th></tr>
    <?php
	//Date_R, Hour_R, Date_RD, ID_RA, ID_RT	
	$currentDate = date('Y-m-d');
	$dateRes= date('Y-m-d', strtotime($currentDate. ' + 1 days'));
	$oneMonthAgo = date('Y-m-d', strtotime('-1 month', strtotime($dateRes)));
	if(strcmp($_SESSION["Role"],"G")==0){	
		if($_SERVER['REQUEST_METHOD']=='POST'){
				$adh=($_POST['adherent']);
				$chDay = ($_POST['chooseDay']);
				$adhArr = (explode("-",$adh));
				$prenomAdh= $adhArr[2];
				$nomAdh= $adhArr[1];
				$ID_A= $adhArr[0];
				$histAdmin = mysqli_query($conn,"select * from reservation where ID_RA='".$ID_A."' AND Date_R<='".$chDay."'")or die(mysqli_error($conn));
				if($histAdmin->num_rows == 0){
					echo "<span>Aucun resultat!</span>";
				}				
				$r = 1;
				while($range = mysqli_fetch_assoc($histAdmin)){
					$checkTer = mysqli_query($conn,"select Nom_ter from terrain where ID_T='".$range['ID_RT']."'")or die(mysqli_error($conn));
					$resultTer = mysqli_fetch_assoc($checkTer);
					$nomT= $resultTer ['Nom_ter'];
					$checkAdh = mysqli_query($conn,"select Prenom, Nom from adherents where ID_A='".$range['ID_RA']."'")or die(mysqli_error($conn));
					$resultAdh = mysqli_fetch_assoc($checkAdh);
					$nomAdh= $resultAdh ['Nom'];
					$prenomAdh= $resultAdh ['Prenom'];
					echo "<tr><td>".$r++."</td><td>" .$prenomAdh." ".$nomAdh."</td><td>".$nomT."</td><td>".$range['Date_R']."</td><td>".$range['Hour_R']."</td><td>".$range['Date_RD']."</td></tr>";
				}
		}
	}else{
		$hist = mysqli_query($conn,"select * from reservation where ID_RA='".$_SESSION["ID_A"]."' AND Date_R<='".$dateRes."' AND Date_R>='".$oneMonthAgo."' ")or die(mysqli_error($conn));		
		$r = 1;
		while($range = mysqli_fetch_assoc($hist)){
			$checkTer = mysqli_query($conn,"select Nom_ter from terrain where ID_T='".$range['ID_RT']."'")or die(mysqli_error($conn));
			$resultTer = mysqli_fetch_assoc($checkTer);
			$nomT= $resultTer ['Nom_ter'];
            echo "<tr><td>".$r++."</td><td>" .$_SESSION["Prenom"]." ".$_SESSION["Nom"]."</td><td>".$nomT."</td><td>".$range['Date_R']."</td><td>".$range['Hour_R']."</td><td>".$range['Date_RD']."</td></tr>"; 
		}
	}

	?>	
    </table>
	</div>  
    </body>
</html>