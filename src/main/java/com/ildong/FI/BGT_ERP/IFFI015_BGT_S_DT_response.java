/**
 * IFFI015_BGT_S_DT_response.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.ildong.FI.BGT_ERP;

public class IFFI015_BGT_S_DT_response  implements java.io.Serializable {
    private com.ildong.FI.BGT_ERP.IFFI015_BGT_S_DT_responseOUT_HEAD[] OUT_HEAD;

    private com.ildong.FI.BGT_ERP.IFFI015_BGT_S_DT_responseOUT_BANK[] OUT_BANK;

    public IFFI015_BGT_S_DT_response() {
    }

    public IFFI015_BGT_S_DT_response(
           com.ildong.FI.BGT_ERP.IFFI015_BGT_S_DT_responseOUT_HEAD[] OUT_HEAD,
           com.ildong.FI.BGT_ERP.IFFI015_BGT_S_DT_responseOUT_BANK[] OUT_BANK) {
           this.OUT_HEAD = OUT_HEAD;
           this.OUT_BANK = OUT_BANK;
    }


    /**
     * Gets the OUT_HEAD value for this IFFI015_BGT_S_DT_response.
     * 
     * @return OUT_HEAD
     */
    public com.ildong.FI.BGT_ERP.IFFI015_BGT_S_DT_responseOUT_HEAD[] getOUT_HEAD() {
        return OUT_HEAD;
    }


    /**
     * Sets the OUT_HEAD value for this IFFI015_BGT_S_DT_response.
     * 
     * @param OUT_HEAD
     */
    public void setOUT_HEAD(com.ildong.FI.BGT_ERP.IFFI015_BGT_S_DT_responseOUT_HEAD[] OUT_HEAD) {
        this.OUT_HEAD = OUT_HEAD;
    }

    public com.ildong.FI.BGT_ERP.IFFI015_BGT_S_DT_responseOUT_HEAD getOUT_HEAD(int i) {
        return this.OUT_HEAD[i];
    }

    public void setOUT_HEAD(int i, com.ildong.FI.BGT_ERP.IFFI015_BGT_S_DT_responseOUT_HEAD _value) {
        this.OUT_HEAD[i] = _value;
    }


    /**
     * Gets the OUT_BANK value for this IFFI015_BGT_S_DT_response.
     * 
     * @return OUT_BANK
     */
    public com.ildong.FI.BGT_ERP.IFFI015_BGT_S_DT_responseOUT_BANK[] getOUT_BANK() {
        return OUT_BANK;
    }


    /**
     * Sets the OUT_BANK value for this IFFI015_BGT_S_DT_response.
     * 
     * @param OUT_BANK
     */
    public void setOUT_BANK(com.ildong.FI.BGT_ERP.IFFI015_BGT_S_DT_responseOUT_BANK[] OUT_BANK) {
        this.OUT_BANK = OUT_BANK;
    }

    public com.ildong.FI.BGT_ERP.IFFI015_BGT_S_DT_responseOUT_BANK getOUT_BANK(int i) {
        return this.OUT_BANK[i];
    }

    public void setOUT_BANK(int i, com.ildong.FI.BGT_ERP.IFFI015_BGT_S_DT_responseOUT_BANK _value) {
        this.OUT_BANK[i] = _value;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof IFFI015_BGT_S_DT_response)) return false;
        IFFI015_BGT_S_DT_response other = (IFFI015_BGT_S_DT_response) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.OUT_HEAD==null && other.getOUT_HEAD()==null) || 
             (this.OUT_HEAD!=null &&
              java.util.Arrays.equals(this.OUT_HEAD, other.getOUT_HEAD()))) &&
            ((this.OUT_BANK==null && other.getOUT_BANK()==null) || 
             (this.OUT_BANK!=null &&
              java.util.Arrays.equals(this.OUT_BANK, other.getOUT_BANK())));
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
        if (getOUT_HEAD() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getOUT_HEAD());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getOUT_HEAD(), i);
                if (obj != null &&
                    !obj.getClass().isArray()) {
                    _hashCode += obj.hashCode();
                }
            }
        }
        if (getOUT_BANK() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getOUT_BANK());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getOUT_BANK(), i);
                if (obj != null &&
                    !obj.getClass().isArray()) {
                    _hashCode += obj.hashCode();
                }
            }
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(IFFI015_BGT_S_DT_response.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://ildong.com/FI/BGT_ERP", "IFFI015_BGT_S_DT_response"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("OUT_HEAD");
        elemField.setXmlName(new javax.xml.namespace.QName("", "OUT_HEAD"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://ildong.com/FI/BGT_ERP", ">IFFI015_BGT_S_DT_response>OUT_HEAD"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        elemField.setMaxOccursUnbounded(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("OUT_BANK");
        elemField.setXmlName(new javax.xml.namespace.QName("", "OUT_BANK"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://ildong.com/FI/BGT_ERP", ">IFFI015_BGT_S_DT_response>OUT_BANK"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        elemField.setMaxOccursUnbounded(true);
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
