package com.ildong.FI.BGT_ERP;

public class IFFI054_BGT_SOProxy implements com.ildong.FI.BGT_ERP.IFFI054_BGT_SO {
  private String _endpoint = null;
  private com.ildong.FI.BGT_ERP.IFFI054_BGT_SO iFFI054_BGT_SO = null;
  
  public IFFI054_BGT_SOProxy() {
    _initIFFI054_BGT_SOProxy();
  }
  
  public IFFI054_BGT_SOProxy(String endpoint) {
    _endpoint = endpoint;
    _initIFFI054_BGT_SOProxy();
  }
  
  private void _initIFFI054_BGT_SOProxy() {
    try {
      iFFI054_BGT_SO = (new com.ildong.FI.BGT_ERP.IFFI054_BGT_SOServiceLocator()).getHTTP_Port();
      if (iFFI054_BGT_SO != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)iFFI054_BGT_SO)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)iFFI054_BGT_SO)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (iFFI054_BGT_SO != null)
      ((javax.xml.rpc.Stub)iFFI054_BGT_SO)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public com.ildong.FI.BGT_ERP.IFFI054_BGT_SO getIFFI054_BGT_SO() {
    if (iFFI054_BGT_SO == null)
      _initIFFI054_BGT_SOProxy();
    return iFFI054_BGT_SO;
  }
  
  public com.ildong.FI.BGT_ERP.IFFI054_BGT_S_DT_response IFFI054_BGT_SO(com.ildong.FI.BGT_ERP.IFFI054_BGT_S_DT IFFI054_BGT_S_MT) throws java.rmi.RemoteException{
    if (iFFI054_BGT_SO == null)
      _initIFFI054_BGT_SOProxy();
    return iFFI054_BGT_SO.IFFI054_BGT_SO(IFFI054_BGT_S_MT);
  }
  
  
}