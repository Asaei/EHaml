<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:utils="af:utils">

    <xsl:import href="attr-common.xsl"/>
    <xsl:import href="attr-container.xsl"/>
    <xsl:import href="label.xsl"/>
    <xsl:output method="html" indent="no" omit-xml-declaration="yes" />

    <xsl:template name="ctl-title">
        <xsl:if test="Size != ''">
            <xsl:element name="{Size}">
                <xsl:attribute name="class">
                    <xsl:text>section-title </xsl:text>
                    <xsl:if test="ShowLine = 'True'">underlined</xsl:if>

                    <xsl:text> col-sm-</xsl:text>
                    <xsl:value-of select="ColSpan"/>

                    <xsl:if test="ColOffset > 0">
                        <xsl:text> col-sm-offset-</xsl:text>
                        <xsl:value-of select="ColOffset"/>
                    </xsl:if>
                </xsl:attribute>
				<xsl:if test="utils:tokenize(LabelCssStyles) != ''">
					<xsl:attribute name="style">
						<xsl:value-of select="utils:tokenize(LabelCssStyles)"></xsl:value-of>
					</xsl:attribute>		
				</xsl:if>
				
                <xsl:if test="ShortDesc != '' and /Form/Settings/LabelAlign = 'inside'">
                    <xsl:attribute name="title">
                        <xsl:value-of select="ShortDesc"/>
                    </xsl:attribute>
                </xsl:if>

                <xsl:attribute name="data-fieldid">
                    <xsl:value-of select="Id"/>
                </xsl:attribute>
                <xsl:attribute name="data-af-field">
                    <xsl:value-of select="Name"/>
                </xsl:attribute>

                <!--<xsl:if test="BindValue != ''">-->
                <xsl:attribute name="data-af-bindvalue">
                    <xsl:value-of select="utils:parseAngularJs(BindValue, 'true')"/>
                </xsl:attribute>
                <!--</xsl:if>-->

                <xsl:if test="BindShow != ''">
                    <xsl:attribute name="data-ng-show">
                        <xsl:value-of select="utils:parseAngularJs(BindShow, 'true')"/>
                    </xsl:attribute>
                </xsl:if>

                <xsl:attribute name="data-ng-model">
                    <xsl:text>form.fields.</xsl:text>
                    <xsl:value-of select="Name"/>
                    <xsl:text>.value</xsl:text>
                </xsl:attribute>

                <xsl:value-of select="TitleTokenized" />
            </xsl:element>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>
