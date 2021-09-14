/**
 * IFCO004_BGT_S_DT_responseITEM.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.ildong.CO.BGT_ERP;

public class IFCO004_BGT_S_DT_responseITEM  implements java.io.Serializable {
    private java.lang.String BUKRS;

    private java.lang.String AUFNR;

    private java.lang.String AUART;

    private java.lang.String ZINVNR;

    private java.lang.String KOSTV;

    private java.lang.String KSTAR;

    private java.lang.String KTEXT;

    public IFCO004_BGT_S_DT_responseITEM() {
    }

    public IFCO004_BGT_S_DT_responseITEM(
           java.lang.String BUKRS,
           java.lang.String AUFNR,
           java.lang.String AUART,
           java.lang.String ZINVNR,
           java.lang.String KOSTV,
           java.lang.String KSTAR,
           java.lang.String KTEXT) {
           this.BUKRS = BUKRS;
           this.AUFNR = AUFNR;
           this.AUART = AUART;
           this.ZINVNR = ZINVNR;
           this.KOSTV = KOSTV;
           this.KSTAR = KSTAR;
           this.KTEXT = KTEXT;
    }


    /**
     * Gets the BUKRS value for this IFCO004_BGT_S_DT_responseITEM.
     * 
     * @return BUKRS
     */
    public java.lang.String getBUKRS() {
        return BUKRS;
    }


    /**
     * Sets the BUKRS value for this IFCO004_BGT_S_DT_responseITEM.
     * 
     * @param BUKRS
     */
    public void setBUKRS(java.lang.String BUKRS) {
        this.BUKRS = BUKRS;
    }


    /**
     * Gets the AUFNR value for this IFCO004_BGT_S_DT_responseITEM.
     * 
     * @return AUFNR
     */
    public java.lang.String getAUFNR() {
        return AUFNR;
    }


    /**
     * Sets the AUFNR value for this IFCO004_BGT_S_DT_responseITEM.
     * 
     * @param AUFNR
     */
    public void setAUFNR(java.lang.String AUFNR) {
        this.AUFNR = AUFNR;
    }


    /**
     * Gets the AUART value for this IFCO004_BGT_S_DT_responseITEM.
     * 
     * @return AUART
     */
    public java.lang.String getAUART() {
        return AUART;
    }


    /**
     * Sets the AUART value for this IFCO004_BGT_S_DT_responseITEM.
     * 
     * @param AUART
     */
    public void setAUART(java.lang.String AUART) {
        this.AUART = AUART;
    }


    /**
     * Gets the ZINVNR value for this IFCO004_BGT_S_DT_responseITEM.
     * 
     * @return ZINVNR
     */
    public java.lang.String getZINVNR() {
        return ZINVNR;
    }


    /**
     * Sets the ZINVNR value for this IFCO004_BGT_S_DT_responseITEM.
     * 
     * @param ZINVNR
     */
    public void setZINVNR(java.lang.String ZINVNR) {
        this.ZINVNR = ZINVNR;
    }


    /**
     * Gets the KOSTV value for this IFCO004_BGT_S_DT_responseITEM.
     * 
     * @return KOSTV
     */
    public java.lang.String getKOSTV() {
        return KOSTV;
    }


    /**
     * Sets the KOSTV value for this IFCO004_BGT_S_DT_responseITEM.
     * 
     * @param KOSTV
     */
    public void setKOSTV(java.lang.String KOSTV) {
        this.KOSTV = KOSTV;
    }


    /**
     * Gets the KSTAR value for this IFCO004_BGT_S_DT_responseITEM.
     * 
     * @return KSTAR
     */
    public java.lang.String getKSTAR() {
        return KSTAR;
    }


    /**
     * Sets the KSTAR value for this IFCO004_BGT_S_DT_responseITEM.
     * 
     * @param KSTAR
     */
    public void setKSTAR(java.lang.String KSTAR) {
        this.KSTAR = KSTAR;
    }


    /**
     * Gets the KTEXT value for this IFCO004_BGT_S_DT_responseITEM.
     * 
     * @return KTEXT
     */
    public java.lang.String getKTEXT() {
        return KTEXT;
    }


    /**
     * Sets the KTEXT value for this IFCO004_BGT_S_DT_responseITEM.
     * 
     * @param KTEXT
     */
    public void setKTEXT(java.lang.String KTEXT) {
        this.KTEXT = KTEXT;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof IFCO004_BGT_S_DT_responseITEM)) return false;
        IFCO004_BGT_S_DT_responseITEM other = (IFCO004_BGT_S_DT_responseITEM) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.BUKRS==null && other.getBUKRS()==null) || 
             (this.BUKRS!=null &&
              this.BUKRS.equals(other.getBUKRS()))) &&
            ((this.AUFNR==null && other.getAUFNR()==null) || 
             (this.AUFNR!=null &&
              this.AUFNR.equals(other.getAUFNR()))) &&
            ((this.AUART==null && other.getAUART()==null) || 
             (this.AUART!=null &&
              this.AUART.equals(other.getAUART()))) &&
            ((this.ZINVNR==null && other.getZINVNR()==null) || 
             (this.ZINVNR!=null &&
              this.ZINVNR.equals(other.getZINVNR()))) &&
            ((this.KOSTV==null && other.getKOSTV()==null) || 
             (this.KOSTV!=null &&
              this.KOSTV.equals(other.getKOSTV()))) &&
            ((this.KSTAR==null && other.getKSTAR()==null) || 
             (this.KSTAR!=null &&
              this.KSTAR.equals(other.getKSTAR()))) &&
            ((this.KTEXT==null && other.getKTEXT()==null) || 
             (this.KTEXT!=null &&
              this.KTEXT.equals(other.getKTEXT())));
        __equalsCalc = null;
        return _equals;
    }

    private boolean __hashCodeCalc = false;
    public synchronized int hashCode() {
        if (__hashCodeCalc) {
            return 0;
        }
        __hashCodeCalc = true;
        int _hashCode = 1;
        if (getBUKRS() != null) {
            _hashCode += getBUKRS().hashCode();
        }
        if (getAUFNR() != null) {
            _hashCode += getAUFNR().hashCode();
        }
        if (getAUART() != null) {
            _hashCode += getAUART().hashCode();
        }
        if (getZINVNR() != null) {
            _hashCode += getZINVNR().hashCode();
        }
        if (getKOSTV() != null) {
            _hashCode += getKOSTV().hashCode();
        }
        if (getKSTAR() != null) {
            _hashCode += getKSTAR().hashCode();
        }
        if (getKTEXT() != null) {
            _hashCode += getKTEXT().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(IFCO004_BGT_S_DT_responseITEM.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://ildong.com/CO/BGT_ERP", ">IFCO004_BGT_S_DT_response>ITEM"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("BUKRS");
        elemField.setXmlName(new javax.xml.namespace.QName("", "BUKRS"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("AUFNR");
        elemField.setXmlName(new javax.xml.namespace.QName("", "AUFNR"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("AUART");
        elemField.setXmlName(new javax.xml.namespace.QName("", "AUART"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ZINVNR");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ZINVNR"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("KOSTV");
        elemField.setXmlName(new javax.xml.namespace.QName("", "KOSTV"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("KSTAR");
        elemField.setXmlName(new javax.xml.namespace.QName("", "KSTAR"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("KTEXT");
        elemField.setXmlName(new javax.xml.namespace.QName("", "KTEXT"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
    }

    /**
     * Return type metadata object
     */
    public static org.apache.axis.description.TypeDesc getTypeDesc() {
        return typeDesc;
    }

    /**
     * Get Custom Serializer
     */
    public static org.apache.axis.encoding.Serializer getSerializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanSerializer(
            _javaType, _xmlType, typeDesc);
    }

    /**
     * Get Custom Deserializer
     */
    public static org.apache.axis.encoding.Deserializer getDeserializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanDeserializer(
            _javaType, _xmlType, typeDesc);
    }

}
