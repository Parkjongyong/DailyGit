package com.app.ildong.sap;

import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.util.JCoUtils;
import com.app.ildong.common.util.PropertiesUtil;
import com.sap.conn.jco.JCoDestination;
import com.sap.conn.jco.JCoDestinationManager;
import com.sap.conn.jco.JCoException;
import com.sap.conn.jco.JCoFunction;
import com.sap.conn.jco.ext.DestinationDataProvider;
import com.sap.conn.jco.ext.Environment;

public class JCoExecuteService  {
	private static String _DEST_NAME = "SKONS_AS";
	
	public static Map<String, Object> processJCoExecute(Map<String, Object> paramMap) throws ServiceException, Exception {
		
//		JCoDestinationDataProvider dataProvider = new JCoDestinationDataProvider();
		
		try
        {
	    	if(PropertiesUtil.isRealMode()) {
	        	String javaLibPath = System.getProperty("java.library.path");
	        	String jcoLibPath  = PropertiesUtil.getProperty("jco.lib.path");
	        	if(javaLibPath.indexOf(jcoLibPath) < 0) {
	            	System.setProperty("java.library.path", System.getProperty("java.library.path") + ";" + jcoLibPath);
	        	}
	    	}
	    	
			String funcName  = (String)paramMap.get("FUNC_NAME");
//			if (!Environment.isDestinationDataProviderRegistered()) {
//				System.out.println("dataProvider register S"+dataProvider);
//				Environment.registerDestinationDataProvider(dataProvider);
//				System.out.println("dataProvider register E"+dataProvider);
//			}
		               	 
			//dataProvider.changeProperties("SKONS_AS",getDestinationPropertiesFromUI());
			return executeCalls(_DEST_NAME, funcName, paramMap);
        }
        catch(IllegalStateException providerAlreadyRegisteredException)
        {
            //somebody else registered its implementation, 
            //stop the execution
            throw new Error(providerAlreadyRegisteredException);
        } finally {
        	try {
//        		if (Environment.isDestinationDataProviderRegistered()) {
//    				System.out.println("dataProvider unregister S"+dataProvider);
//    				Environment.unregisterDestinationDataProvider(dataProvider);
//    				System.out.println("dataProvider unregister E"+dataProvider);
//        		}
        	} catch (Exception e) {
        		throw new Error(e);
        	}
        }
	}
	
    //business logic
    private static Map<String,Object> executeCalls(String destName, String funcName, Map<String, Object> paramMap) throws ServiceException, Exception
    {
        JCoDestination dest = null;
        JCoFunction function = null;
        
        Map<String,Object> responseData = new HashMap<>();
        try
        {
        	JCoDestinationDataProvider dataProvider = new JCoDestinationDataProvider();
            //dest = JCoDestinationManager.getDestination(destName);
        	dest = dataProvider.getDestination(destName, getDestinationPropertiesFromUI());
            dest.ping();
            
            //ZFI_WITHUS_GL_ACCOUNT_LIST 
            function = dest.getRepository().getFunction(funcName);
            
            if(function == null)
                throw new RuntimeException(funcName + " not found in SAP.");

            
            JCoUtils.convertMapToImportParameterList(function, paramMap);
            
            //execute, i.e. send the function to the ABAP system addressed 
            //by the specified destination, which then returns the function result.
            //All necessary conversions between Java and ABAP data types
            //are done automatically.
            function.execute(dest);
           
            responseData = JCoUtils.convertExportParameterListToListMap(function);

            //responseData.put("RESULT"		, "S");
            //responseData.put("I_PARAMS"		, paramMap);
        }
        catch(JCoException e)
        {
            e.printStackTrace();
            responseData.put("RESULT"		, "F");
            responseData.put("RESULT_MSG"	, e.getMessage());
        }
        catch (Exception e) 
        {
        	e.printStackTrace();
            responseData.put("RESULT"		, "F");
            responseData.put("RESULT_MSG"	, e.getMessage());
        }
        
        return responseData;
    }
    
    private static Properties getDestinationPropertiesFromUI()
    {
    	String user 	= PropertiesUtil.getProperty("jco.client.user");
    	String passwd 	= PropertiesUtil.getProperty("jco.client.passwd");
    	String lang 	= PropertiesUtil.getProperty("jco.client.lang");
    	String client 	= PropertiesUtil.getProperty("jco.client.client");
    	String sysnr 	= PropertiesUtil.getProperty("jco.client.sysnr");
    	String ashost 	= PropertiesUtil.getProperty("jco.client.ashost");
    	String gwhost 	= PropertiesUtil.getProperty("jco.client.gwhost");
    	String gwserv 	= PropertiesUtil.getProperty("jco.client.gwserv");

    	Properties connectProperties = new Properties();
    	
    	connectProperties.setProperty(DestinationDataProvider.JCO_USER			,  user);
    	connectProperties.setProperty(DestinationDataProvider.JCO_PASSWD		,  passwd);
    	connectProperties.setProperty(DestinationDataProvider.JCO_CLIENT		,  client);
    	connectProperties.setProperty(DestinationDataProvider.JCO_SYSNR			,  sysnr);
    	connectProperties.setProperty(DestinationDataProvider.JCO_ASHOST		,  ashost);
	    if (!PropertiesUtil.isLocalMode()) {
	    	connectProperties.setProperty(DestinationDataProvider.JCO_GWHOST		,  gwhost);
	    	connectProperties.setProperty(DestinationDataProvider.JCO_GWSERV		,  gwserv);
	    }

//	    connectProperties.setProperty(DestinationDataProvider.JCO_POOL_CAPACITY, "5");
//	    connectProperties.setProperty(DestinationDataProvider.JCO_PEAK_LIMIT,    "30");


        return connectProperties;
    }
    
    public static void main(String[] args) throws JCoException
    {
    	try {
    		Map<String,Object> paramMap = new HashMap<>();
    		
   		    System.out.println("1.=======================");
//환율
   		    //    		paramMap.put("FUNC_NAME", "Z_MM_EPRO_EVENT_A_4");
//    		paramMap.put("I_FOREIGN_CURR"	, "EUR");
//    		paramMap.put("I_LOCAL_CURR"	, "KRW");
    		paramMap.put("FUNC_NAME", "ZMM_IPRO_01_5_A");//기존 rfc Z_MM_EPRO_EVENT_01_5

    		paramMap.put("I_LIFNR"	, "");//업체번호
    		paramMap.put("I_NAME1"	, "");//업체명
    		paramMap.put("I_J_1KFREPRE"	, "");//대표자명
    		paramMap.put("I_STCD2"	, "");//사업자등록번호

    		paramMap.put("PAGE_NO"	, "1");
    		paramMap.put("PAGE_SIZE"	, "999");
    		
//    		JCO Input Parameter () set to Field (I_EKORG).
//    		JCO Input Parameter (c) set to Field (I_J_1KFREPRE).
//    		JCO Input Parameter (a) set to Field (I_LIFNR).
//    		JCO Input Parameter (b) set to Field (I_NAME1).
//    		JCO Input Parameter () set to Field (I_QINF).
//    		JCO Input Parameter (d) set to Field (I_STCD2).
//    		JCO Input Parameter (1) set to Field (PAGE_NO).
//    		JCO Input Parameter (999) set to Field (PAGE_SIZE).
    		
    		 Map<String, Object> oMap = processJCoExecute(paramMap);
    		 System.out.println("2.=======================");
    		 System.out.println(oMap);
    		 System.out.println("3.=======================");
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
//        step2ConnectUsingPool();
//        step3SimpleCall();
//        step4WorkWithTable();
//        step4SimpleStatefulCalls();
    }
}
