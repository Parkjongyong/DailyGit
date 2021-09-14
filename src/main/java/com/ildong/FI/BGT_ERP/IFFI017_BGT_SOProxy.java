package com.ildong.FI.BGT_ERP;

public class IFFI017_BGT_SOProxy implements com.ildong.FI.BGT_ERP.IFFI017_BGT_SO {
  private String _endpoint = null;
  private com.ildong.FI.BGT_ERP.IFFI017_BGT_SO iFFI017_BGT_SO = null;
  
  public IFFI017_BGT_SOProxy() {
    _initIFFI017_BGT_SOProxy();
  }
  
  public IFFI017_BGT_SOProxy(String endpoint) {
    _endpoint = endpoint;
    _initIFFI017_BGT_SOProxy();
  }
  
  private void _initIFFI017_BGT_SOProxy() {
    try {
      iFFI017_BGT_SO = (new com.ildong.FI.BGT_ERP.IFFI017_BGT_SOServiceLocator()).getHTTP_Port();
      if (iFFI017_BGT_SO != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)iFFI017_BGT_SO)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)iFFI017_BGT_SO)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (iFFI017_BGT_SO != null)
      ((javax.xml.rpc.Stub)iFFI017_BGT_SO)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public com.ildong.FI.BGT_ERP.IFFI017_BGT_SO getIFFI017_BGT_SO() {
    if (iFFI017_BGT_SO == null)
      _initIFFI017_BGT_SOProxy();
    return iFFI017_BGT_SO;
  }
  
  public com.ildong.FI.BGT_ERP.IFFI017_BGT_S_DT_responseRETURN[] IFFI017_BGT_SO(com.ildong.FI.BGT_ERP.IFFI017_BGT_S_DT IFFI017_BGT_S_MT) throws java.rmi.RemoteException{
    if (iFFI017_BGT_SO == null)
      _initIFFI017_BGT_SOProxy();
    return iFFI017_BGT_SO.IFFI017_BGT_SO(IFFI017_BGT_S_MT);
  }
  
  
}