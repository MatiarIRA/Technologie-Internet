<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:template match="/">
        <head><title>inventory</title></head>
        <body>
            <xsl:variable name="exist" select="//book[/bookstore/@specialty=@style]"/>
            <xsl:if test="$exist">
                <h1>hello</h1>
                <h1><xsl:value-of select="$exist/author/first-name"/></h1>
            </xsl:if>
            
        </body>
    </xsl:template>
</xsl:stylesheet>