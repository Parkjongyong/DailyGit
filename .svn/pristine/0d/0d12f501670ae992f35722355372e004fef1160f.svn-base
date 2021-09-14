package com.app.ildong.common.sms;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;

import org.apache.commons.beanutils.PropertyUtils;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.protocol.HTTP;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.app.ildong.common.util.PropertiesUtil;

import org.apache.http.entity.ContentType;

public class SMSSender  {
	protected final Log logger = LogFactory.getLog(getClass());
	
	private String _RUNTIME_MODE	= PropertiesUtil.getProperty("runtime.mode");
	
	private String _SMS_URL		= PropertiesUtil.getProperty("sms.endpoint.url");
	private String _SMS_SYSPW 	= "aW5hczIwMTQhIQ==";
	
	public String sendSms(String tranType, String tranPhone, String tranCallBack, String TranMsg) {
		if ("local".equals(_RUNTIME_MODE)) {
			return "";
		}
		
		String serverResponse = new String();
		
		try {
			CloseableHttpClient httpClient = HttpClientBuilder.create().build();
			HttpPost postRequest = new HttpPost(_SMS_URL);
		
			String reqParam = "";
				  
			reqParam ="\"TranType\":\""+tranType+"\",";
			reqParam+="\"TranPhone\":\""+tranPhone+"\",";
			reqParam+="\"TranCallBack\":\""+tranCallBack+"\",";
			reqParam+="\"TranMsg\":\""+TranMsg+"\",";
			reqParam+="\"SysPw\":\""+_SMS_SYSPW+"\"";
				  
			reqParam = "{" + reqParam + "}";
				  
//			StringEntity entity = new StringEntity(reqParam, ContentType.create("application/json"));
//			postRequest.setEntity(entity);

			StringEntity entity = new StringEntity(reqParam, "UTF-8");
			entity.setContentType("application/json");
			entity.setContentEncoding("UTF-8");
			postRequest.setEntity(entity);

			HttpResponse response = httpClient.execute(postRequest);
			serverResponse = catchResponse(response);
		
			httpClient.close();
	
		} catch (MalformedURLException e) {
			logger.error("########## ERROR IN SMSSender - MalformedURLException : "+ this.getClass());
			logger.error(e);
			e.printStackTrace();
			serverResponse = null;
		}catch(IOException e) {;
			logger.error("########## ERROR IN SMSSender - IOException: "+ this.getClass());
			logger.error(e);
			e.printStackTrace();
			serverResponse = null;
		}catch(Exception e) {;
			logger.error("########## ERROR IN SMSSender - Exception : "+ this.getClass());
			logger.error(e);
			e.printStackTrace();
			serverResponse = null;
		}
	
		return serverResponse;
	}

	private String catchResponse(HttpResponse response ) throws IOException{
		String serverResponse = "";
		if (response.getStatusLine().getStatusCode() != 200) {
			logger.error("\n########## Failed ##########\n HTTP error code : " + response.getStatusLine().getStatusCode() 
			+ "\n HTTP error reason :" + response.getStatusLine().getReasonPhrase());
		
			if(response.getStatusLine().getStatusCode() != 400)
			return new String( ("{\"error\":\""+response.getStatusLine().getStatusCode() + response.getStatusLine().getReasonPhrase() +"\"}").getBytes(), "UTF-8");
		}
	
		BufferedReader br = new BufferedReader(
		new InputStreamReader((response.getEntity().getContent()), "UTF-8"));
		String output;
		logger.debug("Output from Server .... \n");
		while ((output = br.readLine()) != null) {
			serverResponse += output;
			logger.debug(output);
		}
	
		return serverResponse;
	}
	
    public static void main(String[] args)
    {
    	SMSSender smsSender = new SMSSender();
    	smsSender.sendSms("4", "받는사람", "보내는사람","TEST2");
        
    }
	

}
