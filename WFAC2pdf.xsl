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
                        <xsl:apply-templates select="tournament/day/group"/>
                    </fo:list-block>
                </fo:flow>
            </fo:page-sequence>

            <fo:page-sequence master-reference="wfac-page">
                <fo:flow flow-name="xsl-region-body">

                    <xsl:apply-templates select="tournament/day"/>


                </fo:flow>
            </fo:page-sequence>

        </fo:root>
    </xsl:template>

    <xsl:template match="tournament/day/group">
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


        <fo:block>
            <xsl:value-of select="position()"/>. Day, <xsl:value-of select="@date"/>
        </fo:block>

    </xsl:template>

</xsl:stylesheet>
