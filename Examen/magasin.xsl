<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:template match="/">
       
        <head>
            <title>magasin</title>
        </head>
        <body>
            <h1> <xsl:value-of select="sum(//price)"/></h1>
            <h1>List de commends de chaque client</h1>
            <xsl:for-each select="//client[//commande/@client=@no]">
                <h2><xsl:value-of select="nom"/></h2>
                <!-- Recuperer les ID des clients qui a commande un article -->
                <xsl:variable name="numClient" select="@no"/>
                
                <table border="border" cellpadding="8px">
                    <tr>
                        <th>Article</th><th>Qte</th><th>Prix</th><th>Commentaire</th>
                    </tr> 
                    <!-- recuperer les ID des article que le client a achete a partir de la commande -->
            
                    <xsl:for-each select="//commande[@client=$numClient]/@article">
                        <!-- enregistrer ID ce dernier dans un vraibale -->
                        <xsl:variable name="numArticle" select="."/>
                        <!-- enregistrer l'article lui-meme en comparant de ID de chaque article avec ID de l'article achete par le client -->
                        <xsl:variable name="art" select="//article[@no=$numArticle]"/>
                        <tr>
                            <td><xsl:value-of select="$art/description"/></td>
                            <td><xsl:value-of select="count(//article/description[1])"/></td>
                            <td><xsl:value-of select="$art/prix"/></td>
                            <td><xsl:value-of select="//commande[@client=$numClient]/commentaire"/></td>
                        </tr>
                        <tr>
                            <td><xsl:value-of select="$art/description"/></td>
                            <td><xsl:value-of select="count(//article/description[1])"/></td>
                            <td><xsl:value-of select="$art/prix"/></td>
                            <td><xsl:value-of select="//commande[@client=$numClient]/commentaire"/></td>
                        </tr>
                    </xsl:for-each>
                    
                    
                    
                </table>
                
            </xsl:for-each>          
        </body>
    </xsl:template>
</xsl:stylesheet>