package com.ildong.SD.BGT_ERP;

public class IFSD110_BGT_SOProxy implements com.ildong.SD.BGT_ERP.IFSD110_BGT_SO {
  private String _endpoint = null;
  private com.ildong.SD.BGT_ERP.IFSD110_BGT_SO iFSD110_BGT_SO = null;
  
  public IFSD110_BGT_SOProxy() {
    _initIFSD110_BGT_SOProxy();
  }
  
  public IFSD110_BGT_SOProxy(String endpoint) {
    _endpoint = endpoint;
    _initIFSD110_BGT_SOProxy();
  }
  
  private void _initIFSD110_BGT_SOProxy() {
    try {
      iFSD110_BGT_SO = (new com.ildong.SD.BGT_ERP.IFSD110_BGT_SOServiceLocator()).getHTTP_Port();
      if (iFSD110_BGT_SO != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)iFSD110_BGT_SO)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)iFSD110_BGT_SO)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (iFSD110_BGT_SO != null)
      ((javax.xml.rpc.Stub)iFSD110_BGT_SO)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public com.ildong.SD.BGT_ERP.IFSD110_BGT_SO getIFSD110_BGT_SO() {
    if (iFSD110_BGT_SO == null)
      _initIFSD110_BGT_SOProxy();
    return iFSD110_BGT_SO;
  }
  
  public com.ildong.SD.BGT_ERP.IFSD110_BGT_S_DT_response IFSD110_BGT_SO(com.ildong.SD.BGT_ERP.IFSD110_BGT_S_DT IFSD110_BGT_S_MT) throws java.rmi.RemoteException{
    if (iFSD110_BGT_SO == null)
      _initIFSD110_BGT_SOProxy();
    return iFSD110_BGT_SO.IFSD110_BGT_SO(IFSD110_BGT_S_MT);
  }
  
  
}