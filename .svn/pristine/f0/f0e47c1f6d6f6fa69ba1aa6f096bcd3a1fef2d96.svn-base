/**
 * IFFI016_BGT_S_DT_response.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.ildong.FI.BGT_ERP;

public class IFFI016_BGT_S_DT_response  implements java.io.Serializable {
    private java.lang.String IF_FLAG;

    private java.lang.String IF_MSG;

    public IFFI016_BGT_S_DT_response() {
    }

    public IFFI016_BGT_S_DT_response(
           java.lang.String IF_FLAG,
           java.lang.String IF_MSG) {
           this.IF_FLAG = IF_FLAG;
           this.IF_MSG = IF_MSG;
    }


    /**
     * Gets the IF_FLAG value for this IFFI016_BGT_S_DT_response.
     * 
     * @return IF_FLAG
     */
    public java.lang.String getIF_FLAG() {
        return IF_FLAG;
    }


    /**
     * Sets the IF_FLAG value for this IFFI016_BGT_S_DT_response.
     * 
     * @param IF_FLAG
     */
    public void setIF_FLAG(java.lang.String IF_FLAG) {
        this.IF_FLAG = IF_FLAG;
    }


    /**
     * Gets the IF_MSG value for this IFFI016_BGT_S_DT_response.
     * 
     * @return IF_MSG
     */
    public java.lang.String getIF_MSG() {
        return IF_MSG;
    }


    /**
     * Sets the IF_MSG value for this IFFI016_BGT_S_DT_response.
     * 
     * @param IF_MSG
     */
    public void setIF_MSG(java.lang.String IF_MSG) {
        this.IF_MSG = IF_MSG;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof IFFI016_BGT_S_DT_response)) return false;
        IFFI016_BGT_S_DT_response other = (IFFI016_BGT_S_DT_response) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.IF_FLAG==null && other.getIF_FLAG()==null) || 
             (this.IF_FLAG!=null &&
              this.IF_FLAG.equals(other.getIF_FLAG()))) &&
            ((this.IF_MSG==null && other.getIF_MSG()==null) || 
             (this.IF_MSG!=null &&
              this.IF_MSG.equals(other.getIF_MSG())));
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
        if (getIF_FLAG() != null) {
            _hashCode += getIF_FLAG().hashCode();
        }
        if (getIF_MSG() != null) {
            _hashCode += getIF_MSG().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(IFFI016_BGT_S_DT_response.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://ildong.com/FI/BGT_ERP", "IFFI016_BGT_S_DT_response"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("IF_FLAG");
        elemField.setXmlName(new javax.xml.namespace.QName("", "IF_FLAG"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("IF_MSG");
        elemField.setXmlName(new javax.xml.namespace.QName("", "IF_MSG"));
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
