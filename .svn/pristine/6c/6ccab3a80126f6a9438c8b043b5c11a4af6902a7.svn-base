package com.ildong.FI.BGT_ERP;

public class IFFI057_BGT_SOProxy implements com.ildong.FI.BGT_ERP.IFFI057_BGT_SO {
  private String _endpoint = null;
  private com.ildong.FI.BGT_ERP.IFFI057_BGT_SO iFFI057_BGT_SO = null;
  
  public IFFI057_BGT_SOProxy() {
    _initIFFI057_BGT_SOProxy();
  }
  
  public IFFI057_BGT_SOProxy(String endpoint) {
    _endpoint = endpoint;
    _initIFFI057_BGT_SOProxy();
  }
  
  private void _initIFFI057_BGT_SOProxy() {
    try {
      iFFI057_BGT_SO = (new com.ildong.FI.BGT_ERP.IFFI057_BGT_SOServiceLocator()).getHTTP_Port();
      if (iFFI057_BGT_SO != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)iFFI057_BGT_SO)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)iFFI057_BGT_SO)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (iFFI057_BGT_SO != null)
      ((javax.xml.rpc.Stub)iFFI057_BGT_SO)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public com.ildong.FI.BGT_ERP.IFFI057_BGT_SO getIFFI057_BGT_SO() {
    if (iFFI057_BGT_SO == null)
      _initIFFI057_BGT_SOProxy();
    return iFFI057_BGT_SO;
  }
  
  public com.ildong.FI.BGT_ERP.IFFI057_BGT_S_DT_responseRETURN[] IFFI057_BGT_SO(com.ildong.FI.BGT_ERP.IFFI057_BGT_S_DTIT_VEND[] IFFI057_BGT_S_MT) throws java.rmi.RemoteException{
    if (iFFI057_BGT_SO == null)
      _initIFFI057_BGT_SOProxy();
    return iFFI057_BGT_SO.IFFI057_BGT_SO(IFFI057_BGT_S_MT);
  }
  
  
}