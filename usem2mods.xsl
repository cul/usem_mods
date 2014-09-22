<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:mods="http://www.loc.gov/mods/v3" exclude-result-prefixes="xs xd" version="2.0">
    <xd:doc scope="stylesheet" version="3.5">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Aug 28, 2014</xd:p>
            <xd:p><xd:b>Author:</xd:b> terry</xd:p>
            <xd:p/>
        </xd:desc>
    </xd:doc>
    <xsl:template match="/">
        <xsl:apply-templates select="//row[note01[not(contains(text(),'REMOVE FILE'))]]"/>
    </xsl:template>
    <xsl:template match="row">
        <xsl:message select="concat('mods/',translate(filepath, '\\', '/'),'_mods.xml')"/>
        <xsl:result-document encoding="utf-8" href="mods/{translate(filepath, '\\', '/')}_mods.xml"
            indent="yes">
            <mods:mods xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-5.xsd">
                <mods:titleInfo>
                    <mods:title>
                        <xsl:apply-templates select="content_type" mode="title"/>
                        <xsl:apply-templates select="date" mode="title"/>
                        <xsl:value-of select="seminar_name"/>
                        <xsl:text xml:space="preserve">, seminar </xsl:text>
                        <xsl:value-of select="seminar_number"/>
                        <xsl:text xml:space="preserve">, </xsl:text>
                        <xsl:value-of select="academic_year"/>
                    </mods:title>
                </mods:titleInfo>
                <mods:name authority="naf" type="corporate">
                    <mods:namePart>Columbia University. University Seminars</mods:namePart>
                </mods:name>
                <mods:name>
                    <mods:namePart>
                        <xsl:text xml:space="preserve">Seminar </xsl:text>
                        <xsl:value-of select="seminar_number"/>
                    </mods:namePart>
                </mods:name>
                <xsl:apply-templates select="academic_year"/>
                <mods:language>
                    <mods:languageTerm>eng</mods:languageTerm>
                </mods:language>
                <mods:typeOfResource>text</mods:typeOfResource>
                <xsl:apply-templates select="content_type"/>
                <mods:subject>
                    <mods:topic>
                        <xsl:value-of select="seminar_name"/>
                    </mods:topic>
                </mods:subject>
                <mods:relatedItem type="host" displayLabel="project">
                    <mods:titleInfo>
                        <mods:title>University Seminars Digital Archive</mods:title>
                    </mods:titleInfo>
                </mods:relatedItem>
                <mods:relatedItem type="host" displayLabel="collection">
                    <mods:titleInfo>
                        <mods:title>University Seminars records</mods:title>
                    </mods:titleInfo>
                </mods:relatedItem>
                <mods:note type="original_filename">
                    <xsl:text>original filename:&#160;</xsl:text>
                    <xsl:value-of select="filename"/>
                </mods:note>
                <mods:location>
                    <mods:physicalLocation>Rare Book &amp; Manuscript Library, Columbia University</mods:physicalLocation>
                    <mods:physicalLocation authority="marcorg">NNC-RB</mods:physicalLocation>
                </mods:location>
                <mods:recordInfo>
                    <mods:recordIdentifier>??????</mods:recordIdentifier>
                    <mods:languageOfCataloging>
                        <mods:languageTerm>eng</mods:languageTerm>
                    </mods:languageOfCataloging>
                    <mods:recordOrigin>Created and edited in general conformance to MODS Guideline. (Version 3)</mods:recordOrigin>
                    <mods:recordContentSource>NNC</mods:recordContentSource>
                </mods:recordInfo>
            </mods:mods>
        </xsl:result-document>

    </xsl:template>
    <xsl:template match="academic_year">
        <mods:originInfo>
            <mods:place>
                <mods:placeTerm>New York</mods:placeTerm>
            </mods:place>
            <mods:dateCreated>
                <xsl:value-of select="."/>
            </mods:dateCreated>
            <mods:dateCreated encoding="iso8601" keyDate="yes" point="start">
                <xsl:value-of select="substring-before(., '-')"/>
            </mods:dateCreated>
            <mods:dateCreated encoding="iso8601" keyDate="yes" point="end">
                <xsl:value-of select="substring-after(., '-')"/>
            </mods:dateCreated>
        </mods:originInfo>
    </xsl:template>
    <xsl:template match="content_type">
        <mods:physicalDescription>
            <mods:form authority="aat">administrative records</mods:form>
            <mods:form>
                <xsl:value-of select="."/>
            </mods:form>
            <mods:digitalOrigin>reformatted digital</mods:digitalOrigin>
            <mods:internetMediaType>pdf</mods:internetMediaType>
        </mods:physicalDescription>
    </xsl:template>
    <xsl:template match="content_type" mode="title">
        <xsl:value-of select="concat(upper-case(substring(.,1,1)),
            substring(.,2))"/>
        <xsl:text xml:space="preserve"> </xsl:text>
    </xsl:template>
    <xsl:template match="date" mode="title">
        <xsl:value-of select="."/>
        <xsl:text xml:space="preserve"> </xsl:text>
    </xsl:template>
</xsl:stylesheet>
