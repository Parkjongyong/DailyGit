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

import com.app.ildong.bat.service.BatCustomerInfoInterfaceService;
import com.app.ildong.bat.service.BatLogService;
import com.app.ildong.bat.service.BatMasterService;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseJobBean;
import com.app.ildong.common.service.CommonSelectService;
import com.app.ildong.common.util.PropertiesUtil;
import com.app.ildong.common.util.StringUtil;
import com.app.ildong.sys.service.SysCmmLogMgmtService;
import com.ildong.SD.BGT_ERP.IFSD113_BGT_SOBindingStub;
import com.ildong.SD.BGT_ERP.IFSD113_BGT_SOServiceLocator;
import com.ildong.SD.BGT_ERP.IFSD113_BGT_S_DT;
import com.ildong.SD.BGT_ERP.IFSD113_BGT_S_DT_response;
import com.ildong.SD.BGT_ERP.IFSD113_BGT_S_DT_responseITEM;

@Controller
public class makeCustomerInfoInterfaceController extends BaseJobBean {
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BatMasterService batMasterService;
	
	@Autowired
	private BatLogService batLogService;
	
	@Autowired
	private BatCustomerInfoInterfaceService batCustomerInfoInterfaceService;	
	
    @Autowired
    private SysCmmLogMgmtService sysCmmLogMgmtService;	
	
	@Autowired
	private CommonSelectService commonSelectService;
	
	private String _BATCH_JOB_ID	= "MAKE_CUSTOMER_INFO_IF"; // 거래처정보 I/F
	
	@Override
	protected void executeInternal(JobExecutionContext arg0) throws JobExecutionException {
		try {
			String currTime = getTimeString(getCurrentTime());
			logger.debug("executeInternal 1 ( 5 second): currentTiem = " + currTime);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void makeCustomerInfoInterfaceJobRun(LinkedHashMap<String, Object> serviceParams) throws Exception {
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
			Map<String,Object> paramMap = new HashMap<>();
			
			String ifFlag = "";
			String ifMgs  = "";
			
			try {
				
				// 1. SOAP 통신으로 거래처  정보 추출 
				IFSD113_BGT_S_DT request = new IFSD113_BGT_S_DT();
	        	
	            Calendar cal = Calendar.getInstance();
	            cal.setTime(new Date());
	            DateFormat uDate = new SimpleDateFormat("yyyyMMdd");
	            DateFormat uTime = new SimpleDateFormat("HHmm00");
	            paramMap.put("TRANSACTION_NO", uDate.format(cal.getTime()) + uTime.format(cal.getTime()));
	            
	            List<Map<String,Object>> compInfo = batMasterService.selectCompCd();
	            
	            for(int i = 0; i < compInfo.size(); i++) {
		            if (!"".equals(StringUtil.isNullToString(paramInfo.get("BATCH_ARG2")))) {
		            	request.setERDAR_TO(paramInfo.get("BATCH_ARG2").toString());
		            	System.out.println("BATCH_ARG2 I::" + paramInfo.get("BATCH_ARG2").toString());
		            } else {
		            	request.setERDAR_TO(uDate.format(cal.getTime()));
		            	System.out.println("BATCH_ARG2 C::" + uDate.format(cal.getTime()));
		            }
		            
		            
		            if (!"".equals(StringUtil.isNullToString(paramInfo.get("BATCH_ARG1")))) {
		            	request.setERDAR_FR(paramInfo.get("BATCH_ARG1").toString());
		            	System.out.println("BATCH_ARG1 I::" + paramInfo.get("BATCH_ARG1").toString());
		            } else {
		            	System.out.println("BATCH_ARG1 C::" + uDate.format(cal.getTime()));
		            	request.setERDAR_FR(uDate.format(cal.getTime()));
		            }
		            
		            // 영업조직
		            if (!"".equals(StringUtil.isNullToString(paramInfo.get("BATCH_ARG5")))) {
		            	request.setVKORG(paramInfo.get("BATCH_ARG5").toString());
		            	System.out.println("BATCH_ARG5 I::" + paramInfo.get("BATCH_ARG5").toString());
		            } else {
		            	request.setVKORG((String)compInfo.get(i).get("CODE"));
		            	System.out.println("BATCH_ARG5 C::" + (String)compInfo.get(i).get("CODE"));
		            }
		            
		            // 테스트용
		            /*
		            request.setI_UDATE_TO("20201015");
		            request.setI_UDATE_FR("20200101");
		        	*/
		            IFSD113_BGT_SOServiceLocator sl = new IFSD113_BGT_SOServiceLocator();
		            IFSD113_BGT_SOBindingStub bs = (IFSD113_BGT_SOBindingStub)sl.getHTTP_Port();
		            IFSD113_BGT_S_DT_response res = new IFSD113_BGT_S_DT_response();
		        	
		        	// USER ID/PW 셋팅
		           	String sapId= PropertiesUtil.getProperty("sap.id");
		           	String sapPw= PropertiesUtil.getProperty("sap.pw");
		           	bs.setUsername(sapId);
		           	bs.setPassword(sapPw);
		           	
		           	res = bs.IFSD113_BGT_SO(request);
		           	
		           	ifFlag = StringUtil.isNullToString(res.getIF_FLAG());
		           	ifMgs  = StringUtil.isNullToString(res.getIF_MSG());
		           	
		           	int customerInfoLen = 0;
	           		if (null != res.getITEM()) {
	           			customerInfoLen = res.getITEM().length;
	           		}
	           		
	           		System.out.println("ifFlag::" + ifFlag);
	           		
//		           	// 성공시에만 수행하도록 ....
//		           	if ("S".equals(ifFlag)) {
		           		
		           		IFSD113_BGT_S_DT_responseITEM[] customerInfoRow = new IFSD113_BGT_S_DT_responseITEM[customerInfoLen];
			           	List<Map<String, Object>> customerInfoList      = new ArrayList<Map<String, Object>>();
			           	
		           		if (customerInfoLen > 0) {
		           			customerInfoRow = res.getITEM();
				           	// 거래처정보
				           	for (IFSD113_BGT_S_DT_responseITEM customerInfo : customerInfoRow) {
				           		Map<String, Object> customerInfoMap = new HashMap<String,Object>();
				                for (Field field : customerInfo.getClass().getDeclaredFields()) {
				                    field.setAccessible(true);
				                    customerInfoMap.put(field.getName(), field.get(customerInfo));
				                }           		
				                customerInfoList.add(customerInfoMap);
				           	}
				           	
							// 2. 전송된 공급업체  정보를 I/F 테이블에 반영 
			           		batCustomerInfoInterfaceService.makeCustomerInfoInterfaceData(customerInfoList, paramMap);			           	
		           		}
						
						batchSucc = true;
						batchResult.put("ERR_MSG", "");	   
	            }
//	           		
//	           	} else if ("E".equals(ifFlag)) {
//	           		batchSucc = false;
//	           		batchResult.put("ERR_MSG", ifMgs);
//	           		batchErrMsg = ifMgs;
//	           	}
	           	
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
