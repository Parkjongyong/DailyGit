/**
 * IFCO001_BGT_S_DT_responseITEM.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.ildong.CO.BGT_ERP;

public class IFCO001_BGT_S_DT_responseITEM  implements java.io.Serializable {
    private java.lang.String KSTAR;

    private java.lang.String KTEXT;

    public IFCO001_BGT_S_DT_responseITEM() {
    }

    public IFCO001_BGT_S_DT_responseITEM(
           java.lang.String KSTAR,
           java.lang.String KTEXT) {
           this.KSTAR = KSTAR;
           this.KTEXT = KTEXT;
    }


    /**
     * Gets the KSTAR value for this IFCO001_BGT_S_DT_responseITEM.
     * 
     * @return KSTAR
     */
    public java.lang.String getKSTAR() {
        return KSTAR;
    }


    /**
     * Sets the KSTAR value for this IFCO001_BGT_S_DT_responseITEM.
     * 
     * @param KSTAR
     */
    public void setKSTAR(java.lang.String KSTAR) {
        this.KSTAR = KSTAR;
    }


    /**
     * Gets the KTEXT value for this IFCO001_BGT_S_DT_responseITEM.
     * 
     * @return KTEXT
     */
    public java.lang.String getKTEXT() {
        return KTEXT;
    }


    /**
     * Sets the KTEXT value for this IFCO001_BGT_S_DT_responseITEM.
     * 
     * @param KTEXT
     */
    public void setKTEXT(java.lang.String KTEXT) {
        this.KTEXT = KTEXT;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof IFCO001_BGT_S_DT_responseITEM)) return false;
        IFCO001_BGT_S_DT_responseITEM other = (IFCO001_BGT_S_DT_responseITEM) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
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
        new org.apache.axis.description.TypeDesc(IFCO001_BGT_S_DT_responseITEM.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://ildong.com/CO/BGT_ERP", ">IFCO001_BGT_S_DT_response>ITEM"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
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
