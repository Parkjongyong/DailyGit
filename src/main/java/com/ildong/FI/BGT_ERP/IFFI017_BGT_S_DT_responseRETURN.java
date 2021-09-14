/**
 * IFFI017_BGT_S_DT_responseRETURN.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.ildong.FI.BGT_ERP;

public class IFFI017_BGT_S_DT_responseRETURN  implements java.io.Serializable {
    private java.lang.String GJAHR;

    private java.lang.String LEGACYNO;

    private java.lang.String BELNR;

    private java.lang.String DSTATE;

    private java.lang.String STBLG;

    private java.lang.String STJAH;

    private java.lang.String IF_FLAG;

    private java.lang.String IF_MSG;

    public IFFI017_BGT_S_DT_responseRETURN() {
    }

    public IFFI017_BGT_S_DT_responseRETURN(
           java.lang.String GJAHR,
           java.lang.String LEGACYNO,
           java.lang.String BELNR,
           java.lang.String DSTATE,
           java.lang.String STBLG,
           java.lang.String STJAH,
           java.lang.String IF_FLAG,
           java.lang.String IF_MSG) {
           this.GJAHR = GJAHR;
           this.LEGACYNO = LEGACYNO;
           this.BELNR = BELNR;
           this.DSTATE = DSTATE;
           this.STBLG = STBLG;
           this.STJAH = STJAH;
           this.IF_FLAG = IF_FLAG;
           this.IF_MSG = IF_MSG;
    }


    /**
     * Gets the GJAHR value for this IFFI017_BGT_S_DT_responseRETURN.
     * 
     * @return GJAHR
     */
    public java.lang.String getGJAHR() {
        return GJAHR;
    }


    /**
     * Sets the GJAHR value for this IFFI017_BGT_S_DT_responseRETURN.
     * 
     * @param GJAHR
     */
    public void setGJAHR(java.lang.String GJAHR) {
        this.GJAHR = GJAHR;
    }


    /**
     * Gets the LEGACYNO value for this IFFI017_BGT_S_DT_responseRETURN.
     * 
     * @return LEGACYNO
     */
    public java.lang.String getLEGACYNO() {
        return LEGACYNO;
    }


    /**
     * Sets the LEGACYNO value for this IFFI017_BGT_S_DT_responseRETURN.
     * 
     * @param LEGACYNO
     */
    public void setLEGACYNO(java.lang.String LEGACYNO) {
        this.LEGACYNO = LEGACYNO;
    }


    /**
     * Gets the BELNR value for this IFFI017_BGT_S_DT_responseRETURN.
     * 
     * @return BELNR
     */
    public java.lang.String getBELNR() {
        return BELNR;
    }


    /**
     * Sets the BELNR value for this IFFI017_BGT_S_DT_responseRETURN.
     * 
     * @param BELNR
     */
    public void setBELNR(java.lang.String BELNR) {
        this.BELNR = BELNR;
    }


    /**
     * Gets the DSTATE value for this IFFI017_BGT_S_DT_responseRETURN.
     * 
     * @return DSTATE
     */
    public java.lang.String getDSTATE() {
        return DSTATE;
    }


    /**
     * Sets the DSTATE value for this IFFI017_BGT_S_DT_responseRETURN.
     * 
     * @param DSTATE
     */
    public void setDSTATE(java.lang.String DSTATE) {
        this.DSTATE = DSTATE;
    }


    /**
     * Gets the STBLG value for this IFFI017_BGT_S_DT_responseRETURN.
     * 
     * @return STBLG
     */
    public java.lang.String getSTBLG() {
        return STBLG;
    }


    /**
     * Sets the STBLG value for this IFFI017_BGT_S_DT_responseRETURN.
     * 
     * @param STBLG
     */
    public void setSTBLG(java.lang.String STBLG) {
        this.STBLG = STBLG;
    }


    /**
     * Gets the STJAH value for this IFFI017_BGT_S_DT_responseRETURN.
     * 
     * @return STJAH
     */
    public java.lang.String getSTJAH() {
        return STJAH;
    }


    /**
     * Sets the STJAH value for this IFFI017_BGT_S_DT_responseRETURN.
     * 
     * @param STJAH
     */
    public void setSTJAH(java.lang.String STJAH) {
        this.STJAH = STJAH;
    }


    /**
     * Gets the IF_FLAG value for this IFFI017_BGT_S_DT_responseRETURN.
     * 
     * @return IF_FLAG
     */
    public java.lang.String getIF_FLAG() {
        return IF_FLAG;
    }


    /**
     * Sets the IF_FLAG value for this IFFI017_BGT_S_DT_responseRETURN.
     * 
     * @param IF_FLAG
     */
    public void setIF_FLAG(java.lang.String IF_FLAG) {
        this.IF_FLAG = IF_FLAG;
    }


    /**
     * Gets the IF_MSG value for this IFFI017_BGT_S_DT_responseRETURN.
     * 
     * @return IF_MSG
     */
    public java.lang.String getIF_MSG() {
        return IF_MSG;
    }


    /**
     * Sets the IF_MSG value for this IFFI017_BGT_S_DT_responseRETURN.
     * 
     * @param IF_MSG
     */
    public void setIF_MSG(java.lang.String IF_MSG) {
        this.IF_MSG = IF_MSG;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof IFFI017_BGT_S_DT_responseRETURN)) return false;
        IFFI017_BGT_S_DT_responseRETURN other = (IFFI017_BGT_S_DT_responseRETURN) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.GJAHR==null && other.getGJAHR()==null) || 
             (this.GJAHR!=null &&
              this.GJAHR.equals(other.getGJAHR()))) &&
            ((this.LEGACYNO==null && other.getLEGACYNO()==null) || 
             (this.LEGACYNO!=null &&
              this.LEGACYNO.equals(other.getLEGACYNO()))) &&
            ((this.BELNR==null && other.getBELNR()==null) || 
             (this.BELNR!=null &&
              this.BELNR.equals(other.getBELNR()))) &&
            ((this.DSTATE==null && other.getDSTATE()==null) || 
             (this.DSTATE!=null &&
              this.DSTATE.equals(other.getDSTATE()))) &&
            ((this.STBLG==null && other.getSTBLG()==null) || 
             (this.STBLG!=null &&
              this.STBLG.equals(other.getSTBLG()))) &&
            ((this.STJAH==null && other.getSTJAH()==null) || 
             (this.STJAH!=null &&
              this.STJAH.equals(other.getSTJAH()))) &&
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
        if (getGJAHR() != null) {
            _hashCode += getGJAHR().hashCode();
        }
        if (getLEGACYNO() != null) {
            _hashCode += getLEGACYNO().hashCode();
        }
        if (getBELNR() != null) {
            _hashCode += getBELNR().hashCode();
        }
        if (getDSTATE() != null) {
            _hashCode += getDSTATE().hashCode();
        }
        if (getSTBLG() != null) {
            _hashCode += getSTBLG().hashCode();
        }
        if (getSTJAH() != null) {
            _hashCode += getSTJAH().hashCode();
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
        new org.apache.axis.description.TypeDesc(IFFI017_BGT_S_DT_responseRETURN.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://ildong.com/FI/BGT_ERP", ">IFFI017_BGT_S_DT_response>RETURN"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("GJAHR");
        elemField.setXmlName(new javax.xml.namespace.QName("", "GJAHR"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("LEGACYNO");
        elemField.setXmlName(new javax.xml.namespace.QName("", "LEGACYNO"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("BELNR");
        elemField.setXmlName(new javax.xml.namespace.QName("", "BELNR"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("DSTATE");
        elemField.setXmlName(new javax.xml.namespace.QName("", "DSTATE"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("STBLG");
        elemField.setXmlName(new javax.xml.namespace.QName("", "STBLG"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("STJAH");
        elemField.setXmlName(new javax.xml.namespace.QName("", "STJAH"));
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
