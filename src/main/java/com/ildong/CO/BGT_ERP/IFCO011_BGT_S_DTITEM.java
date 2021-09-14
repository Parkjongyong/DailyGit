/**
 * IFCO011_BGT_S_DTITEM.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.ildong.CO.BGT_ERP;

public class IFCO011_BGT_S_DTITEM  implements java.io.Serializable {
    private java.lang.String BUKRS;

    private java.lang.String ZCONO;

    private java.lang.String ZSEQ;

    private java.lang.String BMODEL;

    private java.lang.String ZCONO_TXT;

    public IFCO011_BGT_S_DTITEM() {
    }

    public IFCO011_BGT_S_DTITEM(
           java.lang.String BUKRS,
           java.lang.String ZCONO,
           java.lang.String ZSEQ,
           java.lang.String BMODEL,
           java.lang.String ZCONO_TXT) {
           this.BUKRS = BUKRS;
           this.ZCONO = ZCONO;
           this.ZSEQ = ZSEQ;
           this.BMODEL = BMODEL;
           this.ZCONO_TXT = ZCONO_TXT;
    }


    /**
     * Gets the BUKRS value for this IFCO011_BGT_S_DTITEM.
     * 
     * @return BUKRS
     */
    public java.lang.String getBUKRS() {
        return BUKRS;
    }


    /**
     * Sets the BUKRS value for this IFCO011_BGT_S_DTITEM.
     * 
     * @param BUKRS
     */
    public void setBUKRS(java.lang.String BUKRS) {
        this.BUKRS = BUKRS;
    }


    /**
     * Gets the ZCONO value for this IFCO011_BGT_S_DTITEM.
     * 
     * @return ZCONO
     */
    public java.lang.String getZCONO() {
        return ZCONO;
    }


    /**
     * Sets the ZCONO value for this IFCO011_BGT_S_DTITEM.
     * 
     * @param ZCONO
     */
    public void setZCONO(java.lang.String ZCONO) {
        this.ZCONO = ZCONO;
    }


    /**
     * Gets the ZSEQ value for this IFCO011_BGT_S_DTITEM.
     * 
     * @return ZSEQ
     */
    public java.lang.String getZSEQ() {
        return ZSEQ;
    }


    /**
     * Sets the ZSEQ value for this IFCO011_BGT_S_DTITEM.
     * 
     * @param ZSEQ
     */
    public void setZSEQ(java.lang.String ZSEQ) {
        this.ZSEQ = ZSEQ;
    }


    /**
     * Gets the BMODEL value for this IFCO011_BGT_S_DTITEM.
     * 
     * @return BMODEL
     */
    public java.lang.String getBMODEL() {
        return BMODEL;
    }


    /**
     * Sets the BMODEL value for this IFCO011_BGT_S_DTITEM.
     * 
     * @param BMODEL
     */
    public void setBMODEL(java.lang.String BMODEL) {
        this.BMODEL = BMODEL;
    }


    /**
     * Gets the ZCONO_TXT value for this IFCO011_BGT_S_DTITEM.
     * 
     * @return ZCONO_TXT
     */
    public java.lang.String getZCONO_TXT() {
        return ZCONO_TXT;
    }


    /**
     * Sets the ZCONO_TXT value for this IFCO011_BGT_S_DTITEM.
     * 
     * @param ZCONO_TXT
     */
    public void setZCONO_TXT(java.lang.String ZCONO_TXT) {
        this.ZCONO_TXT = ZCONO_TXT;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof IFCO011_BGT_S_DTITEM)) return false;
        IFCO011_BGT_S_DTITEM other = (IFCO011_BGT_S_DTITEM) obj;
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
            ((this.ZCONO==null && other.getZCONO()==null) || 
             (this.ZCONO!=null &&
              this.ZCONO.equals(other.getZCONO()))) &&
            ((this.ZSEQ==null && other.getZSEQ()==null) || 
             (this.ZSEQ!=null &&
              this.ZSEQ.equals(other.getZSEQ()))) &&
            ((this.BMODEL==null && other.getBMODEL()==null) || 
             (this.BMODEL!=null &&
              this.BMODEL.equals(other.getBMODEL()))) &&
            ((this.ZCONO_TXT==null && other.getZCONO_TXT()==null) || 
             (this.ZCONO_TXT!=null &&
              this.ZCONO_TXT.equals(other.getZCONO_TXT())));
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
        if (getZCONO() != null) {
            _hashCode += getZCONO().hashCode();
        }
        if (getZSEQ() != null) {
            _hashCode += getZSEQ().hashCode();
        }
        if (getBMODEL() != null) {
            _hashCode += getBMODEL().hashCode();
        }
        if (getZCONO_TXT() != null) {
            _hashCode += getZCONO_TXT().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(IFCO011_BGT_S_DTITEM.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://ildong.com/CO/BGT_ERP", ">IFCO011_BGT_S_DT>ITEM"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("BUKRS");
        elemField.setXmlName(new javax.xml.namespace.QName("", "BUKRS"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ZCONO");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ZCONO"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ZSEQ");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ZSEQ"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("BMODEL");
        elemField.setXmlName(new javax.xml.namespace.QName("", "BMODEL"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ZCONO_TXT");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ZCONO_TXT"));
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
