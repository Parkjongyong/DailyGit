package com.app.ildong.common.util;

import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import org.apache.commons.httpclient.DefaultHttpMethodRetryHandler;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.params.HttpMethodParams;

public class MailUtils {

	
	/**
	 * 메일 content를 생성해서 return 한다.
	 * 
	 * @param mailInfoMap
	 * @param postData
	 * @return
	 * @throws Exception
	 */
	public static String getMailContents(String serverUrl, Map mailInfoMap,  Map postData) throws Exception {

		if( mailInfoMap != null) {
			String strUseYn = mailInfoMap.get("USE_YN") == null ? null : String.valueOf( mailInfoMap.get("USE_YN") );
			if( "Y".equals( strUseYn)) {
				String strContentPath = mailInfoMap.get("CONTENT_PATH") == null ? "" : String.valueOf( mailInfoMap.get("CONTENT_PATH") );
				
				if( !"".equals(strContentPath)) {
					
					String strContents = parseRequest(serverUrl, strContentPath, postData );
							
					return strContents;
				}			
			}
		}
		return null;
	}
	



	/**
	 * 메일 content를 생성해서 return 한다.
	 * 
	 * @param serverUrl
	 * @param mailInfoMap
	 * @param datalist
	 * @return
	 * @throws Exception
	 */
	public static String getMailContents(String serverUrl, Map mailInfoMap,  List<Map> datalist)throws Exception {
		if( mailInfoMap != null) {
			String strUseYn = mailInfoMap.get("USE_YN") == null ? null : String.valueOf( mailInfoMap.get("USE_YN") );
			if( "Y".equals( strUseYn)) {
				String strContentPath = mailInfoMap.get("CONTENT_PATH") == null ? "" : String.valueOf( mailInfoMap.get("CONTENT_PATH") );
				
				if( !"".equals(strContentPath)) {
					
					String strContents = parseRequest(serverUrl, strContentPath, datalist );
							
					return strContents;
				}			
			}
		}
		return null;


	}

	
	/**
	 * 메일 template에 data를 mapping하여 content를 생성한다. 
	 * @param url
	 * @param postDatas
	 * @return
	 */
	public static String parseRequest(String serverUrl, String contentPath, Map postDatas) {
		
		PostMethod pm = new PostMethod(makeUrl(serverUrl, contentPath));
		pm.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
		
		pm.addParameter("URL", serverUrl);
		addPostData(pm, postDatas);
		return doRequest(pm);
	}
	
	

	/**
	 * 메일 template에 data를 mapping하여 content를 생성한다. 
	 * 
	 * @param serverUrl
	 * @param contentPath
	 * @param dateList
	 * @return
	 */
	public static String parseRequest(String serverUrl, String contentPath, List<Map> dateList) {
		PostMethod pm = new PostMethod(makeUrl(serverUrl, contentPath));
		pm.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
		pm.addParameter("URL", serverUrl);
		
		for(int i=0 ; i < dateList.size() ; i++){
			addPostData(pm, dateList.get(i));
		}
		return doRequest(pm);
	}
	
	
	/**
	 * 메일 content URL을 생성한다.
	 * @param serverPath
	 * @param url
	 * @return
	 */
	private static String makeUrl(String serverPath, String url) {
		String cUrl = url;
		if (url == null || "".equals(url.trim()))
			return null;

		if (serverPath.endsWith("/") && url.startsWith("/")) {
			cUrl = url.substring(1);
		}
		return serverPath + cUrl;
	}
	
	
	



	/**
	 * template에 parameter를 Mapping한다.
	 * @param pm
	 * @param postDatas
	 */
	private static void addPostData(PostMethod pm, Map postDatas){
		for (Iterator i = postDatas.keySet().iterator(); i.hasNext();) {
			String key = (String) i.next();
			Object obj = postDatas.get(key);
			if ( obj instanceof java.util.List ) {
				List listObj = (List)obj;
				for( int j = 0, nSize=listObj.size(); j < nSize ; j++) {
					pm.addParameter(key, String.valueOf(listObj.get(j)));
				}
			} else {
				String value = postDatas.get(key) == null ? "" : String.valueOf(postDatas.get(key));
				pm.addParameter(key, value);
			}
		}
	}


	
	
	/**
	 * 메일 content를 생성한다.
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
				//logger.info( "statusCode is Not OK");
			}

			// Read the response body.
			return pm.getResponseBodyAsString();
		} catch (HttpException e) {
			//System.err.println("Fatal protocol violation: " + e.getMessage());
			//e.printStackTrace();
		} catch (IOException e) {
			//System.err.println("Fatal transport error: " + e.getMessage());
			//logger.error("Fatal transport error: " + e.getMessage());
			//e.printStackTrace();
		} finally {
			// Release the connection.
			pm.releaseConnection();
		}
		return null;
	}

	

	
	/**
	 * SMS 메세지를 return 한다.
	 * 
	 * @param mailInfoMap
	 * @param postData
	 * @return
	 * @throws Exception
	 */
	public static String getSmsMessage( Map mailInfoMap,  Map postData ) throws Exception {
		
		if( mailInfoMap != null) {
			String strUseYn = mailInfoMap.get("USE_YN") == null ? "" : String.valueOf( mailInfoMap.get("USE_YN") );
			if( "Y".equals( strUseYn)) {
				String strSmsMsg = mailInfoMap.get("SMS_MSG") == null ? "" : String.valueOf( mailInfoMap.get("SMS_MSG") );
				if( !"".equals(strSmsMsg) ) {
					
					return exchangeData( strSmsMsg, postData);
				}
			}
			
		}
		return null;
	}
	
	
	/**
	 * Note message를 return 한다.
	 * 
	 * @param mailInfoMap
	 * @param postData
	 * @return
	 * @throws Exception
	 */
	public static String getNoteMessage( Map mailInfoMap,  Map postData ) throws Exception {
		
		if( mailInfoMap != null) {
			String strUseYn = mailInfoMap.get("USE_YN") == null ? "" : String.valueOf( mailInfoMap.get("USE_YN") );
			if( "Y".equals( strUseYn)) {
				String strNoteMsg = mailInfoMap.get("NOTE_MSG") == null ? "" : String.valueOf( mailInfoMap.get("NOTE_MSG") );
				if( !"".equals(strNoteMsg) ) {
					
					return exchangeData( strNoteMsg, postData);
				}
			}
			
		}
		return null;
	}
	
	
	/**
	 * 주어진 문자열에서 data 값으로 대치한다.
	 * 
	 * @param message
	 * @param data
	 * @return
	 */
	private static String exchangeData(String strMsg, Map data){
		StringBuilder result = new StringBuilder();
		//StringBuffer result = new StringBuffer();
		StringTokenizer stk = new StringTokenizer(" "+ strMsg , "#" ,false);
		boolean isParameter = true;
		while(stk.hasMoreTokens()){
			if((isParameter = !isParameter)){
				String token = stk.nextToken().toUpperCase();
				Object value = data.get(token);
				if(value != null)
					result.append(value.toString());
			}else{
				String token = stk.nextToken();
				result.append(token);
			}
		}
		result.delete(0, 1);
		/* \n 을 입력하면 \\n 으로 바뀌는 문제가 있어서 \\n 을 \n 으로 치환 */
		//return result.toString().replace("\\n", "\n");
		return result.toString();
	}

}
