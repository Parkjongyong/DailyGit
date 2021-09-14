/**
 * IFFI017_BGT_S_DT.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.ildong.FI.BGT_ERP;

public class IFFI017_BGT_S_DT  implements java.io.Serializable {
    private com.ildong.FI.BGT_ERP.IFFI017_BGT_S_DTIN_HEAD[] IN_HEAD;

    private com.ildong.FI.BGT_ERP.IFFI017_BGT_S_DTIN_DETAIL[] IN_DETAIL;

    public IFFI017_BGT_S_DT() {
    }

    public IFFI017_BGT_S_DT(
           com.ildong.FI.BGT_ERP.IFFI017_BGT_S_DTIN_HEAD[] IN_HEAD,
           com.ildong.FI.BGT_ERP.IFFI017_BGT_S_DTIN_DETAIL[] IN_DETAIL) {
           this.IN_HEAD = IN_HEAD;
           this.IN_DETAIL = IN_DETAIL;
    }


    /**
     * Gets the IN_HEAD value for this IFFI017_BGT_S_DT.
     * 
     * @return IN_HEAD
     */
    public com.ildong.FI.BGT_ERP.IFFI017_BGT_S_DTIN_HEAD[] getIN_HEAD() {
        return IN_HEAD;
    }


    /**
     * Sets the IN_HEAD value for this IFFI017_BGT_S_DT.
     * 
     * @param IN_HEAD
     */
    public void setIN_HEAD(com.ildong.FI.BGT_ERP.IFFI017_BGT_S_DTIN_HEAD[] IN_HEAD) {
        this.IN_HEAD = IN_HEAD;
    }

    public com.ildong.FI.BGT_ERP.IFFI017_BGT_S_DTIN_HEAD getIN_HEAD(int i) {
        return this.IN_HEAD[i];
    }

    public void setIN_HEAD(int i, com.ildong.FI.BGT_ERP.IFFI017_BGT_S_DTIN_HEAD _value) {
        this.IN_HEAD[i] = _value;
    }


    /**
     * Gets the IN_DETAIL value for this IFFI017_BGT_S_DT.
     * 
     * @return IN_DETAIL
     */
    public com.ildong.FI.BGT_ERP.IFFI017_BGT_S_DTIN_DETAIL[] getIN_DETAIL() {
        return IN_DETAIL;
    }


    /**
     * Sets the IN_DETAIL value for this IFFI017_BGT_S_DT.
     * 
     * @param IN_DETAIL
     */
    public void setIN_DETAIL(com.ildong.FI.BGT_ERP.IFFI017_BGT_S_DTIN_DETAIL[] IN_DETAIL) {
        this.IN_DETAIL = IN_DETAIL;
    }

    public com.ildong.FI.BGT_ERP.IFFI017_BGT_S_DTIN_DETAIL getIN_DETAIL(int i) {
        return this.IN_DETAIL[i];
    }

    public void setIN_DETAIL(int i, com.ildong.FI.BGT_ERP.IFFI017_BGT_S_DTIN_DETAIL _value) {
        this.IN_DETAIL[i] = _value;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof IFFI017_BGT_S_DT)) return false;
        IFFI017_BGT_S_DT other = (IFFI017_BGT_S_DT) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.IN_HEAD==null && other.getIN_HEAD()==null) || 
             (this.IN_HEAD!=null &&
              java.util.Arrays.equals(this.IN_HEAD, other.getIN_HEAD()))) &&
            ((this.IN_DETAIL==null && other.getIN_DETAIL()==null) || 
             (this.IN_DETAIL!=null &&
              java.util.Arrays.equals(this.IN_DETAIL, other.getIN_DETAIL())));
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
        if (getIN_HEAD() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getIN_HEAD());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getIN_HEAD(), i);
                if (obj != null &&
                    !obj.getClass().isArray()) {
                    _hashCode += obj.hashCode();
                }
            }
        }
        if (getIN_DETAIL() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getIN_DETAIL());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getIN_DETAIL(), i);
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
        new org.apache.axis.description.TypeDesc(IFFI017_BGT_S_DT.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://ildong.com/FI/BGT_ERP", "IFFI017_BGT_S_DT"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("IN_HEAD");
        elemField.setXmlName(new javax.xml.namespace.QName("", "IN_HEAD"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://ildong.com/FI/BGT_ERP", ">IFFI017_BGT_S_DT>IN_HEAD"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        elemField.setMaxOccursUnbounded(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("IN_DETAIL");
        elemField.setXmlName(new javax.xml.namespace.QName("", "IN_DETAIL"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://ildong.com/FI/BGT_ERP", ">IFFI017_BGT_S_DT>IN_DETAIL"));
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
