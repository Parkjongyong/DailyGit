/**
 * IFCO010_BGT_S_DT.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.ildong.CO.BGT_ERP;

public class IFCO010_BGT_S_DT  implements java.io.Serializable {
    private java.lang.String i_BUKRS;

    private java.lang.String i_GJAHR;

    private java.lang.String i_MONAT;

    public IFCO010_BGT_S_DT() {
    }

    public IFCO010_BGT_S_DT(
           java.lang.String i_BUKRS,
           java.lang.String i_GJAHR,
           java.lang.String i_MONAT) {
           this.i_BUKRS = i_BUKRS;
           this.i_GJAHR = i_GJAHR;
           this.i_MONAT = i_MONAT;
    }


    /**
     * Gets the i_BUKRS value for this IFCO010_BGT_S_DT.
     * 
     * @return i_BUKRS
     */
    public java.lang.String getI_BUKRS() {
        return i_BUKRS;
    }


    /**
     * Sets the i_BUKRS value for this IFCO010_BGT_S_DT.
     * 
     * @param i_BUKRS
     */
    public void setI_BUKRS(java.lang.String i_BUKRS) {
        this.i_BUKRS = i_BUKRS;
    }


    /**
     * Gets the i_GJAHR value for this IFCO010_BGT_S_DT.
     * 
     * @return i_GJAHR
     */
    public java.lang.String getI_GJAHR() {
        return i_GJAHR;
    }


    /**
     * Sets the i_GJAHR value for this IFCO010_BGT_S_DT.
     * 
     * @param i_GJAHR
     */
    public void setI_GJAHR(java.lang.String i_GJAHR) {
        this.i_GJAHR = i_GJAHR;
    }


    /**
     * Gets the i_MONAT value for this IFCO010_BGT_S_DT.
     * 
     * @return i_MONAT
     */
    public java.lang.String getI_MONAT() {
        return i_MONAT;
    }


    /**
     * Sets the i_MONAT value for this IFCO010_BGT_S_DT.
     * 
     * @param i_MONAT
     */
    public void setI_MONAT(java.lang.String i_MONAT) {
        this.i_MONAT = i_MONAT;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof IFCO010_BGT_S_DT)) return false;
        IFCO010_BGT_S_DT other = (IFCO010_BGT_S_DT) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.i_BUKRS==null && other.getI_BUKRS()==null) || 
             (this.i_BUKRS!=null &&
              this.i_BUKRS.equals(other.getI_BUKRS()))) &&
            ((this.i_GJAHR==null && other.getI_GJAHR()==null) || 
             (this.i_GJAHR!=null &&
              this.i_GJAHR.equals(other.getI_GJAHR()))) &&
            ((this.i_MONAT==null && other.getI_MONAT()==null) || 
             (this.i_MONAT!=null &&
              this.i_MONAT.equals(other.getI_MONAT())));
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
        if (getI_BUKRS() != null) {
            _hashCode += getI_BUKRS().hashCode();
        }
        if (getI_GJAHR() != null) {
            _hashCode += getI_GJAHR().hashCode();
        }
        if (getI_MONAT() != null) {
            _hashCode += getI_MONAT().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(IFCO010_BGT_S_DT.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://ildong.com/CO/BGT_ERP", "IFCO010_BGT_S_DT"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("i_BUKRS");
        elemField.setXmlName(new javax.xml.namespace.QName("", "I_BUKRS"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("i_GJAHR");
        elemField.setXmlName(new javax.xml.namespace.QName("", "I_GJAHR"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("i_MONAT");
        elemField.setXmlName(new javax.xml.namespace.QName("", "I_MONAT"));
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
