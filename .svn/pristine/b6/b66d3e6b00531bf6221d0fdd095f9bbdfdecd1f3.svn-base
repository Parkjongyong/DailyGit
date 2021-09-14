/**
 * IFMM038_BGT_S_DT.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.ildong.MM.BGT_ERP;

public class IFMM038_BGT_S_DT  implements java.io.Serializable {
    private com.ildong.MM.BGT_ERP.IFMM038_BGT_S_DTHEADER HEADER;

    public IFMM038_BGT_S_DT() {
    }

    public IFMM038_BGT_S_DT(
           com.ildong.MM.BGT_ERP.IFMM038_BGT_S_DTHEADER HEADER) {
           this.HEADER = HEADER;
    }


    /**
     * Gets the HEADER value for this IFMM038_BGT_S_DT.
     * 
     * @return HEADER
     */
    public com.ildong.MM.BGT_ERP.IFMM038_BGT_S_DTHEADER getHEADER() {
        return HEADER;
    }


    /**
     * Sets the HEADER value for this IFMM038_BGT_S_DT.
     * 
     * @param HEADER
     */
    public void setHEADER(com.ildong.MM.BGT_ERP.IFMM038_BGT_S_DTHEADER HEADER) {
        this.HEADER = HEADER;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof IFMM038_BGT_S_DT)) return false;
        IFMM038_BGT_S_DT other = (IFMM038_BGT_S_DT) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.HEADER==null && other.getHEADER()==null) || 
             (this.HEADER!=null &&
              this.HEADER.equals(other.getHEADER())));
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
        if (getHEADER() != null) {
            _hashCode += getHEADER().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(IFMM038_BGT_S_DT.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://ildong.com/MM/BGT_ERP", "IFMM038_BGT_S_DT"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("HEADER");
        elemField.setXmlName(new javax.xml.namespace.QName("", "HEADER"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://ildong.com/MM/BGT_ERP", ">IFMM038_BGT_S_DT>HEADER"));
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
