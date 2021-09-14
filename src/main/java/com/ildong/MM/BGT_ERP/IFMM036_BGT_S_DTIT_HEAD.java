/**
 * IFMM036_BGT_S_DTIT_HEAD.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.ildong.MM.BGT_ERP;

public class IFMM036_BGT_S_DTIT_HEAD  implements java.io.Serializable {
    private java.lang.String BUKRS;

    private java.lang.String EBELN;

    private java.lang.String EBELP;

    private java.lang.String LABNR;

    private java.lang.String ZEDATE;

    private java.lang.String ZSREASON;

    public IFMM036_BGT_S_DTIT_HEAD() {
    }

    public IFMM036_BGT_S_DTIT_HEAD(
           java.lang.String BUKRS,
           java.lang.String EBELN,
           java.lang.String EBELP,
           java.lang.String LABNR,
           java.lang.String ZEDATE,
           java.lang.String ZSREASON) {
           this.BUKRS = BUKRS;
           this.EBELN = EBELN;
           this.EBELP = EBELP;
           this.LABNR = LABNR;
           this.ZEDATE = ZEDATE;
           this.ZSREASON = ZSREASON;
    }


    /**
     * Gets the BUKRS value for this IFMM036_BGT_S_DTIT_HEAD.
     * 
     * @return BUKRS
     */
    public java.lang.String getBUKRS() {
        return BUKRS;
    }


    /**
     * Sets the BUKRS value for this IFMM036_BGT_S_DTIT_HEAD.
     * 
     * @param BUKRS
     */
    public void setBUKRS(java.lang.String BUKRS) {
        this.BUKRS = BUKRS;
    }


    /**
     * Gets the EBELN value for this IFMM036_BGT_S_DTIT_HEAD.
     * 
     * @return EBELN
     */
    public java.lang.String getEBELN() {
        return EBELN;
    }


    /**
     * Sets the EBELN value for this IFMM036_BGT_S_DTIT_HEAD.
     * 
     * @param EBELN
     */
    public void setEBELN(java.lang.String EBELN) {
        this.EBELN = EBELN;
    }


    /**
     * Gets the EBELP value for this IFMM036_BGT_S_DTIT_HEAD.
     * 
     * @return EBELP
     */
    public java.lang.String getEBELP() {
        return EBELP;
    }


    /**
     * Sets the EBELP value for this IFMM036_BGT_S_DTIT_HEAD.
     * 
     * @param EBELP
     */
    public void setEBELP(java.lang.String EBELP) {
        this.EBELP = EBELP;
    }


    /**
     * Gets the LABNR value for this IFMM036_BGT_S_DTIT_HEAD.
     * 
     * @return LABNR
     */
    public java.lang.String getLABNR() {
        return LABNR;
    }


    /**
     * Sets the LABNR value for this IFMM036_BGT_S_DTIT_HEAD.
     * 
     * @param LABNR
     */
    public void setLABNR(java.lang.String LABNR) {
        this.LABNR = LABNR;
    }


    /**
     * Gets the ZEDATE value for this IFMM036_BGT_S_DTIT_HEAD.
     * 
     * @return ZEDATE
     */
    public java.lang.String getZEDATE() {
        return ZEDATE;
    }


    /**
     * Sets the ZEDATE value for this IFMM036_BGT_S_DTIT_HEAD.
     * 
     * @param ZEDATE
     */
    public void setZEDATE(java.lang.String ZEDATE) {
        this.ZEDATE = ZEDATE;
    }


    /**
     * Gets the ZSREASON value for this IFMM036_BGT_S_DTIT_HEAD.
     * 
     * @return ZSREASON
     */
    public java.lang.String getZSREASON() {
        return ZSREASON;
    }


    /**
     * Sets the ZSREASON value for this IFMM036_BGT_S_DTIT_HEAD.
     * 
     * @param ZSREASON
     */
    public void setZSREASON(java.lang.String ZSREASON) {
        this.ZSREASON = ZSREASON;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof IFMM036_BGT_S_DTIT_HEAD)) return false;
        IFMM036_BGT_S_DTIT_HEAD other = (IFMM036_BGT_S_DTIT_HEAD) obj;
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
            ((this.EBELN==null && other.getEBELN()==null) || 
             (this.EBELN!=null &&
              this.EBELN.equals(other.getEBELN()))) &&
            ((this.EBELP==null && other.getEBELP()==null) || 
             (this.EBELP!=null &&
              this.EBELP.equals(other.getEBELP()))) &&
            ((this.LABNR==null && other.getLABNR()==null) || 
             (this.LABNR!=null &&
              this.LABNR.equals(other.getLABNR()))) &&
            ((this.ZEDATE==null && other.getZEDATE()==null) || 
             (this.ZEDATE!=null &&
              this.ZEDATE.equals(other.getZEDATE()))) &&
            ((this.ZSREASON==null && other.getZSREASON()==null) || 
             (this.ZSREASON!=null &&
              this.ZSREASON.equals(other.getZSREASON())));
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
        if (getEBELN() != null) {
            _hashCode += getEBELN().hashCode();
        }
        if (getEBELP() != null) {
            _hashCode += getEBELP().hashCode();
        }
        if (getLABNR() != null) {
            _hashCode += getLABNR().hashCode();
        }
        if (getZEDATE() != null) {
            _hashCode += getZEDATE().hashCode();
        }
        if (getZSREASON() != null) {
            _hashCode += getZSREASON().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(IFMM036_BGT_S_DTIT_HEAD.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://ildong.com/MM/BGT_ERP", ">IFMM036_BGT_S_DT>IT_HEAD"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("BUKRS");
        elemField.setXmlName(new javax.xml.namespace.QName("", "BUKRS"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("EBELN");
        elemField.setXmlName(new javax.xml.namespace.QName("", "EBELN"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("EBELP");
        elemField.setXmlName(new javax.xml.namespace.QName("", "EBELP"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("LABNR");
        elemField.setXmlName(new javax.xml.namespace.QName("", "LABNR"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ZEDATE");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ZEDATE"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ZSREASON");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ZSREASON"));
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
