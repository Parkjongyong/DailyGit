package com.ildong.CO.BGT_ERP;

public class IFCO011_BGT_SOProxy implements com.ildong.CO.BGT_ERP.IFCO011_BGT_SO {
  private String _endpoint = null;
  private com.ildong.CO.BGT_ERP.IFCO011_BGT_SO iFCO011_BGT_SO = null;
  
  public IFCO011_BGT_SOProxy() {
    _initIFCO011_BGT_SOProxy();
  }
  
  public IFCO011_BGT_SOProxy(String endpoint) {
    _endpoint = endpoint;
    _initIFCO011_BGT_SOProxy();
  }
  
  private void _initIFCO011_BGT_SOProxy() {
    try {
      iFCO011_BGT_SO = (new com.ildong.CO.BGT_ERP.IFCO011_BGT_SOServiceLocator()).getHTTP_Port();
      if (iFCO011_BGT_SO != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)iFCO011_BGT_SO)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)iFCO011_BGT_SO)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (iFCO011_BGT_SO != null)
      ((javax.xml.rpc.Stub)iFCO011_BGT_SO)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public com.ildong.CO.BGT_ERP.IFCO011_BGT_SO getIFCO011_BGT_SO() {
    if (iFCO011_BGT_SO == null)
      _initIFCO011_BGT_SOProxy();
    return iFCO011_BGT_SO;
  }
  
  public com.ildong.CO.BGT_ERP.IFCO011_BGT_S_DT_response IFCO011_BGT_SO(com.ildong.CO.BGT_ERP.IFCO011_BGT_S_DTITEM[] IFCO011_BGT_S_MT) throws java.rmi.RemoteException{
    if (iFCO011_BGT_SO == null)
      _initIFCO011_BGT_SOProxy();
    return iFCO011_BGT_SO.IFCO011_BGT_SO(IFCO011_BGT_S_MT);
  }
  
  
}