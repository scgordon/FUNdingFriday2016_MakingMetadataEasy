<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:srv1="http://www.isotc211.org/2005/srv" xmlns:gml="http://www.opengis.net/gml/3.2" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:cat="http://standards.iso.org/iso/19115/-3/cat/1.0"
  xmlns:cit="http://standards.iso.org/iso/19115/-3/cit/1.0" xmlns:gco="http://standards.iso.org/iso/19115/-3/gco/1.0" xmlns:gcx="http://standards.iso.org/iso/19115/-3/gcx/1.0" xmlns:gex="http://standards.iso.org/iso/19115/-3/gex/1.0" xmlns:lan="http://standards.iso.org/iso/19115/-3/lan/1.0" xmlns:srv="http://standards.iso.org/iso/19115/-3/srv/2.0"
  xmlns:mac="http://standards.iso.org/iso/19115/-3/mac/1.0" xmlns:mdb="http://standards.iso.org/iso/19115/-3/mdb/1.0" xmlns:mcc="http://standards.iso.org/iso/19115/-3/mcc/1.0" xmlns:mco="http://standards.iso.org/iso/19115/-3/mco/1.0" xmlns:mdt="http://standards.iso.org/iso/19115/-3/mdt/1.0" xmlns:mex="http://standards.iso.org/iso/19115/-3/mex/1.0"
  xmlns:mrl="http://standards.iso.org/iso/19115/-3/mrl/1.0" xmlns:mmi="http://standards.iso.org/iso/19115/-3/mmi/1.0" xmlns:mrc="http://standards.iso.org/iso/19115/-3/mrc/1.0" xmlns:mrd="http://standards.iso.org/iso/19115/-3/mrd/1.0" xmlns:mri="http://standards.iso.org/iso/19115/-3/mri/1.0" xmlns:mrs="http://standards.iso.org/iso/19115/-3/mrs/1.0"
  xmlns:msr="http://standards.iso.org/iso/19115/-3/msr/1.0" xmlns:mdq="http://standards.iso.org/iso/19157/-2/mdq/1.0" xmlns:eos="http://earthdata.nasa.gov/schema/eos" exclude-result-prefixes="xs xsi srv1">
  <xsl:import href="create19115-3Namespaces.xsl"/>
  <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Title:ECHO to ISO 19115-1</xd:b>
      </xd:p>
      <xd:p><xd:b>Version:</xd:b>0.3</xd:p>
      <xd:p><xd:b>Created on:</xd:b>January 23, 2014</xd:p>
      <xd:p><xd:b>Author:</xd:b>thabermann@hdfgroup.org</xd:p>
      <xd:p>This stylesheets transforms ECHO collections and granules to ISO 19115-1</xd:p>
      <xd:p/>
      <xd:p>
        <xd:b>Version 0.2 (January 21, 2014)</xd:b>
      </xd:p>
      <xd:p>Corrected namespaces to match 2013-06-24 version of 19115-1</xd:p>
      <xd:p>Revised DQ_DataQuality information to match 19157-2</xd:p>
      <xd:p>Transformed real record and created valid output.</xd:p>
      <xd:p>
        <xd:b>Version 0.3 (January 23, 2014)</xd:b>
      </xd:p>
      <xd:p>Transformed collection path record and created valid output.</xd:p>
      <xd:p>Transformed granule path record and created valid output.</xd:p>
      <xd:p>Transformed collection sample records and created valid output.</xd:p>
      <xd:p>Transformed granule sample records and created valid output.</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:variable name="translationName" select="'ECHOToISO19115-3.xsl'"/>
  <xsl:variable name="translationVersion" select="'May 5, 2015'"/>
  <xsl:output method="xml" indent="yes"/>
  <xsl:strip-space elements="*"/>
  <xsl:param name="recordType"/>
  <!-- external lookups for additionalAttribute types and onlineResource types -->
  <xsl:key name="additionalAttributeLookup" match="//additionalAttribute" use="@name"/>
  <xsl:key name="onlineResourceTypeLookup" match="//onlineResourceType" use="@name"/>
  <xsl:variable name="additionalAttributeCount" select="count(//AdditionalAttribute)"/>
  <xsl:variable name="contentInformationCount">
    <xsl:value-of select="count(//AdditionalAttribute[key('additionalAttributeLookup', Name, doc('additionalAttributeType.xml'))/@type = 'contentInformation']) + count(/Granule/DataGranule/DayNightFlag)"/>
  </xsl:variable>
  <xsl:variable name="platformInformationCount">
    <xsl:value-of select="count(//AdditionalAttribute[key('additionalAttributeLookup', Name, doc('additionalAttributeType.xml'))/@type = 'platformInformation'])"/>
  </xsl:variable>
  <xsl:variable name="instrumentInformationCount">
    <xsl:value-of select="count(//AdditionalAttribute[key('additionalAttributeLookup', Name, doc('additionalAttributeType.xml'))/@type = 'instrumentInformation'])"/>
  </xsl:variable>
  <xsl:variable name="sensorInformationCount">
    <xsl:value-of select="count(//AdditionalAttribute[key('additionalAttributeLookup', Name, doc('additionalAttributeType.xml'))/@type = 'sensorInformation'])"/>
  </xsl:variable>
  <xsl:variable name="processingInformationCount">
    <xsl:value-of select="count(//AdditionalAttribute[key('additionalAttributeLookup', Name, doc('additionalAttributeType.xml'))/@type = 'processingInformation'])"/>
  </xsl:variable>
  <xsl:variable name="qualityInformationCount">
    <xsl:value-of select="count(//AdditionalAttribute[key('additionalAttributeLookup', Name, doc('additionalAttributeType.xml'))/@type = 'qualityInformation'])"/>
  </xsl:variable>
  <xsl:variable name="geographicIdentifierCount">
    <xsl:value-of select="count(//AdditionalAttribute[key('additionalAttributeLookup', Name, doc('additionalAttributeType.xml'))/@type = 'geographicIdentifier'])"/>
  </xsl:variable>
  <xsl:variable name="citation.identifierCount">
    <xsl:value-of select="count(//AdditionalAttribute[key('additionalAttributeLookup', Name, doc('additionalAttributeType.xml'))/@type = 'citation.identifier'])"/>
  </xsl:variable>
  <xsl:variable name="descriptiveKeywordCount">
    <xsl:value-of select="count(//AdditionalAttribute[key('additionalAttributeLookup', Name, doc('additionalAttributeType.xml'))/@type = 'descriptiveKeyword'])"/>
  </xsl:variable>
  <xsl:variable name="platformCharacteristicCount" select="count(//Platforms/Platform/Characteristics/Characteristic)"/>
  <xsl:variable name="instrumentCharacteristicCount" select="count(//Instruments/Instrument/Characteristics/Characteristic)"/>
  <xsl:variable name="sensorCharacteristicCount" select="count(//Sensors/Sensor/Characteristics/Characteristic)"/>
  <xsl:variable name="classifiedAdditionalAttributeCount" select="
      $contentInformationCount + +$platformInformationCount + $instrumentInformationCount + $sensorInformationCount
      + $processingInformationCount + $qualityInformationCount + $geographicIdentifierCount + $citation.identifierCount + $descriptiveKeywordCount"/>
  <xsl:template match="/">
    <!-- metadataScope is determined from the root element -->
    <xsl:variable name="metadataScope">
      <xsl:choose>
        <xsl:when test="/Collection">
          <xsl:value-of select="'series'"/>
        </xsl:when>
        <xsl:when test="/Granule">
          <xsl:value-of select="'dataset'"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="'unknown'"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <mdb:MD_Metadata>
      <xsl:call-template name="add-iso19115-3-namespaces"/>
      <!-- NASA namespaces -->
      <xsl:namespace name="eos" select="'http://earthdata.nasa.gov/schema/eos'"/>
      <xsl:comment>
        <xsl:value-of select="concat('Other Properties', ' all:', $additionalAttributeCount, ',classified:', $classifiedAdditionalAttributeCount, ' ci:', $contentInformationCount, ',ii:', $instrumentInformationCount, ',pli:', $platformInformationCount, ',pri:', $processingInformationCount, ',qi:', $qualityInformationCount, ',gi:', $geographicIdentifierCount, ',ci:', $citation.identifierCount, ',dk:', $descriptiveKeywordCount)"/>
      </xsl:comment>
      <mdb:metadataIdentifier>
        <mcc:MD_Identifier>
          <mcc:code>
            <gco:CharacterString>gov.nasa.eos:<xsl:value-of select="/*/DataSetId | /*/GranuleUR"/></gco:CharacterString>
          </mcc:code>
          <mcc:codeSpace>
            <gco:CharacterString>gov.nasa.eos</gco:CharacterString>
          </mcc:codeSpace>
        </mcc:MD_Identifier>
      </mdb:metadataIdentifier>
      <mdb:defaultLocale>
        <lan:PT_Locale>
          <lan:language>
            <lan:LanguageCode codeList="codeListLocation#LanguageCode" codeListValue="eng">eng</lan:LanguageCode>
          </lan:language>
          <lan:characterEncoding>
            <lan:MD_CharacterSetCode codeList="codeListLocation#MD_CharacterSetCode" codeListValue="utf8">utf8</lan:MD_CharacterSetCode>
          </lan:characterEncoding>
        </lan:PT_Locale>
      </mdb:defaultLocale>
      <mdb:metadataScope>
        <mdb:MD_MetadataScope>
          <xsl:call-template name="writeCodelistElement">
            <xsl:with-param name="elementName" select="'mdb:resourceScope'"/>
            <xsl:with-param name="codeListName" select="'mcc:MD_ScopeCode'"/>
            <xsl:with-param name="codeListValue" select="$metadataScope"/>
          </xsl:call-template>
        </mdb:MD_MetadataScope>
      </mdb:metadataScope>
      <mdb:contact gco:nilReason="unknown"/>
      <xsl:for-each select="/*/Contacts/Contact[contains(Role, 'DIF AUTHOR')]">
        <xsl:call-template name="contact2Responsibility">
          <xsl:with-param name="roleName" select="'mdb:contact'"/>
          <xsl:with-param name="roleCode" select="'pointOfContact'"/>
        </xsl:call-template>
      </xsl:for-each>
      <mdb:dateInfo>
        <!-- The metadata creation date depends on the type of the metadata -->
        <xsl:choose>
          <xsl:when test="/Collection/RevisionDate">
            <cit:CI_Date>
              <cit:date>
                <gco:DateTime>
                  <xsl:value-of select="concat(/Collection/RevisionDate, 'T00:00:00')"/>
                </gco:DateTime>
              </cit:date>
              <xsl:call-template name="writeCodelistElement">
                <xsl:with-param name="elementName" select="'cit:dateType'"/>
                <xsl:with-param name="codeListName" select="'cit:CI_DateTypeCode'"/>
                <xsl:with-param name="codeListValue" select="'revision'"/>
              </xsl:call-template>
            </cit:CI_Date>
          </xsl:when>
          <xsl:when test="/Granule/DataGranule/ProductionDateTime">
            <cit:CI_Date>
              <cit:date>
                <gco:DateTime>
                  <xsl:value-of select="concat(/Granule/DataGranule/ProductionDateTime, 'T00:00:00')"/>
                </gco:DateTime>
              </cit:date>
              <xsl:call-template name="writeCodelistElement">
                <xsl:with-param name="elementName" select="'cit:dateType'"/>
                <xsl:with-param name="codeListName" select="'cit:CI_DateTypeCode'"/>
                <xsl:with-param name="codeListValue" select="'creation'"/>
              </xsl:call-template>
            </cit:CI_Date>
          </xsl:when>
          <xsl:otherwise>
            <cit:CI_Date>
              <cit:date>
                <gco:DateTime>
                  <xsl:value-of select="current-dateTime()"/>
                </gco:DateTime>
              </cit:date>
              <xsl:call-template name="writeCodelistElement">
                <xsl:with-param name="elementName" select="'cit:dateType'"/>
                <xsl:with-param name="codeListName" select="'cit:CI_DateTypeCode'"/>
                <xsl:with-param name="codeListValue" select="'creation'"/>
              </xsl:call-template>
            </cit:CI_Date>

          </xsl:otherwise>
        </xsl:choose>
      </mdb:dateInfo>
      <mdb:metadataStandard>
        <cit:CI_Citation>
          <xsl:call-template name="writeCharacterStringElement">
            <xsl:with-param name="elementName" select="'cit:title'"/>
            <xsl:with-param name="stringToWrite" select="'ISO 19115-2 Geographic Information - Metadata Part 2 Extensions for imagery and gridded data'"/>
          </xsl:call-template>
          <xsl:call-template name="writeCharacterStringElement">
            <xsl:with-param name="elementName" select="'cit:edition'"/>
            <xsl:with-param name="stringToWrite" select="'ISO 19115-2:2009(E)'"/>
          </xsl:call-template>
        </cit:CI_Citation>
      </mdb:metadataStandard>
      <xsl:for-each select="/Collection/SpatialInfo/VerticalCoordinateSystem">
        <!-- The SpatialInfo element only has real content in 16 records. They are all the same. -->
        <mdb:spatialRepresentationInfo>
          <msr:MD_Georeferenceable>
            <msr:numberOfDimensions>
              <gco:Integer>3</gco:Integer>
            </msr:numberOfDimensions>
            <msr:axisDimensionProperties>
              <msr:MD_Dimension>
                <xsl:call-template name="writeCodelistElement">
                  <xsl:with-param name="elementName" select="'msr:dimensionName'"/>
                  <xsl:with-param name="codeListName" select="'msr:MD_DimensionNameTypeCode'"/>
                  <xsl:with-param name="codeListValue" select="'column'"/>
                </xsl:call-template>
                <msr:dimensionSize gco:nilReason="unknown"/>
                <msr:resolution>
                  <xsl:element name="gco:Measure">
                    <xsl:attribute name="uom">
                      <xsl:value-of select="encode-for-uri(../HorizontalCoordinateSystem/GeographicCoordinateSystem/GeographicCoordinateUnits)"/>
                    </xsl:attribute>
                    <xsl:value-of select="../HorizontalCoordinateSystem/GeographicCoordinateSystem/LongitudeResolution"/>
                  </xsl:element>
                </msr:resolution>
              </msr:MD_Dimension>
            </msr:axisDimensionProperties>
            <msr:axisDimensionProperties>
              <msr:MD_Dimension>
                <xsl:call-template name="writeCodelistElement">
                  <xsl:with-param name="elementName" select="'msr:dimensionName'"/>
                  <xsl:with-param name="codeListName" select="'msr:MD_DimensionNameTypeCode'"/>
                  <xsl:with-param name="codeListValue" select="'row'"/>
                </xsl:call-template>
                <msr:dimensionSize gco:nilReason="unknown"/>
                <msr:resolution>
                  <xsl:element name="gco:Measure">
                    <xsl:attribute name="uom">
                      <xsl:value-of select="encode-for-uri(../HorizontalCoordinateSystem/GeographicCoordinateSystem/GeographicCoordinateUnits)"/>
                    </xsl:attribute>
                    <xsl:value-of select="../HorizontalCoordinateSystem/GeographicCoordinateSystem/LatitudeResolution"/>
                  </xsl:element>
                </msr:resolution>
              </msr:MD_Dimension>
            </msr:axisDimensionProperties>
            <msr:axisDimensionProperties>
              <msr:MD_Dimension>
                <xsl:call-template name="writeCodelistElement">
                  <xsl:with-param name="elementName" select="'msr:dimensionName'"/>
                  <xsl:with-param name="codeListName" select="'msr:MD_DimensionNameTypeCode'"/>
                  <xsl:with-param name="codeListValue" select="'vertical'"/>
                </xsl:call-template>
                <msr:dimensionSize gco:nilReason="unknown"/>
                <msr:resolution>
                  <xsl:element name="gco:Measure">
                    <xsl:attribute name="uom">
                      <xsl:value-of select="encode-for-uri(AltitudeSystemDefinition/DistanceUnits)"/>
                    </xsl:attribute>
                    <xsl:value-of select="AltitudeSystemDefinition/Resolutions/Resolution"/>
                  </xsl:element>
                </msr:resolution>
              </msr:MD_Dimension>
            </msr:axisDimensionProperties>
            <msr:cellGeometry/>
            <msr:transformationParameterAvailability/>
            <msr:controlPointAvailability/>
            <msr:orientationParameterAvailability/>
            <msr:georeferencedParameters/>
          </msr:MD_Georeferenceable>
        </mdb:spatialRepresentationInfo>
      </xsl:for-each>
      <mdb:identificationInfo>
        <mri:MD_DataIdentification>
          <mri:citation>
            <cit:CI_Citation>
              <cit:title>
                <xsl:choose>
                  <xsl:when test="/*/ShortName | /*/LongName">
                    <!-- Collection Record -->
                    <xsl:call-template name="writeCharacterString">
                      <xsl:with-param name="stringToWrite">
                        <xsl:value-of select="/*/ShortName"/>
                        <xsl:if test="/*/LongName">
                          <xsl:value-of select="concat(' &gt; ', /*/LongName)"/>
                        </xsl:if>
                      </xsl:with-param>
                    </xsl:call-template>
                  </xsl:when>
                  <xsl:when test="/*/GranuleUR">
                    <!-- Granule Record -->
                    <xsl:call-template name="writeCharacterString">
                      <xsl:with-param name="stringToWrite">
                        <xsl:value-of select="/*/GranuleUR"/>
                      </xsl:with-param>
                    </xsl:call-template>
                  </xsl:when>
                  <xsl:otherwise>
                    <!-- No title -->
                    <xsl:attribute name="gco:nilReason" select="'missing'"/>
                  </xsl:otherwise>
                </xsl:choose>
              </cit:title>
              <cit:date>
                <cit:CI_Date>
                  <cit:date>
                    <gco:DateTime>
                      <xsl:value-of select="concat(/*/LastUpdate, 'T00:00:00')"/>
                    </gco:DateTime>
                  </cit:date>
                  <xsl:call-template name="writeCodelistElement">
                    <xsl:with-param name="elementName" select="'cit:dateType'"/>
                    <xsl:with-param name="codeListName" select="'cit:CI_DateTypeCode'"/>
                    <xsl:with-param name="codeListValue" select="'revision'"/>
                  </xsl:call-template>
                </cit:CI_Date>
              </cit:date>
              <cit:date>
                <cit:CI_Date>
                  <cit:date>
                    <gco:DateTime>
                      <xsl:value-of select="concat(/*/InsertTime, 'T00:00:00')"/>
                    </gco:DateTime>
                  </cit:date>
                  <xsl:call-template name="writeCodelistElement">
                    <xsl:with-param name="elementName" select="'cit:dateType'"/>
                    <xsl:with-param name="codeListName" select="'cit:CI_DateTypeCode'"/>
                    <xsl:with-param name="codeListValue" select="'creation'"/>
                  </xsl:call-template>
                </cit:CI_Date>
              </cit:date>
              <xsl:for-each select="/*/AdditionalAttributes/AdditionalAttribute">
                <xsl:if test="key('additionalAttributeLookup', Name, doc('additionalAttributeType.xml'))/@type = 'citation.date'">
                  <xsl:choose>
                    <xsl:when test="Values/Value | Value">
                      <xsl:for-each select="Values/Value | Value">
                        <cit:date>
                          <cit:CI_Date>
                            <cit:date>
                              <gco:DateTime>
                                <xsl:value-of select="concat(., 'T00:00:00')"/>
                              </gco:DateTime>
                            </cit:date>
                            <xsl:call-template name="writeCodelistElement">
                              <xsl:with-param name="elementName" select="'cit:dateType'"/>
                              <xsl:with-param name="codeListName" select="'cit:CI_DateTypeCode'"/>
                              <xsl:with-param name="codeListValue" select="ancestor::AdditionalAttribute/Name"/>
                            </xsl:call-template>
                          </cit:CI_Date>
                        </cit:date>
                      </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise>
                      <!-- date attribute with no value -->
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:if>
              </xsl:for-each>
              <cit:edition>
                <xsl:choose>
                  <xsl:when test="/*/DataGranule/LocalVersionId">
                    <xsl:call-template name="writeCharacterString">
                      <xsl:with-param name="stringToWrite" select="/*/DataGranule/LocalVersionId"/>
                    </xsl:call-template>
                  </xsl:when>
                  <xsl:when test="/*/VersionId">
                    <xsl:call-template name="writeCharacterString">
                      <xsl:with-param name="stringToWrite" select="/*/VersionId"/>
                    </xsl:call-template>
                  </xsl:when>
                </xsl:choose>
              </cit:edition>
              <cit:identifier>
                <mcc:MD_Identifier>
                  <!-- The first identifier is GranuleUR or ShortName > LongName -->
                  <xsl:choose>
                    <xsl:when test="/*/GranuleUR">
                      <!-- Granule Record -->
                      <mcc:code>
                        <xsl:call-template name="writeCharacterString">
                          <xsl:with-param name="stringToWrite" select="/*/GranuleUR"/>
                        </xsl:call-template>
                      </mcc:code>
                      <mcc:description>
                        <xsl:call-template name="writeCharacterString">
                          <xsl:with-param name="stringToWrite" select="'GranuleUR'"/>
                        </xsl:call-template>
                      </mcc:description>
                    </xsl:when>
                    <xsl:when test="/*/Collection/ShortName">
                      <!-- Granule Record with no GranuleUR-->
                      <mcc:code>
                        <xsl:call-template name="writeCharacterString">
                          <xsl:with-param name="stringToWrite" select="/*/Collection/ShortName"/>
                        </xsl:call-template>
                      </mcc:code>
                      <mcc:description>
                        <xsl:call-template name="writeCharacterString">
                          <xsl:with-param name="stringToWrite" select="'Collection/ShortName'"/>
                        </xsl:call-template>
                      </mcc:description>
                    </xsl:when>
                    <xsl:when test="/*/ShortName | /*/LongName">
                      <!-- Collection Record -->
                      <mcc:code>
                        <xsl:call-template name="writeCharacterString">
                          <xsl:with-param name="stringToWrite" select="/*/ShortName"/>
                        </xsl:call-template>
                      </mcc:code>
                      <mcc:description>
                        <xsl:call-template name="writeCharacterString">
                          <xsl:with-param name="stringToWrite" select="/*/LongName"/>
                        </xsl:call-template>
                      </mcc:description>
                    </xsl:when>
                  </xsl:choose>
                </mcc:MD_Identifier>
              </cit:identifier>
              <xsl:if test="/Granule/DataGranule/ProducerGranuleId">
                <!-- write ProducerGranuleId -->
                <cit:identifier>
                  <mcc:MD_Identifier>
                    <mcc:code>
                      <xsl:call-template name="writeCharacterString">
                        <xsl:with-param name="stringToWrite" select="/Granule/DataGranule/ProducerGranuleId"/>
                      </xsl:call-template>
                    </mcc:code>
                    <mcc:description>
                      <gco:CharacterString>ProducerGranuleId</gco:CharacterString>
                    </mcc:description>
                  </mcc:MD_Identifier>
                </cit:identifier>
              </xsl:if>
              <xsl:if test="/Granule/DataGranule/LocalVersionId">
                <cit:identifier>
                  <mcc:MD_Identifier>
                    <mcc:code>
                      <xsl:call-template name="writeCharacterString">
                        <xsl:with-param name="stringToWrite" select="/Granule/DataGranule/LocalVersionId"/>
                      </xsl:call-template>
                    </mcc:code>
                    <mcc:description>
                      <gco:CharacterString>LocalVersionId</gco:CharacterString>
                    </mcc:description>
                  </mcc:MD_Identifier>
                </cit:identifier>
              </xsl:if>
              <xsl:for-each select="/*/AssociatedDIFs/DIF/EntryId">
                <cit:identifier>
                  <mcc:MD_Identifier>
                    <!-- Third identifier is DIF EntryId from gcmd namespace-->
                    <mcc:code>
                      <xsl:call-template name="writeCharacterString">
                        <xsl:with-param name="stringToWrite" select="."/>
                      </xsl:call-template>
                    </mcc:code>
                    <mcc:codeSpace>
                      <xsl:call-template name="writeCharacterString">
                        <xsl:with-param name="stringToWrite" select="'gov.nasa.gcmd'"/>
                      </xsl:call-template>
                    </mcc:codeSpace>
                    <mcc:description>
                      <gco:CharacterString>DIFEntryId</gco:CharacterString>
                    </mcc:description>
                  </mcc:MD_Identifier>
                </cit:identifier>
              </xsl:for-each>
              <xsl:if test="$citation.identifierCount">
                <xsl:for-each select="/*/AdditionalAttributes/AdditionalAttribute">
                  <xsl:if test="key('additionalAttributeLookup', Name, doc('additionalAttributeType.xml'))/@type = 'citation.identifier'">
                    <xsl:choose>
                      <xsl:when test="Values/Value | Value">
                        <xsl:for-each select="Values/Value | Value">
                          <cit:identifier>
                            <mcc:MD_Identifier>
                              <mcc:code>
                                <xsl:call-template name="writeCharacterString">
                                  <xsl:with-param name="stringToWrite" select="."/>
                                </xsl:call-template>
                              </mcc:code>
                              <mcc:codeSpace>
                                <xsl:call-template name="writeCharacterString">
                                  <xsl:with-param name="stringToWrite" select="'gov.nasa.echo'"/>
                                </xsl:call-template>
                              </mcc:codeSpace>
                              <mcc:description>
                                <gco:CharacterString>
                                  <xsl:value-of select="../../Name | ../Name"/>
                                  <xsl:if test="../../Description | ../Description">
                                    <xsl:value-of select="concat(' - ', ../../Description | ../Description)"/>
                                  </xsl:if>
                                </gco:CharacterString>
                              </mcc:description>
                            </mcc:MD_Identifier>
                          </cit:identifier>
                        </xsl:for-each>
                      </xsl:when>
                      <xsl:otherwise>
                        <cit:identifier>
                          <mcc:MD_Identifier>
                            <mcc:code>
                              <gco:CharacterString>
                                <xsl:value-of select="concat(ParameterRangeBegin, ' - ', ParameterRangeEnd)"/>
                              </gco:CharacterString>
                            </mcc:code>
                            <mcc:codeSpace>
                              <xsl:call-template name="writeCharacterString">
                                <xsl:with-param name="stringToWrite" select="'gov.nasa.echo'"/>
                              </xsl:call-template>
                            </mcc:codeSpace>
                            <mcc:description>
                              <gco:CharacterString>
                                <xsl:value-of select="../../Name | ../Name"/>
                                <xsl:if test="../../Description | ../Description">
                                  <xsl:value-of select="concat(' - ', ../../Description | ../Description)"/>
                                </xsl:if>
                              </gco:CharacterString>
                            </mcc:description>
                          </mcc:MD_Identifier>
                        </cit:identifier>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:if>
                </xsl:for-each>
              </xsl:if>
              <xsl:for-each select="/*/Contacts/Contact[contains(Role, 'Data Originator') or contains(Role, 'Producer')]">
                <xsl:call-template name="contact2Responsibility">
                  <xsl:with-param name="roleName" select="'cit:citedResponsibleParty'"/>
                  <xsl:with-param name="roleCode" select="'originator'"/>
                </xsl:call-template>
              </xsl:for-each>
              <xsl:for-each select="/*/Contacts/Contact[contains(Role, 'Investigator') or contains(Role, 'INVESTIGATOR')]">
                <xsl:call-template name="contact2Responsibility">
                  <xsl:with-param name="roleName" select="'cit:citedResponsibleParty'"/>
                  <xsl:with-param name="roleCode" select="'principalInvestigator'"/>
                </xsl:call-template>
              </xsl:for-each>
              <xsl:for-each select="/*/AdditionalAttributes/AdditionalAttribute">
                <xsl:if test="key('additionalAttributeLookup', Name, doc('additionalAttributeType.xml'))/@type = 'citation.website'">
                  <xsl:choose>
                    <xsl:when test="Values/Value | Value">
                      <xsl:element name="cit:onlineResource">
                        <cit:CI_OnlineResource>
                          <cit:linkage>
                            <gco:CharacterString>
                              <xsl:value-of select="Values/Value | Value"/>
                            </gco:CharacterString>
                          </cit:linkage>
                          <xsl:call-template name="writeCodelistElement">
                            <xsl:with-param name="elementName" select="'cit:function'"/>
                            <xsl:with-param name="codeListName" select="'cit:CI_OnLineFunctionCode'"/>
                            <xsl:with-param name="codeListValue" select="'information'"/>
                          </xsl:call-template>
                        </cit:CI_OnlineResource>
                      </xsl:element>
                    </xsl:when>
                    <xsl:otherwise>
                      <!-- scienceTeamWebsite attribute with no value -->
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:if>
              </xsl:for-each>
              <xsl:if test="/*/CitationForExternalPublication">
                <cit:otherCitationDetails>
                  <xsl:call-template name="writeCharacterString">
                    <xsl:with-param name="stringToWrite">
                      <xsl:value-of select="/*/CitationForExternalPublication"/>
                    </xsl:with-param>
                  </xsl:call-template>
                </cit:otherCitationDetails>
              </xsl:if>
            </cit:CI_Citation>
          </mri:citation>
          <mri:abstract>
            <!-- abstract is a required element, will be gco:nilReason in granules -->
            <xsl:choose>
              <xsl:when test="/*/Description">
                <gco:CharacterString>
                  <xsl:value-of select="/*/Description"/>
                  <xsl:if test="/*/VersionDescription">
                    <xsl:value-of select="concat(' Version Description: ', /*/VersionDescription)"/>
                  </xsl:if>
                </gco:CharacterString>
              </xsl:when>
              <xsl:otherwise>
                <xsl:attribute name="gco:nilReason" select="'inapplicable'"/>
              </xsl:otherwise>
            </xsl:choose>
          </mri:abstract>
          <mri:purpose>
            <xsl:call-template name="writeCharacterString">
              <xsl:with-param name="stringToWrite" select="/Collection/SuggestedUsage"/>
            </xsl:call-template>
          </mri:purpose>
          <!-- ArchiveCenter is used as pointOfContact and distributor -->
          <xsl:for-each select="/*/ArchiveCenter">
            <mri:pointOfContact>
              <cit:CI_Responsibility>
                <xsl:comment select="'ArchiveCenter'"/>
                <xsl:call-template name="writeCodelistElement">
                  <xsl:with-param name="elementName" select="'cit:role'"/>
                  <xsl:with-param name="codeListName" select="'cit:CI_RoleCode'"/>
                  <xsl:with-param name="codeListValue" select="'pointOfContact'"/>
                </xsl:call-template>
                <xsl:element name="cit:party">
                  <cit:CI_Organisation>
                    <cit:name>
                      <xsl:call-template name="writeCharacterString">
                        <xsl:with-param name="stringToWrite" select="."/>
                      </xsl:call-template>
                    </cit:name>
                  </cit:CI_Organisation>
                </xsl:element>
              </cit:CI_Responsibility>
            </mri:pointOfContact>
          </xsl:for-each>
          <xsl:for-each select="/*/Contacts/Contact[contains(Role, 'TECHNICAL CONTACT')]">
            <xsl:call-template name="contact2Responsibility">
              <xsl:with-param name="roleName" select="'mri:pointOfContact'"/>
              <xsl:with-param name="roleCode" select="'pointOfContact'"/>
            </xsl:call-template>
          </xsl:for-each>
          <xsl:call-template name="ECHOExtentToISO"/>
          <mri:processingLevel>
            <mcc:MD_Identifier>
              <mcc:code>
                <xsl:call-template name="writeCharacterString">
                  <xsl:with-param name="stringToWrite" select="/*/ProcessingLevelId"/>
                </xsl:call-template>
              </mcc:code>
              <mcc:description>
                <xsl:call-template name="writeCharacterString">
                  <xsl:with-param name="stringToWrite" select="/*/ProcessingLevelDescription"/>
                </xsl:call-template>
              </mcc:description>
            </mcc:MD_Identifier>
          </mri:processingLevel>
          <xsl:if test="/*/MaintenanceAndUpdateFrequency or /*/DataGranule/ReprocessingPlanned">
            <mri:resourceMaintenance>
              <mmi:MD_MaintenanceInformation>
                <xsl:choose>
                  <xsl:when test="/*/MaintenanceAndUpdateFrequency">
                    <xsl:call-template name="writeCodelistElement">
                      <xsl:with-param name="elementName" select="'mmi:maintenanceAndUpdateFrequency'"/>
                      <xsl:with-param name="codeListName" select="'mmi:MD_MaintenanceFrequencyCode'"/>
                      <xsl:with-param name="codeListValue" select="/Collection/MaintenanceAndUpdateFrequency"/>
                    </xsl:call-template>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:element name="mmi:maintenanceAndUpdateFrequency">
                      <xsl:attribute name="gco:nilReason" select="'missing'"/>
                    </xsl:element>
                  </xsl:otherwise>
                </xsl:choose>
                <xsl:if test="/*/DataGranule/ReprocessingPlanned">
                  <mmi:maintenanceNote>
                    <gco:CharacterString>
                      <xsl:value-of select="/*/DataGranule/ReprocessingPlanned"/>
                    </gco:CharacterString>
                  </mmi:maintenanceNote>
                </xsl:if>
              </mmi:MD_MaintenanceInformation>
            </mri:resourceMaintenance>
          </xsl:if>
          <!-- 
            end of series-only elements 
          -->
          <xsl:for-each select="/*/AssociatedBrowseImageUrls/ProviderBrowseUrl">
            <mri:graphicOverview>
              <mcc:MD_BrowseGraphic>
                <mcc:fileName>
                  <xsl:element name="gcx:FileName">
                    <xsl:attribute name="src" select="URL"/>
                  </xsl:element>
                </mcc:fileName>
                <mcc:fileDescription>
                  <gco:CharacterString>
                    <xsl:value-of select="concat(Description, ' File Size: ', FileSize)"/>
                  </gco:CharacterString>
                </mcc:fileDescription>
                <mcc:fileType>
                  <xsl:call-template name="writeCharacterString">
                    <xsl:with-param name="stringToWrite" select="MimeType"/>
                  </xsl:call-template>
                </mcc:fileType>
              </mcc:MD_BrowseGraphic>
            </mri:graphicOverview>
          </xsl:for-each>
          <xsl:for-each select="//OnlineResources/OnlineResource[Type = 'Browse' or Type = 'BROWSE' or Type = 'Thumbnail']">
            <mri:graphicOverview>
              <mcc:MD_BrowseGraphic>
                <mcc:fileName>
                  <xsl:element name="gcx:FileName">
                    <xsl:attribute name="src" select="URL"/>
                  </xsl:element>
                </mcc:fileName>
                <mcc:fileDescription>
                  <xsl:call-template name="writeCharacterString">
                    <xsl:with-param name="stringToWrite" select="Description"/>
                  </xsl:call-template>
                </mcc:fileDescription>
                <mcc:fileType>
                  <xsl:call-template name="writeCharacterString">
                    <xsl:with-param name="stringToWrite" select="MimeType"/>
                  </xsl:call-template>
                </mcc:fileType>
              </mcc:MD_BrowseGraphic>
            </mri:graphicOverview>
          </xsl:for-each>
          <xsl:for-each select="/*/DataFormat | /*/CSDTDescriptions/CSDTDescription/Implementation">
            <mri:resourceFormat>
              <mrd:MD_Format>
                <mrd:formatSpecificationCitation>
                  <cit:CI_Citation>
                    <cit:title>
                      <xsl:call-template name="writeCharacterString">
                        <xsl:with-param name="stringToWrite" select="."/>
                      </xsl:call-template>
                    </cit:title>
                    <xsl:choose>
                      <xsl:when test="contains(., '4')">
                        <cit:edition>
                          <gco:CharacterString>4</gco:CharacterString>
                        </cit:edition>
                      </xsl:when>
                      <xsl:when test="contains(., '5')">
                        <cit:edition>
                          <gco:CharacterString>5</gco:CharacterString>
                        </cit:edition>
                      </xsl:when>
                      <xsl:otherwise>
                        <cit:edition gco:nilReason="unknown"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </cit:CI_Citation>
                </mrd:formatSpecificationCitation>
              </mrd:MD_Format>
            </mri:resourceFormat>
          </xsl:for-each>
          <xsl:for-each select="/*/AdditionalAttributes/AdditionalAttribute[Name = 'FileFormat']/Value">
            <!-- Additional Attribute fileFormat is in 2 collections  -->
            <mri:resourceFormat>
              <mrd:MD_Format>
                <mrd:formatSpecificationCitation>
                  <cit:CI_Citation>
                    <cit:title>
                      <xsl:call-template name="writeCharacterString">
                        <xsl:with-param name="stringToWrite" select="."/>
                      </xsl:call-template>
                    </cit:title>
                    <xsl:choose>
                      <xsl:when test="contains(., '4')">
                        <cit:edition>
                          <gco:CharacterString>4</gco:CharacterString>
                        </cit:edition>
                      </xsl:when>
                      <xsl:when test="contains(., '5')">
                        <cit:edition>
                          <gco:CharacterString>5</gco:CharacterString>
                        </cit:edition>
                      </xsl:when>
                      <xsl:otherwise>
                        <cit:edition gco:nilReason="unknown"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </cit:CI_Citation>
                </mrd:formatSpecificationCitation>
              </mrd:MD_Format>
            </mri:resourceFormat>
          </xsl:for-each>
          <!-- Additional Attribute Flags -->
          <xsl:if test="$descriptiveKeywordCount > 0">
            <mri:descriptiveKeywords>
              <mri:MD_Keywords>
                <xsl:for-each select="/*/AdditionalAttributes/AdditionalAttribute">
                  <xsl:if test="key('additionalAttributeLookup', Name, doc('additionalAttributeType.xml'))/@type = 'descriptiveKeyword'">
                    <xsl:choose>
                      <xsl:when test="Values/Value | Value">
                        <xsl:for-each select="Values/Value | Value">
                          <mri:keyword>
                            <gco:CharacterString>
                              <xsl:value-of select="concat(../../Name | ../Name, ': ', .)"/>
                            </gco:CharacterString>
                          </mri:keyword>
                        </xsl:for-each>
                      </xsl:when>
                      <xsl:otherwise>
                        <mri:keyword>
                          <gco:CharacterString>
                            <xsl:value-of select="../../Name | ../Name"/>
                          </gco:CharacterString>
                        </mri:keyword>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:if>
                </xsl:for-each>
                <mri:thesaurusName>
                  <cit:CI_Citation>
                    <cit:title>
                      <gco:CharacterString>NASA ECHO Additional Attributes as descriptiveKeywords</gco:CharacterString>
                    </cit:title>
                    <cit:date gco:nilReason="unknown"/>
                  </cit:CI_Citation>
                </mri:thesaurusName>
              </mri:MD_Keywords>
            </mri:descriptiveKeywords>
          </xsl:if>
          <!-- The various kinds of keywords only occur in collection records -->
          <!-- Science Keywords -->
          <xsl:if test="/*/ScienceKeywords/ScienceKeyword">
            <mri:descriptiveKeywords>
              <mri:MD_Keywords>
                <xsl:for-each select="/*/ScienceKeywords/ScienceKeyword">
                  <mri:keyword>
                    <gco:CharacterString>
                      <xsl:value-of select="CategoryKeyword"/>
                      <xsl:text>&gt;</xsl:text>
                      <xsl:value-of select="TopicKeyword"/>
                      <xsl:text>&gt;</xsl:text>
                      <xsl:value-of select="TermKeyword"/>
                      <xsl:text>&gt;</xsl:text>
                      <xsl:value-of select="VariableLevel1Keyword/Value"/>
                      <xsl:if test="VariableLevel1Keyword/VariableLevel2Keyword/Value">
                        <xsl:text>&gt;</xsl:text>
                        <xsl:value-of select="VariableLevel1Keyword/VariableLevel2Keyword/Value"/>
                      </xsl:if>
                      <xsl:if test="VariableLevel1Keyword/VariableLevel2Keyword/VariableLevel3Keyword">
                        <xsl:text>&gt;</xsl:text>
                        <xsl:value-of select="VariableLevel1Keyword/VariableLevel2Keyword/VariableLevel3Keyword"/>
                      </xsl:if>
                      <xsl:if test="DetailedVariableKeyword">
                        <xsl:text>&gt;</xsl:text>
                        <xsl:value-of select="DetailedVariableKeyword"/>
                      </xsl:if>
                    </gco:CharacterString>
                  </mri:keyword>
                </xsl:for-each>
                <xsl:call-template name="writeCodelistElement">
                  <xsl:with-param name="elementName" select="'mri:type'"/>
                  <xsl:with-param name="codeListName" select="'mri:MD_KeywordTypeCode'"/>
                  <xsl:with-param name="codeListValue" select="'theme'"/>
                </xsl:call-template>
                <mri:thesaurusName>
                  <cit:CI_Citation>
                    <cit:title>
                      <gco:CharacterString>NASA Global Change Master Directory Keywords</gco:CharacterString>
                    </cit:title>
                    <cit:date gco:nilReason="unknown"/>
                  </cit:CI_Citation>
                </mri:thesaurusName>
              </mri:MD_Keywords>
            </mri:descriptiveKeywords>
          </xsl:if>
          <!-- Place Keywords -->
          <xsl:if test="/*/SpatialKeywords/Keyword">
            <mri:descriptiveKeywords>
              <mri:MD_Keywords>
                <xsl:for-each select="/*/SpatialKeywords/Keyword">
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
                <mri:thesaurusName>
                  <cit:CI_Citation>
                    <cit:title>
                      <gco:CharacterString>NASA Global Change Master Directory Keywords</gco:CharacterString>
                    </cit:title>
                    <cit:date gco:nilReason="unknown"/>
                  </cit:CI_Citation>
                </mri:thesaurusName>
              </mri:MD_Keywords>
            </mri:descriptiveKeywords>
          </xsl:if>
          <!-- Time Keywords -->
          <xsl:if test="/*/TemporalKeywords/Keyword">
            <mri:descriptiveKeywords>
              <mri:MD_Keywords>
                <xsl:for-each select="/*/TemporalKeywords/Keyword">
                  <mri:keyword>
                    <gco:CharacterString>
                      <xsl:value-of select="."/>
                    </gco:CharacterString>
                  </mri:keyword>
                </xsl:for-each>
                <xsl:call-template name="writeCodelistElement">
                  <xsl:with-param name="elementName" select="'mri:type'"/>
                  <xsl:with-param name="codeListName" select="'mri:MD_KeywordTypeCode'"/>
                  <xsl:with-param name="codeListValue" select="'temporal'"/>
                </xsl:call-template>
                <mri:thesaurusName>
                  <cit:CI_Citation>
                    <cit:title>
                      <gco:CharacterString>NASA Global Change Master Directory Keywords</gco:CharacterString>
                    </cit:title>
                    <cit:date gco:nilReason="unknown"/>
                  </cit:CI_Citation>
                </mri:thesaurusName>
              </mri:MD_Keywords>
            </mri:descriptiveKeywords>
          </xsl:if>
          <!-- Data Center Keywords -->
          <xsl:if test="//ArchiveCenter">
            <mri:descriptiveKeywords>
              <mri:MD_Keywords>
                <xsl:for-each select="//ArchiveCenter">
                  <mri:keyword>
                    <gco:CharacterString>
                      <xsl:value-of select="."/>
                    </gco:CharacterString>
                  </mri:keyword>
                </xsl:for-each>
                <xsl:call-template name="writeCodelistElement">
                  <xsl:with-param name="elementName" select="'mri:type'"/>
                  <xsl:with-param name="codeListName" select="'mri:MD_KeywordTypeCode'"/>
                  <xsl:with-param name="codeListValue" select="'dataCenter'"/>
                </xsl:call-template>
                <mri:thesaurusName>
                  <cit:CI_Citation>
                    <cit:title>
                      <gco:CharacterString> NASA/Global Change Master Directory (GCMD) Data Center Keywords </gco:CharacterString>
                    </cit:title>
                    <cit:date>
                      <cit:CI_Date>
                        <cit:date>
                          <gco:DateTime>2008-02-07T00:00:00</gco:DateTime>
                        </cit:date>
                        <cit:dateType>
                          <cit:CI_DateTypeCode codeList="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#CI_DateTypeCode" codeListValue="publication">publication</cit:CI_DateTypeCode>
                        </cit:dateType>
                      </cit:CI_Date>
                    </cit:date>
                    <cit:identifier gco:nilReason="unknown"/>
                    <cit:citedResponsibleParty>
                      <cit:CI_Responsibility>
                        <xsl:call-template name="writeCodelistElement">
                          <xsl:with-param name="elementName" select="'cit:role'"/>
                          <xsl:with-param name="codeListName" select="'cit:CI_RoleCode'"/>
                          <xsl:with-param name="codeListValue" select="'pointOfContact'"/>
                        </xsl:call-template>
                        <xsl:element name="cit:party">
                          <cit:CI_Organisation>
                            <cit:name>
                              <xsl:call-template name="writeCharacterString">
                                <xsl:with-param name="stringToWrite" select="'GCMD User Support Office'"/>
                              </xsl:call-template>
                            </cit:name>
                            <cit:contactInfo>
                              <cit:CI_Contact>
                                <cit:address>
                                  <cit:CI_Address>
                                    <cit:electronicMailAddress>
                                      <gco:CharacterString>gcmduso@gcmd.gsfc.nasa.gov</gco:CharacterString>
                                    </cit:electronicMailAddress>
                                  </cit:CI_Address>
                                </cit:address>
                              </cit:CI_Contact>
                            </cit:contactInfo>
                          </cit:CI_Organisation>
                        </xsl:element>
                      </cit:CI_Responsibility>
                    </cit:citedResponsibleParty>
                    <cit:onlineResource>
                      <cit:CI_OnlineResource>
                        <cit:linkage>
                          <gco:CharacterString>http://gcmd.nasa.gov/Resources/valids/</gco:CharacterString>
                        </cit:linkage>
                        <cit:name>
                          <gco:CharacterString>GCMD Keywords Page</gco:CharacterString>
                        </cit:name>
                        <cit:description>
                          <gco:CharacterString>This page describes the NASA GCMD Keywords, how to reference those keywords and provides download instructions. </gco:CharacterString>
                        </cit:description>
                        <cit:function>
                          <cit:CI_OnLineFunctionCode codeList="http://www.ngdc.noaa.gov/metadata/published/xsd/schema/resources/Codelist/gmxCodelists.xml#CI_OnLineFunctionCode" codeListValue="information">information</cit:CI_OnLineFunctionCode>
                        </cit:function>
                      </cit:CI_OnlineResource>
                    </cit:onlineResource>
                  </cit:CI_Citation>
                </mri:thesaurusName>
              </mri:MD_Keywords>
            </mri:descriptiveKeywords>
          </xsl:if>
          <!-- Project Keywords -->
          <xsl:if test="/*/Campaigns/Campaign/ShortName | /*/Campaigns/Campaign/LongName">
            <mri:descriptiveKeywords>
              <mri:MD_Keywords>
                <xsl:for-each select="/*/Campaigns/Campaign">
                  <mri:keyword>
                    <gco:CharacterString>
                      <xsl:value-of select="ShortName"/>
                      <xsl:if test="LongName">
                        <xsl:value-of select="concat(' &gt; ', LongName)"/>
                      </xsl:if>
                    </gco:CharacterString>
                  </mri:keyword>
                </xsl:for-each>
                <xsl:call-template name="writeCodelistElement">
                  <xsl:with-param name="elementName" select="'mri:type'"/>
                  <xsl:with-param name="codeListName" select="'mri:MD_KeywordTypeCode'"/>
                  <xsl:with-param name="codeListValue" select="'project'"/>
                </xsl:call-template>
                <mri:thesaurusName>
                  <cit:CI_Citation>
                    <cit:title>
                      <gco:CharacterString> NASA/Global Change Master Directory (GCMD) Data Center Keywords </gco:CharacterString>
                    </cit:title>
                    <cit:date>
                      <cit:CI_Date>
                        <cit:date>
                          <gco:DateTime>2008-02-07T00:00:00</gco:DateTime>
                        </cit:date>
                        <cit:dateType>
                          <cit:CI_DateTypeCode codeList="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#CI_DateTypeCode" codeListValue="publication">publication</cit:CI_DateTypeCode>
                        </cit:dateType>
                      </cit:CI_Date>
                    </cit:date>
                    <cit:identifier gco:nilReason="unknown"/>
                    <cit:citedResponsibleParty>
                      <cit:CI_Responsibility>
                        <xsl:call-template name="writeCodelistElement">
                          <xsl:with-param name="elementName" select="'cit:role'"/>
                          <xsl:with-param name="codeListName" select="'cit:CI_RoleCode'"/>
                          <xsl:with-param name="codeListValue" select="'pointOfContact'"/>
                        </xsl:call-template>
                        <xsl:element name="cit:party">
                          <cit:CI_Organisation>
                            <cit:name>
                              <xsl:call-template name="writeCharacterString">
                                <xsl:with-param name="stringToWrite" select="'GCMD User Support Office'"/>
                              </xsl:call-template>
                            </cit:name>
                            <cit:contactInfo>
                              <cit:CI_Contact>
                                <cit:address>
                                  <cit:CI_Address>
                                    <cit:electronicMailAddress>
                                      <gco:CharacterString>gcmduso@gcmd.gsfc.nasa.gov</gco:CharacterString>
                                    </cit:electronicMailAddress>
                                  </cit:CI_Address>
                                </cit:address>
                              </cit:CI_Contact>
                            </cit:contactInfo>
                          </cit:CI_Organisation>
                        </xsl:element>
                      </cit:CI_Responsibility>
                    </cit:citedResponsibleParty>
                    <cit:onlineResource>
                      <cit:CI_OnlineResource>
                        <cit:linkage>
                          <gco:CharacterString>http://gcmd.nasa.gov/Resources/valids/</gco:CharacterString>
                        </cit:linkage>
                        <cit:name>
                          <gco:CharacterString>GCMD Keywords Page</gco:CharacterString>
                        </cit:name>
                        <cit:description>
                          <gco:CharacterString>This page describes the NASA GCMD Keywords, how to reference those keywords and provides download instructions. </gco:CharacterString>
                        </cit:description>
                        <cit:function>
                          <cit:CI_OnLineFunctionCode codeList="http://www.ngdc.noaa.gov/metadata/published/xsd/schema/resources/Codelist/gmxCodelists.xml#CI_OnLineFunctionCode" codeListValue="information">information</cit:CI_OnLineFunctionCode>
                        </cit:function>
                      </cit:CI_OnlineResource>
                    </cit:onlineResource>
                  </cit:CI_Citation>
                </mri:thesaurusName>

              </mri:MD_Keywords>
            </mri:descriptiveKeywords>
          </xsl:if>
          <!-- Platform Keywords -->
          <xsl:if test="/*/Platforms/Platform/ShortName | /*/Platforms/Platform/ShortName">
            <mri:descriptiveKeywords>
              <mri:MD_Keywords>
                <xsl:for-each select="/*/Platforms/Platform">
                  <mri:keyword>
                    <gco:CharacterString>
                      <xsl:value-of select="ShortName"/>
                      <xsl:if test="LongName">
                        <xsl:value-of select="concat(' &gt; ', LongName)"/>
                      </xsl:if>
                    </gco:CharacterString>
                  </mri:keyword>
                </xsl:for-each>
                <xsl:call-template name="writeCodelistElement">
                  <xsl:with-param name="elementName" select="'mri:type'"/>
                  <xsl:with-param name="codeListName" select="'mri:MD_KeywordTypeCode'"/>
                  <xsl:with-param name="codeListValue" select="'platform'"/>
                </xsl:call-template>
                <mri:thesaurusName>
                  <cit:CI_Citation>
                    <cit:title>
                      <gco:CharacterString> NASA/Global Change Master Directory (GCMD) Data Center Keywords </gco:CharacterString>
                    </cit:title>
                    <cit:date>
                      <cit:CI_Date>
                        <cit:date>
                          <gco:DateTime>2008-02-07T00:00:00</gco:DateTime>
                        </cit:date>
                        <cit:dateType>
                          <cit:CI_DateTypeCode codeList="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#CI_DateTypeCode" codeListValue="publication">publication</cit:CI_DateTypeCode>
                        </cit:dateType>
                      </cit:CI_Date>
                    </cit:date>
                    <cit:identifier gco:nilReason="unknown"/>
                    <cit:citedResponsibleParty>
                      <cit:CI_Responsibility>
                        <xsl:call-template name="writeCodelistElement">
                          <xsl:with-param name="elementName" select="'cit:role'"/>
                          <xsl:with-param name="codeListName" select="'cit:CI_RoleCode'"/>
                          <xsl:with-param name="codeListValue" select="'pointOfContact'"/>
                        </xsl:call-template>
                        <xsl:element name="cit:party">
                          <cit:CI_Organisation>
                            <cit:name>
                              <xsl:call-template name="writeCharacterString">
                                <xsl:with-param name="stringToWrite" select="'GCMD User Support Office'"/>
                              </xsl:call-template>
                            </cit:name>
                            <cit:contactInfo>
                              <cit:CI_Contact>
                                <cit:address>
                                  <cit:CI_Address>
                                    <cit:electronicMailAddress>
                                      <gco:CharacterString>gcmduso@gcmd.gsfc.nasa.gov</gco:CharacterString>
                                    </cit:electronicMailAddress>
                                  </cit:CI_Address>
                                </cit:address>
                              </cit:CI_Contact>
                            </cit:contactInfo>
                          </cit:CI_Organisation>
                        </xsl:element>
                      </cit:CI_Responsibility>
                    </cit:citedResponsibleParty>
                    <cit:onlineResource>
                      <cit:CI_OnlineResource>
                        <cit:linkage>
                          <gco:CharacterString>http://gcmd.nasa.gov/Resources/valids/</gco:CharacterString>
                        </cit:linkage>
                        <cit:name>
                          <gco:CharacterString>GCMD Keywords Page</gco:CharacterString>
                        </cit:name>
                        <cit:description>
                          <gco:CharacterString>This page describes the NASA GCMD Keywords, how to reference those keywords and provides download instructions. </gco:CharacterString>
                        </cit:description>
                        <cit:function>
                          <cit:CI_OnLineFunctionCode codeList="http://www.ngdc.noaa.gov/metadata/published/xsd/schema/resources/Codelist/gmxCodelists.xml#CI_OnLineFunctionCode" codeListValue="information">information</cit:CI_OnLineFunctionCode>
                        </cit:function>
                      </cit:CI_OnlineResource>
                    </cit:onlineResource>
                  </cit:CI_Citation>
                </mri:thesaurusName>
              </mri:MD_Keywords>
            </mri:descriptiveKeywords>
          </xsl:if>
          <!-- Instrument Keywords -->
          <xsl:if test="//Instruments/Instrument/ShortName | //Instruments/Instrument/LongName">
            <mri:descriptiveKeywords>
              <mri:MD_Keywords>
                <xsl:for-each select="/*/Platforms/Platform/Instruments/Instrument">
                  <mri:keyword>
                    <gco:CharacterString>
                      <xsl:value-of select="ShortName"/>
                      <xsl:if test="LongName">
                        <xsl:value-of select="concat(' &gt; ', LongName)"/>
                      </xsl:if>
                    </gco:CharacterString>
                  </mri:keyword>
                </xsl:for-each>
                <xsl:call-template name="writeCodelistElement">
                  <xsl:with-param name="elementName" select="'mri:type'"/>
                  <xsl:with-param name="codeListName" select="'mri:MD_KeywordTypeCode'"/>
                  <xsl:with-param name="codeListValue" select="'instrument'"/>
                </xsl:call-template>
                <mri:thesaurusName>
                  <cit:CI_Citation>
                    <cit:title>
                      <gco:CharacterString> NASA/Global Change Master Directory (GCMD) Data Center Keywords </gco:CharacterString>
                    </cit:title>
                    <cit:date>
                      <cit:CI_Date>
                        <cit:date>
                          <gco:DateTime>2008-02-07T00:00:00</gco:DateTime>
                        </cit:date>
                        <cit:dateType>
                          <cit:CI_DateTypeCode codeList="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#CI_DateTypeCode" codeListValue="publication">publication</cit:CI_DateTypeCode>
                        </cit:dateType>
                      </cit:CI_Date>
                    </cit:date>
                    <cit:identifier gco:nilReason="unknown"/>
                    <cit:citedResponsibleParty>
                      <cit:CI_Responsibility>
                        <xsl:call-template name="writeCodelistElement">
                          <xsl:with-param name="elementName" select="'cit:role'"/>
                          <xsl:with-param name="codeListName" select="'cit:CI_RoleCode'"/>
                          <xsl:with-param name="codeListValue" select="'pointOfContact'"/>
                        </xsl:call-template>
                        <xsl:element name="cit:party">
                          <cit:CI_Organisation>
                            <cit:name>
                              <xsl:call-template name="writeCharacterString">
                                <xsl:with-param name="stringToWrite" select="'GCMD User Support Office'"/>
                              </xsl:call-template>
                            </cit:name>
                            <cit:contactInfo>
                              <cit:CI_Contact>
                                <cit:address>
                                  <cit:CI_Address>
                                    <cit:electronicMailAddress>
                                      <gco:CharacterString>gcmduso@gcmd.gsfc.nasa.gov</gco:CharacterString>
                                    </cit:electronicMailAddress>
                                  </cit:CI_Address>
                                </cit:address>
                              </cit:CI_Contact>
                            </cit:contactInfo>
                          </cit:CI_Organisation>
                        </xsl:element>
                      </cit:CI_Responsibility>
                    </cit:citedResponsibleParty>
                    <cit:onlineResource>
                      <cit:CI_OnlineResource>
                        <cit:linkage>
                          <gco:CharacterString>http://gcmd.nasa.gov/Resources/valids/</gco:CharacterString>
                        </cit:linkage>
                        <cit:name>
                          <gco:CharacterString>GCMD Keywords Page</gco:CharacterString>
                        </cit:name>
                        <cit:description>
                          <gco:CharacterString>This page describes the NASA GCMD Keywords, how to reference those keywords and provides download instructions. </gco:CharacterString>
                        </cit:description>
                        <cit:function>
                          <cit:CI_OnLineFunctionCode codeList="http://www.ngdc.noaa.gov/metadata/published/xsd/schema/resources/Codelist/gmxCodelists.xml#CI_OnLineFunctionCode" codeListValue="information">information</cit:CI_OnLineFunctionCode>
                        </cit:function>
                      </cit:CI_OnlineResource>
                    </cit:onlineResource>
                  </cit:CI_Citation>
                </mri:thesaurusName>

              </mri:MD_Keywords>
            </mri:descriptiveKeywords>
          </xsl:if>

          <xsl:if test="//RestrictionComment | //RestrictionFlag">
            <!-- 
            Only write copnstraints if RestrictionComment or RestrictionFlag exist in the ECHO record
            -->
            <mri:resourceConstraints>
              <mco:MD_LegalConstraints>
                <xsl:if test="/*/RestrictionComment">
                  <mco:otherConstraints>
                    <xsl:call-template name="writeCharacterString">
                      <xsl:with-param name="stringToWrite" select="concat('Restriction Comment: ', /*/RestrictionComment)"/>
                    </xsl:call-template>
                  </mco:otherConstraints>
                </xsl:if>
                <xsl:if test="/*/RestrictionComment">
                  <mco:otherConstraints>
                    <xsl:call-template name="writeCharacterString">
                      <xsl:with-param name="stringToWrite" select="concat('Restriction Flag: ', /*/RestrictionFlag)"/>
                    </xsl:call-template>
                  </mco:otherConstraints>
                </xsl:if>
              </mco:MD_LegalConstraints>
            </mri:resourceConstraints>
          </xsl:if>
          <xsl:for-each select="/*/Collection">
            <mri:associatedResource>
              <mri:MD_AsociatedResource>
                <xsl:comment select="'Parent Collection'"/>
                <mri:name>
                  <cit:CI_Citation>
                    <cit:title>
                      <xsl:call-template name="writeCharacterString">
                        <xsl:with-param name="stringToWrite" select="ShortName | DataSetId"/>
                      </xsl:call-template>
                    </cit:title>
                    <cit:date gco:nilReason="unknown"/>
                    <xsl:if test="VersionId">
                      <cit:edition>
                        <xsl:call-template name="writeCharacterString">
                          <xsl:with-param name="stringToWrite" select="VersionId"/>
                        </xsl:call-template>
                      </cit:edition>
                    </xsl:if>
                    <cit:identifier>
                      <mcc:MD_Identifier>
                        <mcc:code>
                          <xsl:choose>
                            <xsl:when test="exists(DataSetId)">
                              <xsl:call-template name="writeCharacterString">
                                <xsl:with-param name="stringToWrite" select="DataSetId"/>
                              </xsl:call-template>
                            </xsl:when>
                            <xsl:otherwise>
                              <xsl:call-template name="writeCharacterString">
                                <xsl:with-param name="stringToWrite" select="concat(ShortName, VersionId)"/>
                              </xsl:call-template>
                            </xsl:otherwise>
                          </xsl:choose>
                        </mcc:code>
                      </mcc:MD_Identifier>
                    </cit:identifier>
                  </cit:CI_Citation>
                </mri:name>
                <!-- In granule records these are all LargeWorkCitations (no CollectionType is included) -->
                <xsl:call-template name="writeCodelistElement">
                  <xsl:with-param name="elementName" select="'mri:associationType'"/>
                  <xsl:with-param name="codeListName" select="'mri:DS_AssociationTypeCode'"/>
                  <xsl:with-param name="codeListValue" select="'LargerWorkCitation'"/>
                </xsl:call-template>
                <xsl:call-template name="writeCodelistElement">
                  <xsl:with-param name="elementName" select="'mri:initiativeType'"/>
                  <xsl:with-param name="codeListName" select="'mri:DS_InitiativeTypeCode'"/>
                  <xsl:with-param name="codeListValue" select="'collection'"/>
                </xsl:call-template>
              </mri:MD_AsociatedResource>
            </mri:associatedResource>
          </xsl:for-each>
          <xsl:for-each select="/Collection/CollectionAssociations/CollectionAssociation[CollectionType != 'Input']">
            <mri:associatedResource>
              <xsl:comment select="'Associated Collection'"/>
              <mri:MD_AssociatedResource>
                <mri:name>
                  <cit:CI_Citation>
                    <cit:title>
                      <xsl:call-template name="writeCharacterString">
                        <xsl:with-param name="stringToWrite" select="ShortName"/>
                      </xsl:call-template>
                    </cit:title>
                    <cit:date gco:nilReason="unknown"/>
                    <cit:edition>
                      <xsl:call-template name="writeCharacterString">
                        <xsl:with-param name="stringToWrite" select="VersionId"/>
                      </xsl:call-template>
                    </cit:edition>
                    <cit:identifier>
                      <mcc:MD_Identifier>
                        <mcc:code>
                          <xsl:call-template name="writeCharacterString">
                            <xsl:with-param name="stringToWrite" select="ShortName"/>
                          </xsl:call-template>
                        </mcc:code>
                      </mcc:MD_Identifier>
                    </cit:identifier>
                    <cit:otherCitationDetails>
                      <gco:CharacterString>
                        <xsl:value-of select="CollectionUse"/>
                      </gco:CharacterString>
                    </cit:otherCitationDetails>
                  </cit:CI_Citation>
                </mri:name>
                <xsl:call-template name="writeCodelistElement">
                  <xsl:with-param name="elementName" select="'mri:associationType'"/>
                  <xsl:with-param name="codeListName" select="'mri:DS_AssociationTypeCode'"/>
                  <xsl:with-param name="codeListValue" select="CollectionType"/>
                </xsl:call-template>
              </mri:MD_AssociatedResource>
            </mri:associatedResource>
          </xsl:for-each>

          <mri:defaultLocale>
            <lan:PT_Locale>
              <lan:language>
                <lan:LanguageCode codeList="codeListLocation#LanguageCode" codeListValue="eng">eng</lan:LanguageCode>
              </lan:language>
              <lan:characterEncoding>
                <lan:MD_CharacterSetCode codeList="codeListLocation#MD_CharacterSetCode" codeListValue="utf8">utf8</lan:MD_CharacterSetCode>
              </lan:characterEncoding>
            </lan:PT_Locale>
          </mri:defaultLocale>
        </mri:MD_DataIdentification>
      </mdb:identificationInfo>
      <xsl:if test="$contentInformationCount > 0">
        <!-- This contentInfo section exists to accomodate AdditionalAttributes with type = contentInformation.
        These AdditionalAttributes provide information about the parameters in the dataset. There is no way to
        associate these AdditionalAttributes with a particular parameter so they are in a separate MD_Band object
        without a sequenceIdentifier. -->
        <mdb:contentInfo>
          <xsl:comment select="'contentInformation AdditionalAttributes'"/>
          <mrc:MD_CoverageDescription>
            <mrc:attributeDescription gco:nilReason="missing"/>
            <mrc:attributeGroup>
              <mrc:MD_AttributeGroup>
                <xsl:call-template name="writeCodelistElement">
                  <xsl:with-param name="elementName" select="'mrc:contentType'"/>
                  <xsl:with-param name="codeListName" select="'mrc:MD_CoverageContentTypeCode'"/>
                  <xsl:with-param name="codeListValue" select="'physicalMeasurement'"/>
                </xsl:call-template>
                <mrc:attribute>
                  <mrc:MD_SampleDimension>
                    <mrc:otherPropertyType>
                      <gco:RecordType xlink:href="http://earthdata.nasa.gov/schema/eos/additionalAttributes.xsd#xpointer(//element[@name='AdditionalAttributes'])">Echo Additional Attributes</gco:RecordType>
                    </mrc:otherPropertyType>
                    <mrc:otherProperty>
                      <gco:Record>
                        <eos:AdditionalAttributes>
                          <xsl:for-each select="//AdditionalAttribute">
                            <xsl:if test="key('additionalAttributeLookup', Name, doc('additionalAttributeType.xml'))/@type = 'contentInformation'">
                              <xsl:call-template name="writeEOS_PSA">
                                <xsl:with-param name="additionalAttributeType" select="'contentInformation'"/>
                              </xsl:call-template>
                            </xsl:if>
                          </xsl:for-each>
                          <xsl:if test="/Granule/DataGranule/DayNightFlag">
                            <eos:AdditionalAttribute>
                              <eos:reference>
                                <eos:EOS_AdditionalAttributeDescription>
                                  <eos:type>
                                    <xsl:element name="eos:EOS_AdditionalAttributeTypeCode">
                                      <xsl:attribute name="codeList" select="'http://earthdata.nasa.gov/metadata/resources/Codelists.xml#EOS_AdditionalAttributeTypeCode'"/>
                                      <xsl:attribute name="codeListValue" select="'contentInformation'"/>
                                      <xsl:value-of select="'contentInformation'"/>
                                    </xsl:element>
                                  </eos:type>
                                  <eos:name>
                                    <gco:CharacterString>DayNightFlag</gco:CharacterString>
                                  </eos:name>
                                </eos:EOS_AdditionalAttributeDescription>
                              </eos:reference>
                              <xsl:element name="eos:value">
                                <gco:CharacterString>
                                  <xsl:value-of select="/Granule/DataGranule/DayNightFlag"/>
                                </gco:CharacterString>
                              </xsl:element>
                            </eos:AdditionalAttribute>
                          </xsl:if>
                        </eos:AdditionalAttributes>
                      </gco:Record>
                    </mrc:otherProperty>
                  </mrc:MD_SampleDimension>
                </mrc:attribute>
              </mrc:MD_AttributeGroup>
            </mrc:attributeGroup>
          </mrc:MD_CoverageDescription>
        </mdb:contentInfo>
      </xsl:if>
      <xsl:if test="$additionalAttributeCount > $classifiedAdditionalAttributeCount">
        <!-- 
          This contentInfo section exists to accomodate AdditionalAttributes without known types 
          (ie. unclassified AdditionalAttributes).
        -->
        <mdb:contentInfo>
          <xsl:comment select="'Unclassified AdditionalAttributes'"/>
          <mrc:MD_CoverageDescription>
            <mrc:attributeDescription gco:nilReason="missing"/>
            <mrc:attributeGroup>
              <mrc:MD_AttributeGroup>
                <xsl:call-template name="writeCodelistElement">
                  <xsl:with-param name="elementName" select="'mrc:contentType'"/>
                  <xsl:with-param name="codeListName" select="'mrc:MD_CoverageContentTypeCode'"/>
                  <xsl:with-param name="codeListValue" select="'physicalMeasurement'"/>
                </xsl:call-template>
                <mrc:attribute>
                  <mrc:MD_SampleDimension>
                    <mrc:otherPropertyType>
                      <gco:RecordType xlink:href="http://earthdata.nasa.gov/schema/eos/additionalAttributes.xsd#xpointer(//element[@name='AdditionalAttributes'])">Echo Additional Attributes</gco:RecordType>
                    </mrc:otherPropertyType>
                    <mrc:otherProperty>
                      <gco:Record>
                        <eos:AdditionalAttributes>
                          <xsl:for-each select="//AdditionalAttribute">
                            <xsl:choose>
                              <xsl:when test="exists(key('additionalAttributeLookup', Name, doc('additionalAttributeType.xml'))/@type)"/>
                              <xsl:otherwise>
                                <xsl:call-template name="writeEOS_PSA">
                                  <xsl:with-param name="additionalAttributeType" select="'unclassified'"/>
                                </xsl:call-template>
                              </xsl:otherwise>
                            </xsl:choose>
                          </xsl:for-each>
                        </eos:AdditionalAttributes>
                      </gco:Record>
                    </mrc:otherProperty>
                  </mrc:MD_SampleDimension>
                </mrc:attribute>
              </mrc:MD_AttributeGroup>
            </mrc:attributeGroup>
          </mrc:MD_CoverageDescription>
        </mdb:contentInfo>
      </xsl:if>
      <xsl:if test="/*/MeasuredParameters/MeasuredParameter">
        <!-- MeasuredParameters are included in granule records along with several quality statistics (QAStats) and flags (QAFlags).
        Only names of the parameters are captured here. The quality information is written into the DQ_QualityInformation section 
        -->
        <mdb:contentInfo>
          <mrc:MD_CoverageDescription>
            <mrc:attributeDescription gco:nilReason="missing"/>
            <mrc:attributeGroup>
              <mrc:MD_AttributeGroup>
                <!-- Parameters are grouped by types. As no type classification is available it is assumed that they are all physicalMeasurements -->
                <xsl:call-template name="writeCodelistElement">
                  <xsl:with-param name="elementName" select="'mrc:contentType'"/>
                  <xsl:with-param name="codeListName" select="'mrc:MD_CoverageContentTypeCode'"/>
                  <xsl:with-param name="codeListValue" select="'physicalMeasurement'"/>
                </xsl:call-template>
                <xsl:for-each select="/*/MeasuredParameters/MeasuredParameter">
                  <mrc:attribute>
                    <mrc:MD_SampleDimension>
                      <mrc:sequenceIdentifier>
                        <gco:MemberName>
                          <gco:aName>
                            <gco:CharacterString>
                              <xsl:value-of select="ParameterName"/>
                            </gco:CharacterString>
                          </gco:aName>
                          <gco:attributeType gco:nilReason="unknown"/>
                        </gco:MemberName>
                      </mrc:sequenceIdentifier>
                    </mrc:MD_SampleDimension>
                  </mrc:attribute>
                </xsl:for-each>
              </mrc:MD_AttributeGroup>
            </mrc:attributeGroup>
          </mrc:MD_CoverageDescription>
        </mdb:contentInfo>
      </xsl:if>
      <mdb:distributionInfo>
        <mrd:MD_Distribution>
          <!-- There is a known problem with multiple distributorContacts. The standard allows only one which means that, even when you have different roles at a single distributor,
            you need an entire distributor section for each contact. 
            This is fixed in 19115-1  -->
          <xsl:variable name="distributorContactCount" select="
              count(/*/Contacts/Contact[contains(Role, 'Archive')
              or contains(Role, 'DATA CENTER CONTACT')
              or contains(Role, 'Distributor')
              or contains(Role, 'User Services')
              or contains(Role, 'GHRC USER SERVICES')
              or contains(Role, 'ORNL DAAC User Services')])"/>
          <mrd:distributor>
            <mrd:MD_Distributor>
              <!-- Use Archive Center only if no more complete contact information exists -->
              <xsl:if test="$distributorContactCount = 0">
                <xsl:choose>
                  <xsl:when test="/*/ArchiveCenter">
                    <mrd:distributorContact>
                      <cit:CI_Responsibility>
                        <xsl:comment select="'ArchiveCenter'"/>
                        <xsl:call-template name="writeCodelistElement">
                          <xsl:with-param name="elementName" select="'cit:role'"/>
                          <xsl:with-param name="codeListName" select="'cit:CI_RoleCode'"/>
                          <xsl:with-param name="codeListValue" select="'distributor'"/>
                        </xsl:call-template>
                        <xsl:element name="cit:party">
                          <cit:CI_Organisation>
                            <cit:name>
                              <xsl:call-template name="writeCharacterString">
                                <xsl:with-param name="stringToWrite" select="."/>
                              </xsl:call-template>
                            </cit:name>
                          </cit:CI_Organisation>
                        </xsl:element>
                      </cit:CI_Responsibility>
                    </mrd:distributorContact>
                  </xsl:when>
                  <xsl:otherwise>
                    <!-- No ArchiveCenter or contact information -->
                    <mrd:distributorContact gco:nilReason="missing"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:if>
              <!-- Take advantage of more complete contact information, first one (position()=1) goes here)-->
              <xsl:for-each select="/*/Contacts/Contact[contains(Role, 'Archive') or contains(Role, 'DATA CENTER CONTACT') or contains(Role, 'Distributor') or contains(Role, 'User Services') or contains(Role, 'GHRC USER SERVICES') or contains(Role, 'ORNL DAAC User Services')]">
                <xsl:if test="position() = 1">
                  <xsl:call-template name="contact2Responsibility">
                    <xsl:with-param name="roleName" select="'mrd:distributorContact'"/>
                    <xsl:with-param name="roleCode" select="'distributor'"/>
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
              <xsl:for-each select="/*/DataFormat | /*/CSDTDescriptions/CSDTDescription/Implementation">
                <mrd:distributorFormat>
                  <mrd:MD_Format>
                    <mrd:formatSpecificationCitation>
                      <cit:CI_Citation>
                        <cit:title>
                          <xsl:call-template name="writeCharacterString">
                            <xsl:with-param name="stringToWrite" select="."/>
                          </xsl:call-template>
                        </cit:title>
                        <xsl:choose>
                          <xsl:when test="contains(., '4')">
                            <cit:edition>
                              <gco:CharacterString>4</gco:CharacterString>
                            </cit:edition>
                          </xsl:when>
                          <xsl:when test="contains(., '5')">
                            <cit:edition>
                              <gco:CharacterString>5</gco:CharacterString>
                            </cit:edition>
                          </xsl:when>
                          <xsl:otherwise>
                            <cit:edition gco:nilReason="unknown"/>
                          </xsl:otherwise>
                        </xsl:choose>
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
                            <xsl:value-of select="URL"/>
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
                        <xsl:call-template name="writeCodelistElement">
                          <xsl:with-param name="elementName" select="'cit:function'"/>
                          <xsl:with-param name="codeListName" select="'CI_OnLineFunctionCode'"/>
                          <xsl:with-param name="codeListValue" select="'download'"/>
                        </xsl:call-template>
                      </cit:CI_OnlineResource>
                    </mrd:onLine>
                  </xsl:for-each>
                  <xsl:for-each select="/*/OnlineResources/OnlineResource">
                    <mrd:onLine>
                      <cit:CI_OnlineResource>
                        <cit:linkage>
                          <gco:CharacterString>
                            <xsl:value-of select="URL"/>
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
                        <!-- lookup the CI_OnlineFunctionCode for the ECHO /*/OnlineResources/OnlineResource/Type  -->
                        <xsl:variable name="onlineResourceType">
                          <xsl:choose>
                            <xsl:when test="exists(key('onlineResourceTypeLookup', Type, doc('onlineResourceType.xml'))/@type)">
                              <xsl:value-of select="key('onlineResourceTypeLookup', Type, doc('onlineResourceType.xml'))/@type"/>
                            </xsl:when>
                            <xsl:otherwise>
                              <!-- Default function code is information -->
                              <xsl:value-of select="'information'"/>
                            </xsl:otherwise>
                          </xsl:choose>
                        </xsl:variable>
                        <xsl:call-template name="writeCodelistElement">
                          <xsl:with-param name="elementName" select="'cit:function'"/>
                          <xsl:with-param name="codeListName" select="'cit:CI_OnLineFunctionCode'"/>
                          <xsl:with-param name="codeListValue" select="$onlineResourceType"/>
                        </xsl:call-template>
                      </cit:CI_OnlineResource>
                    </mrd:onLine>
                  </xsl:for-each>
                  <!-- This section writes AdditionalAttributes identified as having type = distribution.url -->
                  <xsl:for-each select="/*/AdditionalAttributes/AdditionalAttribute">
                    <xsl:if test="key('additionalAttributeLookup', Name, doc('additionalAttributeType.xml'))/@type = 'distribution.url'">
                      <xsl:for-each select="Values/Value | Value">
                        <xsl:comment select="'Additional Attribute: distribution.url'"/>
                        <cit:onLine>
                          <cit:CI_OnlineResource>
                            <cit:linkage>
                              <gco:CharacterString>
                                <xsl:value-of select="Values/Value | Value"/>
                              </gco:CharacterString>
                            </cit:linkage>
                            <cit:description>
                              <xsl:call-template name="writeCharacterString">
                                <xsl:with-param name="stringToWrite" select="ancestor::AdditionalAttribute/Name"/>
                              </xsl:call-template>
                            </cit:description>
                            <xsl:call-template name="writeCodelistElement">
                              <xsl:with-param name="elementName" select="'cit:function'"/>
                              <xsl:with-param name="codeListName" select="'cit:CI_OnLineFunctionCode'"/>
                              <xsl:with-param name="codeListValue" select="'download'"/>
                            </xsl:call-template>
                          </cit:CI_OnlineResource>
                        </cit:onLine>
                      </xsl:for-each>
                    </xsl:if>
                  </xsl:for-each>
                </mrd:MD_DigitalTransferOptions>
              </mrd:distributorTransferOptions>
            </mrd:MD_Distributor>
          </mrd:distributor>
          <!-- write additional contact information (standard only allows one distributionContact -->
          <xsl:for-each select="/*/Contacts/Contact[contains(Role, 'Archive') or contains(Role, 'DATA CENTER CONTACT') or contains(Role, 'Distributor') or contains(Role, 'User Services') or contains(Role, 'GHRC USER SERVICES') or contains(Role, 'ORNL DAAC User Services')]">
            <xsl:if test="position() > 1">
              <mrd:distributor>
                <mrd:MD_Distributor>
                  <xsl:call-template name="contact2Responsibility">
                    <xsl:with-param name="roleName" select="'mrd:distributorContact'"/>
                    <xsl:with-param name="roleCode" select="'distributor'"/>
                  </xsl:call-template>
                </mrd:MD_Distributor>
              </mrd:distributor>
            </xsl:if>
          </xsl:for-each>
          <xsl:for-each select="/*/Contacts/Contact[contains(Role, 'Data Manager')]">
            <mrd:distributor>
              <mrd:MD_Distributor>
                <xsl:comment select="'Role: Data Manager'"/>
                <xsl:call-template name="contact2Responsibility">
                  <xsl:with-param name="roleName" select="'mrd:distributorContact'"/>
                  <xsl:with-param name="roleCode" select="'custodian'"/>
                </xsl:call-template>
              </mrd:MD_Distributor>
            </mrd:distributor>
          </xsl:for-each>

        </mrd:MD_Distribution>
      </mdb:distributionInfo>
      <mdb:dataQualityInfo>
        <mdq:DQ_DataQuality>
          <xsl:comment select="'dataset quality information'"/>
          <mdq:scope>
            <mcc:MD_Scope>
              <xsl:call-template name="writeCodelistElement">
                <xsl:with-param name="elementName" select="'mcc:level'"/>
                <xsl:with-param name="codeListName" select="'mcc:MD_ScopeCode'"/>
                <xsl:with-param name="codeListValue" select="$metadataScope"/>
              </xsl:call-template>
            </mcc:MD_Scope>
          </mdq:scope>

          <xsl:comment select="'Additional Attributes'"/>
          <xsl:for-each select="/*/AdditionalAttributes/AdditionalAttribute">
            <xsl:if test="key('additionalAttributeLookup', Name, doc('additionalAttributeType.xml'))/@type = 'qualityInformation'">
              <!-- This section writes AdditionalAttributes identified as having type = quaityInformation -->
              <mdq:report>
                <mdq:DQ_QuantitativeAttributeAccuracy>
                  <mdq:measure>
                    <mdq:DQ_MeasureReference>
                      <mdq:nameOfMeasure>
                        <!-- write the name of the additional attribute as the name of the quality measure -->
                        <gco:CharacterString>
                          <xsl:value-of select="Name"/>
                        </gco:CharacterString>
                      </mdq:nameOfMeasure>
                    </mdq:DQ_MeasureReference>
                  </mdq:measure>
                  <mdq:result>
                    <mdq:DQ_QuantitativeResult>
                      <mdq:value>
                        <gco:Record>
                          <eos:AdditionalAttributes>
                            <!-- write the complete additional attribute -->
                            <xsl:call-template name="writeEOS_PSA"/>
                          </eos:AdditionalAttributes>
                        </gco:Record>
                      </mdq:value>
                      <mdq:valueUnit gco:nilReason="missing"/>
                      <mdq:valueRecordType>
                        <gco:RecordType xlink:href="http://earthdata.nasa.gov/schema/eos/additionalAttributes.xsd#xpointer(//element[@name='AdditionalAttributes'])">Echo Additional Attributes</gco:RecordType>
                      </mdq:valueRecordType>
                    </mdq:DQ_QuantitativeResult>
                  </mdq:result>
                </mdq:DQ_QuantitativeAttributeAccuracy>
              </mdq:report>
            </xsl:if>
          </xsl:for-each>

          <!-- write PrecisionOfSeconds as a quality report -->
          <xsl:if test="/*/Temporal/PrecisionOfSeconds">
            <xsl:comment select="'PrecisionOfSeconds'"/>
            <mdq:report>
              <mdq:DQ_AccuracyOfATimeMeasurement>
                <mdq:measure>
                  <mdq:DQ_MeasureReference>
                    <mdq:measureIdentification>
                      <mcc:MD_Identifier>
                        <mcc:code>
                          <xsl:call-template name="writeCharacterString">
                            <xsl:with-param name="stringToWrite" select="'PrecisionOfSeconds'"/>
                          </xsl:call-template>
                        </mcc:code>
                      </mcc:MD_Identifier>
                    </mdq:measureIdentification>
                  </mdq:DQ_MeasureReference>
                </mdq:measure>
                <mdq:result>
                  <mdq:DQ_QuantitativeResult>
                    <mdq:value>
                      <gco:Record xsi:type="gco:Real_PropertyType">
                        <gco:Real>
                          <xsl:value-of select="/*/Temporal/PrecisionOfSeconds"/>
                        </gco:Real>
                      </gco:Record>
                    </mdq:value>
                    <mdq:valueUnit gco:nilReason="missing"/>
                  </mdq:DQ_QuantitativeResult>
                </mdq:result>
              </mdq:DQ_AccuracyOfATimeMeasurement>
            </mdq:report>
          </xsl:if>
        </mdq:DQ_DataQuality>
      </mdb:dataQualityInfo>
      <xsl:if test="/*/MeasuredParameters/MeasuredParameter">
        <!-- Granule records include MeasuredParameters which include QAFlags and QAStats. 
              These are written into DQ_Dataquality reports for each MeasuredParameter.
              There are four standard QAStats: QAPercentMissingData, QAPercentOutOfBoundsData,QAPercentInterpolatedData, QAPercentCloudCover
            -->
        <mdb:dataQualityInfo>
          <mdq:DQ_DataQuality>
            <xsl:comment select="'attribute quality information (QStats)'"/>
            <mdq:report>
              <!-- write QAPercentMissingData report as a result for each MeasuredParameter -->
              <mdq:DQ_CompletenessOmission>
                <mdq:measure>
                  <mdq:DQ_MeasureReference>
                    <mdq:measureIdentification>
                      <mcc:MD_Identifier>
                        <mcc:code>
                          <gco:CharacterString>QAPercentMissingData</gco:CharacterString>
                        </mcc:code>
                      </mcc:MD_Identifier>
                    </mdq:measureIdentification>
                  </mdq:DQ_MeasureReference>
                </mdq:measure>
                <xsl:for-each select="/*/MeasuredParameters/MeasuredParameter">
                  <!-- 19115-1 supports multiple results with different scopes in a single report. In this case, 
                  QAPercentMissingValue results for all parameters (attributes) are grouped together -->
                  <mdq:result>
                    <mdq:DQ_QuantitativeResult>
                      <mdq:resultScope>
                        <mdq:DQ_Scope>

                          <xsl:call-template name="writeCodelistElement">
                            <xsl:with-param name="elementName" select="'mdq:level'"/>
                            <xsl:with-param name="codeListName" select="'mcc:MD_ScopeCode'"/>
                            <xsl:with-param name="codeListValue" select="'attribute'"/>
                          </xsl:call-template>

                          <mdq:levelDescription>
                            <mdq:MD_ScopeDescription>
                              <mdq:attributes>
                                <gco:CharacterString>
                                  <xsl:value-of select="ParameterName"/>
                                </gco:CharacterString>
                              </mdq:attributes>
                            </mdq:MD_ScopeDescription>
                          </mdq:levelDescription>
                        </mdq:DQ_Scope>
                      </mdq:resultScope>
                      <mdq:value>
                        <xsl:choose>
                          <xsl:when test="QAStats/QAPercentMissingData">
                            <gco:Record xsi:type="gco:Real_PropertyType">
                              <xsl:value-of select="QAStats/QAPercentMissingData"/>
                            </gco:Record>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:attribute name="gco:nilReason" select="'unknown'"/>
                          </xsl:otherwise>
                        </xsl:choose>
                      </mdq:value>
                      <mdq:valueUnit gco:nilReason="missing"/>
                    </mdq:DQ_QuantitativeResult>
                  </mdq:result>
                </xsl:for-each>
              </mdq:DQ_CompletenessOmission>
            </mdq:report>
            <mdq:report>
              <mdq:DQ_CompletenessOmission>
                <mdq:measure>
                  <mdq:DQ_MeasureReference>
                    <mdq:measureIdentification>
                      <mcc:MD_Identifier>
                        <mcc:code>
                          <gco:CharacterString>QAPercentOutOfBoundsData</gco:CharacterString>
                        </mcc:code>
                      </mcc:MD_Identifier>
                    </mdq:measureIdentification>
                  </mdq:DQ_MeasureReference>
                </mdq:measure>
                <xsl:for-each select="/*/MeasuredParameters/MeasuredParameter">
                  <!-- 19115-1 supports multiple results with different scopes in a single report. In this case, 
                  QAPercentOutOfBoundsData results for all parameters (attributes) are grouped together -->
                  <mdq:result>
                    <mdq:DQ_QuantitativeResult>
                      <mdq:resultScope>
                        <mdq:DQ_Scope>

                          <xsl:call-template name="writeCodelistElement">
                            <xsl:with-param name="elementName" select="'mdq:level'"/>
                            <xsl:with-param name="codeListName" select="'mcc:MD_ScopeCode'"/>
                            <xsl:with-param name="codeListValue" select="'attribute'"/>
                          </xsl:call-template>

                          <mdq:levelDescription>
                            <mdq:MD_ScopeDescription>
                              <mdq:attributes>
                                <gco:CharacterString>
                                  <xsl:value-of select="ParameterName"/>
                                </gco:CharacterString>
                              </mdq:attributes>
                            </mdq:MD_ScopeDescription>
                          </mdq:levelDescription>
                        </mdq:DQ_Scope>
                      </mdq:resultScope>
                      <mdq:value>
                        <gco:Record xsi:type="gco:Real_PropertyType">
                          <xsl:value-of select="QAStats/QAPercentOutOfBoundsData"/>
                        </gco:Record>
                      </mdq:value>
                      <mdq:valueUnit gco:nilReason="missing"/>
                    </mdq:DQ_QuantitativeResult>
                  </mdq:result>
                </xsl:for-each>
              </mdq:DQ_CompletenessOmission>
            </mdq:report>
            <mdq:report>
              <!-- write QAPercentCloudCover report as a result for each MeasuredParameter -->
              <mdq:DQ_CompletenessOmission>
                <mdq:measure>
                  <mdq:DQ_MeasureReference>
                    <mdq:measureIdentification>
                      <mcc:MD_Identifier>
                        <mcc:code>
                          <gco:CharacterString>QAPercentCloudCover</gco:CharacterString>
                        </mcc:code>
                      </mcc:MD_Identifier>
                    </mdq:measureIdentification>
                  </mdq:DQ_MeasureReference>
                </mdq:measure>
                <xsl:for-each select="/*/MeasuredParameters/MeasuredParameter">
                  <!-- 19115-1 supports multiple results with different scopes in a single report. In this case, 
                  QAPercentMissingValue results for all parameters (attributes) are grouped together -->
                  <mdq:result>
                    <mdq:DQ_QuantitativeResult>
                      <mdq:resultScope>
                        <mdq:DQ_Scope>

                          <xsl:call-template name="writeCodelistElement">
                            <xsl:with-param name="elementName" select="'mdq:level'"/>
                            <xsl:with-param name="codeListName" select="'mcc:MD_ScopeCode'"/>
                            <xsl:with-param name="codeListValue" select="'attribute'"/>
                          </xsl:call-template>

                          <mdq:levelDescription>
                            <mdq:MD_ScopeDescription>
                              <mdq:attributes>
                                <gco:CharacterString>
                                  <xsl:value-of select="ParameterName"/>
                                </gco:CharacterString>
                              </mdq:attributes>
                            </mdq:MD_ScopeDescription>
                          </mdq:levelDescription>
                        </mdq:DQ_Scope>
                      </mdq:resultScope>
                      <mdq:value>
                        <xsl:choose>
                          <xsl:when test="QAStats/QAPercentCloudCover">
                            <gco:Record xsi:type="gco:Real_PropertyType">
                              <xsl:value-of select="QAPercentCloudCover"/>
                            </gco:Record>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:attribute name="gco:nilReason" select="'unknown'"/>
                          </xsl:otherwise>
                        </xsl:choose>
                      </mdq:value>
                      <mdq:valueUnit gco:nilReason="missing"/>
                    </mdq:DQ_QuantitativeResult>
                  </mdq:result>
                </xsl:for-each>
              </mdq:DQ_CompletenessOmission>
            </mdq:report>
            <mdq:report>
              <!-- write QAPercentInterpolatedData report as a result for each MeasuredParameter -->
              <mdq:DQ_QuantitativeResult>
                <mdq:measure>
                  <mdq:DQ_MeasureReference>
                    <mdq:measureIdentification>
                      <mcc:MD_Identifier>
                        <mcc:code>
                          <gco:CharacterString>DQ_QuantitativeResult</gco:CharacterString>
                        </mcc:code>
                      </mcc:MD_Identifier>
                    </mdq:measureIdentification>
                  </mdq:DQ_MeasureReference>
                </mdq:measure>
                <xsl:for-each select="/*/MeasuredParameters/MeasuredParameter">
                  <!-- 19115-1 supports multiple results with different scopes in a single report. In this case, 
                  QAPercentMissingValue results for all parameters (attributes) are grouped together -->
                  <mdq:result>
                    <mdq:DQ_QuantitativeResult>
                      <mdq:resultScope>
                        <mdq:DQ_Scope>

                          <xsl:call-template name="writeCodelistElement">
                            <xsl:with-param name="elementName" select="'mdq:level'"/>
                            <xsl:with-param name="codeListName" select="'mcc:MD_ScopeCode'"/>
                            <xsl:with-param name="codeListValue" select="'attribute'"/>
                          </xsl:call-template>

                          <mdq:levelDescription>
                            <mdq:MD_ScopeDescription>
                              <mdq:attributes>
                                <gco:CharacterString>
                                  <xsl:value-of select="ParameterName"/>
                                </gco:CharacterString>
                              </mdq:attributes>
                            </mdq:MD_ScopeDescription>
                          </mdq:levelDescription>
                        </mdq:DQ_Scope>
                      </mdq:resultScope>
                      <mdq:value>
                        <xsl:choose>
                          <xsl:when test="QAStats/DQ_QuantitativeResult">
                            <gco:Record xsi:type="gco:Real_PropertyType">
                              <xsl:value-of select="QAStats/DQ_QuantitativeResult"/>
                            </gco:Record>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:attribute name="gco:nilReason" select="'unknown'"/>
                          </xsl:otherwise>
                        </xsl:choose>
                      </mdq:value>
                      <mdq:valueUnit gco:nilReason="missing"/>
                    </mdq:DQ_QuantitativeResult>
                  </mdq:result>
                </xsl:for-each>
              </mdq:DQ_QuantitativeResult>
            </mdq:report>
          </mdq:DQ_DataQuality>
        </mdb:dataQualityInfo>

        <mdb:dataQualityInfo>
          <mdq:DQ_DataQuality>
            <xsl:comment select="'attribute quality information (QFlags)'"/>
            <!-- Granule records include MeasuredParameters which include QAFlags and QAStats. 
              These are written into DQ_Dataquality reports for each MeasuredParameter.
              There are three standard QAFlags: Automatic, Operational, and ScienceQuality.
              The QAFlag explanations are specific for each parameter, so a separate report
              is required for each MeasuredParameter/QAFlag combination (up to 3 reports / MeasuredParameter)
            -->
            <xsl:for-each select="/*/MeasuredParameters/MeasuredParameter">
              <xsl:if test="QAFlags/*[starts-with(name(.), 'Automatic')]">
                <!-- Write this report if an AutomaticQualityFlag or AutomaticQualityFlagExplanation exists -->
                <mdq:report>
                  <mdq:DQ_NonQuantitativeAttributeCorrectness>
                    <mdq:measure>
                      <mdq:DQ_MeasureReference>
                        <mdq:measureIdentification>
                          <mcc:MD_Identifier>
                            <mcc:code>
                              <gco:CharacterString>AutomaticQualityFlag</gco:CharacterString>
                            </mcc:code>
                          </mcc:MD_Identifier>
                        </mdq:measureIdentification>
                        <mdq:measureDescription>
                          <xsl:call-template name="writeCharacterString">
                            <xsl:with-param name="stringToWrite" select="QAFlags/AutomaticQualityFlagExplanation"/>
                          </xsl:call-template>
                        </mdq:measureDescription>
                      </mdq:DQ_MeasureReference>
                    </mdq:measure>
                    <mdq:result>
                      <mdq:DQ_QuantitativeResult>
                        <mdq:resultScope>
                          <mdq:DQ_Scope>

                            <xsl:call-template name="writeCodelistElement">
                              <xsl:with-param name="elementName" select="'mdq:level'"/>
                              <xsl:with-param name="codeListName" select="'mcc:MD_ScopeCode'"/>
                              <xsl:with-param name="codeListValue" select="'attribute'"/>
                            </xsl:call-template>

                            <mdq:levelDescription>
                              <mdq:MD_ScopeDescription>
                                <mdq:attributes>
                                  <gco:CharacterString>
                                    <xsl:value-of select="ParameterName"/>
                                  </gco:CharacterString>
                                </mdq:attributes>
                              </mdq:MD_ScopeDescription>
                            </mdq:levelDescription>
                          </mdq:DQ_Scope>
                        </mdq:resultScope>
                        <mdq:value>
                          <gco:Record xsi:type="gco:Integer_PropertyType">
                            <xsl:value-of select="QAFlags/AutomaticQualityFlag"/>
                          </gco:Record>
                        </mdq:value>
                        <mdq:valueUnit gco:nilReason="missing"/>
                      </mdq:DQ_QuantitativeResult>
                    </mdq:result>
                  </mdq:DQ_NonQuantitativeAttributeCorrectness>
                </mdq:report>
              </xsl:if>

              <xsl:if test="QAFlags/*[starts-with(name(.), 'Operational')]">
                <!-- Write this report if an OperationalQualityFlag or OperationalQualityFlagExplanation exists -->
                <mdq:report>
                  <mdq:DQ_NonQuantitativeAttributeCorrectness>
                    <mdq:measure>
                      <mdq:DQ_MeasureReference>
                        <mdq:measureIdentification>
                          <mcc:MD_Identifier>
                            <mcc:code>
                              <gco:CharacterString>OperationalQualityFlag</gco:CharacterString>
                            </mcc:code>
                          </mcc:MD_Identifier>
                        </mdq:measureIdentification>
                        <mdq:measureDescription>
                          <xsl:call-template name="writeCharacterString">
                            <xsl:with-param name="stringToWrite" select="QAFlags/OperationalQualityFlagExplanation"/>
                          </xsl:call-template>
                        </mdq:measureDescription>
                      </mdq:DQ_MeasureReference>
                    </mdq:measure>
                    <mdq:result>
                      <mdq:DQ_QuantitativeResult>
                        <mdq:value>
                          <gco:Record xsi:type="gco:CharacterString_PropertyType">
                            <xsl:value-of select="QAFlags/OperationalQualityFlagExplanation"/>
                          </gco:Record>
                        </mdq:value>
                        <mdq:valueUnit gco:nilReason="missing"/>
                      </mdq:DQ_QuantitativeResult>
                    </mdq:result>
                  </mdq:DQ_NonQuantitativeAttributeCorrectness>
                </mdq:report>
              </xsl:if>
              <xsl:if test="QAFlags/*[starts-with(name(.), 'Science')]">
                <!-- Write this report if an OperationalQualityFlag or OperationalQualityFlagExplanation exists -->
                <mdq:report>
                  <mdq:DQ_CompletenessOmission>
                    <mdq:measure>
                      <mdq:DQ_MeasureReference>
                        <mdq:measureIdentification>
                          <mcc:MD_Identifier>
                            <mcc:code>
                              <gco:CharacterString>ScienceQualityFlag</gco:CharacterString>
                            </mcc:code>
                          </mcc:MD_Identifier>
                        </mdq:measureIdentification>
                        <mdq:measureDescription>
                          <xsl:call-template name="writeCharacterString">
                            <xsl:with-param name="stringToWrite" select="QAFlags/ScienceQualityFlagExplanation"/>
                          </xsl:call-template>
                        </mdq:measureDescription>
                      </mdq:DQ_MeasureReference>
                    </mdq:measure>
                    <mdq:result>
                      <mdq:DQ_QuantitativeResult>
                        <mdq:value>
                          <gco:Record xsi:type="gco:CharacterString_PropertyType">
                            <xsl:value-of select="QAFlags/ScienceQualityFlagExplanation"/>
                          </gco:Record>
                        </mdq:value>
                        <mdq:valueUnit gco:nilReason="missing"/>
                      </mdq:DQ_QuantitativeResult>
                    </mdq:result>
                  </mdq:DQ_CompletenessOmission>
                </mdq:report>
              </xsl:if>
            </xsl:for-each>
          </mdq:DQ_DataQuality>
        </mdb:dataQualityInfo>
      </xsl:if>
      <mdb:resourceLineage>
        <mrl:LI_Lineage>
          <xsl:for-each select="/*/CollectionAssociations/CollectionAssociation[CollectionType = 'Input']">
            <mrl:source>
              <mrl:LE_Source>
                <mrl:description>
                  <xsl:call-template name="writeCharacterString">
                    <xsl:with-param name="stringToWrite" select="CollectionUse"/>
                  </xsl:call-template>
                </mrl:description>
                <mrl:sourceCitation>
                  <cit:CI_Citation>
                    <cit:title>
                      <xsl:call-template name="writeCharacterString">
                        <xsl:with-param name="stringToWrite" select="concat(ShortName, ' Version:', VersionId)"/>
                      </xsl:call-template>
                    </cit:title>
                    <cit:date gco:nilReason="unknown"/>
                  </cit:CI_Citation>
                </mrl:sourceCitation>
              </mrl:LE_Source>
            </mrl:source>
          </xsl:for-each>
          <xsl:for-each select="/*/InputGranules/InputGranule">
            <mrl:source>
              <mrl:LE_Source id="{generate-id()}">
                <mrl:sourceCitation>
                  <cit:CI_Citation>
                    <cit:title>
                      <gcx:FileName>
                        <xsl:attribute name="src">
                          <xsl:value-of select="."/>
                        </xsl:attribute>
                      </gcx:FileName>
                    </cit:title>
                    <cit:date gco:nilReason="unknown"/>
                  </cit:CI_Citation>
                </mrl:sourceCitation>
              </mrl:LE_Source>
            </mrl:source>
          </xsl:for-each>
          <mrl:processStep>
            <mrl:LE_ProcessStep>
              <mrl:description gco:nilReason="unknown"/>
              <xsl:if test="$metadataScope = 'series'">
                <mrl:processor>
                  <cit:CI_Responsibility>
                    <xsl:call-template name="writeCodelistElement">
                      <xsl:with-param name="elementName" select="'cit:role'"/>
                      <xsl:with-param name="codeListName" select="'cit:CI_RoleCode'"/>
                      <xsl:with-param name="codeListValue" select="'processor'"/>
                    </xsl:call-template>
                    <cit:party>
                      <cit:CI_Organisation>
                        <cit:name>
                          <xsl:call-template name="writeCharacterString">
                            <xsl:with-param name="stringToWrite" select="/*/ProcessingCenter"/>
                          </xsl:call-template>
                        </cit:name>
                      </cit:CI_Organisation>
                    </cit:party>
                  </cit:CI_Responsibility>
                </mrl:processor>
              </xsl:if>
              <xsl:if test="/*/AlgorithmPackages/AlgorithmPackage or $processingInformationCount > 0">
                <mrl:processingInformation>
                  <eos:EOS_Processing>
                    <xsl:if test="$metadataScope = 'series'">
                      <xsl:for-each select="/*/AlgorithmPackages/AlgorithmPackage">
                        <mrl:algorithm>
                          <mrl:LE_Algorithm>
                            <mrl:citation>
                              <cit:CI_Citation>
                                <cit:title>
                                  <xsl:call-template name="writeCharacterString">
                                    <xsl:with-param name="stringToWrite" select="Name"/>
                                  </xsl:call-template>
                                </cit:title>
                                <cit:date gco:nilReason="unknown"/>
                                <cit:edition>
                                  <xsl:call-template name="writeCharacterString">
                                    <xsl:with-param name="stringToWrite" select="Version"/>
                                  </xsl:call-template>
                                </cit:edition>
                              </cit:CI_Citation>
                            </mrl:citation>
                            <mrl:description>
                              <xsl:call-template name="writeCharacterString">
                                <xsl:with-param name="stringToWrite" select="Description"/>
                              </xsl:call-template>
                            </mrl:description>
                          </mrl:LE_Algorithm>
                        </mrl:algorithm>
                      </xsl:for-each>
                    </xsl:if>
                    <!-- NASA Specific Extensions -->
                    <xsl:if test="$processingInformationCount > 0">
                      <mrl:identifier gco:nilReason="unknown"/>
                      <eos:otherPropertyType>
                        <gco:RecordType xlink:href="http://earthdata.nasa.gov/schema/eos/additionalAttributes.xsd#xpointer(//element[@name='AdditionalAttributes'])">Echo Additional Attributes</gco:RecordType>
                      </eos:otherPropertyType>
                      <eos:otherProperty>
                        <gco:Record>
                          <eos:AdditionalAttributes>
                            <xsl:for-each select="/*/AdditionalAttributes/AdditionalAttribute">
                              <xsl:if test="key('additionalAttributeLookup', Name, doc('additionalAttributeType.xml'))/@type = 'processingInformation'">
                                <xsl:call-template name="writeEOS_PSA">
                                  <xsl:with-param name="additionalAttributeType" select="'processingInformation'"/>
                                </xsl:call-template>
                              </xsl:if>
                            </xsl:for-each>
                          </eos:AdditionalAttributes>
                        </gco:Record>
                      </eos:otherProperty>
                    </xsl:if>
                  </eos:EOS_Processing>
                </mrl:processingInformation>
              </xsl:if>
            </mrl:LE_ProcessStep>
          </mrl:processStep>
        </mrl:LI_Lineage>
      </mdb:resourceLineage>
      <mdb:metadataMaintenance>
        <mmi:MD_MaintenanceInformation>
          <xsl:call-template name="writeCodelistElement">
            <xsl:with-param name="elementName" select="'mmi:maintenanceAndUpdateFrequency'"/>
            <xsl:with-param name="codeListName" select="'mmi:MD_MaintenanceFrequencyCode'"/>
            <xsl:with-param name="codeListValue" select="'irregular'"/>
          </xsl:call-template>
          <mmi:maintenanceNote>
            <gco:CharacterString>
              <xsl:value-of select="concat('Translated from ECHO using ', $translationName, ' Version: ', $translationVersion)"/>
            </gco:CharacterString>
          </mmi:maintenanceNote>
        </mmi:MD_MaintenanceInformation>
      </mdb:metadataMaintenance>
      <mdb:acquisitionInformation>
        <mac:MI_AcquisitionInformation>
          <xsl:call-template name="writeInstrument"/>
          <xsl:call-template name="writeOperation"/>
          <xsl:call-template name="writePlatform"/>
          <xsl:if test="count(//Platforms/Platform) = 0 and (//OrbitCalculatedSpatialDomains or //Spatial/OrbitParameters or //Spatial/HorizontalSpatialDomain/Orbit)">
            <!-- Write Platform Additional Attributes when no Platforms/Platform exists -->
            <mac:platform>
              <eos:EOS_Platform>
                <xsl:comment select="'Platform Additional Attributes when no platform is desined'"/>
                <mac:identifier gco:nilReason="missing"/>
                <mac:description gco:nilReason="missing"/>
                <mac:instrument gco:nilReason="missing"/>
                <eos:otherPropertyType>
                  <gco:RecordType xlink:href="http://earthdata.nasa.gov/schema/eos/additionalAttributes.xsd#xpointer(//element[@name='AdditionalAttributes'])">Echo Additional Attributes</gco:RecordType>
                </eos:otherPropertyType>
                <eos:otherProperty>
                  <gco:Record>
                    <eos:AdditionalAttributes>
                      <!-- Write platformInformation AdditionalAttributes -->
                      <xsl:for-each select="/*/AdditionalAttributes/AdditionalAttribute">
                        <xsl:if test="key('additionalAttributeLookup', Name, doc('additionalAttributeType.xml'))/@type = 'platformInformation'">
                          <xsl:call-template name="writeEOS_PSA">
                            <xsl:with-param name="additionalAttributeType" select="'platformInformation'"/>
                          </xsl:call-template>
                        </xsl:if>
                      </xsl:for-each>
                    </eos:AdditionalAttributes>
                  </gco:Record>
                </eos:otherProperty>
              </eos:EOS_Platform>
            </mac:platform>
          </xsl:if>
        </mac:MI_AcquisitionInformation>
      </mdb:acquisitionInformation>
    </mdb:MD_Metadata>
  </xsl:template>
  <!-- suppress default with this template -->
  <xsl:template match="text()"/>
  <xsl:template name="contact2Responsibility">
    <xsl:param name="roleName"/>
    <xsl:param name="roleCode"/>
    <xsl:element name="{$roleName}">
      <cit:CI_Responsibility>
        <xsl:comment select="concat('Original role:', Role)"/>
        <xsl:call-template name="writeCodelistElement">
          <xsl:with-param name="elementName" select="'cit:role'"/>
          <xsl:with-param name="codeListName" select="'cit:CI_RoleCode'"/>
          <xsl:with-param name="codeListValue" select="$roleCode"/>
        </xsl:call-template>
        <xsl:element name="cit:party">
          <xsl:choose>
            <xsl:when test="OrganizationName">
              <!-- If an organization exists, do that first -->
              <cit:CI_Organisation>
                <cit:name>
                  <xsl:call-template name="writeCharacterString">
                    <xsl:with-param name="stringToWrite" select="OrganizationName"/>
                  </xsl:call-template>
                </cit:name>
                <cit:contactInfo>
                  <cit:CI_Contact>
                    <xsl:for-each select="OrganizationPhones/Phone">
                      <cit:phone>
                        <cit:CI_Telephone>
                          <cit:number>
                            <xsl:call-template name="writeCharacterString">
                              <xsl:with-param name="stringToWrite" select="Number"/>
                            </xsl:call-template>
                          </cit:number>
                          <xsl:call-template name="writeCodelistElement">
                            <xsl:with-param name="elementName" select="'cit:numberType'"/>
                            <xsl:with-param name="codeListName" select="'cit:CI_TelephoneTypeCode'"/>
                            <xsl:with-param name="codeListValue" select="Type"/>
                          </xsl:call-template>
                        </cit:CI_Telephone>
                      </cit:phone>
                    </xsl:for-each>
                    <xsl:for-each select="OrganizationAddresses/Address">
                      <cit:address>
                        <cit:CI_Address>
                          <cit:deliveryPoint>
                            <xsl:call-template name="writeCharacterString">
                              <xsl:with-param name="stringToWrite" select="StreetAddress"/>
                            </xsl:call-template>
                          </cit:deliveryPoint>
                          <cit:city>
                            <xsl:call-template name="writeCharacterString">
                              <xsl:with-param name="stringToWrite" select="City"/>
                            </xsl:call-template>
                          </cit:city>
                          <cit:administrativeArea>
                            <xsl:call-template name="writeCharacterString">
                              <xsl:with-param name="stringToWrite" select="StateProvince"/>
                            </xsl:call-template>
                          </cit:administrativeArea>
                          <cit:postalCode>
                            <xsl:call-template name="writeCharacterString">
                              <xsl:with-param name="stringToWrite" select="PostalCode"/>
                            </xsl:call-template>
                          </cit:postalCode>
                          <cit:country>
                            <xsl:call-template name="writeCharacterString">
                              <xsl:with-param name="stringToWrite" select="Country"/>
                            </xsl:call-template>
                          </cit:country>
                          <xsl:for-each select="OrganizationEmails/Email">
                            <cit:electronicMailAddress>
                              <xsl:call-template name="writeCharacterString">
                                <xsl:with-param name="stringToWrite" select="../..//OrganizationEmails/Email[1]"/>
                              </xsl:call-template>
                            </cit:electronicMailAddress>
                          </xsl:for-each>
                        </cit:CI_Address>
                      </cit:address>
                    </xsl:for-each>
                    <cit:hoursOfService>
                      <xsl:call-template name="writeCharacterString">
                        <xsl:with-param name="stringToWrite" select="../../HoursOfService"/>
                      </xsl:call-template>
                    </cit:hoursOfService>
                    <cit:contactInstructions>
                      <xsl:call-template name="writeCharacterString">
                        <xsl:with-param name="stringToWrite" select="../../Instructions"/>
                      </xsl:call-template>
                    </cit:contactInstructions>
                  </cit:CI_Contact>
                </cit:contactInfo>
                <xsl:for-each select="ContactPersons/ContactPerson">
                  <cit:individual>
                    <cit:CI_Individual>
                      <cit:name>
                        <xsl:call-template name="writeCharacterString">
                          <xsl:with-param name="stringToWrite" select="concat(FirstName, ' ', MiddleName, ' ', LastName)"/>
                        </xsl:call-template>
                      </cit:name>
                      <cit:positionName>
                        <xsl:call-template name="writeCharacterString">
                          <xsl:with-param name="stringToWrite" select="JobPosition"/>
                        </xsl:call-template>
                      </cit:positionName>
                    </cit:CI_Individual>
                  </cit:individual>
                </xsl:for-each>
              </cit:CI_Organisation>
            </xsl:when>
            <xsl:otherwise>
              <!-- only individuals -->
            </xsl:otherwise>
          </xsl:choose>
        </xsl:element>
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
            <!--<xsl:value-of select="'anyValidURI'"/>-->
            <xsl:value-of select="$codeListValue"/>
          </xsl:attribute>
          <xsl:value-of select="$codeListValue"/>
        </xsl:element>
      </xsl:element>
    </xsl:if>
  </xsl:template>
  <xsl:template name="writeCharacterStringElement">
    <xsl:param name="elementName"/>
    <xsl:param name="stringToWrite"/>
    <xsl:choose>
      <xsl:when test="$stringToWrite">
        <xsl:element name="{$elementName}">
          <gco:CharacterString>
            <xsl:value-of select="$stringToWrite"/>
          </gco:CharacterString>
        </xsl:element>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="writeCharacteristicList">
    <xsl:choose>
      <xsl:when test="$recordType = 'SWEDataArray'">
        <xsl:call-template name="writeCharacteristicListAsSWEDataArray"/>
      </xsl:when>
      <xsl:when test="$recordType = 'NcML'">
        <xsl:call-template name="writeCharacteristicListAsNcML"/>
      </xsl:when>
      <xsl:when test="$recordType = 'JSON'">
        <xsl:call-template name="writeCharacteristicListAsJSON"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="writeCharacteristicListAsEOS_PSA"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="writeCharacteristicListAsSWEDataArray">
    <eos:otherPropertyType>
      <gco:RecordType xlink:href="http://schemas.opengis.net/sweCommon/2.0/block_components.xsd#xpointer(//element[@name='DataArray'])">SWECommon Data Array</gco:RecordType>
    </eos:otherPropertyType>
    <eos:otherProperty>
      <gco:Record>
        <swe:DataArray xmlns:swe="http://schemas.opengis.net/sweCommon/2.0/block_components.xsd">
          <swe:elementCount>
            <swe:Count>
              <swe:value>
                <xsl:value-of select="count(Characteristics/Characteristic)"/>
              </swe:value>
            </swe:Count>
          </swe:elementCount>
          <swe:DataRecord>
            <swe:field name="Name"/>
            <swe:field name="Description"/>
            <swe:field name="DataType"/>
            <swe:field name="Unit"/>
            <swe:field name="Value"/>
          </swe:DataRecord>
          <swe:encoding>
            <swe:TextBlock decimalSeparator="." tokenSeparator="," blockSeparator="&#10;"/>
          </swe:encoding>
          <swe:values>
            <xsl:for-each select="Characteristics/Characteristic">
              <xsl:text>"</xsl:text>
              <xsl:value-of select="Name"/>
              <xsl:text>"</xsl:text>
              <xsl:text>,</xsl:text>
              <xsl:text>"</xsl:text>
              <xsl:value-of select="Description"/>
              <xsl:text>"</xsl:text>
              <xsl:text>,</xsl:text>
              <xsl:text>"</xsl:text>
              <xsl:value-of select="DataType"/>
              <xsl:text>"</xsl:text>
              <xsl:text>,</xsl:text>
              <xsl:text>"</xsl:text>
              <xsl:value-of select="Unit"/>
              <xsl:text>"</xsl:text>
              <xsl:text>,</xsl:text>
              <xsl:text>"</xsl:text>
              <xsl:value-of select="Value"/>
              <xsl:text>"</xsl:text>
              <xsl:text>&#10;</xsl:text>
            </xsl:for-each>
          </swe:values>
        </swe:DataArray>
      </gco:Record>
    </eos:otherProperty>
  </xsl:template>
  <xsl:template name="writeCharacteristicListAsEOS_PSA">
    <eos:otherPropertyType>
      <gco:RecordType xlink:href="http://earthdata.nasa.gov/schema/eos/additionalAttributes.xsd#xpointer(//element[@name='AdditionalAttributes'])">Echo Additional Attributes</gco:RecordType>
    </eos:otherPropertyType>
    <eos:otherProperty>
      <gco:Record>
        <eos:AdditionalAttributes>
          <xsl:for-each select="Characteristics/Characteristic">
            <xsl:call-template name="writeEOS_PSA"/>
          </xsl:for-each>
        </eos:AdditionalAttributes>
      </gco:Record>
    </eos:otherProperty>
  </xsl:template>
  <xsl:template name="writeEOS_PSA">
    <xsl:param name="additionalAttributeType"/>
    <eos:AdditionalAttribute>
      <eos:reference>
        <eos:EOS_AdditionalAttributeDescription>
          <eos:type>
            <xsl:element name="eos:EOS_AdditionalAttributeTypeCode">
              <xsl:attribute name="codeList" select="'http://earthdata.nasa.gov/metadata/resources/Codelists.xml#EOS_AdditionalAttributeTypeCode'"/>
              <xsl:attribute name="codeListValue" select="$additionalAttributeType"/>
              <xsl:value-of select="$additionalAttributeType"/>
            </xsl:element>
          </eos:type>
          <xsl:element name="eos:name">
            <xsl:call-template name="writeCharacterString">
              <xsl:with-param name="stringToWrite" select="Name"/>
            </xsl:call-template>
          </xsl:element>
          <xsl:if test="Description">
            <eos:description>
              <gco:CharacterString>
                <xsl:value-of select="Description"/>
              </gco:CharacterString>
            </eos:description>
          </xsl:if>
          <xsl:if test="DataType">
            <eos:dataType>
              <xsl:element name="eos:EOS_AdditionalAttributeDataTypeCode">
                <xsl:attribute name="codeList" select="'http://earthdata.nasa.gov/metadata/resources/Codelists.xml#EOS_AdditionalAttributeDataTypeCode'"/>
                <xsl:attribute name="codeListValue" select="encode-for-uri(DataType)"/>
                <xsl:value-of select="DataType"/>
              </xsl:element>
            </eos:dataType>
          </xsl:if>
          <xsl:if test="MeasurementResolution">
            <eos:measurementResolution>
              <gco:CharacterString>
                <xsl:value-of select="MeasurementResolution"/>
              </gco:CharacterString>
            </eos:measurementResolution>
          </xsl:if>
          <xsl:if test="ParameterRangeBegin">
            <eos:parameterRangeBegin>
              <gco:CharacterString>
                <xsl:value-of select="ParameterRangeBegin"/>
              </gco:CharacterString>
            </eos:parameterRangeBegin>
          </xsl:if>
          <xsl:if test="ParameterRangeEnd">
            <eos:parameterRangeEnd>
              <gco:CharacterString>
                <xsl:value-of select="ParameterRangeEnd"/>
              </gco:CharacterString>
            </eos:parameterRangeEnd>
          </xsl:if>
          <xsl:if test="ParameterUnitsOfMeasure | Unit">
            <eos:parameterUnitsOfMeasure>
              <gco:CharacterString>
                <xsl:value-of select="ParameterUnitsOfMeasure | Unit"/>
              </gco:CharacterString>
            </eos:parameterUnitsOfMeasure>
          </xsl:if>
          <xsl:if test="ParameterValueAccuracy">
            <eos:parameterValueAccuracy>
              <gco:CharacterString>
                <xsl:value-of select="ParameterValueAccuracy"/>
              </gco:CharacterString>
            </eos:parameterValueAccuracy>
          </xsl:if>
          <xsl:if test="ValueAccuracyExplanation">
            <eos:valueAccuracyExplanation>
              <gco:CharacterString>
                <xsl:value-of select="ValueAccuracyExplanation"/>
              </gco:CharacterString>
            </eos:valueAccuracyExplanation>
          </xsl:if>
        </eos:EOS_AdditionalAttributeDescription>
      </eos:reference>
      <xsl:for-each select="Value | Values/Value">
        <xsl:element name="eos:value">
          <gco:CharacterString>
            <xsl:value-of select="."/>
          </gco:CharacterString>
        </xsl:element>
      </xsl:for-each>
    </eos:AdditionalAttribute>
  </xsl:template>
  <xsl:template name="writeCharacteristicListAsJSON">
    <eos:otherPropertyType>
      <gco:RecordType xlink:href="http://json.org">JSON Description</gco:RecordType>
    </eos:otherPropertyType>
    <eos:otherProperty>
      <gco:Record>
        <gco:CharacterString>
          <xsl:text>{"characteristics":[&#10;</xsl:text>
          <xsl:for-each select="Characteristics/Characteristic">
            <xsl:if test="position() != 1">
              <xsl:text>,&#10;</xsl:text>
            </xsl:if>
            <xsl:text>{</xsl:text>
            <xsl:call-template name="writeJsonItem">
              <xsl:with-param name="id" select="'Name'"/>
              <xsl:with-param name="value" select="Name"/>
            </xsl:call-template>
            <xsl:text>,&#10;</xsl:text>
            <xsl:call-template name="writeJsonItem">
              <xsl:with-param name="id" select="'Description'"/>
              <xsl:with-param name="value" select="Description"/>
            </xsl:call-template>
            <xsl:text>,&#10;</xsl:text>
            <xsl:call-template name="writeJsonItem">
              <xsl:with-param name="id" select="'DataType'"/>
              <xsl:with-param name="value" select="DataType"/>
            </xsl:call-template>
            <xsl:text>,&#10;</xsl:text>
            <xsl:call-template name="writeJsonItem">
              <xsl:with-param name="id" select="'Unit'"/>
              <xsl:with-param name="value" select="Unit"/>
            </xsl:call-template>
            <xsl:text>,&#10;</xsl:text>
            <xsl:call-template name="writeJsonItem">
              <xsl:with-param name="id" select="'Value'"/>
              <xsl:with-param name="value" select="Value"/>
            </xsl:call-template>
            <xsl:text>}&#10;</xsl:text>
          </xsl:for-each>
          <xsl:text>]&#10;}</xsl:text>
        </gco:CharacterString>
      </gco:Record>
    </eos:otherProperty>
  </xsl:template>
  <xsl:template name="writeJsonItem">
    <xsl:param name="id"/>
    <xsl:param name="value"/>
    <xsl:value-of select="concat('&quot;', $id, '&quot;:&quot;', $value, '&quot;')"/>
  </xsl:template>
  <xsl:template name="writeCharacteristicListAsNcML">
    <eos:otherPropertyType>
      <gco:RecordType xlink:href="http://www.unidata.ucar.edu/schemas/netcdf/ncml-2.2.xsd#xpointer(//element[@name='group'])">netCDF Group Type</gco:RecordType>
    </eos:otherPropertyType>
    <eos:otherProperty>
      <gco:Record xmlns:nc="http://www.unidata.ucar.edu/schemas/netcdf">
        <xsl:element name="nc:group">
          <xsl:attribute name="name">additional_attributes</xsl:attribute>
          <xsl:for-each select="Characteristics/Characteristic">
            <xsl:element name="nc:variable">
              <xsl:attribute name="name">
                <xsl:value-of select="Name"/>
              </xsl:attribute>
              <xsl:call-template name="writeNcMLItem">
                <xsl:with-param name="id" select="'Description'"/>
                <xsl:with-param name="value" select="Description"/>
              </xsl:call-template>
              <xsl:call-template name="writeNcMLItem">
                <xsl:with-param name="id" select="'DataType'"/>
                <xsl:with-param name="value" select="DataType"/>
              </xsl:call-template>
              <xsl:call-template name="writeNcMLItem">
                <xsl:with-param name="id" select="'Unit'"/>
                <xsl:with-param name="value" select="Unit"/>
              </xsl:call-template>
              <xsl:call-template name="writeNcMLItem">
                <xsl:with-param name="id" select="'Value'"/>
                <xsl:with-param name="value" select="Value"/>
              </xsl:call-template>
            </xsl:element>
          </xsl:for-each>
        </xsl:element>
      </gco:Record>
    </eos:otherProperty>
  </xsl:template>
  <xsl:template name="writeNcMLItem">
    <xsl:param name="id"/>
    <xsl:param name="value"/>
    <xsl:element name="nc:attribute" namespace="www">
      <xsl:attribute name="name">
        <xsl:value-of select="$id"/>
      </xsl:attribute>
      <xsl:attribute name="value">
        <xsl:value-of select="$value"/>
      </xsl:attribute>
    </xsl:element>
  </xsl:template>
  <xsl:template name="ECHOExtentToISO">
    <mri:extent>
      <xsl:choose>
        <xsl:when test="contains(/*/Spatial, 'NO_SPATIAL') and count(/Collection/Temporal) = 0">
          <!-- No spatial or temporal information in source metadata -->
          <xsl:attribute name="gco:nilReason" select="'missing'"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:element name="gex:EX_Extent">
            <xsl:choose>
              <!-- No spatial contant -->
              <xsl:when test="contains(/*/Spatial, 'NO_SPATIAL')"/>
              <xsl:otherwise>
                <!-- spatial content exists -->
                <xsl:call-template name="writeExtentDescription"/>
                <xsl:call-template name="writeExtentBoundingBox"/>
                <xsl:choose>
                  <!-- Test for non-numeric value in VerticalSpatialDomain (works because NaN != NaN) -->
                  <xsl:when test="//VerticalSpatialDomain[number(Value) != number(Value)]">
                    <gex:geographicElement>
                      <gex:EX_GeographicDescription>
                        <gex:geographicIdentifier>
                          <mcc:MD_Identifier>
                            <mcc:code>
                              <gco:CharacterString>Atmosphere Layer</gco:CharacterString>
                            </mcc:code>
                            <mcc:description>
                              <gco:CharacterString>
                                <xsl:value-of select="concat(//VerticalSpatialDomain[Type = 'Minimum Altitude']/Value, ' to ', //VerticalSpatialDomain[Type = 'Maximum Altitude']/Value)"/>
                              </gco:CharacterString>
                            </mcc:description>
                          </mcc:MD_Identifier>
                        </gex:geographicIdentifier>
                      </gex:EX_GeographicDescription>
                    </gex:geographicElement>
                  </xsl:when>
                  <xsl:when test="/*/Spatial/SpatialCoverageType = 'Orbit' or /*/Spatial/GranuleSpatialRepresentation = 'ORBIT'">
                    <gex:geographicElement>
                      <gex:EX_GeographicDescription>
                        <gex:geographicIdentifier>
                          <mcc:MD_Identifier>
                            <mcc:code>
                              <gco:CharacterString>Orbit</gco:CharacterString>
                            </mcc:code>
                            <mcc:description>
                              <gco:CharacterString>
                                <xsl:for-each select="/Collection/Spatial/OrbitParameters/*">
                                  <xsl:if test="position() > 1">
                                    <xsl:text> </xsl:text>
                                  </xsl:if>
                                  <xsl:value-of select="concat(local-name(.), ': ', .)"/>
                                </xsl:for-each>
                              </gco:CharacterString>
                            </mcc:description>
                          </mcc:MD_Identifier>
                        </gex:geographicIdentifier>
                      </gex:EX_GeographicDescription>
                    </gex:geographicElement>
                  </xsl:when>
                </xsl:choose>
              </xsl:otherwise>
            </xsl:choose>
            <!-- Check for center points -->
            <xsl:for-each select="/*/Spatial/HorizontalSpatialDomain/Geometry/*/CenterPoint">
              <gex:geographicElement>
                <xsl:comment select="'CenterPoint'"/>
                <xsl:variable name="centerPointId" select="concat('centerPoint_', position())"/>
                <gex:EX_BoundingPolygon>
                  <xsl:attribute name="id" select="$centerPointId"/>
                  <gex:polygon>
                    <gml:Point>
                      <xsl:attribute name="gml:id" select="generate-id()"/>
                      <gml:pos>
                        <xsl:attribute name="srsName" select="'http://www.opengis.net/def/crs/EPSG/4326'"/>
                        <xsl:attribute name="srsDimension" select="'2'"/>
                        <xsl:value-of select="concat(PointLatitude, ' ', PointLongitude)"/>
                      </gml:pos>
                    </gml:Point>
                  </gex:polygon>
                </gex:EX_BoundingPolygon>
              </gex:geographicElement>
            </xsl:for-each>
            <!-- Check for spatial information in AdditionalAttributes -->
            <xsl:call-template name="writeGeographicIdentifiers"/>
            <xsl:call-template name="writeExtentTemporalInformation"/>
            <xsl:if test="
                count(//VerticalSpatialDomain[number(Value) = number(Value)]) > 0 or
                /*/SpatialInfo/VerticalCoordinateSystem/AltitudeSystemDefinition/DatumName">
              <!-- If minimum and maximum altitudes are numeric, write verticalElement -->
              <gex:verticalElement>
                <gex:EX_VerticalExtent>
                  <gex:minimumValue>
                    <gco:Real>
                      <xsl:value-of select="//VerticalSpatialDomain[Type = 'Minimum Altitude']/Value"/>
                    </gco:Real>
                  </gex:minimumValue>
                  <gex:maximumValue>
                    <gco:Real>
                      <xsl:value-of select="//VerticalSpatialDomain[Type = 'Maximum Altitude']/Value"/>
                    </gco:Real>
                  </gex:maximumValue>
                  <xsl:if test="/*/SpatialInfo/VerticalCoordinateSystem/AltitudeSystemDefinition/DatumName">
                    <xsl:choose>
                      <xsl:when test="/*/SpatialInfo/VerticalCoordinateSystem/AltitudeSystemDefinition/DatumName = 'Not Applicable'">
                        <gex:verticalCRS gco:nilReason="inapplicable"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <gex:verticalCRS>
                          <gml:VerticalCRS>
                            <xsl:attribute name="gml:id" select="generate-id()"/>
                            <gml:identifier codeSpace="gov.nasa.esdis">missing</gml:identifier>
                            <gml:scope/>
                            <gml:verticalCS/>
                            <gml:verticalDatum>
                              <gml:VerticalDatum>
                                <xsl:attribute name="gml:id" select="generate-id()"/>
                                <gml:identifier codeSpace="gov.nasa.esdis">
                                  <xsl:value-of select="/*/SpatialInfo/VerticalCoordinateSystem/AltitudeSystemDefinition/DatumName"/>
                                </gml:identifier>
                                <gml:scope/>
                              </gml:VerticalDatum>
                            </gml:verticalDatum>
                          </gml:VerticalCRS>
                        </gex:verticalCRS>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:if>
                </gex:EX_VerticalExtent>
              </gex:verticalElement>
            </xsl:if>
          </xsl:element>
        </xsl:otherwise>
      </xsl:choose>
    </mri:extent>
  </xsl:template>
  <xsl:template name="writeExtentDescription">
    <gex:description>
      <xsl:choose>
        <!-- The extent description is a catch-all for a variety of textual spatial elements -->
        <xsl:when test="
            /*/Spatial/SpatialCoverageType | /*/SpatialInfo/SpatialCoverageType
            | /*/Spatial/GranuleSpatialRepresentation | /*/Temporal/TemporalRangeType
            | /*/Temporal/TimeType | /*/Spatial/VerticalSpatialDomains/VerticalSpatialDomain">
          <xsl:variable name="extentDescription" as="xs:string+">
            <xsl:for-each select="/*/Spatial/SpatialCoverageType">
              <xsl:sequence select="concat('SpatialCoverageType=', .)"/>
            </xsl:for-each>
            <xsl:for-each select="/*/SpatialInfo/SpatialCoverageType">
              <xsl:sequence select="concat('SpatialInfoCoverageType=', .)"/>
            </xsl:for-each>
            <xsl:for-each select="/*/Spatial/GranuleSpatialRepresentation">
              <xsl:sequence select="concat('SpatialGranuleSpatialRepresentation=', .)"/>
            </xsl:for-each>
            <xsl:for-each select="/*/Temporal/TemporalRangeType">
              <xsl:sequence select="concat('Temporal Range Type=', .)"/>
            </xsl:for-each>
            <xsl:for-each select="/*/Temporal/TimeType">
              <xsl:sequence select="concat('Time Type=', .)"/>
            </xsl:for-each>
            <xsl:for-each select="/*/Spatial/VerticalSpatialDomains/VerticalSpatialDomain">
              <xsl:sequence select="concat('VerticalSpatialDomainType=', Type)"/>
              <xsl:sequence select="concat('VerticalSpatialDomainValue=', Value)"/>
            </xsl:for-each>
          </xsl:variable>
          <gco:CharacterString>
            <xsl:value-of select="$extentDescription" separator=", "/>
          </gco:CharacterString>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="gco:nilReason" select="'unknown'"/>
        </xsl:otherwise>
      </xsl:choose>
    </gex:description>
  </xsl:template>
  <xsl:template name="writeExtentBoundingBox">
    <xsl:for-each select="/*/Spatial/HorizontalSpatialDomain/Geometry/Point">
      <gex:geographicElement>
        <xsl:comment select="'Point Bounds'"/>
        <gex:EX_GeographicBoundingBox>
          <gex:westBoundLongitude>
            <gco:Decimal>
              <xsl:value-of select="PointLongitude"/>
            </gco:Decimal>
          </gex:westBoundLongitude>
          <gex:eastBoundLongitude>
            <gco:Decimal>
              <xsl:value-of select="PointLongitude"/>
            </gco:Decimal>
          </gex:eastBoundLongitude>
          <gex:southBoundLatitude>
            <gco:Decimal>
              <xsl:value-of select="PointLatitude"/>
            </gco:Decimal>
          </gex:southBoundLatitude>
          <gex:northBoundLatitude>
            <gco:Decimal>
              <xsl:value-of select="PointLatitude"/>
            </gco:Decimal>
          </gex:northBoundLatitude>
        </gex:EX_GeographicBoundingBox>
      </gex:geographicElement>
      <gex:geographicElement>
        <xsl:comment select="'Point'"/>
        <gex:EX_BoundingPolygon>
          <gex:polygon>
            <gml:Point>
              <xsl:attribute name="gml:id" select="generate-id()"/>
              <gml:pos>
                <xsl:attribute name="srsName" select="'http://www.opengis.net/def/crs/EPSG/4326'"/>
                <xsl:attribute name="srsDimension" select="'2'"/>
                <xsl:value-of select="concat(PointLatitude, ' ', PointLongitude)"/>
              </gml:pos>
            </gml:Point>
          </gex:polygon>
        </gex:EX_BoundingPolygon>
      </gex:geographicElement>
    </xsl:for-each>
    <xsl:for-each select="/*/Spatial/HorizontalSpatialDomain/Geometry/Line">
      <gex:geographicElement>
        <xsl:comment>Line Bounds</xsl:comment>
        <gex:EX_GeographicBoundingBox>
          <gex:westBoundLongitude>
            <gco:Decimal>
              <xsl:value-of select="min(Point/PointLongitude)"/>
            </gco:Decimal>
          </gex:westBoundLongitude>
          <gex:eastBoundLongitude>
            <gco:Decimal>
              <xsl:value-of select="max(Point/PointLongitude)"/>
            </gco:Decimal>
          </gex:eastBoundLongitude>
          <gex:southBoundLatitude>
            <gco:Decimal>
              <xsl:value-of select="min(Point/PointLatitude)"/>
            </gco:Decimal>
          </gex:southBoundLatitude>
          <gex:northBoundLatitude>
            <gco:Decimal>
              <xsl:value-of select="max(Point/PointLatitude)"/>
            </gco:Decimal>
          </gex:northBoundLatitude>
        </gex:EX_GeographicBoundingBox>
      </gex:geographicElement>
      <gex:geographicElement>
        <xsl:comment select="'Line'"/>
        <gex:EX_BoundingPolygon>
          <gex:polygon>
            <gml:LineString>
              <xsl:attribute name="gml:id" select="generate-id()"/>
              <gml:posList>
                <xsl:attribute name="srsName" select="'http://www.opengis.net/def/crs/EPSG/4326'"/>
                <xsl:attribute name="srsDimension" select="'2'"/>
                <xsl:for-each select="Point">
                  <xsl:value-of select="concat(PointLatitude, ' ', PointLongitude)"/>
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
    <xsl:for-each select="/*/Spatial/HorizontalSpatialDomain/Geometry/GPolygon">
      <xsl:for-each select="Boundary">
        <gex:geographicElement>
          <xsl:comment select="'Polygon Bounds'"/>
          <gex:EX_GeographicBoundingBox>
            <gex:westBoundLongitude>
              <gco:Decimal>
                <xsl:value-of select="min(Point/PointLongitude)"/>
              </gco:Decimal>
            </gex:westBoundLongitude>
            <gex:eastBoundLongitude>
              <gco:Decimal>
                <xsl:value-of select="max(Point/PointLongitude)"/>
              </gco:Decimal>
            </gex:eastBoundLongitude>
            <gex:southBoundLatitude>
              <gco:Decimal>
                <xsl:value-of select="min(Point/PointLatitude)"/>
              </gco:Decimal>
            </gex:southBoundLatitude>
            <gex:northBoundLatitude>
              <gco:Decimal>
                <xsl:value-of select="max(Point/PointLatitude)"/>
              </gco:Decimal>
            </gex:northBoundLatitude>
          </gex:EX_GeographicBoundingBox>
        </gex:geographicElement>
      </xsl:for-each>
      <gex:geographicElement>
        <xsl:comment select="'Polygon'"/>
        <gex:EX_BoundingPolygon>
          <gex:polygon>
            <gml:Polygon>
              <xsl:attribute name="gml:id" select="generate-id()"/>
              <xsl:for-each select="Boundary">
                <xsl:element name="gml:exterior">
                  <gml:LinearRing>
                    <gml:posList>
                      <xsl:attribute name="srsName" select="'http://www.opengis.net/def/crs/EPSG/4326'"/>
                      <xsl:attribute name="srsDimension" select="'2'"/>
                      <xsl:for-each select="Point | Boundary/Point">
                        <xsl:value-of select="concat(PointLatitude, ' ', PointLongitude)"/>
                        <xsl:if test="position() != last()">
                          <xsl:text> </xsl:text>
                        </xsl:if>
                      </xsl:for-each>
                      <!-- The last point should repeat the first -->
                      <xsl:value-of select="concat(' ', Point[1]/PointLatitude | Boundary/Point[1]/PointLatitude, ' ', Point[1]/PointLongitude | Boundary/Point[1]/PointLongitude)"/>
                    </gml:posList>
                  </gml:LinearRing>
                </xsl:element>
              </xsl:for-each>
              <xsl:for-each select="ExclusiveZone">
                <xsl:element name="gml:interior">
                  <gml:LinearRing>
                    <gml:posList>
                      <xsl:attribute name="srsName" select="'http://www.opengis.net/def/crs/EPSG/4326'"/>
                      <xsl:attribute name="srsDimension" select="'2'"/>
                      <xsl:for-each select="Point | Boundary/Point">
                        <xsl:value-of select="concat(PointLatitude, ' ', PointLongitude)"/>
                        <xsl:if test="position() != last()">
                          <xsl:text> </xsl:text>
                        </xsl:if>
                      </xsl:for-each>
                      <!-- The last point should repeat the first -->
                      <xsl:value-of select="concat(' ', Point[1]/PointLatitude | Boundary/Point[1]/PointLatitude, ' ', Point[1]/PointLongitude | Boundary/Point[1]/PointLongitude)"/>
                    </gml:posList>
                  </gml:LinearRing>
                </xsl:element>
              </xsl:for-each>
            </gml:Polygon>
          </gex:polygon>
        </gex:EX_BoundingPolygon>
      </gex:geographicElement>
    </xsl:for-each>
    <xsl:for-each select="/*/Spatial/HorizontalSpatialDomain/Geometry/BoundingRectangle">
      <gex:geographicElement>
        <xsl:comment select="'Bounding Rectangle'"/>
        <gex:EX_GeographicBoundingBox>
          <gex:westBoundLongitude>
            <gco:Decimal>
              <xsl:value-of select="WestBoundingCoordinate"/>
            </gco:Decimal>
          </gex:westBoundLongitude>
          <gex:eastBoundLongitude>
            <gco:Decimal>
              <xsl:value-of select="EastBoundingCoordinate"/>
            </gco:Decimal>
          </gex:eastBoundLongitude>
          <gex:southBoundLatitude>
            <gco:Decimal>
              <xsl:value-of select="SouthBoundingCoordinate"/>
            </gco:Decimal>
          </gex:southBoundLatitude>
          <gex:northBoundLatitude>
            <gco:Decimal>
              <xsl:value-of select="NorthBoundingCoordinate"/>
            </gco:Decimal>
          </gex:northBoundLatitude>
        </gex:EX_GeographicBoundingBox>
      </gex:geographicElement>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="writeGeographicIdentifiers">
    <xsl:if test="$geographicIdentifierCount > 0">
      <xsl:for-each select="/*/AdditionalAttributes/AdditionalAttribute">
        <xsl:if test="key('additionalAttributeLookup', Name, doc('additionalAttributeType.xml'))/@type = 'geographicIdentifier'">
          <xsl:choose>
            <!-- Translating an additiuonalAttribute to a geographic Identifier:
                 if Values/Value or Value exists - that becomes the code
                 if no value exists and there is a parameter range, the parameter range is written as the code (Strat - End)
                 if no value exists and no parameter range - the code is empty
            -->
            <xsl:when test="Values/Value | Value">
              <xsl:for-each select="Values/Value | Value">
                <gex:geographicElement>
                  <xsl:comment select="'Additional Attribute Identifier'"/>
                  <gex:EX_GeographicDescription>
                    <gex:geographicIdentifier>
                      <mcc:MD_Identifier>
                        <mcc:code>
                          <gco:CharacterString>
                            <xsl:value-of select="."/>
                          </gco:CharacterString>
                        </mcc:code>
                        <mcc:codeSpace>
                          <xsl:call-template name="writeCharacterString">
                            <xsl:with-param name="stringToWrite" select="'gov.nasa.echo'"/>
                          </xsl:call-template>
                        </mcc:codeSpace>
                        <mcc:description>
                          <gco:CharacterString>
                            <xsl:value-of select="../../Name | ../Name"/>
                            <xsl:if test="../../Description | ../Description">
                              <xsl:value-of select="concat(' - ', ../../Description | ../Description)"/>
                            </xsl:if>
                          </gco:CharacterString>
                        </mcc:description>
                      </mcc:MD_Identifier>
                    </gex:geographicIdentifier>
                  </gex:EX_GeographicDescription>
                </gex:geographicElement>
              </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
              <!-- No value exists -->
              <gex:geographicElement>
                <gex:EX_GeographicDescription>
                  <gex:geographicIdentifier>
                    <mcc:MD_Identifier>
                      <xsl:choose>
                        <xsl:when test="count(ParameterRangeBegin | ParameterRangeEnd) = 2">
                          <!-- Parameter Range exists -->
                          <mcc:code>
                            <gco:CharacterString>
                              <xsl:value-of select="concat(ParameterRangeBegin, ' - ', ParameterRangeEnd)"/>
                            </gco:CharacterString>
                          </mcc:code>
                          <mcc:codeSpace>
                            <xsl:call-template name="writeCharacterString">
                              <xsl:with-param name="stringToWrite" select="'gov.nasa.echo'"/>
                            </xsl:call-template>
                          </mcc:codeSpace>
                        </xsl:when>
                        <xsl:otherwise>
                          <!-- No value or parameter range exists -->
                          <mcc:code gco:nilReason="missing"/>
                        </xsl:otherwise>
                      </xsl:choose>
                      <mcc:description>
                        <gco:CharacterString>
                          <xsl:value-of select="concat(Name, ' - ', Description)"/>
                        </gco:CharacterString>
                      </mcc:description>
                    </mcc:MD_Identifier>
                  </gex:geographicIdentifier>
                </gex:EX_GeographicDescription>
              </gex:geographicElement>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>
      </xsl:for-each>
    </xsl:if>
    <xsl:if test="/*/Spatial/HorizontalSpatialDomain/ZoneIdentifier">
      <gex:geographicElement>
        <gex:EX_GeographicDescription>
          <gex:geographicIdentifier>
            <mcc:MD_Identifier>
              <mcc:code>
                <gco:CharacterString>
                  <xsl:value-of select="/*/Spatial/HorizontalSpatialDomain/ZoneIdentifier"/>
                </gco:CharacterString>
              </mcc:code>
              <mcc:description>
                <gco:CharacterString>ZoneIdentifier</gco:CharacterString>
              </mcc:description>
            </mcc:MD_Identifier>
          </gex:geographicIdentifier>
        </gex:EX_GeographicDescription>
      </gex:geographicElement>
    </xsl:if>
    <xsl:for-each select="//TwoDCoordinateSystem">
      <xsl:call-template name="writeTilesAsIdentifier"/>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="writeTilesAsIdentifier">
    <xsl:choose>
      <xsl:when test="TwoDCoordinateSystemName = 'CALIPSO'">
        <gex:geographicElement>
          <gex:EX_GeographicDescription>
            <gex:geographicIdentifier>
              <mcc:MD_Identifier>
                <mcc:code>
                  <gco:CharacterString>
                    <xsl:value-of select="concat('o', StartCoordinate1 | Coordinate1/MinimumValue)"/>
                    <xsl:if test="EndCoordinate1 | Coordinate1/MaximumValue">
                      <xsl:value-of select="concat(',', EndCoordinate1 | Coordinate1/MaximumValue)"/>
                    </xsl:if>
                    <xsl:value-of select="concat('p', StartCoordinate2 | Coordinate2/MinimumValue)"/>
                    <xsl:if test="EndCoordinate2 | Coordinate2/MaximumValue">
                      <xsl:value-of select="concat(',', EndCoordinate2 | Coordinate2/MaximumValue)"/>
                    </xsl:if>
                  </gco:CharacterString>
                </mcc:code>
                <mcc:description>
                  <gco:CharacterString>CALIPSO</gco:CharacterString>
                </mcc:description>
              </mcc:MD_Identifier>
            </gex:geographicIdentifier>
          </gex:EX_GeographicDescription>
        </gex:geographicElement>
      </xsl:when>
      <xsl:when test="TwoDCoordinateSystemName = 'MISR'">
        <gex:geographicElement>
          <gex:EX_GeographicDescription>
            <gex:geographicIdentifier>
              <mcc:MD_Identifier>
                <mcc:code>
                  <gco:CharacterString>
                    <xsl:value-of select="concat('p', StartCoordinate1 | Coordinate1/MinimumValue)"/>
                    <xsl:if test="EndCoordinate1 | Coordinate1/MaximumValue">
                      <xsl:value-of select="concat('-', EndCoordinate1 | Coordinate1/MaximumValue)"/>
                    </xsl:if>
                    <xsl:value-of select="concat('b', StartCoordinate2 | Coordinate2/MinimumValue)"/>
                    <xsl:if test="EndCoordinate2 | Coordinate2/MaximumValue">
                      <xsl:value-of select="concat('-', EndCoordinate2 | Coordinate2/MaximumValue)"/>
                    </xsl:if>
                  </gco:CharacterString>
                </mcc:code>
                <mcc:description>
                  <gco:CharacterString>MISR</gco:CharacterString>
                </mcc:description>
              </mcc:MD_Identifier>
            </gex:geographicIdentifier>
          </gex:EX_GeographicDescription>
        </gex:geographicElement>
      </xsl:when>
      <xsl:when test="contains(TwoDCoordinateSystemName, 'MODIS')">
        <gex:geographicElement>
          <gex:EX_GeographicDescription>
            <gex:geographicIdentifier>
              <mcc:MD_Identifier>
                <mcc:code>
                  <gco:CharacterString>
                    <xsl:value-of select="concat('h', StartCoordinate1 | Coordinate1/MinimumValue)"/>
                    <xsl:if test="EndCoordinate1 | Coordinate1/MaximumValue">
                      <xsl:value-of select="concat('-', EndCoordinate1 | Coordinate1/MaximumValue)"/>
                    </xsl:if>
                    <xsl:value-of select="concat('v', StartCoordinate2 | Coordinate2/MinimumValue)"/>
                    <xsl:if test="EndCoordinate2 | Coordinate2/MaximumValue">
                      <xsl:value-of select="concat('-', EndCoordinate2 | Coordinate2/MaximumValue)"/>
                    </xsl:if>
                  </gco:CharacterString>
                </mcc:code>
                <mcc:description>
                  <gco:CharacterString>
                    <xsl:value-of select="TwoDCoordinateSystemName"/>
                  </gco:CharacterString>
                </mcc:description>
              </mcc:MD_Identifier>
            </gex:geographicIdentifier>
          </gex:EX_GeographicDescription>
        </gex:geographicElement>
      </xsl:when>
      <xsl:when test="contains(TwoDCoordinateSystemName, 'WRS')">
        <gex:geographicElement>
          <gex:EX_GeographicDescription>
            <gex:geographicIdentifier>
              <mcc:MD_Identifier>
                <mcc:code>
                  <gco:CharacterString>
                    <xsl:value-of select="concat('p', StartCoordinate1 | Coordinate1/MinimumValue)"/>
                    <xsl:if test="EndCoordinate1 | Coordinate1/MaximumValue">
                      <xsl:value-of select="concat('-', EndCoordinate1 | Coordinate1/MaximumValue)"/>
                    </xsl:if>
                    <xsl:value-of select="concat('r', StartCoordinate2 | Coordinate2/MinimumValue)"/>
                    <xsl:if test="EndCoordinate2 | Coordinate2/MaximumValue">
                      <xsl:value-of select="concat('-', EndCoordinate2 | Coordinate2/MaximumValue)"/>
                    </xsl:if>
                  </gco:CharacterString>
                </mcc:code>
                <mcc:description>
                  <gco:CharacterString>
                    <xsl:value-of select="TwoDCoordinateSystemName"/>
                  </gco:CharacterString>
                </mcc:description>
              </mcc:MD_Identifier>
            </gex:geographicIdentifier>
          </gex:EX_GeographicDescription>
        </gex:geographicElement>
      </xsl:when>
      <xsl:otherwise>
        <gex:geographicElement>
          <gex:EX_GeographicDescription>
            <gex:geographicIdentifier>
              <mcc:MD_Identifier>
                <mcc:code>
                  <gco:CharacterString>
                    <xsl:value-of select="concat('x', StartCoordinate1 | Coordinate1/MinimumValue)"/>
                    <xsl:if test="EndCoordinate1 | Coordinate1/MaximumValue">
                      <xsl:value-of select="concat('-', EndCoordinate1 | Coordinate1/MaximumValue)"/>
                    </xsl:if>
                    <xsl:value-of select="concat('y', StartCoordinate2 | Coordinate2/MinimumValue)"/>
                    <xsl:if test="EndCoordinate2 | Coordinate2/MaximumValue">
                      <xsl:value-of select="concat('-', EndCoordinate2 | Coordinate2/MaximumValue)"/>
                    </xsl:if>
                  </gco:CharacterString>
                </mcc:code>
                <mcc:description>
                  <gco:CharacterString>
                    <xsl:value-of select="'Unknown Tiling System'"/>
                  </gco:CharacterString>
                </mcc:description>
              </mcc:MD_Identifier>
            </gex:geographicIdentifier>
          </gex:EX_GeographicDescription>
        </gex:geographicElement>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="writeExtentTemporalInformation">
    <xsl:choose>
      <xsl:when test="/*/Temporal/SingleDateTime">
        <gex:temporalElement>
          <gex:EX_TemporalExtent>
            <xsl:attribute name="id" select="'boundingTemporalExtent'"/>
            <gex:extent>
              <gml:TimePeriod>
                <xsl:attribute name="gml:id" select="generate-id()"/>
                <gml:beginPosition>
                  <xsl:value-of select="/*/Temporal/SingleDateTime"/>
                </gml:beginPosition>
                <gml:endPosition>
                  <xsl:if test="/*/Temporal/EndsAtPresentFlag = 'true'">
                    <xsl:attribute name="indeterminatePosition">now</xsl:attribute>
                  </xsl:if>
                </gml:endPosition>
              </gml:TimePeriod>
            </gex:extent>
          </gex:EX_TemporalExtent>
        </gex:temporalElement>
      </xsl:when>
      <xsl:otherwise>
        <xsl:for-each select="/*/Temporal/RangeDateTime">
          <gex:temporalElement>
            <gex:EX_TemporalExtent>
              <xsl:if test="position() = 1">
                <xsl:attribute name="id" select="'boundingTemporalExtent'"/>
              </xsl:if>
              <gex:extent>
                <gml:TimePeriod>
                  <xsl:attribute name="gml:id" select="generate-id()"/>
                  <gml:beginPosition>
                    <xsl:value-of select="BeginningDateTime"/>
                  </gml:beginPosition>
                  <gml:endPosition>
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
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="writeOperation">
    <xsl:for-each select="/*/Campaigns/Campaign">
      <mac:operation>
        <mac:MI_Operation>
          <mac:description>
            <xsl:call-template name="writeCharacterString">
              <xsl:with-param name="stringToWrite">
                <xsl:value-of select="ShortName"/>
                <xsl:if test="LongName">
                  <xsl:value-of select="concat(' &gt; ', LongName)"/>
                </xsl:if>
                <xsl:if test="StartDate">
                  <xsl:value-of select="concat(' ', StartDate)"/>
                </xsl:if>
                <xsl:if test="EndDate">
                  <xsl:value-of select="concat(' to ', EndDate)"/>
                </xsl:if>
              </xsl:with-param>
            </xsl:call-template>
          </mac:description>
          <mac:identifier>
            <mcc:MD_Identifier>
              <mcc:code>
                <xsl:call-template name="writeCharacterString">
                  <xsl:with-param name="stringToWrite" select="ShortName"/>
                </xsl:call-template>
              </mcc:code>
            </mcc:MD_Identifier>
          </mac:identifier>
          <mac:status gco:nilReason="unknown"/>
          <mac:parentOperation gco:nilReason="inapplicable"/>
        </mac:MI_Operation>
      </mac:operation>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="writePlatform">
    <xsl:for-each select="/*/Platforms/Platform[ShortName != 'N/A']">
      <mac:platform>
        <xsl:variable name="platformObjectName">
          <!-- 
            eos:EOS_Platform must be used when any of the extension criteria exist for any instrument
            or sensor, but we want to avoid using it if it is not needed.
          -->
          <xsl:choose>
            <xsl:when test="
                $platformCharacteristicCount + $platformInformationCount
                + $instrumentCharacteristicCount + $instrumentInformationCount
                + $sensorCharacteristicCount + $sensorInformationCount
                + count(//Sensors/Sensor) + count(//Instrument/OperationModes/OperationMode)">
              <!-- Extension is needed use eos:EOS_Platform -->
              <xsl:value-of select="'eos:EOS_Platform'"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="'mac:MI_Platform'"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:element name="{$platformObjectName}">
          <xsl:attribute name="id" select="generate-id()"/>
          <mac:identifier>
            <mcc:MD_Identifier>
              <mcc:code>
                <xsl:call-template name="writeCharacterString">
                  <xsl:with-param name="stringToWrite" select="ShortName"/>
                </xsl:call-template>
              </mcc:code>
              <mcc:description>
                <xsl:call-template name="writeCharacterString">
                  <xsl:with-param name="stringToWrite" select="LongName"/>
                </xsl:call-template>
              </mcc:description>
            </mcc:MD_Identifier>
          </mac:identifier>
          <mac:description>
            <xsl:call-template name="writeCharacterString">
              <xsl:with-param name="stringToWrite" select="Type"/>
            </xsl:call-template>
          </mac:description>
          <xsl:choose>
            <xsl:when test="count(Instruments/Instrument) > 0">
              <xsl:for-each select="Instruments/Instrument">
                <mac:instrument>
                  <xsl:attribute name="xlink:href" select="concat('#', generate-id())"/>
                </mac:instrument>
              </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
              <xsl:element name="mac:instrument">
                <xsl:attribute name="gco:nilReason" select="'inapplicable'"/>
              </xsl:element>
            </xsl:otherwise>
          </xsl:choose>
          <!-- Need to take care of unnamed platforms with instruments -->
          <xsl:for-each select="../Platform[ShortName = 'N/A']/Instruments/Instrument">
            <mac:instrument>
              <xsl:attribute name="xlink:href" select="concat('#', generate-id())"/>
            </mac:instrument>
          </xsl:for-each>
          <xsl:if test="Characteristics/Characteristic or $platformInformationCount > 0">
            <xsl:comment select="'platform characteristics and additional attributes'"/>
            <eos:otherPropertyType>
              <gco:RecordType xlink:href="http://earthdata.nasa.gov/schema/eos/additionalAttributes.xsd#xpointer(//element[@name='AdditionalAttributes'])">Echo Additional Attributes</gco:RecordType>
            </eos:otherPropertyType>
            <eos:otherProperty>
              <gco:Record>
                <eos:AdditionalAttributes>
                  <!-- Write Platform Characteristics -->
                  <xsl:for-each select="Characteristics/Characteristic">
                    <xsl:call-template name="writeEOS_PSA"/>
                  </xsl:for-each>
                  <!-- Write platformInformation AdditionalAttributes -->
                  <xsl:for-each select="/*/AdditionalAttributes/AdditionalAttribute">
                    <xsl:if test="key('additionalAttributeLookup', Name, doc('additionalAttributeType.xml'))/@type = 'platformInformation'">
                      <xsl:call-template name="writeEOS_PSA"/>
                    </xsl:if>
                  </xsl:for-each>
                </eos:AdditionalAttributes>
              </gco:Record>
            </eos:otherProperty>
          </xsl:if>
        </xsl:element>
      </mac:platform>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="writePlatformAdditionalAttributes">
    <eos:otherPropertyType>
      <gco:RecordType xlink:href="http://earthdata.nasa.gov/metadata/schema/eos/1.0/eos.xsd#xpointer(//element[@name='AdditionalAttributes'])">Echo Additional Attributes</gco:RecordType>
    </eos:otherPropertyType>
    <eos:otherProperty>
      <gco:Record>
        <eos:AdditionalAttributes>
          <!-- Write Platform Characteristics -->
          <xsl:for-each select="Characteristics/Characteristic">
            <xsl:comment select="'Platform Characteristic'"/>
            <xsl:call-template name="writeEOS_PSA">
              <xsl:with-param name="additionalAttributeType" select="'platformInformation'"/>
            </xsl:call-template>
          </xsl:for-each>
          <!-- Write platformInformation AdditionalAttributes -->
          <xsl:for-each select="//AdditionalAttributes/AdditionalAttribute">
            <xsl:if test="key('additionalAttributeLookup', Name, doc('additionalAttributeType.xml'))/@type = 'platformInformation'">
              <xsl:comment select="'Platform Additional Attributes (platformInformation)'"/>
              <xsl:call-template name="writeEOS_PSA">
                <xsl:with-param name="additionalAttributeType" select="'platformInformation'"/>
              </xsl:call-template>
            </xsl:if>
          </xsl:for-each>
          <!-- Write OrbitCalculatedSpatialDomains -->
          <xsl:for-each select="//OrbitCalculatedSpatialDomains/OrbitCalculatedSpatialDomain">
            <xsl:comment select="'OrbitCalculatedSpatialDomains'"/>
            <xsl:for-each select="*">
              <eos:AdditionalAttribute>
                <eos:reference>
                  <eos:EOS_AdditionalAttributeDescription>
                    <eos:type>
                      <eos:EOS_AdditionalAttributeTypeCode codeList="http://earthdata.nasa.gov/metadata/resources/Codelists.xml#EOS_AdditionalAttributeTypeCode" codeListValue="platformInformation">platformInformation</eos:EOS_AdditionalAttributeTypeCode>
                    </eos:type>
                    <eos:name>
                      <gco:CharacterString>
                        <xsl:value-of select="local-name()"/>
                      </gco:CharacterString>
                    </eos:name>
                  </eos:EOS_AdditionalAttributeDescription>
                </eos:reference>
                <eos:value>
                  <gco:CharacterString>
                    <xsl:value-of select="."/>
                  </gco:CharacterString>
                </eos:value>
              </eos:AdditionalAttribute>
            </xsl:for-each>
          </xsl:for-each>
          <!-- Write HorizontalSpatialDomain/Orbit Information -->
          <xsl:for-each select="//Spatial/HorizontalSpatialDomain/Orbit">
            <xsl:comment select="'HorizontalSpatialDomain/Orbit'"/>
            <xsl:for-each select="*">
              <eos:AdditionalAttribute>
                <eos:reference>
                  <eos:EOS_AdditionalAttributeDescription>
                    <eos:type>
                      <eos:EOS_AdditionalAttributeTypeCode codeList="http://earthdata.nasa.gov/metadata/resources/Codelists.xml#EOS_AdditionalAttributeTypeCode" codeListValue="platformInformation">platformInformation</eos:EOS_AdditionalAttributeTypeCode>
                    </eos:type>
                    <eos:name>
                      <gco:CharacterString>
                        <xsl:value-of select="local-name()"/>
                      </gco:CharacterString>
                    </eos:name>
                  </eos:EOS_AdditionalAttributeDescription>
                </eos:reference>
                <eos:value>
                  <gco:CharacterString>
                    <xsl:value-of select="."/>
                  </gco:CharacterString>
                </eos:value>
              </eos:AdditionalAttribute>
            </xsl:for-each>
          </xsl:for-each>
          <!-- Write Spatial Orbit Parameters -->
          <xsl:for-each select="//Spatial/OrbitParameters">
            <xsl:comment select="'Spatial/OrbitParameters'"/>
            <xsl:for-each select="*">
              <eos:AdditionalAttribute>
                <eos:reference>
                  <eos:EOS_AdditionalAttributeDescription>
                    <eos:type>
                      <eos:EOS_AdditionalAttributeTypeCode codeList="http://earthdata.nasa.gov/metadata/resources/Codelists.xml#EOS_AdditionalAttributeTypeCode" codeListValue="platformInformation">platformInformation</eos:EOS_AdditionalAttributeTypeCode>
                    </eos:type>
                    <eos:name>
                      <gco:CharacterString>
                        <xsl:value-of select="local-name()"/>
                      </gco:CharacterString>
                    </eos:name>
                  </eos:EOS_AdditionalAttributeDescription>
                </eos:reference>
                <eos:value>
                  <gco:CharacterString>
                    <xsl:value-of select="."/>
                  </gco:CharacterString>
                </eos:value>
              </eos:AdditionalAttribute>
            </xsl:for-each>
          </xsl:for-each>
        </eos:AdditionalAttributes>
      </gco:Record>
    </eos:otherProperty>
  </xsl:template>
  <xsl:template name="writeInstrument">
    <xsl:for-each select="//Instruments/Instrument">
      <mac:instrument>
        <xsl:variable name="instrumentObjectName">
          <!-- 
            eos:EOS_Instrument must be used when any of the extension criteria exist for any instrument
            or sensor, but we want to avoid using it if it is not needed.
          -->
          <xsl:choose>
            <!-- Check extension requirements -->
            <xsl:when test="
                $instrumentCharacteristicCount +
                $instrumentInformationCount +
                $sensorCharacteristicCount +
                $sensorInformationCount +
                count(OperationModes/OperationMode) +
                count(Sensors/Sensor)">
              <xsl:value-of select="'eos:EOS_Instrument'"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="'mac:MI_Instrument'"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <eos:EOS_Instrument>
          <xsl:attribute name="id" select="generate-id()"/>
          <mac:citation>
            <cit:CI_Citation>
              <cit:title>
                <xsl:call-template name="writeCharacterString">
                  <!-- Concat Instrument and Short and Long Names -->
                  <xsl:with-param name="stringToWrite" select="concat(ShortName, '>', LongName)"/>
                </xsl:call-template>
              </cit:title>
              <cit:date gco:nilReason="unknown"/>
            </cit:CI_Citation>
          </mac:citation>
          <mac:identifier>
            <mcc:MD_Identifier>
              <mcc:code>
                <xsl:call-template name="writeCharacterString">
                  <xsl:with-param name="stringToWrite" select="ShortName"/>
                </xsl:call-template>
              </mcc:code>
              <mcc:description>
                <xsl:call-template name="writeCharacterString">
                  <xsl:with-param name="stringToWrite" select="LongName"/>
                </xsl:call-template>
              </mcc:description>
            </mcc:MD_Identifier>
          </mac:identifier>
          <mac:type>
            <xsl:call-template name="writeCharacterString">
              <xsl:with-param name="stringToWrite" select="Technique"/>
            </xsl:call-template>
          </mac:type>
          <mac:description gco:nilReason="missing"/>
          <xsl:for-each select="ancestor::Platform">
            <mac:mountedOn>
              <xsl:attribute name="xlink:href" select="concat('#', generate-id())"/>
            </mac:mountedOn>
          </xsl:for-each>
          <xsl:if test="Characteristics/Characteristic or $instrumentInformationCount > 0">
            <eos:otherPropertyType>
              <gco:RecordType xlink:href="http://earthdata.nasa.gov/schema/eos/additionalAttributes.xsd#xpointer(//element[@name='AdditionalAttributes'])">Echo Additional Attributes</gco:RecordType>
            </eos:otherPropertyType>
            <eos:otherProperty>
              <gco:Record>
                <eos:AdditionalAttributes>
                  <!-- Write Instrument Characteristics -->
                  <xsl:for-each select="Characteristics/Characteristic">
                    <xsl:comment select="'Instrument Characteristic'"/>
                    <xsl:call-template name="writeEOS_PSA">
                      <xsl:with-param name="additionalAttributeType" select="'instrumentInformation'"/>
                    </xsl:call-template>
                  </xsl:for-each>
                  <!-- Write instrumentInformation AdditionalAttributes -->
                  <xsl:for-each select="/*/AdditionalAttributes/AdditionalAttribute">
                    <xsl:if test="key('additionalAttributeLookup', Name, doc('additionalAttributeType.xml'))/@type = 'instrumentInformation'">
                      <xsl:comment select="'Instrument Information Additional Attribute'"/>
                      <xsl:call-template name="writeEOS_PSA">
                        <xsl:with-param name="additionalAttributeType" select="'instrumentInformation'"/>
                      </xsl:call-template>
                    </xsl:if>
                  </xsl:for-each>
                  <!-- Write instrument OperationMode -->
                  <xsl:for-each select="OperationModes/OperationMode">
                    <eos:AdditionalAttribute>
                      <eos:reference>
                        <eos:EOS_AdditionalAttributeDescription>
                          <eos:type>
                            <xsl:element name="eos:EOS_AdditionalAttributeTypeCode">
                              <xsl:attribute name="codeList" select="'http://earthdata.nasa.gov/metadata/resources/Codelists.xml#EOS_AdditionalAttributeTypeCode'"/>
                              <xsl:attribute name="codeListValue" select="'instrumentInformation'"/>
                              <xsl:value-of select="'instrumentInformation'"/>
                            </xsl:element>
                          </eos:type>
                          <eos:name>
                            <gco:CharacterString>OperationMode</gco:CharacterString>
                          </eos:name>
                        </eos:EOS_AdditionalAttributeDescription>
                      </eos:reference>
                      <eos:value>
                        <gco:CharacterString>
                          <xsl:value-of select="."/>
                        </gco:CharacterString>
                      </eos:value>
                    </eos:AdditionalAttribute>
                  </xsl:for-each>
                </eos:AdditionalAttributes>
              </gco:Record>
            </eos:otherProperty>
          </xsl:if>
          <xsl:call-template name="writeSensor"/>
        </eos:EOS_Instrument>
      </mac:instrument>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="writeSensor">
    <xsl:for-each select="Sensors/Sensor">
      <xsl:element name="eos:sensor">
        <xsl:element name="eos:EOS_Sensor">
          <xsl:attribute name="id" select="generate-id()"/>
          <eos:citation>
            <cit:CI_Citation>
              <cit:title>
                <xsl:call-template name="writeCharacterString">
                  <!-- Concat Instrument and Short and Long Names -->
                  <xsl:with-param name="stringToWrite" select="concat(ShortName, '>', LongName)"/>
                </xsl:call-template>
              </cit:title>
              <cit:date gco:nilReason="unknown"/>
            </cit:CI_Citation>
          </eos:citation>
          <eos:identifier>
            <mcc:MD_Identifier>
              <mcc:code>
                <xsl:call-template name="writeCharacterString">
                  <xsl:with-param name="stringToWrite" select="ShortName"/>
                </xsl:call-template>
              </mcc:code>
              <mcc:description>
                <xsl:call-template name="writeCharacterString">
                  <xsl:with-param name="stringToWrite" select="LongName"/>
                </xsl:call-template>
              </mcc:description>
            </mcc:MD_Identifier>
          </eos:identifier>
          <eos:type>
            <xsl:call-template name="writeCharacterString">
              <xsl:with-param name="stringToWrite" select="Technique"/>
            </xsl:call-template>
          </eos:type>
          <xsl:for-each select="ancestor::Instrument">
            <eos:mountedOn>
              <xsl:attribute name="xlink:href" select="concat('#', generate-id())"/>
            </eos:mountedOn>
          </xsl:for-each>
          <xsl:if test="Characteristics/Characteristic or $sensorInformationCount > 0">
            <eos:otherPropertyType>
              <gco:RecordType xlink:href="http://earthdata.nasa.gov/metadata/schema/eos/1.0/eos.xsd#xpointer(//element[@name='AdditionalAttributes'])">Echo Additional Attributes</gco:RecordType>
            </eos:otherPropertyType>
            <eos:otherProperty>
              <gco:Record>
                <eos:AdditionalAttributes>
                  <!-- Write Sensor Characteristics -->
                  <xsl:comment select="'Sensor Characteristic'"/>
                  <xsl:for-each select="Characteristics/Characteristic">
                    <xsl:call-template name="writeEOS_PSA">
                      <xsl:with-param name="additionalAttributeType" select="'sensorInformation'"/>
                    </xsl:call-template>
                  </xsl:for-each>
                  <!-- Write sensorInformation AdditionalAttributes -->
                  <xsl:for-each select="/*/AdditionalAttributes/AdditionalAttribute">
                    <xsl:if test="key('additionalAttributeLookup', Name, doc('additionalAttributeType.xml'))/@type = 'sensorInformation'">
                      <xsl:comment select="'Sensor Additional Attribute'"/>
                      <xsl:call-template name="writeEOS_PSA">
                        <xsl:with-param name="additionalAttributeType" select="'sensorInformation'"/>
                      </xsl:call-template>
                    </xsl:if>
                  </xsl:for-each>
                </eos:AdditionalAttributes>
              </gco:Record>
            </eos:otherProperty>
          </xsl:if>
        </xsl:element>
      </xsl:element>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
