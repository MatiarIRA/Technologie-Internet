<?xml version="1.0" encoding="UTF-8"?>
<!--  Créer une feuille de style XSL permettant à partir de cette fiche recette de produire une page HTML qui :
a pour titre le contenu de la balise titre ;
commence par un titre <h1> ayant comme contenu le contenu de la balise titre ;
    donne ensuite le nom de l'auteur de la recette ;
    affiche ensuite le mot "Remarque :" puis le contenu de la balise remarque ;
    affiche "Procédure :" en niveau <h2> ;
        puis dans un paragraphe, présente la procédure à suivre(contenu de procedure).
        Evaluer la feuille de style à l'aide de Exchanger XML, puis d'un navigateur web classique (Firefox ou IE). -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:template match="/">
        <html>
            <head>
                <title><xsl:value-of select="recette/entete/titre"/></title>
            </head>
            <body>
                <h1><xsl:value-of select="recette/entete/titre"/></h1>
                <h1><xsl:value-of select="recette/entete/auteur"/></h1>
                <h1>Remarque :<xsl:value-of select="recette/entete/remarque"/></h1>
                <h2>Procédure :</h2>
                <p><xsl:value-of select="recette/procedure"/></p>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>