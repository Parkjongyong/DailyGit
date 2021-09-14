/**
 * IFFI015_BGT_S_DT_responseOUT_BANK.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.ildong.FI.BGT_ERP;

public class IFFI015_BGT_S_DT_responseOUT_BANK  implements java.io.Serializable {
    private java.lang.String PARTNER;

    private java.lang.String BVTYP;

    private java.lang.String BANKS;

    private java.lang.String BANKL;

    private java.lang.String BANKN;

    private java.lang.String BKREF;

    public IFFI015_BGT_S_DT_responseOUT_BANK() {
    }

    public IFFI015_BGT_S_DT_responseOUT_BANK(
           java.lang.String PARTNER,
           java.lang.String BVTYP,
           java.lang.String BANKS,
           java.lang.String BANKL,
           java.lang.String BANKN,
           java.lang.String BKREF) {
           this.PARTNER = PARTNER;
           this.BVTYP = BVTYP;
           this.BANKS = BANKS;
           this.BANKL = BANKL;
           this.BANKN = BANKN;
           this.BKREF = BKREF;
    }


    /**
     * Gets the PARTNER value for this IFFI015_BGT_S_DT_responseOUT_BANK.
     * 
     * @return PARTNER
     */
    public java.lang.String getPARTNER() {
        return PARTNER;
    }


    /**
     * Sets the PARTNER value for this IFFI015_BGT_S_DT_responseOUT_BANK.
     * 
     * @param PARTNER
     */
    public void setPARTNER(java.lang.String PARTNER) {
        this.PARTNER = PARTNER;
    }


    /**
     * Gets the BVTYP value for this IFFI015_BGT_S_DT_responseOUT_BANK.
     * 
     * @return BVTYP
     */
    public java.lang.String getBVTYP() {
        return BVTYP;
    }


    /**
     * Sets the BVTYP value for this IFFI015_BGT_S_DT_responseOUT_BANK.
     * 
     * @param BVTYP
     */
    public void setBVTYP(java.lang.String BVTYP) {
        this.BVTYP = BVTYP;
    }


    /**
     * Gets the BANKS value for this IFFI015_BGT_S_DT_responseOUT_BANK.
     * 
     * @return BANKS
     */
    public java.lang.String getBANKS() {
        return BANKS;
    }


    /**
     * Sets the BANKS value for this IFFI015_BGT_S_DT_responseOUT_BANK.
     * 
     * @param BANKS
     */
    public void setBANKS(java.lang.String BANKS) {
        this.BANKS = BANKS;
    }


    /**
     * Gets the BANKL value for this IFFI015_BGT_S_DT_responseOUT_BANK.
     * 
     * @return BANKL
     */
    public java.lang.String getBANKL() {
        return BANKL;
    }


    /**
     * Sets the BANKL value for this IFFI015_BGT_S_DT_responseOUT_BANK.
     * 
     * @param BANKL
     */
    public void setBANKL(java.lang.String BANKL) {
        this.BANKL = BANKL;
    }


    /**
     * Gets the BANKN value for this IFFI015_BGT_S_DT_responseOUT_BANK.
     * 
     * @return BANKN
     */
    public java.lang.String getBANKN() {
        return BANKN;
    }


    /**
     * Sets the BANKN value for this IFFI015_BGT_S_DT_responseOUT_BANK.
     * 
     * @param BANKN
     */
    public void setBANKN(java.lang.String BANKN) {
        this.BANKN = BANKN;
    }


    /**
     * Gets the BKREF value for this IFFI015_BGT_S_DT_responseOUT_BANK.
     * 
     * @return BKREF
     */
    public java.lang.String getBKREF() {
        return BKREF;
    }


    /**
     * Sets the BKREF value for this IFFI015_BGT_S_DT_responseOUT_BANK.
     * 
     * @param BKREF
     */
    public void setBKREF(java.lang.String BKREF) {
        this.BKREF = BKREF;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof IFFI015_BGT_S_DT_responseOUT_BANK)) return false;
        IFFI015_BGT_S_DT_responseOUT_BANK other = (IFFI015_BGT_S_DT_responseOUT_BANK) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.PARTNER==null && other.getPARTNER()==null) || 
             (this.PARTNER!=null &&
              this.PARTNER.equals(other.getPARTNER()))) &&
            ((this.BVTYP==null && other.getBVTYP()==null) || 
             (this.BVTYP!=null &&
              this.BVTYP.equals(other.getBVTYP()))) &&
            ((this.BANKS==null && other.getBANKS()==null) || 
             (this.BANKS!=null &&
              this.BANKS.equals(other.getBANKS()))) &&
            ((this.BANKL==null && other.getBANKL()==null) || 
             (this.BANKL!=null &&
              this.BANKL.equals(other.getBANKL()))) &&
            ((this.BANKN==null && other.getBANKN()==null) || 
             (this.BANKN!=null &&
              this.BANKN.equals(other.getBANKN()))) &&
            ((this.BKREF==null && other.getBKREF()==null) || 
             (this.BKREF!=null &&
              this.BKREF.equals(other.getBKREF())));
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
        if (getPARTNER() != null) {
            _hashCode += getPARTNER().hashCode();
        }
        if (getBVTYP() != null) {
            _hashCode += getBVTYP().hashCode();
        }
        if (getBANKS() != null) {
            _hashCode += getBANKS().hashCode();
        }
        if (getBANKL() != null) {
            _hashCode += getBANKL().hashCode();
        }
        if (getBANKN() != null) {
            _hashCode += getBANKN().hashCode();
        }
        if (getBKREF() != null) {
            _hashCode += getBKREF().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(IFFI015_BGT_S_DT_responseOUT_BANK.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://ildong.com/FI/BGT_ERP", ">IFFI015_BGT_S_DT_response>OUT_BANK"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("PARTNER");
        elemField.setXmlName(new javax.xml.namespace.QName("", "PARTNER"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("BVTYP");
        elemField.setXmlName(new javax.xml.namespace.QName("", "BVTYP"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("BANKS");
        elemField.setXmlName(new javax.xml.namespace.QName("", "BANKS"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("BANKL");
        elemField.setXmlName(new javax.xml.namespace.QName("", "BANKL"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("BANKN");
        elemField.setXmlName(new javax.xml.namespace.QName("", "BANKN"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("BKREF");
        elemField.setXmlName(new javax.xml.namespace.QName("", "BKREF"));
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
