package com.ildong.CO.BGT_ERP;

public class IFCO004_BGT_SOProxy implements com.ildong.CO.BGT_ERP.IFCO004_BGT_SO {
  private String _endpoint = null;
  private com.ildong.CO.BGT_ERP.IFCO004_BGT_SO iFCO004_BGT_SO = null;
  
  public IFCO004_BGT_SOProxy() {
    _initIFCO004_BGT_SOProxy();
  }
  
  public IFCO004_BGT_SOProxy(String endpoint) {
    _endpoint = endpoint;
    _initIFCO004_BGT_SOProxy();
  }
  
  private void _initIFCO004_BGT_SOProxy() {
    try {
      iFCO004_BGT_SO = (new com.ildong.CO.BGT_ERP.IFCO004_BGT_SOServiceLocator()).getHTTP_Port();
      if (iFCO004_BGT_SO != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)iFCO004_BGT_SO)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)iFCO004_BGT_SO)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (iFCO004_BGT_SO != null)
      ((javax.xml.rpc.Stub)iFCO004_BGT_SO)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public com.ildong.CO.BGT_ERP.IFCO004_BGT_SO getIFCO004_BGT_SO() {
    if (iFCO004_BGT_SO == null)
      _initIFCO004_BGT_SOProxy();
    return iFCO004_BGT_SO;
  }
  
  public com.ildong.CO.BGT_ERP.IFCO004_BGT_S_DT_response IFCO004_BGT_SO(com.ildong.CO.BGT_ERP.IFCO004_BGT_S_DT IFCO004_BGT_S_MT) throws java.rmi.RemoteException{
    if (iFCO004_BGT_SO == null)
      _initIFCO004_BGT_SOProxy();
    return iFCO004_BGT_SO.IFCO004_BGT_SO(IFCO004_BGT_S_MT);
  }
  
  
}