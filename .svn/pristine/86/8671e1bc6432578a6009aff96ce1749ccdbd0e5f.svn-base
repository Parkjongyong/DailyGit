package com.app.ildong.common.util;


import java.io.IOException;
import java.util.Iterator;

import java.util.Map;


import org.apache.commons.httpclient.DefaultHttpMethodRetryHandler;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;




public class HtmlBuilder {

	
	final static Log logger = LogFactory.getLog(HtmlBuilder.class);
	
	/**
	 * Jsp 파일 기본 경로
	 */
	public static String strBasePath = "/template/";// 결재 파일 경로
	

	
	/**
	 * Jsp에서 Html 문서를 생성한다.
	 * 
	 * @param mailInfoMap
	 * @param postData
	 * @return
	 * @throws Exception
	 */
	public static String getHtmlFromJsp(String contentPath, Map postData) throws Exception {

		if( !"".equals(contentPath)) {
			
			String strContents = parseRequest(contentPath, postData );
					
			return strContents;
		}			

	
		return null;
	}
	
	/**
	 * 메일 template에 data를 mapping하여 content를 생성한다. 
	 * @param url
	 * @param postDatas
	 * @return
	 */
	public static String parseRequest(String contentPath, Map postDatas) {
		
		PostMethod pm = new PostMethod(contentPath);
		pm.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");

		addPostData(pm, postDatas);
		return doRequest(pm);
	}
	
	

	/**
	 *  content URL을 생성한다.
	 * @param serverPath
	 * @param url
	 * @return
	 */
	public static String makeUrl(String serverPath, String jspFileName) {
		String strUrl = serverPath;
		if (jspFileName == null || "".equals(jspFileName.trim()))
			return null;

		if (strUrl.endsWith("/") && strBasePath.startsWith("/")) {
			strUrl = strUrl + strBasePath.substring(1);
		} else {
			strUrl = strUrl + strBasePath;
		}
		
		return strUrl + jspFileName;
	}
	
	
	



	/**
	 * template에 parameter를 Mapping한다.
	 * @param pm
	 * @param postDatas
	 */
	private static void addPostData(PostMethod pm, Map postDatas){
		for (Iterator i = postDatas.keySet().iterator(); i.hasNext();) {
			String key = (String) i.next();

			String value = postDatas.get(key) == null ? "" : String.valueOf(postDatas.get(key));
			if( logger.isDebugEnabled()) {
				logger.debug("key= : " + key + ", value="+value);
			}
			pm.addParameter(key, value);
		}
	}


	
	
	/**
	 * jsp를 호출한다.
	 * 
	 * @param pm
	 * @return
	 */
	private static String doRequest(PostMethod pm){
		// Create an instance of HttpClient.
		HttpClient client = new HttpClient();
		// Provide custom retry handler is necessary
		pm.getParams().setParameter(HttpMethodParams.RETRY_HANDLER,
				new DefaultHttpMethodRetryHandler(3, false));

		try {
			// Execute the method.
			int statusCode = client.executeMethod(pm);

			if (statusCode != HttpStatus.SC_OK) {
				logger.info( "statusCode is Not OK");
			}

			// Read the response body.
			return pm.getResponseBodyAsString();
		} catch (HttpException e) {
			//System.err.println("Fatal protocol violation: " + e.getMessage());
			logger.error("Fatal protocol violation: " + e.getMessage());
			//e.printStackTrace();
		} catch (IOException e) {
			//System.err.println("Fatal transport error: " + e.getMessage());
			logger.error("Fatal transport error: " + e.getMessage());
			//e.printStackTrace();
		} finally {
			// Release the connection.
			pm.releaseConnection();
		}
		return null;
	}

	

}