/**
 * IFSD020_BGT_S_DT.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.ildong.SD.BGT_ERP;

public class IFSD020_BGT_S_DT  implements java.io.Serializable {
    private com.ildong.SD.BGT_ERP.IFSD020_BGT_S_DTHEADER HEADER;

    private com.ildong.SD.BGT_ERP.IFSD020_BGT_S_DTITEM[] ITEM;

    public IFSD020_BGT_S_DT() {
    }

    public IFSD020_BGT_S_DT(
           com.ildong.SD.BGT_ERP.IFSD020_BGT_S_DTHEADER HEADER,
           com.ildong.SD.BGT_ERP.IFSD020_BGT_S_DTITEM[] ITEM) {
           this.HEADER = HEADER;
           this.ITEM = ITEM;
    }


    /**
     * Gets the HEADER value for this IFSD020_BGT_S_DT.
     * 
     * @return HEADER
     */
    public com.ildong.SD.BGT_ERP.IFSD020_BGT_S_DTHEADER getHEADER() {
        return HEADER;
    }


    /**
     * Sets the HEADER value for this IFSD020_BGT_S_DT.
     * 
     * @param HEADER
     */
    public void setHEADER(com.ildong.SD.BGT_ERP.IFSD020_BGT_S_DTHEADER HEADER) {
        this.HEADER = HEADER;
    }


    /**
     * Gets the ITEM value for this IFSD020_BGT_S_DT.
     * 
     * @return ITEM
     */
    public com.ildong.SD.BGT_ERP.IFSD020_BGT_S_DTITEM[] getITEM() {
        return ITEM;
    }


    /**
     * Sets the ITEM value for this IFSD020_BGT_S_DT.
     * 
     * @param ITEM
     */
    public void setITEM(com.ildong.SD.BGT_ERP.IFSD020_BGT_S_DTITEM[] ITEM) {
        this.ITEM = ITEM;
    }

    public com.ildong.SD.BGT_ERP.IFSD020_BGT_S_DTITEM getITEM(int i) {
        return this.ITEM[i];
    }

    public void setITEM(int i, com.ildong.SD.BGT_ERP.IFSD020_BGT_S_DTITEM _value) {
        this.ITEM[i] = _value;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof IFSD020_BGT_S_DT)) return false;
        IFSD020_BGT_S_DT other = (IFSD020_BGT_S_DT) obj;
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
              this.HEADER.equals(other.getHEADER()))) &&
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
        if (getHEADER() != null) {
            _hashCode += getHEADER().hashCode();
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
        new org.apache.axis.description.TypeDesc(IFSD020_BGT_S_DT.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://ildong.com/SD/BGT_ERP", "IFSD020_BGT_S_DT"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("HEADER");
        elemField.setXmlName(new javax.xml.namespace.QName("", "HEADER"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://ildong.com/SD/BGT_ERP", ">IFSD020_BGT_S_DT>HEADER"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ITEM");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ITEM"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://ildong.com/SD/BGT_ERP", ">IFSD020_BGT_S_DT>ITEM"));
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
