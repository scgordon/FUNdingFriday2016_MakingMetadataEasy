<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:gco="http://www.isotc211.org/2005/gco" xmlns:gmi="http://www.isotc211.org/2005/gmi" xmlns:gmx="http://www.isotc211.org/2005/gmx"
  xmlns:gsr="http://www.isotc211.org/2005/gsr" xmlns:gss="http://www.isotc211.org/2005/gss" xmlns:gts="http://www.isotc211.org/2005/gts" xmlns:srv1="http://www.isotc211.org/2005/srv" xmlns:gml="http://www.opengis.net/gml/3.2" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:cat="http://standards.iso.org/iso/19115/-3/cat/1.0" xmlns:cit="http://standards.iso.org/iso/19115/-3/cit/1.0"
  xmlns:gcx="http://standards.iso.org/iso/19115/-3/gcx/1.0" xmlns:gex="http://standards.iso.org/iso/19115/-3/gex/1.0" xmlns:lan="http://standards.iso.org/iso/19115/-3/lan/1.0" xmlns:srv="http://standards.iso.org/iso/19115/-3/srv/2.0" xmlns:mac="http://standards.iso.org/iso/19115/-3/mac/1.0" xmlns:mas="http://standards.iso.org/iso/19115/-3/mas/1.0"
  xmlns:mdb="http://standards.iso.org/iso/19115/-3/mdb/1.0" xmlns:mcc="http://standards.iso.org/iso/19115/-3/mcc/1.0" xmlns:mco="http://standards.iso.org/iso/19115/-3/mco/1.0" xmlns:mda="http://standards.iso.org/iso/19115/-3/mda/1.0" xmlns:mdt="http://standards.iso.org/iso/19115/-3/mdt/1.0" xmlns:mex="http://standards.iso.org/iso/19115/-3/mex/1.0"
  xmlns:mil="http://standards.iso.org/iso/19115/-3/mil/1.0" xmlns:mrl="http://standards.iso.org/iso/19115/-3/mrl/1.0" xmlns:mmd="http://standards.iso.org/iso/19115/-3/mmd/1.0" xmlns:mmi="http://standards.iso.org/iso/19115/-3/mmi/1.0" xmlns:mpc="http://standards.iso.org/iso/19115/-3/mpc/1.0" xmlns:mrc="http://standards.iso.org/iso/19115/-3/mrc/1.0"
  xmlns:mrd="http://standards.iso.org/iso/19115/-3/mrd/1.0" xmlns:mri="http://standards.iso.org/iso/19115/-3/mri/1.0" xmlns:mrs="http://standards.iso.org/iso/19115/-3/mrs/1.0" xmlns:msr="http://standards.iso.org/iso/19115/-3/msr/1.0" xmlns:mdq="http://standards.iso.org/iso/19115/-3/mdq/1.0" xmlns:eos="http://earthdata.nasa.gov/schema/eos" xmlns:dcite="http://datacite.org/schema/kernel-3"
  exclude-result-prefixes="gmd gsr gss gts xs gmi gmx xsi srv1">
  <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Title:DataCite to ISO 19115-1</xd:b>
      </xd:p>
      <xd:p><xd:b>Version:</xd:b>2017-01-08</xd:p>
      <xd:p><xd:b>Created on:</xd:b>January 8, 2017</xd:p>
      <xd:p><xd:b>Author:</xd:b>thabermann@hdfgroup.org</xd:p>
      <xd:p>This stylesheets transforms DataCite to ISO 19115-1</xd:p>
      <xd:p/>
    </xd:desc>
  </xd:doc>
  <xsl:variable name="translationName" select="'DataCiteToISO19115-3.xsl'"/>
  <xsl:variable name="translationVersion" select="'2017-01-08'"/>
  <xsl:output method="xml" indent="yes"/>
  <xsl:strip-space elements="*"/>

  <xsl:template match="/">
    <mdb:MD_Metadata>
      <xsl:call-template name="createISONamespaces"/>
      <mdb:metadataIdentifier>
        <mcc:MD_Identifier>
          <mcc:code>
            <gco:CharacterString>
              <xsl:value-of select="/dcite:resource/dcite:identifier"/>
            </gco:CharacterString>
          </mcc:code>
          <mcc:description>
            <gco:CharacterString>
              <xsl:value-of select="/dcite:resource/dcite:identifier/@identifierType"/>
            </gco:CharacterString>
          </mcc:description>
        </mcc:MD_Identifier>
      </mdb:metadataIdentifier>
      <xsl:for-each select="/dcite:resource/dcite:language">
        <mdb:defaultLocale>
          <lan:PT_Locale>
            <xsl:call-template name="writeCodelistElement">
              <xsl:with-param name="elementName" select="'lan:Language'"/>
              <xsl:with-param name="codeListName" select="'lan:LanguageCode'"/>
              <xsl:with-param name="codeListValue" select="."/>
            </xsl:call-template>
          </lan:PT_Locale>
        </mdb:defaultLocale>
      </xsl:for-each>
      <mdb:metadataScope>
        <mdb:MD_MetadataScope>
          <xsl:call-template name="writeCodelistElement">
            <xsl:with-param name="elementName" select="'mdb:resourceScope'"/>
            <xsl:with-param name="codeListName" select="'mcc:MD_ScopeCode'"/>
            <xsl:with-param name="codeListValue" select="'dataset'"/>
          </xsl:call-template>
        </mdb:MD_MetadataScope>
      </mdb:metadataScope>
      <xsl:for-each select="/dcite:resource/dcite:contributors/dcite:contributor[
           @contributorType = 'DataManager'
        or @contributorType = 'DataCurator'
        or @contributorType = 'HostingInstitution']">
        <xsl:call-template name="writeResponsibility">
          <xsl:with-param name="roleName" select="'mdb:contact'"/>
          <xsl:with-param name="role" select="'pointOfContact'"/>
        </xsl:call-template>
      </xsl:for-each>
      <mdb:dateInfo>
        <cit:CI_Date>
          <cit:date>
            <gco:DateTime>
              <xsl:choose>
                <xsl:when test="/*/RevisionDate">
                  <xsl:call-template name="writeDateTime">
                    <xsl:with-param name="dateTimeString" select="/*/RevisionDate"/>
                  </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="current-dateTime()"/>
                </xsl:otherwise>
              </xsl:choose>
            </gco:DateTime>
          </cit:date>
          <xsl:call-template name="writeCodelistElement">
            <xsl:with-param name="elementName" select="'cit:dateType'"/>
            <xsl:with-param name="codeListName" select="'cit:CI_DateTypeCode'"/>
            <xsl:with-param name="codeListValue" select="'creation'"/>
          </xsl:call-template>
        </cit:CI_Date>
      </mdb:dateInfo>
      <mdb:metadataStandard>
        <cit:CI_Citation>
          <cit:title>
            <xsl:call-template name="writeCharacterString">
              <xsl:with-param name="stringToWrite" select="'ISO 19115-1 Geographic Information - Metadata Part 1 Fundamentals'"/>
            </xsl:call-template>
          </cit:title>
          <cit:edition>
            <xsl:call-template name="writeCharacterString">
              <xsl:with-param name="stringToWrite" select="'ISO/FDIS 19115-1:2013(E)'"/>
            </xsl:call-template>
          </cit:edition>
        </cit:CI_Citation>
      </mdb:metadataStandard>
      <mdb:identificationInfo>
        <mri:MD_DataIdentification>
          <mri:citation>
            <xsl:call-template name="writeResourceCitation"/>
          </mri:citation>
          <mri:abstract>
            <xsl:call-template name="writeCharacterString">
              <xsl:with-param name="stringToWrite" select="/dcite:resource/dcite:descriptions/dcite:description"/>
            </xsl:call-template>
          </mri:abstract>
          <xsl:call-template name="writeCodelistElement">
            <xsl:with-param name="elementName" select="'mri:status'"/>
            <xsl:with-param name="codeListName" select="'mcc:MD_ProgressCode'"/>
            <xsl:with-param name="codeListValue" select="/Collection/CollectionState"/>
          </xsl:call-template>
          <!--
            DataCite contributorTypes that = pointOfContact
          -->
          <xsl:for-each select="/dcite:resource/dcite:contributors/dcite:contributor[@contributorType = 'ContactPerson' or @contributorType = 'DataManager']">
            <xsl:call-template name="writeResponsibility">
              <xsl:with-param name="roleName" select="'mri:pointOfContact'"/>
              <xsl:with-param name="role" select="'pointOfContact'"/>
            </xsl:call-template>
          </xsl:for-each>
          <mri:extent>
            <xsl:call-template name="writeExtent"/>
          </mri:extent>
          <xsl:for-each select="/*/AssociatedBrowseImageUrls/ProviderBrowseUrl">
            <mri:graphicOverview>
              <mcc:MD_BrowseGraphic>
                <mcc:fileName>
                  <xsl:element name="gcx:FileName">
                    <xsl:attribute name="src" select="encode-for-uri(URL)"/>
                  </xsl:element>
                </mcc:fileName>
                <mcc:fileDescription>
                  <gco:CharacterString>
                    <xsl:value-of select="concat(Description, ' File Size: ', FileSize)"/>
                  </gco:CharacterString>
                </mcc:fileDescription>
                <mcc:fileType>
                  <gco:CharacterString>
                    <xsl:value-of select="MimeType"/>
                  </gco:CharacterString>
                </mcc:fileType>
              </mcc:MD_BrowseGraphic>
            </mri:graphicOverview>
          </xsl:for-each>
          <xsl:for-each select="/dcite:resource/dcite:formats/dcite:format">
            <mri:resourceFormat>
              <mrd:MD_Format>
                <mrd:formatSpecificationCitation>
                  <cit:CI_Citation>
                    <cit:title>
                      <xsl:call-template name="writeCharacterString">
                        <xsl:with-param name="stringToWrite" select="."/>
                      </xsl:call-template>
                    </cit:title>
                  </cit:CI_Citation>
                </mrd:formatSpecificationCitation>
              </mrd:MD_Format>
            </mri:resourceFormat>
          </xsl:for-each>
          <!--
            Theme Keywords
          -->
          <mri:descriptiveKeywords>
            <mri:MD_Keywords>
              <xsl:for-each select="/dcite:resource/dcite:subjects/dcite:subject">
                <mri:keyword>
                  <gco:CharacterString>
                    <xsl:value-of select="."/>
                  </gco:CharacterString>
                </mri:keyword>
              </xsl:for-each>
              <!--<mri:thesaurusName>
                <cit:CI_Citation>
                  <cit:title>
                    <gco:CharacterString><xsl:value-of select="@subjectScheme"/></gco:CharacterString>
                  </cit:title>
                </cit:CI_Citation>
              </mri:thesaurusName>-->
              <xsl:call-template name="writeCodelistElement">
                <xsl:with-param name="elementName" select="'mri:type'"/>
                <xsl:with-param name="codeListName" select="'mri:MD_KeywordTypeCode'"/>
                <xsl:with-param name="codeListValue" select="'theme'"/>
              </xsl:call-template>
            </mri:MD_Keywords>
          </mri:descriptiveKeywords>
          <!--
            Place Keywords
          -->
          <xsl:for-each select="/dcite:resource/dcite:geoLocations/dcite:geoLocation/dcite:geoLocationPlace">
            <mri:descriptiveKeywords>
              <mri:MD_Keywords>
                <xsl:for-each select="/dcite:resource/dcite:geoLocations/dcite:geoLocation/dcite:geoLocationPlace">
                  <mri:keyword>
                    <gco:CharacterString>
                      <xsl:value-of select="."/>
                    </gco:CharacterString>
                  </mri:keyword>
                </xsl:for-each>
                <xsl:call-template name="writeCodelistElement">
                  <xsl:with-param name="elementName" select="'mri:type'"/>
                  <xsl:with-param name="codeListName" select="'mri:MD_KeywordTypeCode'"/>
                  <xsl:with-param name="codeListValue" select="'place'"/>
                </xsl:call-template>
              </mri:MD_Keywords>
            </mri:descriptiveKeywords>
          </xsl:for-each>
          <xsl:for-each select="/dcite:resource/dcite:rightsList/dcite:rights">
            <mri:resourceConstraints>
              <mco:MD_LegalConstraints>
                <mco:otherConstraints>
                  <xsl:call-template name="writeCharacterString">
                    <xsl:with-param name="stringToWrite" select="."/>
                  </xsl:call-template>
                </mco:otherConstraints>
              </mco:MD_LegalConstraints>
            </mri:resourceConstraints>
          </xsl:for-each>
          <mri:supplementalInformation/>
        </mri:MD_DataIdentification>
      </mdb:identificationInfo>
      <mdb:distributionInfo>
        <mrd:MD_Distribution>
          <mrd:distributor>
            <mrd:MD_Distributor>

              <xsl:for-each select="/*/Contacts/Contact[contains(Role, 'Archive') or contains(Role, 'DATA CENTER CONTACT') or contains(Role, 'Distributor') or contains(Role, 'User Services') or contains(Role, 'GHRC USER SERVICES') or contains(Role, 'ORNL DAAC User Services')]">
                <xsl:if test="position() = 1">
                  <xsl:call-template name="writeResponsibility">
                    <xsl:with-param name="roleName" select="'mrd:distributorContact'"/>
                  </xsl:call-template>
                </xsl:if>
              </xsl:for-each>
              <mrd:distributionOrderProcess>
                <mrd:MD_StandardOrderProcess>
                  <mrd:fees>
                    <xsl:call-template name="writeCharacterString">
                      <xsl:with-param name="stringToWrite" select="/*/Price"/>
                    </xsl:call-template>
                  </mrd:fees>
                </mrd:MD_StandardOrderProcess>
              </mrd:distributionOrderProcess>
              <xsl:for-each select="/dcite:resource/dcite:formats/dcite:format">
                <mrd:distributorFormat>
                  <mrd:MD_Format>
                    <mrd:formatSpecificationCitation>
                      <cit:CI_Citation>
                        <cit:title>
                          <xsl:call-template name="writeCharacterString">
                            <xsl:with-param name="stringToWrite" select="."/>
                          </xsl:call-template>
                        </cit:title>
                      </cit:CI_Citation>
                    </mrd:formatSpecificationCitation>
                  </mrd:MD_Format>
                </mrd:distributorFormat>
              </xsl:for-each>
              <mrd:distributorTransferOptions>
                <mrd:MD_DigitalTransferOptions>
                  <xsl:if test="/*/DataGranule/SizeMBDataGranule">
                    <mrd:transferSize>
                      <gco:Real>
                        <xsl:value-of select="/*/DataGranule/SizeMBDataGranule"/>
                      </gco:Real>
                    </mrd:transferSize>
                  </xsl:if>
                  <xsl:for-each select="/*/OnlineAccessURLs/OnlineAccessURL">
                    <mrd:onLine>
                      <cit:CI_OnlineResource>
                        <cit:linkage>
                          <gco:CharacterString>
                            <xsl:value-of select="encode-for-uri(URL)"/>
                          </gco:CharacterString>
                        </cit:linkage>
                        <cit:applicationProfile>
                          <xsl:call-template name="writeCharacterString">
                            <xsl:with-param name="stringToWrite" select="MimeType"/>
                          </xsl:call-template>
                        </cit:applicationProfile>
                        <cit:description>
                          <xsl:call-template name="writeCharacterString">
                            <xsl:with-param name="stringToWrite" select="URLDescription"/>
                          </xsl:call-template>
                        </cit:description>
                      </cit:CI_OnlineResource>
                    </mrd:onLine>
                  </xsl:for-each>
                  <xsl:for-each select="/*/OnlineResources/OnlineResource">
                    <mrd:onLine>
                      <cit:CI_OnlineResource>
                        <cit:linkage>
                          <gco:CharacterString>
                            <xsl:value-of select="encode-for-uri(URL)"/>
                          </gco:CharacterString>
                        </cit:linkage>
                        <cit:applicationProfile>
                          <xsl:call-template name="writeCharacterString">
                            <xsl:with-param name="stringToWrite" select="MimeType"/>
                          </xsl:call-template>
                        </cit:applicationProfile>
                        <cit:name>
                          <xsl:call-template name="writeCharacterString">
                            <xsl:with-param name="stringToWrite" select="Type"/>
                          </xsl:call-template>
                        </cit:name>
                        <cit:description>
                          <xsl:call-template name="writeCharacterString">
                            <xsl:with-param name="stringToWrite" select="Description"/>
                          </xsl:call-template>
                        </cit:description>
                        <xsl:call-template name="writeCodelistElement">
                          <xsl:with-param name="elementName" select="'cit:function'"/>
                          <xsl:with-param name="codeListName" select="'cit:CI_OnLineFunctionCode'"/>
                          <xsl:with-param name="codeListValue" select="'information'"/>
                        </xsl:call-template>
                      </cit:CI_OnlineResource>
                    </mrd:onLine>
                  </xsl:for-each>
                </mrd:MD_DigitalTransferOptions>
              </mrd:distributorTransferOptions>
            </mrd:MD_Distributor>
          </mrd:distributor>
        </mrd:MD_Distribution>
      </mdb:distributionInfo>
      <mdb:metadataMaintenance>
        <mmi:MD_MaintenanceInformation>
          <xsl:call-template name="writeCodelistElement">
            <xsl:with-param name="elementName" select="'mmi:maintenanceAndUpdateFrequency'"/>
            <xsl:with-param name="codeListName" select="'mmi:MD_MaintenanceFrequencyCode'"/>
            <xsl:with-param name="codeListValue" select="'irregular'"/>
          </xsl:call-template>
          <mmi:maintenanceNote>
            <gco:CharacterString>
              <xsl:value-of select="concat('Translated to ISO using ', $translationName, ' Version: ', $translationVersion)"/>
            </gco:CharacterString>
          </mmi:maintenanceNote>
        </mmi:MD_MaintenanceInformation>
      </mdb:metadataMaintenance>
    </mdb:MD_Metadata>
  </xsl:template>
  <!-- suppress default with this template -->
  <xsl:template match="text()"/>
  <xsl:template name="createISONamespaces">
    <!-- new namespaces -->
    <!-- Namespaces that include concepts outside of metadata -->
    <!-- Catalog -->
    <xsl:namespace name="cat" select="'http://standards.iso.org/iso/19115/-3/cat/1.0'"/>
    <!-- Citation -->
    <xsl:namespace name="cit" select="'http://standards.iso.org/iso/19115/-3/cit/1.0'"/>
    <!-- Geospatial Common eXtension -->
    <xsl:namespace name="gcx" select="'http://standards.iso.org/iso/19115/-3/gcx/1.0'"/>
    <!-- Geospatial EXtent -->
    <xsl:namespace name="gex" select="'http://standards.iso.org/iso/19115/-3/gex/1.0'"/>
    <!-- Language Localization -->
    <xsl:namespace name="lan" select="'http://standards.iso.org/iso/19115/-3/lan/1.0'"/>
    <!-- Metadata for Services -->
    <xsl:namespace name="srv" select="'http://standards.iso.org/iso/19115/-3/srv/2.0'"/>
    <!-- Namespaces specific to metadata -->
    <!-- Metadata for Application Schema -->
    <xsl:namespace name="mas" select="'http://standards.iso.org/iso/19115/-3/mas/1.0'"/>
    <!-- Metadata for Common Classes -->
    <xsl:namespace name="mcc" select="'http://standards.iso.org/iso/19115/-3/mcc/1.0'"/>
    <!-- Metadata for COnstraints -->
    <xsl:namespace name="mco" select="'http://standards.iso.org/iso/19115/-3/mco/1.0'"/>
    <!-- MetaData Application -->
    <xsl:namespace name="mda" select="'http://standards.iso.org/iso/19115/-3/mda/1.0'"/>
    <!-- Metadata based Data Transfer -->
    <xsl:namespace name="mdt" select="'http://standards.iso.org/iso/19115/-3/mdt/1.0'"/>
    <!-- Metadata for EXtensions -->
    <xsl:namespace name="mex" select="'http://standards.iso.org/iso/19115/-3/mex/1.0'"/>
    <!-- Metadata for Maintenance Information -->
    <xsl:namespace name="mmi" select="'http://standards.iso.org/iso/19115/-3/mmi/1.0'"/>
    <!-- Metadata for MetaData -->
    <xsl:namespace name="mmd" select="'http://standards.iso.org/iso/19115/-3/mmd/1.0'"/>
    <!-- Metadata for Portrayal Catalog -->
    <xsl:namespace name="mpc" select="'http://standards.iso.org/iso/19115/-3/mpc/1.0'"/>
    <!-- Metadata for Resource Content -->
    <xsl:namespace name="mrc" select="'http://standards.iso.org/iso/19115/-3/mrc/1.0'"/>
    <!-- Metadata for Resource Distribution -->
    <xsl:namespace name="mrd" select="'http://standards.iso.org/iso/19115/-3/mrd/1.0'"/>
    <!-- Metadata for Resource Identification -->
    <xsl:namespace name="mri" select="'http://standards.iso.org/iso/19115/-3/mri/1.0'"/>
    <!-- Metadata for Resource Lineage -->
    <xsl:namespace name="mrl" select="'http://standards.iso.org/iso/19115/-3/mrl/1.0'"/>
    <!-- Metadata for Reference System -->
    <xsl:namespace name="mrs" select="'http://standards.iso.org/iso/19115/-3/mrs/1.0'"/>
    <!-- Metadata for Spatial Representation -->
    <xsl:namespace name="msr" select="'http://standards.iso.org/iso/19115/-3/msr/1.0'"/>
    <!-- Metadata for MetaData -->
    <xsl:namespace name="mmd" select="'http://standards.iso.org/iso/19115/-3/mmd/1.0'"/>
    <!-- Data quality namespaces -->
    <!-- Data Quality Measures -->
    <xsl:namespace name="dqm" select="'http://standards.iso.org/iso/19115/-3/dqm/1.0'"/>
    <!-- Metadata for Data Quality -->
    <xsl:namespace name="mdq" select="'http://standards.iso.org/iso/19115/-3/mdq/1.0'"/>
    <!-- Metadata for Acquisition and Imagery -->
    <xsl:namespace name="mai" select="'http://standards.iso.org/iso/19115/-3/mai/1.0'"/>
    <!-- Metadata for Acquisition -->
    <xsl:namespace name="mac" select="'http://standards.iso.org/iso/19115/-3/mac/1.0'"/>
    <!-- Metadata for Image Content -->
    <xsl:namespace name="mic" select="'http://standards.iso.org/iso/19115/-3/mic/1.0'"/>
    <!-- Metadata for Image Lineage -->
    <xsl:namespace name="mil" select="'http://standards.iso.org/iso/19115/-3/mil/1.0'"/>
    <!-- Metadata for Image spatial -->
    <xsl:namespace name="mis" select="'http://standards.iso.org/iso/19115/-3/mis/1.0'"/>
    <!-- other ISO namespaces -->
    <!-- Geospatial COmmon -->
    <xsl:namespace name="gco" select="'http://www.isotc211.org/2005/gco'"/>
    <!-- external namespaces -->
    <xsl:namespace name="gml" select="'http://www.opengis.net/gml/3.2'"/>
    <xsl:namespace name="xlink" select="'http://www.w3.org/1999/xlink'"/>
    <xsl:namespace name="xsi" select="'http://www.w3.org/2001/XMLSchema-instance'"/>
  </xsl:template>
  <xsl:template name="writeResourceCitation">
    <cit:CI_Citation>
      <!-- The dataCite standard allows multiple titles -->
      <xsl:for-each select="/dcite:resource/dcite:titles/dcite:title">
        <xsl:choose>
          <xsl:when test="position() = 1">
            <cit:title>
              <xsl:call-template name="writeCharacterString">
                <xsl:with-param name="stringToWrite">
                  <xsl:value-of select="."/>
                </xsl:with-param>
              </xsl:call-template>
            </cit:title>
          </xsl:when>
          <xsl:otherwise>
            <cit:alternateTitle>
              <xsl:call-template name="writeCharacterString">
                <xsl:with-param name="stringToWrite">
                  <xsl:value-of select="."/>
                </xsl:with-param>
              </xsl:call-template>
            </cit:alternateTitle>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
      <xsl:for-each select="/dcite:resource/dcite:dates/dcite:date">
        <cit:date>
          <cit:CI_Date>
            <cit:date>
              <gco:DateTime>
                <xsl:call-template name="writeDateTime">
                  <xsl:with-param name="dateTimeString" select="/*/LastUpdate"/>
                </xsl:call-template>
              </gco:DateTime>
            </cit:date>
            <xsl:call-template name="writeCodelistElement">
              <xsl:with-param name="elementName" select="'cit:dateType'"/>
              <xsl:with-param name="codeListName" select="'cit:CI_DateTypeCode'"/>
              <xsl:with-param name="codeListValue" select="'revision'"/>
            </xsl:call-template>
          </cit:CI_Date>
        </cit:date>
      </xsl:for-each>
      <cit:edition/>
      <cit:identifier>
        <mcc:MD_Identifier>
          <mcc:MD_Identifier>
            <mcc:code>
              <gco:CharacterString>
                <xsl:value-of select="/dcite:resource/dcite:identifier"/>
              </gco:CharacterString>
            </mcc:code>
            <mcc:description>
              <gco:CharacterString>
                <xsl:value-of select="/dcite:resource/dcite:identifier/@identifierType"/>
              </gco:CharacterString>
            </mcc:description>
          </mcc:MD_Identifier>
        </mcc:MD_Identifier>
      </cit:identifier>
      <xsl:for-each select="/dcite:resource/dcite:contributors/dcite:contributor">
        <xsl:call-template name="writeResponsibility">
          <xsl:with-param name="roleName" select="'cit:citedResponsibleParty'"/>
        </xsl:call-template>
      </xsl:for-each>
    </cit:CI_Citation>
  </xsl:template>
  <xsl:template name="writeResponsibility">
    <xsl:param name="roleName"/>
    <xsl:param name="role"/>
    <xsl:element name="{$roleName}">
      <cit:CI_Responsibility>
        <xsl:variable name="roleValue">
          <xsl:choose>
            <xsl:when test="$role">
              <xsl:value-of select="$role"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="@contributorType"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:call-template name="writeCodelistElement">
          <xsl:with-param name="elementName" select="'cit:role'"/>
          <xsl:with-param name="codeListName" select="'cit:CI_RoleCode'"/>
          <xsl:with-param name="codeListValue" select="$roleValue"/>
        </xsl:call-template>
        <cit:party>
          <xsl:choose>
            <xsl:when test="dcite:affiliation">
              <cit:party>
                <cit:CI_Organisation>
                  <cit:name>
                    <gco:CharacterString>
                      <xsl:value-of select="dcite:affiliation"/>
                    </gco:CharacterString>
                  </cit:name>
                  <cit:individual>
                    <cit:CI_Individual>
                      <cit:name>
                        <gco:CharacterString>
                          <xsl:value-of select="dcite:contributorName"/>
                        </gco:CharacterString>
                      </cit:name>
                    </cit:CI_Individual>
                  </cit:individual>
                </cit:CI_Organisation>
              </cit:party>
            </xsl:when>
            <xsl:otherwise>
              <cit:CI_Individual>
                <cit:name>
                  <xsl:call-template name="writeCharacterString">
                    <xsl:with-param name="stringToWrite" select="./dcite:contributorName"/>
                  </xsl:call-template>
                </cit:name>
              </cit:CI_Individual>
            </xsl:otherwise>
          </xsl:choose>
        </cit:party>
      </cit:CI_Responsibility>
    </xsl:element>
  </xsl:template>
  <xsl:template name="writeCharacterString">
    <xsl:param name="stringToWrite"/>
    <xsl:choose>
      <xsl:when test="$stringToWrite">
        <gco:CharacterString>
          <xsl:value-of select="normalize-space($stringToWrite)"/>
        </gco:CharacterString>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="gco:nilReason">
          <xsl:value-of select="'missing'"/>
        </xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="writeCodelistElement">
    <xsl:param name="elementName"/>
    <xsl:param name="codeListName"/>
    <xsl:param name="codeListValue"/>
    <!-- The correct codeList Location goes here -->
    <xsl:variable name="codeListLocation" select="'codeListLocation'"/>
    <xsl:if test="$codeListValue">
      <xsl:element name="{$elementName}">
        <xsl:element name="{$codeListName}">
          <xsl:attribute name="codeList">
            <xsl:value-of select="$codeListLocation"/>
            <xsl:value-of select="'#'"/>
            <xsl:value-of select="substring-after($codeListName, ':')"/>
          </xsl:attribute>
          <xsl:attribute name="codeListValue">
            <!-- the anyValidURI value is used for testing with paths -->
            <!-- commented out for testing -->
            <!--<xsl:value-of select="'anyValidURI'"/>-->
            <xsl:value-of select="$codeListValue"/>
          </xsl:attribute>
          <xsl:value-of select="$codeListValue"/>
        </xsl:element>
      </xsl:element>
    </xsl:if>
  </xsl:template>
  <xsl:template name="writeDateTime">
    <xsl:param name="dateTimeString"/>
    <xsl:value-of select="$dateTimeString"/>
    <xsl:if test="not(contains($dateTimeString, 'T'))">
      <xsl:value-of select="'T00:00:00'"/>
    </xsl:if>
  </xsl:template>
  <xsl:template name="writeExtent">
    <gex:EX_Extent id="boundingExtent">
      <xsl:call-template name="writeExtentBoundingBox"/>
    </gex:EX_Extent>
  </xsl:template>
  <xsl:template name="writeExtentBoundingBox">
    <xsl:for-each select="/dcite:resource/dcite:geoLocations/dcite:geoLocation/dcite:geoLocationPoint">
      <xsl:comment>Point</xsl:comment>
      <xsl:variable name="coordinates" select="tokenize(., ' ')"/>
      <!-- 
        Write bounding box around point assumming points are lat lon
      -->
      <gex:geographicElement>
        <gex:EX_GeographicBoundingBox>
          <gex:westBoundLongitude>
            <gco:Decimal>
              <xsl:value-of select="$coordinates[2]"/>
            </gco:Decimal>
          </gex:westBoundLongitude>
          <gex:eastBoundLongitude>
            <gco:Decimal>
              <xsl:value-of select="$coordinates[2]"/>
            </gco:Decimal>
          </gex:eastBoundLongitude>
          <gex:southBoundLatitude>
            <gco:Decimal>
              <xsl:value-of select="$coordinates[1]"/>
            </gco:Decimal>
          </gex:southBoundLatitude>
          <gex:northBoundLatitude>
            <gco:Decimal>
              <xsl:value-of select="$coordinates[1]"/>
            </gco:Decimal>
          </gex:northBoundLatitude>
        </gex:EX_GeographicBoundingBox>
      </gex:geographicElement>
    </xsl:for-each>
    <xsl:for-each select="/*/Spatial/HorizontalSpatialDomain/Geometry/GPolygon">
      <xsl:comment>Polygon</xsl:comment>
      <gex:geographicElement>
        <gex:EX_BoundingPolygon>
          <gex:polygon>
            <gml:LineString>
              <xsl:attribute name="gml:id" select="generate-id()"/>
              <gml:posList>
                <xsl:for-each select="Boundary/Point">
                  <xsl:value-of select="concat(PointLongitude, ' ', PointLatitude)"/>
                  <xsl:if test="position() != last()">
                    <xsl:text> </xsl:text>
                  </xsl:if>
                </xsl:for-each>
              </gml:posList>
            </gml:LineString>
          </gex:polygon>
        </gex:EX_BoundingPolygon>
      </gex:geographicElement>
    </xsl:for-each>
    <xsl:for-each select="/dcite:resource/dcite:geoLocations/dcite:geoLocation/dcite:geoLocationBox">
      <xsl:comment>Bounding Rectangle</xsl:comment>
      <xsl:variable name="coordinates" select="tokenize(., ' ')"/>
      <gex:geographicElement>
        <gex:EX_GeographicBoundingBox>
          <gex:westBoundLongitude>
            <gco:Decimal>
              <xsl:value-of select="$coordinates[2]"/>
            </gco:Decimal>
          </gex:westBoundLongitude>
          <gex:eastBoundLongitude>
            <gco:Decimal>
              <xsl:value-of select="$coordinates[4]"/>
            </gco:Decimal>
          </gex:eastBoundLongitude>
          <gex:southBoundLatitude>
            <gco:Decimal>
              <xsl:value-of select="$coordinates[1]"/>
            </gco:Decimal>
          </gex:southBoundLatitude>
          <gex:northBoundLatitude>
            <gco:Decimal>
              <xsl:value-of select="$coordinates[3]"/>
            </gco:Decimal>
          </gex:northBoundLatitude>
        </gex:EX_GeographicBoundingBox>
      </gex:geographicElement>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="writeGeographicIdentifiers"> </xsl:template>
  <xsl:template name="writeExtentTemporalInformation">
    <xsl:for-each select="/*/Temporal/SingleDateTime">
      <gex:temporalElement>
        <xsl:comment>SingleDateTime</xsl:comment>
        <gex:EX_TemporalExtent>
          <!-- In cases with multiple SingleDateTimes this boundingTemporalExtent id is not correct -->
          <xsl:if test="position() = 1">
            <xsl:attribute name="id" select="'boundingTemporalExtent'"/>
          </xsl:if>
          <gex:extent>
            <gml:TimeInstant>
              <xsl:attribute name="gml:id" select="generate-id()"/>
              <gml:timePosition>
                <xsl:if test="/*/Temporal/DateType">
                  <xsl:attribute name="frame" select="/*/Temporal/DateType"/>
                </xsl:if>
                <xsl:value-of select="."/>
              </gml:timePosition>
            </gml:TimeInstant>
          </gex:extent>
        </gex:EX_TemporalExtent>
      </gex:temporalElement>
    </xsl:for-each>
    <xsl:for-each select="/*/Temporal/RangeDateTime">
      <gex:temporalElement>
        <gex:EX_TemporalExtent>
          <xsl:if test="position() = 1">
            <!-- In cases with multiple RangeDateTimes this boundingTemporalExtent id is not correct -->
            <xsl:attribute name="id" select="'boundingTemporalExtent'"/>
          </xsl:if>
          <gex:extent>
            <gml:TimePeriod>
              <xsl:attribute name="gml:id" select="generate-id()"/>
              <gml:beginPosition>
                <xsl:if test="/*/Temporal/DateType">
                  <xsl:attribute name="frame" select="/*/Temporal/DateType"/>
                </xsl:if>
                <xsl:value-of select="BeginningDateTime"/>
              </gml:beginPosition>
              <gml:endPosition>
                <xsl:if test="/*/Temporal/DateType">
                  <xsl:attribute name="frame" select="/*/Temporal/DateType"/>
                </xsl:if>
                <xsl:choose>
                  <xsl:when test="/Collection/Temporal/EndsAtPresentFlag = 'true'">
                    <xsl:attribute name="indeterminatePosition">now</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="EndingDateTime"/>
                  </xsl:otherwise>
                </xsl:choose>
              </gml:endPosition>
            </gml:TimePeriod>
          </gex:extent>
        </gex:EX_TemporalExtent>
      </gex:temporalElement>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
