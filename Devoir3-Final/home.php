<!--Mohammad Hossein ERFANIAN , Hanifa MALLEK-->
<?php
session_start();
?>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta charset="UTF-8"></meta>
        <title>Accueil</title>
        <link href="clubSportif.css" rel="stylesheet" type="text/css" style="screen"/>
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    </head>
    <body id=<?php if(strcmp($_SESSION["Role"],"G")==0){echo "G";}else{echo "J";} ?> class="homePage">
        <header class=<?php if(strcmp($_SESSION["Role"],"G")==0){echo "headerAdmin";}else{echo "headerAdh";} ?>>
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
                <li><a class="selection" href="home.php">Accueil</a></li>
                <?php
					if(strcmp($_SESSION["Role"],"G")==0){
						echo "<li><a  href='admin_reserve.php'> Faire une reservation </a></li>";
					}else{
						echo "<li><a  href='reservation.php'> Faire une reservation </a></li>";
					}
				?>
                <li><a href="historique.php"> Historique </a></li>
                <li id="out"><a href="logout.php"> Se deconnecter </a></li>
            </ul>
        </nav>
        
        <div class="homeimage"><img src="http://www.tandemevenements.com/wp-content/uploads/2012/06/dominickgravel-2190-web.jpg"
            alt="des parkoureurs"/><h1 class="accueil">Beinvenu au CEPSUM</h1></div>
        
        <div class="homemain">
        
        <h2>Introduction</h2>
        <p>
            Ce site est le site de club sportif de l'Universite de Montreal s'appellant <strong>CEPSUM</strong>. Ici vous pouvez reserver un terrain 
            sur l'ongle<a href="reservation.php"> <em><b>Faire une reservation</b></em> </a> vous pouvez egalement vous consulter l'historique de vos activités durant le mois currant sur l'ongle
            <a href="historique.php"> <em><b>Historique</b></em></a>. 
            N'oubliez pas de partager votre plaisir et votre experience avec vos amis. :)

        </div>
          </body>
</html>