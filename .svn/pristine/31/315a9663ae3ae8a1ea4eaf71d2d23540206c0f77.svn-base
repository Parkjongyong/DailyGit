package com.ildong.MM.BGT_ERP;

public class IFMM037_BGT_SOProxy implements com.ildong.MM.BGT_ERP.IFMM037_BGT_SO {
  private String _endpoint = null;
  private com.ildong.MM.BGT_ERP.IFMM037_BGT_SO iFMM037_BGT_SO = null;
  
  public IFMM037_BGT_SOProxy() {
    _initIFMM037_BGT_SOProxy();
  }
  
  public IFMM037_BGT_SOProxy(String endpoint) {
    _endpoint = endpoint;
    _initIFMM037_BGT_SOProxy();
  }
  
  private void _initIFMM037_BGT_SOProxy() {
    try {
      iFMM037_BGT_SO = (new com.ildong.MM.BGT_ERP.IFMM037_BGT_SOServiceLocator()).getHTTP_Port();
      if (iFMM037_BGT_SO != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)iFMM037_BGT_SO)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)iFMM037_BGT_SO)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (iFMM037_BGT_SO != null)
      ((javax.xml.rpc.Stub)iFMM037_BGT_SO)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public com.ildong.MM.BGT_ERP.IFMM037_BGT_SO getIFMM037_BGT_SO() {
    if (iFMM037_BGT_SO == null)
      _initIFMM037_BGT_SOProxy();
    return iFMM037_BGT_SO;
  }
  
  public com.ildong.MM.BGT_ERP.IFMM037_BGT_S_DT_response IFMM037_BGT_SO(com.ildong.MM.BGT_ERP.IFMM037_BGT_S_DT IFMM037_BGT_S_MT) throws java.rmi.RemoteException{
    if (iFMM037_BGT_SO == null)
      _initIFMM037_BGT_SOProxy();
    return iFMM037_BGT_SO.IFMM037_BGT_SO(IFMM037_BGT_S_MT);
  }
  
  
}