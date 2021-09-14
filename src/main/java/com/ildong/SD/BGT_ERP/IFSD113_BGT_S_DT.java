/**
 * IFSD113_BGT_S_DT.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.ildong.SD.BGT_ERP;

public class IFSD113_BGT_S_DT  implements java.io.Serializable {
    private java.lang.String ERDAR_FR;

    private java.lang.String ERDAR_TO;

    private java.lang.String VKORG;

    public IFSD113_BGT_S_DT() {
    }

    public IFSD113_BGT_S_DT(
           java.lang.String ERDAR_FR,
           java.lang.String ERDAR_TO,
           java.lang.String VKORG) {
           this.ERDAR_FR = ERDAR_FR;
           this.ERDAR_TO = ERDAR_TO;
           this.VKORG = VKORG;
    }


    /**
     * Gets the ERDAR_FR value for this IFSD113_BGT_S_DT.
     * 
     * @return ERDAR_FR
     */
    public java.lang.String getERDAR_FR() {
        return ERDAR_FR;
    }


    /**
     * Sets the ERDAR_FR value for this IFSD113_BGT_S_DT.
     * 
     * @param ERDAR_FR
     */
    public void setERDAR_FR(java.lang.String ERDAR_FR) {
        this.ERDAR_FR = ERDAR_FR;
    }


    /**
     * Gets the ERDAR_TO value for this IFSD113_BGT_S_DT.
     * 
     * @return ERDAR_TO
     */
    public java.lang.String getERDAR_TO() {
        return ERDAR_TO;
    }


    /**
     * Sets the ERDAR_TO value for this IFSD113_BGT_S_DT.
     * 
     * @param ERDAR_TO
     */
    public void setERDAR_TO(java.lang.String ERDAR_TO) {
        this.ERDAR_TO = ERDAR_TO;
    }


    /**
     * Gets the VKORG value for this IFSD113_BGT_S_DT.
     * 
     * @return VKORG
     */
    public java.lang.String getVKORG() {
        return VKORG;
    }


    /**
     * Sets the VKORG value for this IFSD113_BGT_S_DT.
     * 
     * @param VKORG
     */
    public void setVKORG(java.lang.String VKORG) {
        this.VKORG = VKORG;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof IFSD113_BGT_S_DT)) return false;
        IFSD113_BGT_S_DT other = (IFSD113_BGT_S_DT) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.ERDAR_FR==null && other.getERDAR_FR()==null) || 
             (this.ERDAR_FR!=null &&
              this.ERDAR_FR.equals(other.getERDAR_FR()))) &&
            ((this.ERDAR_TO==null && other.getERDAR_TO()==null) || 
             (this.ERDAR_TO!=null &&
              this.ERDAR_TO.equals(other.getERDAR_TO()))) &&
            ((this.VKORG==null && other.getVKORG()==null) || 
             (this.VKORG!=null &&
              this.VKORG.equals(other.getVKORG())));
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
        if (getERDAR_FR() != null) {
            _hashCode += getERDAR_FR().hashCode();
        }
        if (getERDAR_TO() != null) {
            _hashCode += getERDAR_TO().hashCode();
        }
        if (getVKORG() != null) {
            _hashCode += getVKORG().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(IFSD113_BGT_S_DT.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://ildong.com/SD/BGT_ERP", "IFSD113_BGT_S_DT"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ERDAR_FR");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ERDAR_FR"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ERDAR_TO");
        elemField.setXmlName(new javax.xml.namespace.QName("", "ERDAR_TO"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("VKORG");
        elemField.setXmlName(new javax.xml.namespace.QName("", "VKORG"));
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
