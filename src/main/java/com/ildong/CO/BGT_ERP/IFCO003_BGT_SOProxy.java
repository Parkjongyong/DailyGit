package com.ildong.CO.BGT_ERP;

public class IFCO003_BGT_SOProxy implements com.ildong.CO.BGT_ERP.IFCO003_BGT_SO {
  private String _endpoint = null;
  private com.ildong.CO.BGT_ERP.IFCO003_BGT_SO iFCO003_BGT_SO = null;
  
  public IFCO003_BGT_SOProxy() {
    _initIFCO003_BGT_SOProxy();
  }
  
  public IFCO003_BGT_SOProxy(String endpoint) {
    _endpoint = endpoint;
    _initIFCO003_BGT_SOProxy();
  }
  
  private void _initIFCO003_BGT_SOProxy() {
    try {
      iFCO003_BGT_SO = (new com.ildong.CO.BGT_ERP.IFCO003_BGT_SOServiceLocator()).getHTTP_Port();
      if (iFCO003_BGT_SO != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)iFCO003_BGT_SO)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)iFCO003_BGT_SO)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (iFCO003_BGT_SO != null)
      ((javax.xml.rpc.Stub)iFCO003_BGT_SO)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public com.ildong.CO.BGT_ERP.IFCO003_BGT_SO getIFCO003_BGT_SO() {
    if (iFCO003_BGT_SO == null)
      _initIFCO003_BGT_SOProxy();
    return iFCO003_BGT_SO;
  }
  
  public com.ildong.CO.BGT_ERP.IFCO003_BGT_S_DT_response IFCO003_BGT_SO(com.ildong.CO.BGT_ERP.IFCO003_BGT_S_DTITEM[] IFCO003_BGT_S_MT) throws java.rmi.RemoteException{
    if (iFCO003_BGT_SO == null)
      _initIFCO003_BGT_SOProxy();
    return iFCO003_BGT_SO.IFCO003_BGT_SO(IFCO003_BGT_S_MT);
  }
  
  
}