/**
 * IFMM038_BGT_S_DT_response.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.ildong.MM.BGT_ERP;

public class IFMM038_BGT_S_DT_response  implements java.io.Serializable {
    private com.ildong.MM.BGT_ERP.IFMM038_BGT_S_DT_responseIV_HEAD[] IV_HEAD;

    private com.ildong.MM.BGT_ERP.IFMM038_BGT_S_DT_responseIV_ITEM[] IV_ITEM;

    private java.lang.String IF_FLAG;

    private java.lang.String IF_MSG;

    public IFMM038_BGT_S_DT_response() {
    }

    public IFMM038_BGT_S_DT_response(
           com.ildong.MM.BGT_ERP.IFMM038_BGT_S_DT_responseIV_HEAD[] IV_HEAD,
           com.ildong.MM.BGT_ERP.IFMM038_BGT_S_DT_responseIV_ITEM[] IV_ITEM,
           java.lang.String IF_FLAG,
           java.lang.String IF_MSG) {
           this.IV_HEAD = IV_HEAD;
           this.IV_ITEM = IV_ITEM;
           this.IF_FLAG = IF_FLAG;
           this.IF_MSG = IF_MSG;
    }


    /**
     * Gets the IV_HEAD value for this IFMM038_BGT_S_DT_response.
     * 
     * @return IV_HEAD
     */
    public com.ildong.MM.BGT_ERP.IFMM038_BGT_S_DT_responseIV_HEAD[] getIV_HEAD() {
        return IV_HEAD;
    }


    /**
     * Sets the IV_HEAD value for this IFMM038_BGT_S_DT_response.
     * 
     * @param IV_HEAD
     */
    public void setIV_HEAD(com.ildong.MM.BGT_ERP.IFMM038_BGT_S_DT_responseIV_HEAD[] IV_HEAD) {
        this.IV_HEAD = IV_HEAD;
    }

    public com.ildong.MM.BGT_ERP.IFMM038_BGT_S_DT_responseIV_HEAD getIV_HEAD(int i) {
        return this.IV_HEAD[i];
    }

    public void setIV_HEAD(int i, com.ildong.MM.BGT_ERP.IFMM038_BGT_S_DT_responseIV_HEAD _value) {
        this.IV_HEAD[i] = _value;
    }


    /**
     * Gets the IV_ITEM value for this IFMM038_BGT_S_DT_response.
     * 
     * @return IV_ITEM
     */
    public com.ildong.MM.BGT_ERP.IFMM038_BGT_S_DT_responseIV_ITEM[] getIV_ITEM() {
        return IV_ITEM;
    }


    /**
     * Sets the IV_ITEM value for this IFMM038_BGT_S_DT_response.
     * 
     * @param IV_ITEM
     */
    public void setIV_ITEM(com.ildong.MM.BGT_ERP.IFMM038_BGT_S_DT_responseIV_ITEM[] IV_ITEM) {
        this.IV_ITEM = IV_ITEM;
    }

    public com.ildong.MM.BGT_ERP.IFMM038_BGT_S_DT_responseIV_ITEM getIV_ITEM(int i) {
        return this.IV_ITEM[i];
    }

    public void setIV_ITEM(int i, com.ildong.MM.BGT_ERP.IFMM038_BGT_S_DT_responseIV_ITEM _value) {
        this.IV_ITEM[i] = _value;
    }


    /**
     * Gets the IF_FLAG value for this IFMM038_BGT_S_DT_response.
     * 
     * @return IF_FLAG
     */
    public java.lang.String getIF_FLAG() {
        return IF_FLAG;
    }


    /**
     * Sets the IF_FLAG value for this IFMM038_BGT_S_DT_response.
     * 
     * @param IF_FLAG
     */
    public void setIF_FLAG(java.lang.String IF_FLAG) {
        this.IF_FLAG = IF_FLAG;
    }


    /**
     * Gets the IF_MSG value for this IFMM038_BGT_S_DT_response.
     * 
     * @return IF_MSG
     */
    public java.lang.String getIF_MSG() {
        return IF_MSG;
    }


    /**
     * Sets the IF_MSG value for this IFMM038_BGT_S_DT_response.
     * 
     * @param IF_MSG
     */
    public void setIF_MSG(java.lang.String IF_MSG) {
        this.IF_MSG = IF_MSG;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof IFMM038_BGT_S_DT_response)) return false;
        IFMM038_BGT_S_DT_response other = (IFMM038_BGT_S_DT_response) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.IV_HEAD==null && other.getIV_HEAD()==null) || 
             (this.IV_HEAD!=null &&
              java.util.Arrays.equals(this.IV_HEAD, other.getIV_HEAD()))) &&
            ((this.IV_ITEM==null && other.getIV_ITEM()==null) || 
             (this.IV_ITEM!=null &&
              java.util.Arrays.equals(this.IV_ITEM, other.getIV_ITEM()))) &&
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
        if (getIV_HEAD() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getIV_HEAD());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getIV_HEAD(), i);
                if (obj != null &&
                    !obj.getClass().isArray()) {
                    _hashCode += obj.hashCode();
                }
            }
        }
        if (getIV_ITEM() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getIV_ITEM());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getIV_ITEM(), i);
                if (obj != null &&
                    !obj.getClass().isArray()) {
                    _hashCode += obj.hashCode();
                }
            }
        }
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
        new org.apache.axis.description.TypeDesc(IFMM038_BGT_S_DT_response.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://ildong.com/MM/BGT_ERP", "IFMM038_BGT_S_DT_response"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("IV_HEAD");
        elemField.setXmlName(new javax.xml.namespace.QName("", "IV_HEAD"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://ildong.com/MM/BGT_ERP", ">IFMM038_BGT_S_DT_response>IV_HEAD"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        elemField.setMaxOccursUnbounded(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("IV_ITEM");
        elemField.setXmlName(new javax.xml.namespace.QName("", "IV_ITEM"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://ildong.com/MM/BGT_ERP", ">IFMM038_BGT_S_DT_response>IV_ITEM"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        elemField.setMaxOccursUnbounded(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
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
