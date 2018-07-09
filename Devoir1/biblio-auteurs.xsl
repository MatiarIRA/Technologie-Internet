<?xml version="1.0" encoding="UTF-8"?>
<!--Auteurs: Mohammad Hossein ERFANIAN AZMOUDEH (20031314) et
             Hanifa MALLEK (P1005515) -->

<!-- un fichier pour visualiser les informations associées à tous les auteurs
        (comme leur information personnelle, les informations des livres qu'ils ont écrit)
        ou à un seul auteur dont le nom sera passé comme valeur du paramètre auteur -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
<xsl:output method="xml" 
    doctype-system="http://www.w3.org/Strict/xhtml1/DTD/xhtml1-
    strict.dtd" 
    doctype-public="-//W3C//DTD XHTML 1.0 Strict//
    EN" indent="yes"/>
    
    
<!-- le template principale-->
    <xsl:template match="/">
        <xsl:call-template name="recherche">
<!--        Entrez le un nom d'un auteur ou entrez 'tout' pour voir tous les auteurs enregistres dans la base de donnee de la bibliotheque--> 
            <xsl:with-param name="auteur" select="'tout'" />
        </xsl:call-template>
    </xsl:template>    
 
<!-- C'est le template pour recherche l'auteur(e)(s) souhaité(e)(s) -->
    <xsl:template name="recherche">
        <xsl:param name="auteur" select="0"></xsl:param>
       
        <xsl:choose>
            <xsl:when test="matches($auteur,'tout','i')">
                <xsl:call-template name="auteur">
                    <xsl:with-param name="path" select="//auteur" />
                </xsl:call-template> 
            </xsl:when>
            <xsl:when test="count(//auteur[matches(nom,$auteur,'i')])=0">
                <h1>L'auteur(e) souhaité n'est pas accessible</h1>              
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="auteur">
                    <xsl:with-param name="path" select="//auteur[matches(nom,$auteur,'i')]"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>       
    </xsl:template>

<!-- le template qui forme un tableau de resultat-->
    <xsl:template name="auteur">
        <xsl:param name="path" select="."></xsl:param>
        <html>
            <head>
                <title>Auteurs de la biblio</title>
                <link rel="stylesheet" type="text/css" href="biblio.css" />
            </head>
            <body>
                <h3>Biliothèque: Livre(s)</h3>
                <section>
                    <div class="container">
                        <table border="border" cellpadding="8px">
                            <thead>
                                <tr class="header">
                                    <th>Auteur<div>Auteur</div></th>
                                    <th>Livre(s)<div>Livre(s)</div></th>
                                    <th>Pays<div>Pays</div></th>
                                    <th>Photo<div>Photo</div></th>
                                    <th>Commentaire<div>Commentaire</div></th>
                                </tr>
                            </thead>  
                            <xsl:for-each select="$path">
                                <xsl:sort select="auteur" order="ascending"/>                       
                                <tr>
                                    <td>
                                        <a><xsl:value-of select="prenom"/><span>s</span> <xsl:value-of select="nom"/></a>
                                    </td>
                                    <td>
                                        <xsl:variable name="authors" select="@ident"/>
                                        <xsl:variable name="books" select="@auteurs"/>
                                        <xsl:for-each select="//livre">
                                            <xsl:if test="contains($authors,$books)">
                                               <xsl:if test="contains(./@auteurs,$authors)">
                                                 <xsl:value-of select="titre"/>
                                                 <br/><br/>
                                               </xsl:if>
                                            </xsl:if>
                                        </xsl:for-each>
                                    </td>
                                    <td>
                                        <xsl:value-of select="pays"/>
                                    </td>
                                    <td>
                                        <img>
                                            <xsl:attribute name="src"><xsl:value-of select="photo"/></xsl:attribute>
                                            <xsl:attribute name="alt">Photo de l'auteur(e)</xsl:attribute>
                                            <xsl:attribute name="style">width:150px;height:100px;</xsl:attribute>
                                        </img><br/>
                                        <a>
                                            <xsl:attribute name="href">
                                                <xsl:value-of select="photo"/>
                                            </xsl:attribute>
                                            Photo de l'auteur(e)
                                        </a>
                                    </td>
                                    <td width="300px">
                                        <p><xsl:value-of select="commentaire"/></p>
                                    </td>
                                </tr>
                            </xsl:for-each>
                        </table>
                    </div>
                </section>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>


