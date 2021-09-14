package com.ildong.CO.BGT_ERP;

public class IFCO007_BGT_SOProxy implements com.ildong.CO.BGT_ERP.IFCO007_BGT_SO {
  private String _endpoint = null;
  private com.ildong.CO.BGT_ERP.IFCO007_BGT_SO iFCO007_BGT_SO = null;
  
  public IFCO007_BGT_SOProxy() {
    _initIFCO007_BGT_SOProxy();
  }
  
  public IFCO007_BGT_SOProxy(String endpoint) {
    _endpoint = endpoint;
    _initIFCO007_BGT_SOProxy();
  }
  
  private void _initIFCO007_BGT_SOProxy() {
    try {
      iFCO007_BGT_SO = (new com.ildong.CO.BGT_ERP.IFCO007_BGT_SOServiceLocator()).getHTTP_Port();
      if (iFCO007_BGT_SO != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)iFCO007_BGT_SO)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)iFCO007_BGT_SO)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (iFCO007_BGT_SO != null)
      ((javax.xml.rpc.Stub)iFCO007_BGT_SO)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public com.ildong.CO.BGT_ERP.IFCO007_BGT_SO getIFCO007_BGT_SO() {
    if (iFCO007_BGT_SO == null)
      _initIFCO007_BGT_SOProxy();
    return iFCO007_BGT_SO;
  }
  
  public com.ildong.CO.BGT_ERP.IFCO007_BGT_S_DT_response IFCO007_BGT_SO(com.ildong.CO.BGT_ERP.IFCO007_BGT_S_DT IFCO007_BGT_S_MT) throws java.rmi.RemoteException{
    if (iFCO007_BGT_SO == null)
      _initIFCO007_BGT_SOProxy();
    return iFCO007_BGT_SO.IFCO007_BGT_SO(IFCO007_BGT_S_MT);
  }
  
  
}