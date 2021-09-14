package com.ildong.SD.BGT_ERP;

public class IFSD113_BGT_SOProxy implements com.ildong.SD.BGT_ERP.IFSD113_BGT_SO {
  private String _endpoint = null;
  private com.ildong.SD.BGT_ERP.IFSD113_BGT_SO iFSD113_BGT_SO = null;
  
  public IFSD113_BGT_SOProxy() {
    _initIFSD113_BGT_SOProxy();
  }
  
  public IFSD113_BGT_SOProxy(String endpoint) {
    _endpoint = endpoint;
    _initIFSD113_BGT_SOProxy();
  }
  
  private void _initIFSD113_BGT_SOProxy() {
    try {
      iFSD113_BGT_SO = (new com.ildong.SD.BGT_ERP.IFSD113_BGT_SOServiceLocator()).getHTTP_Port();
      if (iFSD113_BGT_SO != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)iFSD113_BGT_SO)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)iFSD113_BGT_SO)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (iFSD113_BGT_SO != null)
      ((javax.xml.rpc.Stub)iFSD113_BGT_SO)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public com.ildong.SD.BGT_ERP.IFSD113_BGT_SO getIFSD113_BGT_SO() {
    if (iFSD113_BGT_SO == null)
      _initIFSD113_BGT_SOProxy();
    return iFSD113_BGT_SO;
  }
  
  public com.ildong.SD.BGT_ERP.IFSD113_BGT_S_DT_response IFSD113_BGT_SO(com.ildong.SD.BGT_ERP.IFSD113_BGT_S_DT IFSD113_BGT_S_MT) throws java.rmi.RemoteException{
    if (iFSD113_BGT_SO == null)
      _initIFSD113_BGT_SOProxy();
    return iFSD113_BGT_SO.IFSD113_BGT_SO(IFSD113_BGT_S_MT);
  }
  
  
}