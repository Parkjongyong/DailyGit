package com.ildong.MM.BGT_ERP;

public class IFMM035_BGT_SOProxy implements com.ildong.MM.BGT_ERP.IFMM035_BGT_SO {
  private String _endpoint = null;
  private com.ildong.MM.BGT_ERP.IFMM035_BGT_SO iFMM035_BGT_SO = null;
  
  public IFMM035_BGT_SOProxy() {
    _initIFMM035_BGT_SOProxy();
  }
  
  public IFMM035_BGT_SOProxy(String endpoint) {
    _endpoint = endpoint;
    _initIFMM035_BGT_SOProxy();
  }
  
  private void _initIFMM035_BGT_SOProxy() {
    try {
      iFMM035_BGT_SO = (new com.ildong.MM.BGT_ERP.IFMM035_BGT_SOServiceLocator()).getHTTP_Port();
      if (iFMM035_BGT_SO != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)iFMM035_BGT_SO)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)iFMM035_BGT_SO)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (iFMM035_BGT_SO != null)
      ((javax.xml.rpc.Stub)iFMM035_BGT_SO)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public com.ildong.MM.BGT_ERP.IFMM035_BGT_SO getIFMM035_BGT_SO() {
    if (iFMM035_BGT_SO == null)
      _initIFMM035_BGT_SOProxy();
    return iFMM035_BGT_SO;
  }
  
  public com.ildong.MM.BGT_ERP.IFMM035_BGT_S_DT_response IFMM035_BGT_SO(com.ildong.MM.BGT_ERP.IFMM035_BGT_S_DT IFMM035_BGT_S_MT) throws java.rmi.RemoteException{
    if (iFMM035_BGT_SO == null)
      _initIFMM035_BGT_SOProxy();
    return iFMM035_BGT_SO.IFMM035_BGT_SO(IFMM035_BGT_S_MT);
  }
  
  
}