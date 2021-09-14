/**
 * IFCO006_BGT_S_DT.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.ildong.CO.BGT_ERP;

public class IFCO006_BGT_S_DT  implements java.io.Serializable {
    private java.lang.String i_BUKRS;

    private java.lang.String SPMON;

    private java.lang.String KOSTL;

    private java.lang.String KSTAR;

    public IFCO006_BGT_S_DT() {
    }

    public IFCO006_BGT_S_DT(
           java.lang.String i_BUKRS,
           java.lang.String SPMON,
           java.lang.String KOSTL,
           java.lang.String KSTAR) {
           this.i_BUKRS = i_BUKRS;
           this.SPMON = SPMON;
           this.KOSTL = KOSTL;
           this.KSTAR = KSTAR;
    }


    /**
     * Gets the i_BUKRS value for this IFCO006_BGT_S_DT.
     * 
     * @return i_BUKRS
     */
    public java.lang.String getI_BUKRS() {
        return i_BUKRS;
    }


    /**
     * Sets the i_BUKRS value for this IFCO006_BGT_S_DT.
     * 
     * @param i_BUKRS
     */
    public void setI_BUKRS(java.lang.String i_BUKRS) {
        this.i_BUKRS = i_BUKRS;
    }


    /**
     * Gets the SPMON value for this IFCO006_BGT_S_DT.
     * 
     * @return SPMON
     */
    public java.lang.String getSPMON() {
        return SPMON;
    }


    /**
     * Sets the SPMON value for this IFCO006_BGT_S_DT.
     * 
     * @param SPMON
     */
    public void setSPMON(java.lang.String SPMON) {
        this.SPMON = SPMON;
    }


    /**
     * Gets the KOSTL value for this IFCO006_BGT_S_DT.
     * 
     * @return KOSTL
     */
    public java.lang.String getKOSTL() {
        return KOSTL;
    }


    /**
     * Sets the KOSTL value for this IFCO006_BGT_S_DT.
     * 
     * @param KOSTL
     */
    public void setKOSTL(java.lang.String KOSTL) {
        this.KOSTL = KOSTL;
    }


    /**
     * Gets the KSTAR value for this IFCO006_BGT_S_DT.
     * 
     * @return KSTAR
     */
    public java.lang.String getKSTAR() {
        return KSTAR;
    }


    /**
     * Sets the KSTAR value for this IFCO006_BGT_S_DT.
     * 
     * @param KSTAR
     */
    public void setKSTAR(java.lang.String KSTAR) {
        this.KSTAR = KSTAR;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof IFCO006_BGT_S_DT)) return false;
        IFCO006_BGT_S_DT other = (IFCO006_BGT_S_DT) obj;
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
            ((this.SPMON==null && other.getSPMON()==null) || 
             (this.SPMON!=null &&
              this.SPMON.equals(other.getSPMON()))) &&
            ((this.KOSTL==null && other.getKOSTL()==null) || 
             (this.KOSTL!=null &&
              this.KOSTL.equals(other.getKOSTL()))) &&
            ((this.KSTAR==null && other.getKSTAR()==null) || 
             (this.KSTAR!=null &&
              this.KSTAR.equals(other.getKSTAR())));
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
        if (getSPMON() != null) {
            _hashCode += getSPMON().hashCode();
        }
        if (getKOSTL() != null) {
            _hashCode += getKOSTL().hashCode();
        }
        if (getKSTAR() != null) {
            _hashCode += getKSTAR().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(IFCO006_BGT_S_DT.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://ildong.com/CO/BGT_ERP", "IFCO006_BGT_S_DT"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("i_BUKRS");
        elemField.setXmlName(new javax.xml.namespace.QName("", "I_BUKRS"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("SPMON");
        elemField.setXmlName(new javax.xml.namespace.QName("", "SPMON"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("KOSTL");
        elemField.setXmlName(new javax.xml.namespace.QName("", "KOSTL"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("KSTAR");
        elemField.setXmlName(new javax.xml.namespace.QName("", "KSTAR"));
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
