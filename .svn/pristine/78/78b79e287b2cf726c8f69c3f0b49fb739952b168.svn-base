/**
 * IFFI054_BGT_S_DT.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.ildong.FI.BGT_ERP;

public class IFFI054_BGT_S_DT  implements java.io.Serializable {
    private com.ildong.FI.BGT_ERP.IFFI054_BGT_S_DTIN_REQUEST IN_REQUEST;

    public IFFI054_BGT_S_DT() {
    }

    public IFFI054_BGT_S_DT(
           com.ildong.FI.BGT_ERP.IFFI054_BGT_S_DTIN_REQUEST IN_REQUEST) {
           this.IN_REQUEST = IN_REQUEST;
    }


    /**
     * Gets the IN_REQUEST value for this IFFI054_BGT_S_DT.
     * 
     * @return IN_REQUEST
     */
    public com.ildong.FI.BGT_ERP.IFFI054_BGT_S_DTIN_REQUEST getIN_REQUEST() {
        return IN_REQUEST;
    }


    /**
     * Sets the IN_REQUEST value for this IFFI054_BGT_S_DT.
     * 
     * @param IN_REQUEST
     */
    public void setIN_REQUEST(com.ildong.FI.BGT_ERP.IFFI054_BGT_S_DTIN_REQUEST IN_REQUEST) {
        this.IN_REQUEST = IN_REQUEST;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof IFFI054_BGT_S_DT)) return false;
        IFFI054_BGT_S_DT other = (IFFI054_BGT_S_DT) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.IN_REQUEST==null && other.getIN_REQUEST()==null) || 
             (this.IN_REQUEST!=null &&
              this.IN_REQUEST.equals(other.getIN_REQUEST())));
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
        if (getIN_REQUEST() != null) {
            _hashCode += getIN_REQUEST().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(IFFI054_BGT_S_DT.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://ildong.com/FI/BGT_ERP", "IFFI054_BGT_S_DT"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("IN_REQUEST");
        elemField.setXmlName(new javax.xml.namespace.QName("", "IN_REQUEST"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://ildong.com/FI/BGT_ERP", ">IFFI054_BGT_S_DT>IN_REQUEST"));
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
