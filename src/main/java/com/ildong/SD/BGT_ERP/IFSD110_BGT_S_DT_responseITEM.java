/**
 * IFSD110_BGT_S_DT_responseITEM.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.ildong.SD.BGT_ERP;

public class IFSD110_BGT_S_DT_responseITEM  implements java.io.Serializable {
    private java.lang.String PRODH;

    private java.lang.String STUFE;

    private java.lang.String VTEXT;

    public IFSD110_BGT_S_DT_responseITEM() {
    }

    public IFSD110_BGT_S_DT_responseITEM(
           java.lang.String PRODH,
           java.lang.String STUFE,
           java.lang.String VTEXT) {
           this.PRODH = PRODH;
           this.STUFE = STUFE;
           this.VTEXT = VTEXT;
    }


    /**
     * Gets the PRODH value for this IFSD110_BGT_S_DT_responseITEM.
     * 
     * @return PRODH
     */
    public java.lang.String getPRODH() {
        return PRODH;
    }


    /**
     * Sets the PRODH value for this IFSD110_BGT_S_DT_responseITEM.
     * 
     * @param PRODH
     */
    public void setPRODH(java.lang.String PRODH) {
        this.PRODH = PRODH;
    }


    /**
     * Gets the STUFE value for this IFSD110_BGT_S_DT_responseITEM.
     * 
     * @return STUFE
     */
    public java.lang.String getSTUFE() {
        return STUFE;
    }


    /**
     * Sets the STUFE value for this IFSD110_BGT_S_DT_responseITEM.
     * 
     * @param STUFE
     */
    public void setSTUFE(java.lang.String STUFE) {
        this.STUFE = STUFE;
    }


    /**
     * Gets the VTEXT value for this IFSD110_BGT_S_DT_responseITEM.
     * 
     * @return VTEXT
     */
    public java.lang.String getVTEXT() {
        return VTEXT;
    }


    /**
     * Sets the VTEXT value for this IFSD110_BGT_S_DT_responseITEM.
     * 
     * @param VTEXT
     */
    public void setVTEXT(java.lang.String VTEXT) {
        this.VTEXT = VTEXT;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof IFSD110_BGT_S_DT_responseITEM)) return false;
        IFSD110_BGT_S_DT_responseITEM other = (IFSD110_BGT_S_DT_responseITEM) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.PRODH==null && other.getPRODH()==null) || 
             (this.PRODH!=null &&
              this.PRODH.equals(other.getPRODH()))) &&
            ((this.STUFE==null && other.getSTUFE()==null) || 
             (this.STUFE!=null &&
              this.STUFE.equals(other.getSTUFE()))) &&
            ((this.VTEXT==null && other.getVTEXT()==null) || 
             (this.VTEXT!=null &&
              this.VTEXT.equals(other.getVTEXT())));
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
        if (getPRODH() != null) {
            _hashCode += getPRODH().hashCode();
        }
        if (getSTUFE() != null) {
            _hashCode += getSTUFE().hashCode();
        }
        if (getVTEXT() != null) {
            _hashCode += getVTEXT().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(IFSD110_BGT_S_DT_responseITEM.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://ildong.com/SD/BGT_ERP", ">IFSD110_BGT_S_DT_response>ITEM"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("PRODH");
        elemField.setXmlName(new javax.xml.namespace.QName("", "PRODH"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("STUFE");
        elemField.setXmlName(new javax.xml.namespace.QName("", "STUFE"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("VTEXT");
        elemField.setXmlName(new javax.xml.namespace.QName("", "VTEXT"));
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
