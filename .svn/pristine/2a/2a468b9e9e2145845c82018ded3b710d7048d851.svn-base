/**
 * IFSD113_BGT_S_DT_response.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.ildong.SD.BGT_ERP;

public class IFSD113_BGT_S_DT_response  implements java.io.Serializable {
    private java.lang.String IF_MSG;

    private java.lang.String IF_FLAG;

    private com.ildong.SD.BGT_ERP.IFSD113_BGT_S_DT_responseITEM[] ITEM;

    public IFSD113_BGT_S_DT_response() {
    }

    public IFSD113_BGT_S_DT_response(
           java.lang.String IF_MSG,
           java.lang.String IF_FLAG,
           com.ildong.SD.BGT_ERP.IFSD113_BGT_S_DT_responseITEM[] ITEM) {
           this.IF_MSG = IF_MSG;
           this.IF_FLAG = IF_FLAG;
           this.ITEM = ITEM;
    }


    /**
     * Gets the IF_MSG value for this IFSD113_BGT_S_DT_response.
     * 
     * @return IF_MSG
     */
    public java.lang.String getIF_MSG() {
        return IF_MSG;
    }


    /**
     * Sets the IF_MSG value for this IFSD113_BGT_S_DT_response.
     * 
     * @param IF_MSG
     */
    public void setIF_MSG(java.lang.String IF_MSG) {
        this.IF_MSG = IF_MSG;
    }


    /**
     * Gets the IF_FLAG value for this IFSD113_BGT_S_DT_response.
     * 
     * @return IF_FLAG
     */
    public java.lang.String getIF_FLAG() {
        return IF_FLAG;
    }


    /**
     * Sets the IF_FLAG value for this IFSD113_BGT_S_DT_response.
     * 
     * @param IF_FLAG
     */
    public void setIF_FLAG(java.lang.String IF_FLAG) {
        this.IF_FLAG = IF_FLAG;
    }


    /**
     * Gets the ITEM value for this IFSD113_BGT_S_DT_response.
     * 
     * @return ITEM
     */
    public com.ildong.SD.BGT_ERP.IFSD113_BGT_S_DT_responseITEM[] getITEM() {
        return ITEM;
    }


    /**
     * Sets the ITEM value for this IFSD113_BGT_S_DT_response.
     * 
     * @param ITEM
     */
    public void setITEM(com.ildong.SD.BGT_ERP.IFSD113_BGT_S_DT_responseITEM[] ITEM) {
        this.ITEM = ITEM;
    }

    public com.ildong.SD.BGT_ERP.IFSD113_BGT_S_DT_responseITEM getITEM(int i) {
        return this.ITEM[i];
    }

    public void setITEM(int i, com.ildong.SD.BGT_ERP.IFSD113_BGT_S_DT_responseITEM _value) {
        this.ITEM[i] = _value;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof IFSD113_BGT_S_DT_response)) return false;
        IFSD113_BGT_S_DT_response other = (IFSD113_BGT_S_DT_response) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.IF_MSG==null && other.getIF_MSG()==null) || 
             (this.IF_MSG!=null &&
              this.IF_MSG.equals(other.getIF_MSG()))) &&
            ((this.IF_FLAG==null && other.getIF_FLAG()==null) || 
             (this.IF_FLAG!=null &&
              this.IF_FLAG.equals(other.getIF_FLAG()))) &&
            ((this.ITEM==null && other.getITEM()==null) || 
             (this.ITEM!=null &&
              java.util.Arrays.equals(this.ITEM, other.getITEM())));
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
        if (getIF_MSG() != null) {
            _hashCode += getIF_MSG().hashCode();
        }
        if (getIF_FLAG() != null) {
            _hashCode += getIF_FLAG().hashCode();
        }
        if (getITEM() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getITEM());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getITEM(), i);
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
        new org.apache.axis.description.TypeDesc(IFSD113_BGT_S_DT_response.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://ildong.com/SD/BGT_ERP", "IFSD113_BGT_S_DT_response"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("IF_MSG");
        elemField.setXmlName(new javax.xml.namespace.QName("", "IF_MSG"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("IF_FLAG");
        elemField.setXmlName(new javax.xml.namespace.QName("", "IF_FLAG"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ITEM");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ITEM"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://ildong.com/SD/BGT_ERP", ">IFSD113_BGT_S_DT_response>ITEM"));
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
