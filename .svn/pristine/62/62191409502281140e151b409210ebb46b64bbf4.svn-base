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
import com.app.ildong.bat.service.BatVendorInterfaceService;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseJobBean;
import com.app.ildong.common.service.CommonSelectService;
import com.app.ildong.common.util.PropertiesUtil;
import com.app.ildong.common.util.StringUtil;
import com.app.ildong.sys.service.SysCmmLogMgmtService;
import com.ildong.MM.BGT_ERP.IFMM033_BGT_SOBindingStub;
import com.ildong.MM.BGT_ERP.IFMM033_BGT_SOServiceLocator;
import com.ildong.MM.BGT_ERP.IFMM033_BGT_S_DT;
import com.ildong.MM.BGT_ERP.IFMM033_BGT_S_DT_response;
import com.ildong.MM.BGT_ERP.IFMM033_BGT_S_DT_responseVEND_HEAD;
import com.ildong.MM.BGT_ERP.IFMM033_BGT_S_DT_responseVEND_PURCHORG;

@Controller
public class makeVendorInterfaceController extends BaseJobBean {
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BatMasterService batMasterService;
	
	@Autowired
	private BatLogService batLogService;
	
	@Autowired
	private BatVendorInterfaceService batVendorInterfaceService;
	
    @Autowired
    private SysCmmLogMgmtService sysCmmLogMgmtService;		
	
	@Autowired
	private CommonSelectService commonSelectService;
	
	private String _BATCH_JOB_ID	= "MAKE_VENDOR_IF";
	
