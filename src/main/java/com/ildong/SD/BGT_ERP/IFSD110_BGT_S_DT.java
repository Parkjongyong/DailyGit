/**
 * IFSD110_BGT_S_DT.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.ildong.SD.BGT_ERP;

public class IFSD110_BGT_S_DT  implements java.io.Serializable {
    private com.ildong.SD.BGT_ERP.IFSD110_BGT_S_DTITEM ITEM;

    public IFSD110_BGT_S_DT() {
    }

    public IFSD110_BGT_S_DT(
           com.ildong.SD.BGT_ERP.IFSD110_BGT_S_DTITEM ITEM) {
           this.ITEM = ITEM;
    }


    /**
     * Gets the ITEM value for this IFSD110_BGT_S_DT.
     * 
     * @return ITEM
     */
    public com.ildong.SD.BGT_ERP.IFSD110_BGT_S_DTITEM getITEM() {
        return ITEM;
    }


    /**
     * Sets the ITEM value for this IFSD110_BGT_S_DT.
     * 
     * @param ITEM
     */
    public void setITEM(com.ildong.SD.BGT_ERP.IFSD110_BGT_S_DTITEM ITEM) {
        this.ITEM = ITEM;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof IFSD110_BGT_S_DT)) return false;
        IFSD110_BGT_S_DT other = (IFSD110_BGT_S_DT) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.ITEM==null && other.getITEM()==null) || 
             (this.ITEM!=null &&
              this.ITEM.equals(other.getITEM())));
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
        if (getITEM() != null) {
            _hashCode += getITEM().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(IFSD110_BGT_S_DT.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://ildong.com/SD/BGT_ERP", "IFSD110_BGT_S_DT"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ITEM");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ITEM"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://ildong.com/SD/BGT_ERP", ">IFSD110_BGT_S_DT>ITEM"));
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
