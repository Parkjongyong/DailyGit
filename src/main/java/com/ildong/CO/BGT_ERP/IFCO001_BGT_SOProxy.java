package com.ildong.CO.BGT_ERP;

public class IFCO001_BGT_SOProxy implements com.ildong.CO.BGT_ERP.IFCO001_BGT_SO {
  private String _endpoint = null;
  private com.ildong.CO.BGT_ERP.IFCO001_BGT_SO iFCO001_BGT_SO = null;
  
  public IFCO001_BGT_SOProxy() {
    _initIFCO001_BGT_SOProxy();
  }
  
  public IFCO001_BGT_SOProxy(String endpoint) {
    _endpoint = endpoint;
    _initIFCO001_BGT_SOProxy();
  }
  
  private void _initIFCO001_BGT_SOProxy() {
    try {
      iFCO001_BGT_SO = (new com.ildong.CO.BGT_ERP.IFCO001_BGT_SOServiceLocator()).getHTTP_Port();
      if (iFCO001_BGT_SO != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)iFCO001_BGT_SO)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)iFCO001_BGT_SO)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (iFCO001_BGT_SO != null)
      ((javax.xml.rpc.Stub)iFCO001_BGT_SO)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public com.ildong.CO.BGT_ERP.IFCO001_BGT_SO getIFCO001_BGT_SO() {
    if (iFCO001_BGT_SO == null)
      _initIFCO001_BGT_SOProxy();
    return iFCO001_BGT_SO;
  }
  
  public com.ildong.CO.BGT_ERP.IFCO001_BGT_S_DT_response IFCO001_BGT_SO(com.ildong.CO.BGT_ERP.IFCO001_BGT_S_DT IFCO001_BGT_S_MT) throws java.rmi.RemoteException{
    if (iFCO001_BGT_SO == null)
      _initIFCO001_BGT_SOProxy();
    return iFCO001_BGT_SO.IFCO001_BGT_SO(IFCO001_BGT_S_MT);
  }
  
  
}