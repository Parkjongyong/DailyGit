package com.app.ildong.bat.controller;

import java.lang.reflect.Field;
import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.app.ildong.bat.service.BatAccountNoInterfaceService;
import com.app.ildong.bat.service.BatLogService;
import com.app.ildong.bat.service.BatMasterService;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseJobBean;
import com.app.ildong.common.service.CommonSelectService;
import com.app.ildong.common.util.PropertiesUtil;
import com.app.ildong.common.util.StringUtil;
import com.app.ildong.sys.service.SysCmmLogMgmtService;
import com.ildong.CO.BGT_ERP.IFCO001_BGT_SOBindingStub;
import com.ildong.CO.BGT_ERP.IFCO001_BGT_SOServiceLocator;
import com.ildong.CO.BGT_ERP.IFCO001_BGT_S_DT;
import com.ildong.CO.BGT_ERP.IFCO001_BGT_S_DT_response;
import com.ildong.CO.BGT_ERP.IFCO001_BGT_S_DT_responseITEM;

@Controller
public class makeAccountNoInterfaceController extends BaseJobBean {
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BatMasterService batMasterService;
	
	@Autowired
	private BatLogService batLogService;
	
	@Autowired
	private BatAccountNoInterfaceService batAccountNoInterfaceService;	
	
    @Autowired
    private SysCmmLogMgmtService sysCmmLogMgmtService;	
	
	@Autowired
	private CommonSelectService commonSelectService;
	
	private String _BATCH_JOB_ID	= "MAKE_ACCOUNT_NO_IF";
	
	@Override
	protected void executeInternal(JobExecutionContext arg0) throws JobExecutionException {
		try {
			String currTime = getTimeString(getCurrentTime());
			logger.debug("executeInternal 1 ( 5 second): currentTiem = " + currTime);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void makeAccountNoInterfaceJobRun(LinkedHashMap<String, Object> serviceParams) throws Exception {
		String compCd		= "";
		String runIp		= "";
		
		boolean goBatchRun 	= true;
		boolean batchSucc	= true;
		String batchErrMsg	= "";
		
		Map<String,Object> batchInfo = new HashMap<>();
		Map<String,Object> paramInfo = new HashMap<>();
		
		try {
			compCd	= getCompCd();
			runIp	= getServerIp();
			
			paramInfo = batMasterService.selectIsBatchWorking(compCd, _BATCH_JOB_ID, runIp);
			
			// BATCH ?????? ?????? ???????????? ???????????? ??????
			if ("N".equals(paramInfo.get("BATCH_YN"))) {
				if (logger.isDebugEnabled()) {
					logger.debug("NOT FIND FOR THIS BATCH : [BATCH_ID:" + _BATCH_JOB_ID +"][RUN_IP:"+ runIp + "]");
				}
				goBatchRun = false;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			if (logger.isDebugEnabled()) {
				logger.debug("NOT FIND FOR THIS BATCH : [BATCH_ID:" + _BATCH_JOB_ID +"]");
			}
		}
		
		if (goBatchRun) {
			//?????? ?????? ?????? ??????
			String startTime;
			try {
				startTime = commonSelectService.selectDbTime();
				batchInfo = batLogService.insertBatchLogOnStart(compCd, _BATCH_JOB_ID, runIp, startTime);
			} catch (Exception e) {
				e.printStackTrace();
				if (logger.isDebugEnabled()) {
					logger.debug("?????? ???????????? ?????? ??????");
				}
			}
			
			/************************** ?????? ?????? ????????? ?????? ?????? ?????? ***********************/
			
			/**
			 * ???????????? ????????? ??????
			 */
			Map<String,Object> batchResult = new HashMap<>();
			Map<String,Object> paramMap    = new HashMap<>();
			
			String ifFlag = "";
			String ifMgs  = "";
			
			try {
				
				// 1. SOAP ???????????? ????????????  ?????? ?????? 
				IFCO001_BGT_S_DT dt = new IFCO001_BGT_S_DT();
	        	String flag = "";
	        	String msg  = "";
	        	
	        	IFCO001_BGT_SOServiceLocator afs = new IFCO001_BGT_SOServiceLocator();
	        	IFCO001_BGT_SOBindingStub af = (IFCO001_BGT_SOBindingStub)afs.getHTTP_Port();
	        	IFCO001_BGT_S_DT_response res = new IFCO001_BGT_S_DT_response();
	        	
	        	// USER ID/PW ??????
	        	// USER ID/PW ??????
	           	String sapId= PropertiesUtil.getProperty("sap.id");
	           	String sapPw= PropertiesUtil.getProperty("sap.pw");
	           	af.setUsername(sapId);
	           	af.setPassword(sapPw);
	           	
	           	res = af.IFCO001_BGT_SO(dt);
	           	
	           	ifFlag = StringUtil.isNullToString(res.getIF_FLAG());
	           	ifMgs  = StringUtil.isNullToString(res.getIF_MSG());
	           	
	           	int accountNoLen = 0;
           		if (null != res.getITEM()) {
           			accountNoLen = res.getITEM().length;
           		}
           		
           		IFCO001_BGT_S_DT_responseITEM[] accountNoRow = new IFCO001_BGT_S_DT_responseITEM[accountNoLen];
	           	List<Map<String, Object>> accountNoList      = new ArrayList<Map<String, Object>>();
	           	
           		if (accountNoLen > 0) {
           			accountNoRow = res.getITEM();
           			
		           	for (IFCO001_BGT_S_DT_responseITEM accountNo : accountNoRow) {
		           		Map<String, Object> accountNoMap = new HashMap<String,Object>();
		                for (Field field : accountNo.getClass().getDeclaredFields()) {
		                    field.setAccessible(true);
		                    accountNoMap.put(field.getName(), field.get(accountNo));
		                    System.out.println("[" + field.getName() + "-" + field.get(accountNo) + "]");
		                }           		
		                accountNoList.add(accountNoMap);
		           	}
		           	
					// ????????? ????????????(????????????) ????????? ???????????? ?????? 
	           		batAccountNoInterfaceService.makeAccountNoData(paramMap, accountNoList);
           		}
           		

				
				batchSucc = true;
				batchResult.put("ERR_MSG", "");	           		
	           	
	       	} catch (RemoteException e) {
				batchSucc = false;
				batchErrMsg = e.toString();
	       	} catch (ServiceException se) {
				batchSucc = false;
				batchErrMsg = se.toString();
	    	} catch (Exception e) {
				batchSucc = false;
				batchErrMsg = e.toString();
	        }
				
			/************************** ?????? ?????? ????????? ?????? ?????? ???	 ***********************/
			
			String endTime;
			try {
				endTime = commonSelectService.selectDbTime();
				
				if (batchSucc) {
					batLogService.updateBatchLogOnEnd(compCd, String.valueOf(batchInfo.get("BATCH_SEQ")), endTime, batchResult);
				} else { 
					batLogService.updateBatchLogOnEnd(compCd, String.valueOf(batchInfo.get("BATCH_SEQ")), endTime, "N", batchErrMsg, batchResult);
				}
			} catch (Exception e) {
				e.printStackTrace();
				if (logger.isDebugEnabled()) {
					logger.debug("?????? ???????????? ?????? ??????");
				}
			}
		}
	}
}