	@Override
	protected void executeInternal(JobExecutionContext arg0) throws JobExecutionException {
		try {
			String currTime = getTimeString(getCurrentTime());
			logger.debug("executeInternal 1 ( 5 second): currentTiem = " + currTime);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void makeVendorInterfaceJobRun(LinkedHashMap<String, Object> serviceParams) throws Exception {
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
			
			// BATCH 사용 유무 확인하여 실행여부 결정
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
			//배치 시작 정보 기록
			String startTime;
			try {
				startTime = commonSelectService.selectDbTime();
				batchInfo = batLogService.insertBatchLogOnStart(compCd, _BATCH_JOB_ID, runIp, startTime);
			} catch (Exception e) {
				e.printStackTrace();
				if (logger.isDebugEnabled()) {
					logger.debug("배치 시작정보 기록 실패");
				}
			}
			
			/************************** 배치 수행 서비스 로직 처리 시작 ***********************/
			
			/**
			 * 대시보드 리포팅 처리
			 */
			Map<String,Object> batchResult = new HashMap<>();
			Map<String,Object> paramMap    = new HashMap<>();
			
			String ifFlag = "";
			String ifMgs  = "";
			
			try {
				
				// 1. SOAP 통신으로 공급업체  정보 추출 
	        	IFMM033_BGT_S_DT dt = new IFMM033_BGT_S_DT();
	        	String flag = "";
	        	String msg  = "";
	        	
	            Calendar cal = Calendar.getInstance();
	            cal.setTime(new Date());
	            DateFormat uDate = new SimpleDateFormat("yyyyMMdd");
	            DateFormat uTime = new SimpleDateFormat("HHmm00");	        	
	        	
	            paramMap.put("TRANSACTION_NO", uDate.format(cal.getTime()) + uTime.format(cal.getTime()));
	            if (!"".equals(StringUtil.isNullToString(paramInfo.get("BATCH_ARG2")))) {
	            	dt.setI_UDATE_TO(paramInfo.get("BATCH_ARG2").toString());
	            } else {
	            	dt.setI_UDATE_TO(uDate.format(cal.getTime()));
	            }
	            
	            if (!"".equals(StringUtil.isNullToString(paramInfo.get("BATCH_ARG4")))) {
	            	dt.setI_UTIME_TO(paramInfo.get("BATCH_ARG4").toString());
	            } else {
	            	dt.setI_UTIME_TO(uDate.format(cal.getTime()) + uTime.format(cal.getTime()));
	            }	            
	            
	            if (!"".equals(StringUtil.isNullToString(paramInfo.get("BATCH_ARG1")))) {
	            	dt.setI_UDATE_FR(paramInfo.get("BATCH_ARG1").toString());
	            } else {
	            	cal.add(Calendar.DATE,-60);
	            	dt.setI_UDATE_FR(uDate.format(cal.getTime()));
	            }
	            
	            if (!"".equals(StringUtil.isNullToString(paramInfo.get("BATCH_ARG3")))) {
	            	dt.setI_UTIME_FR(paramInfo.get("BATCH_ARG3").toString());
	            } else {
	            	cal.add(Calendar.MINUTE,-30);
	            	dt.setI_UTIME_FR(uDate.format(cal.getTime()) + uTime.format(cal.getTime()));
	            }
	            
	            
	            // 테스트용
	            /*
	            dt.setI_UDATE_TO("20200801");
	            dt.setI_UDATE_FR("20200731");
	            dt.setI_UTIME_TO("235959");
	            dt.setI_UTIME_FR("154800");
	            paramMap.put("TRANSACTION_NO", "20200801235959");
	        	*/	        	
	        	
	        	IFMM033_BGT_SOServiceLocator afs = new IFMM033_BGT_SOServiceLocator();
	        	IFMM033_BGT_SOBindingStub af = (IFMM033_BGT_SOBindingStub)afs.getHTTP_Port();
	        	IFMM033_BGT_S_DT_response res = new IFMM033_BGT_S_DT_response();
	        	
	        	// USER ID/PW 셋팅
	           	String sapId= PropertiesUtil.getProperty("sap.id");
	           	String sapPw= PropertiesUtil.getProperty("sap.pw");
	           	af.setUsername(sapId);
	           	af.setPassword(sapPw);
	           	
	           	res = af.IFMM033_BGT_SO(dt);
	           	
	           	ifFlag = StringUtil.isNullToString(res.getIF_FLAG());
	           	ifMgs  = StringUtil.isNullToString(res.getIF_MSG());
	           	
	           	int vendHeadLen = 0;
	           	int vendPurchOrgLen = 0;	           	
           		if (null != res.getVEND_HEAD()) {
           			vendHeadLen = res.getVEND_HEAD().length;
           		}
           		
           		if (null != res.getVEND_PURCHORG()) {
           			vendPurchOrgLen = res.getVEND_PURCHORG().length;
           		}           		

	           	// 성공시에만 수행하도록 ....
	           	if ("S".equals(ifFlag)) {
	           		IFMM033_BGT_S_DT_responseVEND_HEAD[] vendDtRow         = new IFMM033_BGT_S_DT_responseVEND_HEAD[vendHeadLen];
		           	IFMM033_BGT_S_DT_responseVEND_PURCHORG[] purchorgDtRow = new IFMM033_BGT_S_DT_responseVEND_PURCHORG[vendPurchOrgLen];
		           	List<Map<String, Object>> vendList         = new ArrayList<Map<String, Object>>();
		           	List<Map<String, Object>> vendPurchorgList = new ArrayList<Map<String, Object>>();
		           	
	           		if (vendHeadLen > 0) {
	           			vendDtRow = res.getVEND_HEAD();
	           			
			           	for (IFMM033_BGT_S_DT_responseVEND_HEAD vendDt : vendDtRow) {
			           		Map<String, Object> vendMap = new HashMap<String,Object>();
			                for (Field field : vendDt.getClass().getDeclaredFields()) {
			                    field.setAccessible(true);
			    				vendMap.put(field.getName(), field.get(vendDt));
			                }           		
			           		vendList.add(vendMap);
			           	}
	           		}
	           		
	           		if (vendPurchOrgLen > 0) {
	           			purchorgDtRow = res.getVEND_PURCHORG();
	           			
			           	if (purchorgDtRow.length > 0) {
				           	for (IFMM033_BGT_S_DT_responseVEND_PURCHORG purchorgDt : purchorgDtRow) {
				           		Map<String, Object> purchorgMap = new HashMap<String,Object>();
				                for (Field field : purchorgDt.getClass().getDeclaredFields()) {
				                    field.setAccessible(true);
				    				purchorgMap.put(field.getName(), field.get(purchorgDt));
				                }           		
				                vendPurchorgList.add(purchorgMap);
				           	}
			           	}	           			
	           		}
					
					// 2. 전송된 공급업체  정보를 I/F 테이블에 반영 
	           		batVendorInterfaceService.makeInterfaceVendorData(paramMap, vendList, vendPurchorgList);
					
					batchSucc = true;
					batchResult.put("ERR_MSG", "");	           		
	           	} else if ("E".equals(ifFlag)) {
	           		batchSucc = false;
	           		batchResult.put("ERR_MSG", ifMgs);
	           		batchErrMsg = ifMgs;
	           	}
	           	
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
				
			/************************** 배치 수행 서비스 로직 처리 끝	 ***********************/
			
			String endTime;
			try {
				endTime = commonSelectService.selectDbTime();
				
				if (batchSucc) {
					batLogService.updateBatchLogOnEnd(compCd, String.valueOf(batchInfo.get("BATCH_SEQ")), endTime, batchResult);
				} else { 
					batLogService.updateBatchLogOnEnd(compCd, String.valueOf(batchInfo.get("BATCH_SEQ")), endTime, "N", batchErrMsg, batchResult);
				}
				
				// 화면에서 입력 받은 값을  초기화!
				sysCmmLogMgmtService.updateParamBatchMaster(paramInfo);
			} catch (Exception e) {
				e.printStackTrace();
				if (logger.isDebugEnabled()) {
					logger.debug("배치 종료정보 기록 실패");
				}
			}
		}
	}
}
