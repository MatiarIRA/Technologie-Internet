<?xml version="1.0" encoding="UTF-8"?>
<!--Auteurs: Mohammad Hossein ERFANIAN AZMOUDEH (20031314) et
             Hanifa MALLEK (P1005515) -->

<!-- un fichier pour visualiser les informations associées aux livres (comme leur auteur), 
    triés en ordre décroissant de leur prix, ou à un seul livre dont le nom sera passé comme valeur du paramètre livre -->
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
<!--        Entrez le un nom du livre ou entrez 'tout' pour voir tous les livres de la bibliotheque--> 
            <xsl:with-param name="livre" select="'tout'" />
        </xsl:call-template>
    </xsl:template>

<!-- C'est le template pour recherche le livre souhaité -->
    <xsl:template name="recherche">
        <xsl:param name="livre" select="0"></xsl:param>

        <xsl:choose>
            <xsl:when test="matches($livre, 'tout' ,'i')">
                <xsl:call-template name="livre">
                    <xsl:with-param name="path" select="//livre" />
                </xsl:call-template> 
            </xsl:when>
            <xsl:when test="count(//livre[matches(titre,$livre,'i')])=0">
                    <h1>Le livre souhaité n'est pas accessible</h1>              
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="livre">
                    <xsl:with-param name="path" select="//livre[matches(titre,$livre,'i')]"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>       
    </xsl:template>

<!-- le template qui forme un tableau de resultat-->
    <xsl:template name="livre">
        <xsl:param name="path" select="."></xsl:param>
        
        <html>
            <head>
                <title>Livrres de la biblio</title>
                <link rel="stylesheet" type="text/css" href="biblio.css" />
            </head>
            <body>
                <h3>Biliothèque: Livre(s)</h3>
                <section>
                    <div class="container">                   
                        <table border="border" cellpadding="8px">                        
                            <thead>
                                <tr class="header">
                                    <th>Titre<div>Titre</div></th>
                                    <th>Auteur(s)<div>Auteur(s)</div></th>
                                    <th>Prix<div>Prix</div></th>
                                    <th>Couverture<div>Couverture</div></th>
                                    <th>Film<div>Film</div></th>
                                    <th>Personnage<div>Personnage</div></th>
                                    <th>Commentaire<div>Commentaire</div></th>
                                </tr>
                            </thead>       
                            <xsl:for-each select="$path">
                                <xsl:sort select="prix/valeur" order="descending"/>                       
                                <tr>
                                    <td>
                                        <xsl:value-of select="titre"/>
                                        <br/><br/>
                                        <i>Année de Publication: <xsl:value-of select="annee"/></i>
                                    </td>
                                    <td>
                                        <xsl:variable name="bookAuthors" select="@auteurs"/>
                                        <xsl:for-each select="//auteur">
                                            <xsl:if test="contains($bookAuthors,@ident)">
                                                <a><xsl:value-of select="prenom"/><span>s</span><xsl:value-of select="nom"/></a>
                                                <br/><br/>
                                            </xsl:if>
                                        </xsl:for-each>
                                    </td>
                                    <td>
                                        <a><xsl:value-of select="prix/valeur"/><span>s</span><xsl:value-of select="prix/@monnaie"/></a>
                                    </td>
                                    <td>
                                        <img>
                                            <xsl:attribute name="src"><xsl:value-of select="couverture"/></xsl:attribute>
                                            <xsl:attribute name="alt">image de couverture du livre</xsl:attribute>
                                            <xsl:attribute name="style">width:150px;height:100px;</xsl:attribute>
                                        </img><br/>
                                        <a>
                                            <xsl:attribute name="href">
                                                <xsl:value-of select="couverture"/>
                                            </xsl:attribute>
                                            Le couverture
                                        </a>
                                    </td>
                                    <td>
                                        <xsl:if test="count(./film)=1">
                                            <a>
                                                <xsl:attribute name="href">
                                                    <xsl:value-of select="film"/>
                                                </xsl:attribute>
                                                le film sorti du livre
                                            </a>  
                                        </xsl:if>                             
                                    </td>
                                    <td width="300px">
                                        <xsl:for-each select="personnage">
                                            <b><xsl:value-of select="prenom"/><span>s</span><xsl:value-of select="nom"/></b>
                                            <br/>
                                            Pays: <xsl:value-of select="pays"/>
                                            <br/>
                                            <a>
                                                <xsl:attribute name="href">
                                                    <xsl:value-of select="photo"/>
                                                </xsl:attribute>
                                                photo du personnage
                                            </a>
                                            <br/>
                                            <p>
                                                <xsl:value-of select="commentaire"/>
                                            </p>                                   
                                        </xsl:for-each>
                                    </td>
                                    <td width="300px">
                                        <p>
                                            <xsl:value-of select="commentaire"/>  
                                        </p>                               
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
