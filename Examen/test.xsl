<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    
    <xsl:template match="/">
        <xsl:variable name="bookAuthors" select="@auteurs"/>
        <xsl:variable name="authors" select="//auteur[contains($bookAuthors,/@ident)]"/>
        <xsl:for-each select="$bookAuthors">
            <xsl:value-of select="$bookAuthors"/>
        </xsl:for-each>
        
        <xsl:for-each select="//auteur[//livre/$bookAuthors=@ident]">
            <h2><xsl:value-of select="nom"/></h2>
            <!-- Recuperer les ID des auteurs qui a commande un article -->
            <xsl:variable name="idAuteur" select="@ident"/>
            
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
        
        
        
        
        
        
        
    </xsl:template>
    
    
    
</xsl:stylesheet>