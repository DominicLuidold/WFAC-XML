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
                <xsl:apply-templates select="tournament/day" mode="group"/>
                <h2>Scorecard</h2>
                <xsl:apply-templates select="tournament/day/group/dailyscore/scorecard"/>
            </body>
        </html>
    </xsl:template>
    
    <!-- Template for each day of a tournament -->
    <xsl:template match="day" mode="group">
        <h2><xsl:value-of select="position()"/>. Day, <xsl:value-of select="@date"/></h2>
        <xsl:apply-templates select="group"/>
        <xsl:apply-templates select="." mode="total" >
            <xsl:with-param name="dayNumber" select="position()"></xsl:with-param>
        </xsl:apply-templates>

    </xsl:template>
    
    <!-- Template for each group of a day -->
    <xsl:template match="group">
        <hr></hr>
        <h3 id="{generate-id()}"><xsl:value-of select="@name"/></h3>
        <xsl:for-each select="dailyscore">
            <div xml:space="preserve">
                <xsl:value-of select="id(@competitor-id)/fname"/>
                <xsl:value-of select="id(@competitor-id)/lname"/>
                <xsl:if test="count(scorecard) > 0">                    
                    (<a href="#{generate-id(scorecard)}"><xsl:value-of select="@score"/></a>)
                </xsl:if>
                <xsl:if test="count(scorecard) = 0">                    
                    (<xsl:value-of select="@score"/>)
                </xsl:if>
            </div>
        </xsl:for-each>
    </xsl:template>
    
    <!-- Template total day score list -->
    <xsl:template match="day" mode="total">
        <xsl:param name="dayNumber"></xsl:param>
        <hr></hr>
        <h3><xsl:value-of select="$dayNumber"/>. Day scoring</h3>
        <xsl:for-each select="group/dailyscore">
            <xsl:sort select="@score" order="descending" />   
            <div xml:space="preserve">
                <xsl:value-of select="id(@competitor-id)/fname"/>
                <xsl:value-of select="id(@competitor-id)/lname"/>
                <xsl:if test="count(scorecard) > 0">                    
                    (<a href="#{generate-id(scorecard)}"><xsl:value-of select="@score"/></a>)
                </xsl:if>
                <xsl:if test="count(scorecard) = 0">                    
                    (<xsl:value-of select="@score"/>)
                </xsl:if>
            </div>
        </xsl:for-each>
    </xsl:template>
    
    <!-- Template for scorecards -->
    <xsl:template match="scorecard">
        <hr></hr>
        <div xml:space="preserve" id="{generate-id()}">
            <h3>
               <xsl:value-of select="parent::dailyscore/id(@competitor-id)/fname"/>
               <xsl:value-of select="parent::dailyscore/id(@competitor-id)/lname"/>
               -
               <xsl:value-of select="parent::dailyscore/parent::group/@name"/>
               <xsl:value-of select="parent::dailyscore/parent::group/parent::day/@date"/>
            </h3>
        </div>
        <table style="border: black 1px solid; border-collapse: collapse">
            <tr style="border: black 1px solid">
                <th style="border: black 1px solid">target</th>
                <th style="border: black 1px solid">arrow 1</th>
                <th style="border: black 1px solid">arrow 2</th>
                <th style="border: black 1px solid">arrow 3</th>
                <th style="border: black 1px solid">arrow 4</th>
            </tr>
            <xsl:for-each select="score">
                <tr style="border: black 1px solid">
                    <td style="border: black 1px solid">
                        <xsl:value-of select="@station"/>    
                    </td>
                    <xsl:for-each select="arrowScore">
                        <xsl:sort select="@attempt" order="ascending" />   
                        <td style="border: black 1px solid">
                             <xsl:value-of select="@value"/>
                        </td>
                   </xsl:for-each>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>
</xsl:stylesheet>
