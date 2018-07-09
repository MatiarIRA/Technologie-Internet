<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:template match="titre" name="titre"><xsl:value-of select="recette/entete/titre"/></xsl:template>

    <xsl:template match="entete" name="entete"> 
        <h1><xsl:value-of select="recette/entete/auteur"/></h1>
        <br></br>
        <h1>Ramarque:
            <xsl:value-of select="recette/entete/remarque"/></h1>
    </xsl:template>
    
    <xsl:template match="procedure" name="procedure">
        Procedure:
        <xsl:value-of select="recette/procedure/text"/>
         <br></br>
             <xsl:for-each select="recette/procedure/list">
                <li><xsl:value-of select="."/></li>
            </xsl:for-each>
         
    </xsl:template>
    
    <xsl:template match="/">
        <html> 
            <head>
                <title><xsl:call-template name="titre"></xsl:call-template></title> 
            </head>
            <body>
                <h1><xsl:call-template name="titre"></xsl:call-template></h1>
                <xsl:call-template name="entete"></xsl:call-template>
                <ul><xsl:call-template name="procedure"></xsl:call-template></ul>
            </body>
        </html>
    </xsl:template>
    

</xsl:stylesheet>