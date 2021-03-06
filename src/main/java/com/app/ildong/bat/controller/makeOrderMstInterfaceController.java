package com.app.ildong.bat.controller;

import java.lang.reflect.Field;
import java.rmi.RemoteException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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

import com.app.ildong.bat.service.BatLogService;
import com.app.ildong.bat.service.BatMasterService;
import com.app.ildong.bat.service.BatOrderMstInterfaceService;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseJobBean;
import com.app.ildong.common.service.CommonSelectService;
import com.app.ildong.common.util.PropertiesUtil;
import com.app.ildong.common.util.StringUtil;
import com.app.ildong.sys.service.SysCmmLogMgmtService;
import com.ildong.CO.BGT_ERP.IFCO004_BGT_SOBindingStub;
import com.ildong.CO.BGT_ERP.IFCO004_BGT_SOServiceLocator;
import com.ildong.CO.BGT_ERP.IFCO004_BGT_S_DT;
import com.ildong.CO.BGT_ERP.IFCO004_BGT_S_DT_response;
import com.ildong.CO.BGT_ERP.IFCO004_BGT_S_DT_responseITEM;

@Controller
public class makeOrderMstInterfaceController extends BaseJobBean {
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BatMasterService batMasterService;
	
	@Autowired
	private BatLogService batLogService;
	
	@Autowired
	private BatOrderMstInterfaceService batOrderMstInterfaceService;	
	
    @Autowired
    private SysCmmLogMgmtService sysCmmLogMgmtService;	
	
	@Autowired
	private CommonSelectService commonSelectService;
	
	private String _BATCH_JOB_ID	= "MAKE_ORDER_MST_IF";
	
	@Override
	protected void executeInternal(JobExecutionContext arg0) throws JobExecutionException {
		try {
			String currTime = getTimeString(getCurrentTime());
			logger.debug("executeInternal 1 ( 5 second): currentTiem = " + currTime);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void makeOrderMstInterfaceJobRun(LinkedHashMap<String, Object> serviceParams) throws Exception {
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
				IFCO004_BGT_S_DT dt = new IFCO004_BGT_S_DT();
	        	String flag = "";
	        	String msg  = "";
	        	List<Map<String,Object>> compInfo = batMasterService.selectCompCd();
	        	
	        	for(int i = 0; i < compInfo.size(); i++) {
	        	
		            Calendar cal = Calendar.getInstance();
		            cal.setTime(new Date());
		            DateFormat uDate = new SimpleDateFormat("yyyyMMdd");
		            DateFormat uTime = new SimpleDateFormat("HHmm00");	        	
		        		        	
		        	
		            if (!"".equals(StringUtil.isNullToString(paramInfo.get("BATCH_ARG5")))) {
		            	dt.setI_BUKRS(paramInfo.get("BATCH_ARG5").toString());
		            	System.out.println("????????????::" + paramInfo.get("BATCH_ARG5").toString());
		            } else {
		            	// ????????? ??????
		            	System.out.println("????????????(???????????????)::"+ (String)compInfo.get(i).get("CODE"));
		            	dt.setI_BUKRS((String)compInfo.get(i).get("CODE"));
		            }
		            
		            if (!"".equals(StringUtil.isNullToString(paramInfo.get("BATCH_ARG1")))) {
		            	dt.setI_UDATE_FR(paramInfo.get("BATCH_ARG1").toString());
		            	System.out.println("????????????::" + paramInfo.get("BATCH_ARG1").toString());
		            } else {
		            	System.out.println("????????????(???????????????)::" + uDate.format(cal.getTime()));
		            	dt.setI_UDATE_FR(uDate.format(cal.getTime()));
		            }
		            
		            if (!"".equals(StringUtil.isNullToString(paramInfo.get("BATCH_ARG2")))) {
		            	dt.setI_UDATE_TO(paramInfo.get("BATCH_ARG2").toString());
		            	System.out.println("????????????::" + paramInfo.get("BATCH_ARG2").toString());
		            } else {
		            	System.out.println("????????????(???????????????)::" + uDate.format(cal.getTime()));
		            	dt.setI_UDATE_TO(uDate.format(cal.getTime()));
		            }
		        	
		        	IFCO004_BGT_SOServiceLocator afs = new IFCO004_BGT_SOServiceLocator();
		        	IFCO004_BGT_SOBindingStub af = (IFCO004_BGT_SOBindingStub)afs.getHTTP_Port();
		        	IFCO004_BGT_S_DT_response res = new IFCO004_BGT_S_DT_response();
		        	
		        	// USER ID/PW ??????
		           	String sapId= PropertiesUtil.getProperty("sap.id");
		           	String sapPw= PropertiesUtil.getProperty("sap.pw");
		           	af.setUsername(sapId);
		           	af.setPassword(sapPw);		           	
		           	
		           	res = af.IFCO004_BGT_SO(dt);
		           	
		           	ifFlag = StringUtil.isNullToString(res.getIF_FLAG());
		           	ifMgs  = StringUtil.isNullToString(res.getIF_MSG());
		           	
		           	int orderMstLen = 0;
	           		if (null != res.getITEM()) {
	           			orderMstLen = res.getITEM().length;
	           		}
	           		
	           		IFCO004_BGT_S_DT_responseITEM[] orderMstRow = new IFCO004_BGT_S_DT_responseITEM[orderMstLen];
		           	List<Map<String, Object>> orderMstList      = new ArrayList<Map<String, Object>>();
		           	
	           		if (orderMstLen > 0) {
	           			orderMstRow = res.getITEM();
	           			
			           	for (IFCO004_BGT_S_DT_responseITEM orderMst : orderMstRow) {
			           		Map<String, Object> orderMstMap = new HashMap<String,Object>();
			                for (Field field : orderMst.getClass().getDeclaredFields()) {
			                    field.setAccessible(true);
			                    orderMstMap.put(field.getName(), field.get(orderMst));
			                    System.out.println("[" + field.getName() + "-" + field.get(orderMst) + "]");
			                }           		
			                orderMstList.add(orderMstMap);
			           	}
			           	
						// ????????? ???????????? ??????(??????????????????) ????????? ???????????? ?????? 
			           	batOrderMstInterfaceService.makeOrderMstData(paramMap, orderMstList);
	           		}
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
				// ???????????? ?????? ?????? ??????  ?????????!
				sysCmmLogMgmtService.updateParamBatchMaster(paramInfo);
			} catch (Exception e) {
				e.printStackTrace();
				if (logger.isDebugEnabled()) {
					logger.debug("?????? ???????????? ?????? ??????");
				}
			}
		}
	}
}
