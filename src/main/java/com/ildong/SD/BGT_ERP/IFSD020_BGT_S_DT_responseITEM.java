/**
 * IFSD020_BGT_S_DT_responseITEM.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.ildong.SD.BGT_ERP;

public class IFSD020_BGT_S_DT_responseITEM  implements java.io.Serializable {
    private java.lang.String VBEXT;

    private java.lang.String POEXT;

    private java.lang.String VBELN;

    private java.lang.String POSNR;

    public IFSD020_BGT_S_DT_responseITEM() {
    }

    public IFSD020_BGT_S_DT_responseITEM(
           java.lang.String VBEXT,
           java.lang.String POEXT,
           java.lang.String VBELN,
           java.lang.String POSNR) {
           this.VBEXT = VBEXT;
           this.POEXT = POEXT;
           this.VBELN = VBELN;
           this.POSNR = POSNR;
    }


    /**
     * Gets the VBEXT value for this IFSD020_BGT_S_DT_responseITEM.
     * 
     * @return VBEXT
     */
    public java.lang.String getVBEXT() {
        return VBEXT;
    }


    /**
     * Sets the VBEXT value for this IFSD020_BGT_S_DT_responseITEM.
     * 
     * @param VBEXT
     */
    public void setVBEXT(java.lang.String VBEXT) {
        this.VBEXT = VBEXT;
    }


    /**
     * Gets the POEXT value for this IFSD020_BGT_S_DT_responseITEM.
     * 
     * @return POEXT
     */
    public java.lang.String getPOEXT() {
        return POEXT;
    }


    /**
     * Sets the POEXT value for this IFSD020_BGT_S_DT_responseITEM.
     * 
     * @param POEXT
     */
    public void setPOEXT(java.lang.String POEXT) {
        this.POEXT = POEXT;
    }


    /**
     * Gets the VBELN value for this IFSD020_BGT_S_DT_responseITEM.
     * 
     * @return VBELN
     */
    public java.lang.String getVBELN() {
        return VBELN;
    }


    /**
     * Sets the VBELN value for this IFSD020_BGT_S_DT_responseITEM.
     * 
     * @param VBELN
     */
    public void setVBELN(java.lang.String VBELN) {
        this.VBELN = VBELN;
    }


    /**
     * Gets the POSNR value for this IFSD020_BGT_S_DT_responseITEM.
     * 
     * @return POSNR
     */
    public java.lang.String getPOSNR() {
        return POSNR;
    }


    /**
     * Sets the POSNR value for this IFSD020_BGT_S_DT_responseITEM.
     * 
     * @param POSNR
     */
    public void setPOSNR(java.lang.String POSNR) {
        this.POSNR = POSNR;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof IFSD020_BGT_S_DT_responseITEM)) return false;
        IFSD020_BGT_S_DT_responseITEM other = (IFSD020_BGT_S_DT_responseITEM) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.VBEXT==null && other.getVBEXT()==null) || 
             (this.VBEXT!=null &&
              this.VBEXT.equals(other.getVBEXT()))) &&
            ((this.POEXT==null && other.getPOEXT()==null) || 
             (this.POEXT!=null &&
              this.POEXT.equals(other.getPOEXT()))) &&
            ((this.VBELN==null && other.getVBELN()==null) || 
             (this.VBELN!=null &&
              this.VBELN.equals(other.getVBELN()))) &&
            ((this.POSNR==null && other.getPOSNR()==null) || 
             (this.POSNR!=null &&
              this.POSNR.equals(other.getPOSNR())));
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
        if (getVBEXT() != null) {
            _hashCode += getVBEXT().hashCode();
        }
        if (getPOEXT() != null) {
            _hashCode += getPOEXT().hashCode();
        }
        if (getVBELN() != null) {
            _hashCode += getVBELN().hashCode();
        }
        if (getPOSNR() != null) {
            _hashCode += getPOSNR().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(IFSD020_BGT_S_DT_responseITEM.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://ildong.com/SD/BGT_ERP", ">IFSD020_BGT_S_DT_response>ITEM"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("VBEXT");
        elemField.setXmlName(new javax.xml.namespace.QName("", "VBEXT"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("POEXT");
        elemField.setXmlName(new javax.xml.namespace.QName("", "POEXT"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("VBELN");
        elemField.setXmlName(new javax.xml.namespace.QName("", "VBELN"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("POSNR");
        elemField.setXmlName(new javax.xml.namespace.QName("", "POSNR"));
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
