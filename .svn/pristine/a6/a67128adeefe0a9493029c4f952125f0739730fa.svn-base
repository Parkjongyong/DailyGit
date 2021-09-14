package com.ildong.FI.BGT_ERP;

public class IFFI019_BGT_SOProxy implements com.ildong.FI.BGT_ERP.IFFI019_BGT_SO {
  private String _endpoint = null;
  private com.ildong.FI.BGT_ERP.IFFI019_BGT_SO iFFI019_BGT_SO = null;
  
  public IFFI019_BGT_SOProxy() {
    _initIFFI019_BGT_SOProxy();
  }
  
  public IFFI019_BGT_SOProxy(String endpoint) {
    _endpoint = endpoint;
    _initIFFI019_BGT_SOProxy();
  }
  
  private void _initIFFI019_BGT_SOProxy() {
    try {
      iFFI019_BGT_SO = (new com.ildong.FI.BGT_ERP.IFFI019_BGT_SOServiceLocator()).getHTTP_Port();
      if (iFFI019_BGT_SO != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)iFFI019_BGT_SO)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)iFFI019_BGT_SO)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (iFFI019_BGT_SO != null)
      ((javax.xml.rpc.Stub)iFFI019_BGT_SO)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public com.ildong.FI.BGT_ERP.IFFI019_BGT_SO getIFFI019_BGT_SO() {
    if (iFFI019_BGT_SO == null)
      _initIFFI019_BGT_SOProxy();
    return iFFI019_BGT_SO;
  }
  
  public com.ildong.FI.BGT_ERP.IFFI019_BGT_S_DT_response IFFI019_BGT_SO(com.ildong.FI.BGT_ERP.IFFI019_BGT_S_DTIN_APM[] IFFI019_BGT_S_MT) throws java.rmi.RemoteException{
    if (iFFI019_BGT_SO == null)
      _initIFFI019_BGT_SOProxy();
    return iFFI019_BGT_SO.IFFI019_BGT_SO(IFFI019_BGT_S_MT);
  }
  
  
}