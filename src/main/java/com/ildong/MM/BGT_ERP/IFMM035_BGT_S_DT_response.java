/**
 * IFMM035_BGT_S_DT_response.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.ildong.MM.BGT_ERP;

public class IFMM035_BGT_S_DT_response  implements java.io.Serializable {
    private com.ildong.MM.BGT_ERP.IFMM035_BGT_S_DT_responsePO_HEAD[] PO_HEAD;

    private com.ildong.MM.BGT_ERP.IFMM035_BGT_S_DT_responsePO_ITEM[] PO_ITEM;

    private com.ildong.MM.BGT_ERP.IFMM035_BGT_S_DT_responsePO_HEAD_REMARK[] PO_HEAD_REMARK;

    private com.ildong.MM.BGT_ERP.IFMM035_BGT_S_DT_responsePO_ITEM_REMARK[] PO_ITEM_REMARK;

    private java.lang.String IF_FLAG;

    private java.lang.String IF_MSG;

    public IFMM035_BGT_S_DT_response() {
    }

    public IFMM035_BGT_S_DT_response(
           com.ildong.MM.BGT_ERP.IFMM035_BGT_S_DT_responsePO_HEAD[] PO_HEAD,
           com.ildong.MM.BGT_ERP.IFMM035_BGT_S_DT_responsePO_ITEM[] PO_ITEM,
           com.ildong.MM.BGT_ERP.IFMM035_BGT_S_DT_responsePO_HEAD_REMARK[] PO_HEAD_REMARK,
           com.ildong.MM.BGT_ERP.IFMM035_BGT_S_DT_responsePO_ITEM_REMARK[] PO_ITEM_REMARK,
           java.lang.String IF_FLAG,
           java.lang.String IF_MSG) {
           this.PO_HEAD = PO_HEAD;
           this.PO_ITEM = PO_ITEM;
           this.PO_HEAD_REMARK = PO_HEAD_REMARK;
           this.PO_ITEM_REMARK = PO_ITEM_REMARK;
           this.IF_FLAG = IF_FLAG;
           this.IF_MSG = IF_MSG;
    }


    /**
     * Gets the PO_HEAD value for this IFMM035_BGT_S_DT_response.
     * 
     * @return PO_HEAD
     */
    public com.ildong.MM.BGT_ERP.IFMM035_BGT_S_DT_responsePO_HEAD[] getPO_HEAD() {
        return PO_HEAD;
    }


    /**
     * Sets the PO_HEAD value for this IFMM035_BGT_S_DT_response.
     * 
     * @param PO_HEAD
     */
    public void setPO_HEAD(com.ildong.MM.BGT_ERP.IFMM035_BGT_S_DT_responsePO_HEAD[] PO_HEAD) {
        this.PO_HEAD = PO_HEAD;
    }

    public com.ildong.MM.BGT_ERP.IFMM035_BGT_S_DT_responsePO_HEAD getPO_HEAD(int i) {
        return this.PO_HEAD[i];
    }

    public void setPO_HEAD(int i, com.ildong.MM.BGT_ERP.IFMM035_BGT_S_DT_responsePO_HEAD _value) {
        this.PO_HEAD[i] = _value;
    }


    /**
     * Gets the PO_ITEM value for this IFMM035_BGT_S_DT_response.
     * 
     * @return PO_ITEM
     */
    public com.ildong.MM.BGT_ERP.IFMM035_BGT_S_DT_responsePO_ITEM[] getPO_ITEM() {
        return PO_ITEM;
    }


    /**
     * Sets the PO_ITEM value for this IFMM035_BGT_S_DT_response.
     * 
     * @param PO_ITEM
     */
    public void setPO_ITEM(com.ildong.MM.BGT_ERP.IFMM035_BGT_S_DT_responsePO_ITEM[] PO_ITEM) {
        this.PO_ITEM = PO_ITEM;
    }

    public com.ildong.MM.BGT_ERP.IFMM035_BGT_S_DT_responsePO_ITEM getPO_ITEM(int i) {
        return this.PO_ITEM[i];
    }

    public void setPO_ITEM(int i, com.ildong.MM.BGT_ERP.IFMM035_BGT_S_DT_responsePO_ITEM _value) {
        this.PO_ITEM[i] = _value;
    }


    /**
     * Gets the PO_HEAD_REMARK value for this IFMM035_BGT_S_DT_response.
     * 
     * @return PO_HEAD_REMARK
     */
    public com.ildong.MM.BGT_ERP.IFMM035_BGT_S_DT_responsePO_HEAD_REMARK[] getPO_HEAD_REMARK() {
        return PO_HEAD_REMARK;
    }


    /**
     * Sets the PO_HEAD_REMARK value for this IFMM035_BGT_S_DT_response.
     * 
     * @param PO_HEAD_REMARK
     */
    public void setPO_HEAD_REMARK(com.ildong.MM.BGT_ERP.IFMM035_BGT_S_DT_responsePO_HEAD_REMARK[] PO_HEAD_REMARK) {
        this.PO_HEAD_REMARK = PO_HEAD_REMARK;
    }

    public com.ildong.MM.BGT_ERP.IFMM035_BGT_S_DT_responsePO_HEAD_REMARK getPO_HEAD_REMARK(int i) {
        return this.PO_HEAD_REMARK[i];
    }

    public void setPO_HEAD_REMARK(int i, com.ildong.MM.BGT_ERP.IFMM035_BGT_S_DT_responsePO_HEAD_REMARK _value) {
        this.PO_HEAD_REMARK[i] = _value;
    }


    /**
     * Gets the PO_ITEM_REMARK value for this IFMM035_BGT_S_DT_response.
     * 
     * @return PO_ITEM_REMARK
     */
    public com.ildong.MM.BGT_ERP.IFMM035_BGT_S_DT_responsePO_ITEM_REMARK[] getPO_ITEM_REMARK() {
        return PO_ITEM_REMARK;
    }


    /**
     * Sets the PO_ITEM_REMARK value for this IFMM035_BGT_S_DT_response.
     * 
     * @param PO_ITEM_REMARK
     */
    public void setPO_ITEM_REMARK(com.ildong.MM.BGT_ERP.IFMM035_BGT_S_DT_responsePO_ITEM_REMARK[] PO_ITEM_REMARK) {
        this.PO_ITEM_REMARK = PO_ITEM_REMARK;
    }

    public com.ildong.MM.BGT_ERP.IFMM035_BGT_S_DT_responsePO_ITEM_REMARK getPO_ITEM_REMARK(int i) {
        return this.PO_ITEM_REMARK[i];
    }

    public void setPO_ITEM_REMARK(int i, com.ildong.MM.BGT_ERP.IFMM035_BGT_S_DT_responsePO_ITEM_REMARK _value) {
        this.PO_ITEM_REMARK[i] = _value;
    }


    /**
     * Gets the IF_FLAG value for this IFMM035_BGT_S_DT_response.
     * 
     * @return IF_FLAG
     */
    public java.lang.String getIF_FLAG() {
        return IF_FLAG;
    }


    /**
     * Sets the IF_FLAG value for this IFMM035_BGT_S_DT_response.
     * 
     * @param IF_FLAG
     */
    public void setIF_FLAG(java.lang.String IF_FLAG) {
        this.IF_FLAG = IF_FLAG;
    }


    /**
     * Gets the IF_MSG value for this IFMM035_BGT_S_DT_response.
     * 
     * @return IF_MSG
     */
    public java.lang.String getIF_MSG() {
        return IF_MSG;
    }


    /**
     * Sets the IF_MSG value for this IFMM035_BGT_S_DT_response.
     * 
     * @param IF_MSG
     */
    public void setIF_MSG(java.lang.String IF_MSG) {
        this.IF_MSG = IF_MSG;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof IFMM035_BGT_S_DT_response)) return false;
        IFMM035_BGT_S_DT_response other = (IFMM035_BGT_S_DT_response) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.PO_HEAD==null && other.getPO_HEAD()==null) || 
             (this.PO_HEAD!=null &&
              java.util.Arrays.equals(this.PO_HEAD, other.getPO_HEAD()))) &&
            ((this.PO_ITEM==null && other.getPO_ITEM()==null) || 
             (this.PO_ITEM!=null &&
              java.util.Arrays.equals(this.PO_ITEM, other.getPO_ITEM()))) &&
            ((this.PO_HEAD_REMARK==null && other.getPO_HEAD_REMARK()==null) || 
             (this.PO_HEAD_REMARK!=null &&
              java.util.Arrays.equals(this.PO_HEAD_REMARK, other.getPO_HEAD_REMARK()))) &&
            ((this.PO_ITEM_REMARK==null && other.getPO_ITEM_REMARK()==null) || 
             (this.PO_ITEM_REMARK!=null &&
              java.util.Arrays.equals(this.PO_ITEM_REMARK, other.getPO_ITEM_REMARK()))) &&
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
        if (getPO_HEAD() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getPO_HEAD());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getPO_HEAD(), i);
                if (obj != null &&
                    !obj.getClass().isArray()) {
                    _hashCode += obj.hashCode();
                }
            }
        }
        if (getPO_ITEM() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getPO_ITEM());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getPO_ITEM(), i);
                if (obj != null &&
                    !obj.getClass().isArray()) {
                    _hashCode += obj.hashCode();
                }
            }
        }
        if (getPO_HEAD_REMARK() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getPO_HEAD_REMARK());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getPO_HEAD_REMARK(), i);
                if (obj != null &&
                    !obj.getClass().isArray()) {
                    _hashCode += obj.hashCode();
                }
            }
        }
        if (getPO_ITEM_REMARK() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getPO_ITEM_REMARK());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getPO_ITEM_REMARK(), i);
                if (obj != null &&
                    !obj.getClass().isArray()) {
                    _hashCode += obj.hashCode();
                }
            }
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
        new org.apache.axis.description.TypeDesc(IFMM035_BGT_S_DT_response.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://ildong.com/MM/BGT_ERP", "IFMM035_BGT_S_DT_response"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("PO_HEAD");
        elemField.setXmlName(new javax.xml.namespace.QName("", "PO_HEAD"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://ildong.com/MM/BGT_ERP", ">IFMM035_BGT_S_DT_response>PO_HEAD"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        elemField.setMaxOccursUnbounded(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("PO_ITEM");
        elemField.setXmlName(new javax.xml.namespace.QName("", "PO_ITEM"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://ildong.com/MM/BGT_ERP", ">IFMM035_BGT_S_DT_response>PO_ITEM"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        elemField.setMaxOccursUnbounded(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("PO_HEAD_REMARK");
        elemField.setXmlName(new javax.xml.namespace.QName("", "PO_HEAD_REMARK"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://ildong.com/MM/BGT_ERP", ">IFMM035_BGT_S_DT_response>PO_HEAD_REMARK"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        elemField.setMaxOccursUnbounded(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("PO_ITEM_REMARK");
        elemField.setXmlName(new javax.xml.namespace.QName("", "PO_ITEM_REMARK"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://ildong.com/MM/BGT_ERP", ">IFMM035_BGT_S_DT_response>PO_ITEM_REMARK"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        elemField.setMaxOccursUnbounded(true);
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
