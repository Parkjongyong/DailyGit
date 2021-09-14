/**
 * IFCO001_BGT_S_DT.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.ildong.CO.BGT_ERP;

public class IFCO001_BGT_S_DT  implements java.io.Serializable {
    private java.lang.String DUMMY;

    public IFCO001_BGT_S_DT() {
    }

    public IFCO001_BGT_S_DT(
           java.lang.String DUMMY) {
           this.DUMMY = DUMMY;
    }


    /**
     * Gets the DUMMY value for this IFCO001_BGT_S_DT.
     * 
     * @return DUMMY
     */
    public java.lang.String getDUMMY() {
        return DUMMY;
    }


    /**
     * Sets the DUMMY value for this IFCO001_BGT_S_DT.
     * 
     * @param DUMMY
     */
    public void setDUMMY(java.lang.String DUMMY) {
        this.DUMMY = DUMMY;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof IFCO001_BGT_S_DT)) return false;
        IFCO001_BGT_S_DT other = (IFCO001_BGT_S_DT) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.DUMMY==null && other.getDUMMY()==null) || 
             (this.DUMMY!=null &&
              this.DUMMY.equals(other.getDUMMY())));
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
        if (getDUMMY() != null) {
            _hashCode += getDUMMY().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(IFCO001_BGT_S_DT.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://ildong.com/CO/BGT_ERP", "IFCO001_BGT_S_DT"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("DUMMY");
        elemField.setXmlName(new javax.xml.namespace.QName("", "DUMMY"));
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
