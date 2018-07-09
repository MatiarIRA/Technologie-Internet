<?php
session_start();
?>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta charset="UTF-8"></meta>
        <title>CIPSUM</title>
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
                <li><a href="login.php"> Se deconnecter </a></li>
                <li><a href="APropos.xhtml">propos</a></li>
            </ul>
        </nav>
        
        <div class="homeimage"><img src="http://www.tandemevenements.com/wp-content/uploads/2012/06/dominickgravel-2190-web.jpg"
            alt="des parkoureurs"/><h1 class="accueil">Beinvenu a CEPSUM</h1></div>
        
        <div class="homemain">
        
        <h2>But du site</h2>
        <p>
            Le but de ce site est d'introduire le sport <strong>Parkour</strong>. Vous allez donc obtenir des renseignements 
            sur <a href="histoire.xhtml"> <em><b>l'histoire</b></em> </a> du sport et bien familiariser avec 
            <a href="entrainement.xhtml"> <em><b>l'entraînement</b></em></a> 
            et savoir <a href="quipeut.xhtml"> <em><b>qui peut le faire</b></em></a>.

        </p>
        <h2>Parkour</h2>
        <p>
            Le <strong>parkour</strong> (abrégé PK) ou <strong>art du déplacement</strong> (abrégé ADD)
            est une discipline de la formation en utilisant le mouvement qui a développé à partir de la formation
            militaire de course d'obstacles. Les praticiens visent à rendre d'un point à un autre dans un 
            environnement complexe, sans équipement d'assistance et de la manière la plus rapide et la plus
            efficace possible. Parkour comprend courir, grimper, se balancer, saut, sauter, rouler, le mouvement 
            quadrupède, et d'autres mouvements que paraît la mieux adaptée à la situation.Le développement de 
            Parkour de la formation militaire, il donne quelques aspects d'un non- art martial combatif.
            
            Parkour est une activité qui peut être pratiquée seule ou avec d'autres, et est généralement, mais pas 
            exclusivement-réalisée dans les espaces urbains. Parkour implique de voir son environnement d'une
            manière nouvelle, et en imaginant les potentialités pour la navigation, il par mouvement autour, 
            partout, dans, sur et sous ses caractéristiques. 
            
        <br/>
        <br/>
            Le parkour en tant que tel n’existe que depuis les années 1990. Il reste peu connu du grand public et des institutions sportives traditionnelles.
            
        </p>
        </div>
          
    </body>
</html>