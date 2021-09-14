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

import com.app.ildong.bat.service.BatBugtResultInterfaceService;
import com.app.ildong.bat.service.BatLogService;
import com.app.ildong.bat.service.BatMasterService;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseJobBean;
import com.app.ildong.common.service.CommonSelectService;
import com.app.ildong.common.util.PropertiesUtil;
import com.app.ildong.common.util.StringUtil;
import com.app.ildong.sys.service.SysCmmLogMgmtService;
import com.ildong.CO.BGT_ERP.IFCO010_BGT_SOBindingStub;
import com.ildong.CO.BGT_ERP.IFCO010_BGT_SOServiceLocator;
import com.ildong.CO.BGT_ERP.IFCO010_BGT_S_DT;
import com.ildong.CO.BGT_ERP.IFCO010_BGT_S_DT_response;
import com.ildong.CO.BGT_ERP.IFCO010_BGT_S_DT_responseITEM;

@Controller
public class makeBugtResultInterfaceController extends BaseJobBean {
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BatMasterService batMasterService;
	
	@Autowired
	private BatLogService batLogService;
	
	@Autowired
	private BatBugtResultInterfaceService batBugtResultInterfaceService;	
	
    @Autowired
    private SysCmmLogMgmtService sysCmmLogMgmtService;	
	
	@Autowired
	private CommonSelectService commonSelectService;
	
	private String _BATCH_JOB_ID	= "MAKE_BUGT_RESULT_IF";
	
	@Override
	protected void executeInternal(JobExecutionContext arg0) throws JobExecutionException {
		try {
			String currTime = getTimeString(getCurrentTime());
			logger.debug("executeInternal 1 ( 5 second): currentTiem = " + currTime);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void makeBugtResultInterfaceJobRun(LinkedHashMap<String, Object> serviceParams) throws Exception {
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
				IFCO010_BGT_S_DT dt = new IFCO010_BGT_S_DT();
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
		            	System.out.println("회사코드::" + paramInfo.get("BATCH_ARG5").toString());
		            } else {
		            	// 디폴트 처리
		            	System.out.println("회사코드(디폴트처리)::"+ (String)compInfo.get(i).get("CODE"));
		            	dt.setI_BUKRS((String)compInfo.get(i).get("CODE"));
		            }
		            
		            if (!"".equals(StringUtil.isNullToString(paramInfo.get("BATCH_ARG6")))) {
		            	dt.setI_GJAHR(paramInfo.get("BATCH_ARG6").toString());
		            	System.out.println("회계연도::" + paramInfo.get("BATCH_ARG6").toString());
		            } else {
		            	System.out.println("회계연도(디폴트처리)::" + uDate.format(cal.getTime()).substring(0, 4));
		            	dt.setI_GJAHR(uDate.format(cal.getTime()).substring(0, 4));
		            }
		            
		            if (!"".equals(StringUtil.isNullToString(paramInfo.get("BATCH_ARG7")))) {
		            	dt.setI_MONAT(paramInfo.get("BATCH_ARG7").toString());
		            	paramMap.put("MONAT", paramInfo.get("BATCH_ARG7").toString());
		            	System.out.println("기간월::" + paramInfo.get("BATCH_ARG7").toString());
		            	
		            } else {
		            	System.out.println("기간월(디폴트처리)::" + uDate.format(cal.getTime()).substring(4, 6));
		            	paramMap.put("MONAT", paramInfo.get("BATCH_ARG7").toString());
		            	dt.setI_MONAT(uDate.format(cal.getTime()).substring(4, 6));
		            }	            
		            
		            IFCO010_BGT_SOServiceLocator afs = new IFCO010_BGT_SOServiceLocator();
		            IFCO010_BGT_SOBindingStub af = (IFCO010_BGT_SOBindingStub)afs.getHTTP_Port();
		            IFCO010_BGT_S_DT_response res = new IFCO010_BGT_S_DT_response();
		        	
		        	// USER ID/PW 셋팅
		           	String sapId= PropertiesUtil.getProperty("sap.id");
		           	String sapPw= PropertiesUtil.getProperty("sap.pw");
		           	af.setUsername(sapId);
		           	af.setPassword(sapPw);
		           	
		           	res = af.IFCO010_BGT_SO(dt);
		           	
		           	ifFlag = StringUtil.isNullToString(res.getIF_FLAG());
		           	ifMgs  = StringUtil.isNullToString(res.getIF_MSG());
		           	
		           	int bugtResultLen = 0;
	           		if (null != res.getITEM()) {
	           			bugtResultLen = res.getITEM().length;
	           		}
	           		
	           		IFCO010_BGT_S_DT_responseITEM[] bugtResultRow = new IFCO010_BGT_S_DT_responseITEM[bugtResultLen];
		           	List<Map<String, Object>> bugtResultList      = new ArrayList<Map<String, Object>>();
		           	
	           		if (bugtResultLen > 0) {
	           			bugtResultRow = res.getITEM();
	           			
			           	for (IFCO010_BGT_S_DT_responseITEM bugtResult : bugtResultRow) {
			           		Map<String, Object> bugtResultMap = new HashMap<String,Object>();
			                for (Field field : bugtResult.getClass().getDeclaredFields()) {
			                    field.setAccessible(true);
			                    System.out.println("org[" + field.getName() + "-" + field.get(bugtResult) + "]");
			                    // 금액 음수 체크
			                    if ("WKGXXX".equals(field.getName())) {
			                    	String WKGXXX = StringUtil.isNullToString(field.get(bugtResult));
			                    	if (WKGXXX.indexOf("-") > -1) {
			                    		bugtResultMap.put(field.getName(), "-" + field.get(bugtResult).toString().replace("-", ""));
			                    		System.out.println("CASE 3[" + field.getName() + "-" + field.get(bugtResult) + "]");
			                    	} else {
			                    		bugtResultMap.put(field.getName(), field.get(bugtResult));
			                    		System.out.println("CASE 2[" + field.getName() + "-" + field.get(bugtResult) + "]");
			                    	}
			                    } else {
				                    bugtResultMap.put(field.getName(), field.get(bugtResult));
				                    System.out.println("CASE 1[" + field.getName() + "-" + field.get(bugtResult) + "]");
			                    }
			                }           		
			                bugtResultList.add(bugtResultMap);
			           	}
			           	
						// 전송된 부서비용 발생실적 송신 정보를 테이블에 반영 
			           	batBugtResultInterfaceService.makeBugtResultData(paramMap, bugtResultList);
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