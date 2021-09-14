package com.ildong.FI.BGT_ERP;

public class IFFI016_BGT_SOProxy implements com.ildong.FI.BGT_ERP.IFFI016_BGT_SO {
  private String _endpoint = null;
  private com.ildong.FI.BGT_ERP.IFFI016_BGT_SO iFFI016_BGT_SO = null;
  
  public IFFI016_BGT_SOProxy() {
    _initIFFI016_BGT_SOProxy();
  }
  
  public IFFI016_BGT_SOProxy(String endpoint) {
    _endpoint = endpoint;
    _initIFFI016_BGT_SOProxy();
  }
  
  private void _initIFFI016_BGT_SOProxy() {
    try {
      iFFI016_BGT_SO = (new com.ildong.FI.BGT_ERP.IFFI016_BGT_SOServiceLocator()).getHTTP_Port();
      if (iFFI016_BGT_SO != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)iFFI016_BGT_SO)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)iFFI016_BGT_SO)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (iFFI016_BGT_SO != null)
      ((javax.xml.rpc.Stub)iFFI016_BGT_SO)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public com.ildong.FI.BGT_ERP.IFFI016_BGT_SO getIFFI016_BGT_SO() {
    if (iFFI016_BGT_SO == null)
      _initIFFI016_BGT_SOProxy();
    return iFFI016_BGT_SO;
  }
  
  public com.ildong.FI.BGT_ERP.IFFI016_BGT_S_DT_response IFFI016_BGT_SO(com.ildong.FI.BGT_ERP.IFFI016_BGT_S_DTIN_BANK[] IFFI016_BGT_S_MT) throws java.rmi.RemoteException{
    if (iFFI016_BGT_SO == null)
      _initIFFI016_BGT_SOProxy();
    return iFFI016_BGT_SO.IFFI016_BGT_SO(IFFI016_BGT_S_MT);
  }
  
  
}