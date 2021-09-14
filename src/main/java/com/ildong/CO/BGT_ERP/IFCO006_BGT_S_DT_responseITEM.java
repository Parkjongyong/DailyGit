/**
 * IFCO006_BGT_S_DT_responseITEM.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.ildong.CO.BGT_ERP;

public class IFCO006_BGT_S_DT_responseITEM  implements java.io.Serializable {
    private java.lang.String BUKRS;

    private java.lang.String SPMON;

    private java.lang.String KOSTL;

    private java.lang.String KSTAR;

    private java.lang.String ZAMT1;

    private java.lang.String ZAMT2;

    public IFCO006_BGT_S_DT_responseITEM() {
    }

    public IFCO006_BGT_S_DT_responseITEM(
           java.lang.String BUKRS,
           java.lang.String SPMON,
           java.lang.String KOSTL,
           java.lang.String KSTAR,
           java.lang.String ZAMT1,
           java.lang.String ZAMT2) {
           this.BUKRS = BUKRS;
           this.SPMON = SPMON;
           this.KOSTL = KOSTL;
           this.KSTAR = KSTAR;
           this.ZAMT1 = ZAMT1;
           this.ZAMT2 = ZAMT2;
    }


    /**
     * Gets the BUKRS value for this IFCO006_BGT_S_DT_responseITEM.
     * 
     * @return BUKRS
     */
    public java.lang.String getBUKRS() {
        return BUKRS;
    }


    /**
     * Sets the BUKRS value for this IFCO006_BGT_S_DT_responseITEM.
     * 
     * @param BUKRS
     */
    public void setBUKRS(java.lang.String BUKRS) {
        this.BUKRS = BUKRS;
    }


    /**
     * Gets the SPMON value for this IFCO006_BGT_S_DT_responseITEM.
     * 
     * @return SPMON
     */
    public java.lang.String getSPMON() {
        return SPMON;
    }


    /**
     * Sets the SPMON value for this IFCO006_BGT_S_DT_responseITEM.
     * 
     * @param SPMON
     */
    public void setSPMON(java.lang.String SPMON) {
        this.SPMON = SPMON;
    }


    /**
     * Gets the KOSTL value for this IFCO006_BGT_S_DT_responseITEM.
     * 
     * @return KOSTL
     */
    public java.lang.String getKOSTL() {
        return KOSTL;
    }


    /**
     * Sets the KOSTL value for this IFCO006_BGT_S_DT_responseITEM.
     * 
     * @param KOSTL
     */
    public void setKOSTL(java.lang.String KOSTL) {
        this.KOSTL = KOSTL;
    }


    /**
     * Gets the KSTAR value for this IFCO006_BGT_S_DT_responseITEM.
     * 
     * @return KSTAR
     */
    public java.lang.String getKSTAR() {
        return KSTAR;
    }


    /**
     * Sets the KSTAR value for this IFCO006_BGT_S_DT_responseITEM.
     * 
     * @param KSTAR
     */
    public void setKSTAR(java.lang.String KSTAR) {
        this.KSTAR = KSTAR;
    }


    /**
     * Gets the ZAMT1 value for this IFCO006_BGT_S_DT_responseITEM.
     * 
     * @return ZAMT1
     */
    public java.lang.String getZAMT1() {
        return ZAMT1;
    }


    /**
     * Sets the ZAMT1 value for this IFCO006_BGT_S_DT_responseITEM.
     * 
     * @param ZAMT1
     */
    public void setZAMT1(java.lang.String ZAMT1) {
        this.ZAMT1 = ZAMT1;
    }


    /**
     * Gets the ZAMT2 value for this IFCO006_BGT_S_DT_responseITEM.
     * 
     * @return ZAMT2
     */
    public java.lang.String getZAMT2() {
        return ZAMT2;
    }


    /**
     * Sets the ZAMT2 value for this IFCO006_BGT_S_DT_responseITEM.
     * 
     * @param ZAMT2
     */
    public void setZAMT2(java.lang.String ZAMT2) {
        this.ZAMT2 = ZAMT2;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof IFCO006_BGT_S_DT_responseITEM)) return false;
        IFCO006_BGT_S_DT_responseITEM other = (IFCO006_BGT_S_DT_responseITEM) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.BUKRS==null && other.getBUKRS()==null) || 
             (this.BUKRS!=null &&
              this.BUKRS.equals(other.getBUKRS()))) &&
            ((this.SPMON==null && other.getSPMON()==null) || 
             (this.SPMON!=null &&
              this.SPMON.equals(other.getSPMON()))) &&
            ((this.KOSTL==null && other.getKOSTL()==null) || 
             (this.KOSTL!=null &&
              this.KOSTL.equals(other.getKOSTL()))) &&
            ((this.KSTAR==null && other.getKSTAR()==null) || 
             (this.KSTAR!=null &&
              this.KSTAR.equals(other.getKSTAR()))) &&
            ((this.ZAMT1==null && other.getZAMT1()==null) || 
             (this.ZAMT1!=null &&
              this.ZAMT1.equals(other.getZAMT1()))) &&
            ((this.ZAMT2==null && other.getZAMT2()==null) || 
             (this.ZAMT2!=null &&
              this.ZAMT2.equals(other.getZAMT2())));
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
        if (getBUKRS() != null) {
            _hashCode += getBUKRS().hashCode();
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
        if (getZAMT1() != null) {
            _hashCode += getZAMT1().hashCode();
        }
        if (getZAMT2() != null) {
            _hashCode += getZAMT2().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(IFCO006_BGT_S_DT_responseITEM.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://ildong.com/CO/BGT_ERP", ">IFCO006_BGT_S_DT_response>ITEM"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("BUKRS");
        elemField.setXmlName(new javax.xml.namespace.QName("", "BUKRS"));
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
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ZAMT1");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ZAMT1"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ZAMT2");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ZAMT2"));
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
