<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">

    <xsl:template match="/WFAC">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master master-name="wfac-page" page-height="297.0mm"
                    page-width="209.9mm" margin-bottom="8mm" margin-left="25mm" margin-right="10mm"
                    margin-top="10mm">

                    <fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="44mm"
                        margin-top="20mm"/>

                    <fo:region-before extent="24pt" region-name="recipe-header"/>

                    <fo:region-after extent="24pt" region-name="recipe-footer"/>

                </fo:simple-page-master>
            </fo:layout-master-set>

            <!-- Front page -->
            <fo:page-sequence master-reference="wfac-page">
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="28pt">
                    <fo:block>
                        <xsl:value-of select="tournament/@name"/>
                    </fo:block>


                    <!-- table of contents -->
                    <fo:block font-weight="bold" margin-top="10mm" font-size="13pt">Table of
                        Contents</fo:block>
                    <fo:list-block space-before="12pt" font-size="9pt">
                        <xsl:apply-templates select="tournament/day/group" mode="inhalt"/>
                    </fo:list-block>
                </fo:flow>
            </fo:page-sequence>

            <fo:page-sequence master-reference="wfac-page">
                <fo:flow flow-name="xsl-region-body">
                    <xsl:apply-templates select="tournament/day"/>
                </fo:flow>
            </fo:page-sequence>
    
            <fo:page-sequence master-reference="wfac-page">
                <fo:flow flow-name="xsl-region-body">
                    <fo:block font-size="18pt" margin-top="20mm">Scorecard</fo:block>
                    <xsl:apply-templates select="tournament/day/group/dailyscore/scorecard"/>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>

    <!-- Inhaltsverzeichnis -->
    <xsl:template match="tournament/day/group" mode="inhalt">
        <fo:list-item>
            <fo:list-item-label>
                <fo:block> </fo:block>
            </fo:list-item-label>

            <fo:list-item-body>
                <fo:block>
                    <xsl:value-of select="@name"/> - <xsl:value-of select="parent::day/@date"/>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>

    <!-- Template for a day -->
    <xsl:template match="tournament/day">
        <fo:block font-size="18pt" margin-top="15pt">
            <xsl:value-of select="position()"/>. Day, <xsl:value-of select="@date"/>
        </fo:block>
        <xsl:apply-templates select="group" mode="day"/>
        <xsl:apply-templates select="." mode="total" >
            <xsl:with-param name="dayNumber" select="position()"/>
        </xsl:apply-templates>
    </xsl:template>

    <!-- group -->
    <xsl:template match="tournament/day/group" mode="day">
        <fo:block font-size="16pt" margin-top="10pt">
            <xsl:value-of select="@name"/>
        </fo:block>
        <xsl:for-each select="dailyscore">
           <fo:block>
                <xsl:value-of select="id(@competitor-id)/fname"/>
                <xsl:value-of select="id(@competitor-id)/lname"/>
                    (<xsl:value-of select="@score"/>)
           </fo:block>
        </xsl:for-each>
    </xsl:template>
    
    
    <!-- total day score list -->
    <xsl:template match="day" mode="total">
        <xsl:param name="dayNumber"/>
        <fo:block margin-top="10pt" font-size="16pt">
            <xsl:value-of select="$dayNumber"/>. Day scoring
        </fo:block>
        <xsl:for-each select="group/dailyscore">
            <xsl:sort select="@score" order="descending"/>
            <fo:block>
                <xsl:value-of select="id(@competitor-id)/fname"/>
                <xsl:value-of select="id(@competitor-id)/lname"/>                  
                    (<xsl:value-of select="@score"/>)
            </fo:block>
        </xsl:for-each>
    </xsl:template>
    
    
    <!-- Template for scorecards -->
    <xsl:template match="scorecard" xml:space="preserve">
        <fo:block font-size="13pt" margin-top="10pt" margin-bottom="10pt">
               <xsl:value-of select="parent::dailyscore/id(@competitor-id)/fname"/>
               <xsl:value-of select="parent::dailyscore/id(@competitor-id)/lname"/>
               -
               <xsl:value-of select="parent::dailyscore/parent::group/@name"/>
               <xsl:value-of select="parent::dailyscore/parent::group/parent::day/@date"/>
        </fo:block>
        <fo:table border="1px solid black">
            <fo:table-header>
                <fo:table-row font-weight="bold">
                    <fo:table-cell>
                        <fo:block border="1px solid black">target</fo:block>
                    </fo:table-cell>              
                    <fo:table-cell>
                        <fo:block border="1px solid black">arrow 1</fo:block>
                    </fo:table-cell>    
                    <fo:table-cell>
                        <fo:block border="1px solid black">arrow 2</fo:block>
                    </fo:table-cell>  
                    <fo:table-cell>
                        <fo:block border="1px solid black">arrow 3</fo:block>
                    </fo:table-cell>   
                    <fo:table-cell>
                        <fo:block border="1px solid black">arrow 4</fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-header>
            <fo:table-body>
                <xsl:for-each select="score">
                    <fo:table-row>
                        <fo:table-cell>
                            <fo:block border="1px solid black">
                                <xsl:value-of select="@station"/>
                            </fo:block>
                        </fo:table-cell>
                        
                        <xsl:for-each select="arrowScore">
                            
                            <xsl:sort select="@attempt" order="ascending"/>
                                
                            <fo:table-cell>
                                <fo:block border="1px solid black">
                                    <xsl:value-of select="@value"/>
                                </fo:block>
                            </fo:table-cell>
                        </xsl:for-each>
                    </fo:table-row>
                </xsl:for-each>
            </fo:table-body>
        </fo:table>

    </xsl:template>
    

</xsl:stylesheet>
