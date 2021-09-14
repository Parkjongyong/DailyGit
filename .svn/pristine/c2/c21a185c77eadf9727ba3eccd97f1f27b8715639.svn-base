/**
 * IFCO010_BGT_SOServiceLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.ildong.CO.BGT_ERP;

import com.app.ildong.common.util.PropertiesUtil;

public class IFCO010_BGT_SOServiceLocator extends org.apache.axis.client.Service implements com.ildong.CO.BGT_ERP.IFCO010_BGT_SOService {

    public IFCO010_BGT_SOServiceLocator() {
    }


    public IFCO010_BGT_SOServiceLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public IFCO010_BGT_SOServiceLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for HTTP_Port
    private java.lang.String HTTP_Port_address = PropertiesUtil.getProperty("sap.url") + "/XISOAPAdapter/MessageServlet?senderParty=&senderService=" + PropertiesUtil.getProperty("sap.sender") + "&receiverParty=&receiverService=&interface=IFCO010_BGT_SO&interfaceNamespace=http%3A%2F%2Fildong.com%2FCO%2FBGT_ERP";

    public java.lang.String getHTTP_PortAddress() {
        return HTTP_Port_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String HTTP_PortWSDDServiceName = "HTTP_Port";

    public java.lang.String getHTTP_PortWSDDServiceName() {
        return HTTP_PortWSDDServiceName;
    }

    public void setHTTP_PortWSDDServiceName(java.lang.String name) {
        HTTP_PortWSDDServiceName = name;
    }

    public com.ildong.CO.BGT_ERP.IFCO010_BGT_SO getHTTP_Port() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(HTTP_Port_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getHTTP_Port(endpoint);
    }

    public com.ildong.CO.BGT_ERP.IFCO010_BGT_SO getHTTP_Port(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            com.ildong.CO.BGT_ERP.IFCO010_BGT_SOBindingStub _stub = new com.ildong.CO.BGT_ERP.IFCO010_BGT_SOBindingStub(portAddress, this);
            _stub.setPortName(getHTTP_PortWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setHTTP_PortEndpointAddress(java.lang.String address) {
        HTTP_Port_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (com.ildong.CO.BGT_ERP.IFCO010_BGT_SO.class.isAssignableFrom(serviceEndpointInterface)) {
                com.ildong.CO.BGT_ERP.IFCO010_BGT_SOBindingStub _stub = new com.ildong.CO.BGT_ERP.IFCO010_BGT_SOBindingStub(new java.net.URL(HTTP_Port_address), this);
                _stub.setPortName(getHTTP_PortWSDDServiceName());
                return _stub;
            }
        }
        catch (java.lang.Throwable t) {
            throw new javax.xml.rpc.ServiceException(t);
        }
        throw new javax.xml.rpc.ServiceException("There is no stub implementation for the interface:  " + (serviceEndpointInterface == null ? "null" : serviceEndpointInterface.getName()));
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(javax.xml.namespace.QName portName, Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        if (portName == null) {
            return getPort(serviceEndpointInterface);
        }
        java.lang.String inputPortName = portName.getLocalPart();
        if ("HTTP_Port".equals(inputPortName)) {
            return getHTTP_Port();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://ildong.com/CO/BGT_ERP", "IFCO010_BGT_SOService");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://ildong.com/CO/BGT_ERP", "HTTP_Port"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("HTTP_Port".equals(portName)) {
            setHTTP_PortEndpointAddress(address);
        }
        else 
{ // Unknown Port Name
            throw new javax.xml.rpc.ServiceException(" Cannot set Endpoint Address for Unknown Port" + portName);
        }
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(javax.xml.namespace.QName portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        setEndpointAddress(portName.getLocalPart(), address);
    }

}
