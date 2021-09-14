package com.app.ildong.common.model.mvc;


import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;

import com.app.ildong.common.util.PropertiesUtil;

public abstract class BaseJobBean extends CommonJobBean {

	/**
	 * @return the compCd
	 */
	public String getCompCd() throws Exception {
		try {
			return PropertiesUtil.getProperty("COMP_CD");
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception ("COMP_CD가 정의되지 않았습니다.");
		}
	}
	
	public String getServerIp() throws Exception {
		try
		{
		    for (Enumeration<NetworkInterface> en = NetworkInterface.getNetworkInterfaces(); en.hasMoreElements();)
		    {
		        NetworkInterface intf = en.nextElement();
		        for (Enumeration<InetAddress> enumIpAddr = intf.getInetAddresses(); enumIpAddr.hasMoreElements();)
		        {
		            InetAddress inetAddress = enumIpAddr.nextElement();
		            if (!inetAddress.isLoopbackAddress() && !inetAddress.isLinkLocalAddress() && inetAddress.isSiteLocalAddress())
		            {
		            	return inetAddress.getHostAddress().toString();
		            }
		        }
		    }
		}
		catch (SocketException ex) {}
		return null;
	}
	
    public long getCurrentTime() throws Exception {
    	long time = System.currentTimeMillis();
		
		return time;
    }
    
    public String getRunIp() throws Exception {
    	InetAddress address = InetAddress.getLocalHost(); 
		String IP = address.getHostAddress();
		
		return IP;
    }
    
    public String getTimeString(long time) throws Exception {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		
		return sdf.format(new Date(time));
    }
    
}
