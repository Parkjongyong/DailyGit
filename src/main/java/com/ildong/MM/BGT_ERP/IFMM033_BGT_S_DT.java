/**
 * IFMM033_BGT_S_DT.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.ildong.MM.BGT_ERP;

public class IFMM033_BGT_S_DT  implements java.io.Serializable {
    private java.lang.String i_UDATE_FR;

    private java.lang.String i_UTIME_FR;

    private java.lang.String i_UDATE_TO;

    private java.lang.String i_UTIME_TO;

    private java.lang.String i_LIFNR;

    public IFMM033_BGT_S_DT() {
    }

    public IFMM033_BGT_S_DT(
           java.lang.String i_UDATE_FR,
           java.lang.String i_UTIME_FR,
           java.lang.String i_UDATE_TO,
           java.lang.String i_UTIME_TO,
           java.lang.String i_LIFNR) {
           this.i_UDATE_FR = i_UDATE_FR;
           this.i_UTIME_FR = i_UTIME_FR;
           this.i_UDATE_TO = i_UDATE_TO;
           this.i_UTIME_TO = i_UTIME_TO;
           this.i_LIFNR = i_LIFNR;
    }


    /**
     * Gets the i_UDATE_FR value for this IFMM033_BGT_S_DT.
     * 
     * @return i_UDATE_FR
     */
    public java.lang.String getI_UDATE_FR() {
        return i_UDATE_FR;
    }


    /**
     * Sets the i_UDATE_FR value for this IFMM033_BGT_S_DT.
     * 
     * @param i_UDATE_FR
     */
    public void setI_UDATE_FR(java.lang.String i_UDATE_FR) {
        this.i_UDATE_FR = i_UDATE_FR;
    }


    /**
     * Gets the i_UTIME_FR value for this IFMM033_BGT_S_DT.
     * 
     * @return i_UTIME_FR
     */
    public java.lang.String getI_UTIME_FR() {
        return i_UTIME_FR;
    }


    /**
     * Sets the i_UTIME_FR value for this IFMM033_BGT_S_DT.
     * 
     * @param i_UTIME_FR
     */
    public void setI_UTIME_FR(java.lang.String i_UTIME_FR) {
        this.i_UTIME_FR = i_UTIME_FR;
    }


    /**
     * Gets the i_UDATE_TO value for this IFMM033_BGT_S_DT.
     * 
     * @return i_UDATE_TO
     */
    public java.lang.String getI_UDATE_TO() {
        return i_UDATE_TO;
    }


    /**
     * Sets the i_UDATE_TO value for this IFMM033_BGT_S_DT.
     * 
     * @param i_UDATE_TO
     */
    public void setI_UDATE_TO(java.lang.String i_UDATE_TO) {
        this.i_UDATE_TO = i_UDATE_TO;
    }


    /**
     * Gets the i_UTIME_TO value for this IFMM033_BGT_S_DT.
     * 
     * @return i_UTIME_TO
     */
    public java.lang.String getI_UTIME_TO() {
        return i_UTIME_TO;
    }


    /**
     * Sets the i_UTIME_TO value for this IFMM033_BGT_S_DT.
     * 
     * @param i_UTIME_TO
     */
    public void setI_UTIME_TO(java.lang.String i_UTIME_TO) {
        this.i_UTIME_TO = i_UTIME_TO;
    }


    /**
     * Gets the i_LIFNR value for this IFMM033_BGT_S_DT.
     * 
     * @return i_LIFNR
     */
    public java.lang.String getI_LIFNR() {
        return i_LIFNR;
    }


    /**
     * Sets the i_LIFNR value for this IFMM033_BGT_S_DT.
     * 
     * @param i_LIFNR
     */
    public void setI_LIFNR(java.lang.String i_LIFNR) {
        this.i_LIFNR = i_LIFNR;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof IFMM033_BGT_S_DT)) return false;
        IFMM033_BGT_S_DT other = (IFMM033_BGT_S_DT) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.i_UDATE_FR==null && other.getI_UDATE_FR()==null) || 
             (this.i_UDATE_FR!=null &&
              this.i_UDATE_FR.equals(other.getI_UDATE_FR()))) &&
            ((this.i_UTIME_FR==null && other.getI_UTIME_FR()==null) || 
             (this.i_UTIME_FR!=null &&
              this.i_UTIME_FR.equals(other.getI_UTIME_FR()))) &&
            ((this.i_UDATE_TO==null && other.getI_UDATE_TO()==null) || 
             (this.i_UDATE_TO!=null &&
              this.i_UDATE_TO.equals(other.getI_UDATE_TO()))) &&
            ((this.i_UTIME_TO==null && other.getI_UTIME_TO()==null) || 
             (this.i_UTIME_TO!=null &&
              this.i_UTIME_TO.equals(other.getI_UTIME_TO()))) &&
            ((this.i_LIFNR==null && other.getI_LIFNR()==null) || 
             (this.i_LIFNR!=null &&
              this.i_LIFNR.equals(other.getI_LIFNR())));
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
        if (getI_UDATE_FR() != null) {
            _hashCode += getI_UDATE_FR().hashCode();
        }
        if (getI_UTIME_FR() != null) {
            _hashCode += getI_UTIME_FR().hashCode();
        }
        if (getI_UDATE_TO() != null) {
            _hashCode += getI_UDATE_TO().hashCode();
        }
        if (getI_UTIME_TO() != null) {
            _hashCode += getI_UTIME_TO().hashCode();
        }
        if (getI_LIFNR() != null) {
            _hashCode += getI_LIFNR().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(IFMM033_BGT_S_DT.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://ildong.com/MM/BGT_ERP", "IFMM033_BGT_S_DT"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("i_UDATE_FR");
        elemField.setXmlName(new javax.xml.namespace.QName("", "I_UDATE_FR"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("i_UTIME_FR");
        elemField.setXmlName(new javax.xml.namespace.QName("", "I_UTIME_FR"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("i_UDATE_TO");
        elemField.setXmlName(new javax.xml.namespace.QName("", "I_UDATE_TO"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("i_UTIME_TO");
        elemField.setXmlName(new javax.xml.namespace.QName("", "I_UTIME_TO"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("i_LIFNR");
        elemField.setXmlName(new javax.xml.namespace.QName("", "I_LIFNR"));
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
