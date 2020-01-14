<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml" version="2.0">
    <xsl:output method="html"/>
    
    <xsl:template match="/WFAC">
        <html>
            <head>
                <title><xsl:value-of select="tournament/@name"/></title>
            </head>
            <body>
                <h1><xsl:value-of select="tournament/@name"/></h1>
                <h2>Inhaltsverzeichnis</h2>
                <xsl:for-each select="tournament/day/group">
                    <a href="#{generate-id()}"><xsl:value-of select="@name"/> - <xsl:value-of select="parent::day/@date"/></a><br/>
                </xsl:for-each>
                <xsl:apply-templates select="tournament/day"/>
            </body>
        </html>
    </xsl:template>
    
    <!-- Template for each day of a tournament -->
    <xsl:template match="day">
        <h2><xsl:value-of select="position()"/>. Day, <xsl:value-of select="@date"/></h2>
        <hr></hr>
        <xsl:apply-templates select="group"/>
    </xsl:template>
    
    <!-- Template for each group of a day -->
    <xsl:template match="group">
        <h3 id="{generate-id()}"><xsl:value-of select="@name"/></h3>
        <xsl:for-each select="dailyscore">
            <div xml:space="preserve">
                <xsl:value-of select="id(@competitor-id)/fname"/>
                <xsl:value-of select="id(@competitor-id)/lname"/>
                (<a href="#"><xsl:value-of select="@score"/></a>)
            </div>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
