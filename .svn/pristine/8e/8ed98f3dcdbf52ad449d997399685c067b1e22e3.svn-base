package com.app.ildong.bat.controller;

import java.rmi.RemoteException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
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
import com.app.ildong.bat.service.BatSendBugtInterfaceService;
import com.app.ildong.common.model.mvc.BaseJobBean;
import com.app.ildong.common.service.CommonSelectService;
import com.app.ildong.common.util.PropertiesUtil;
import com.app.ildong.common.util.StringUtil;
import com.app.ildong.sys.service.SysCmmLogMgmtService;
import com.ildong.CO.BGT_ERP.IFCO008_BGT_SOBindingStub;
import com.ildong.CO.BGT_ERP.IFCO008_BGT_SOServiceLocator;
import com.ildong.CO.BGT_ERP.IFCO008_BGT_S_DTITEM;
import com.ildong.CO.BGT_ERP.IFCO008_BGT_S_DT_response;
import com.ildong.CO.BGT_ERP.IFCO014_BGT_SOBindingStub;
import com.ildong.CO.BGT_ERP.IFCO014_BGT_SOServiceLocator;
import com.ildong.CO.BGT_ERP.IFCO014_BGT_S_DTITEM;
import com.ildong.CO.BGT_ERP.IFCO014_BGT_S_DT_response;

@Controller
public class makeSendBugtDataController extends BaseJobBean {
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BatMasterService batMasterService;
	
	@Autowired
	private BatLogService batLogService;
	
	@Autowired
	private BatSendBugtInterfaceService batSendBugtInterfaceService;
	
    @Autowired
    private SysCmmLogMgmtService sysCmmLogMgmtService;	
	
	@Autowired
	private CommonSelectService commonSelectService;
	
	private String _BATCH_JOB_ID	= "MAKE_SEND_BUGT_DATA";
	
	@Override
	protected void executeInternal(JobExecutionContext arg0) throws JobExecutionException {
		try {
			String currTime = getTimeString(getCurrentTime());
			logger.debug("executeInternal 1 ( 5 second): currentTiem = " + currTime);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void makeSendBugtDataJobRun(LinkedHashMap<String, Object> serviceParams) throws Exception {
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
				
	            Calendar cal = Calendar.getInstance();
	            cal.setTime(new Date());
	            DateFormat uDate = new SimpleDateFormat("yyyyMMdd");
				
	            if (!"".equals(StringUtil.isNullToString(paramInfo.get("BATCH_ARG5")))) {
	            	paramInfo.put("COMP_CD", paramInfo.get("BATCH_ARG5").toString());
	            	System.out.println("회사코드::" + paramInfo.get("BATCH_ARG5").toString());
	            } else {
	            	// 디폴트 처리
	            	System.out.println("회사코드(디폴트처리)::1100");
	            	paramInfo.put("COMP_CD", "1100");
	            }
	            
	            if (!"".equals(StringUtil.isNullToString(paramInfo.get("BATCH_ARG6")))) {
	            	paramInfo.put("CRTN_YY", paramInfo.get("BATCH_ARG6").toString());
	            	System.out.println("회계연도::" + paramInfo.get("BATCH_ARG6").toString());
	            } else {
	            	// 전송 대상이 존재하지 않도록 과거로 잡아놓음
	            	//paramInfo.put("CRTN_YY", uDate.format(cal.getTime()).substring(1, 4));
	            	paramInfo.put("CRTN_YY", "1900");
	            	//System.out.println("회계연도(디폴트처리)::" + uDate.format(cal.getTime()).substring(1, 4));
	            	System.out.println("회계연도(디폴트처리)::1900");
	            }
	            
	            if (!"".equals(StringUtil.isNullToString(paramInfo.get("BATCH_ARG7")))) {
	            	paramInfo.put("ZBUDCA", paramInfo.get("BATCH_ARG7").toString());
	            	System.out.println("예산종류::" + paramInfo.get("BATCH_ARG7").toString());
	            } else {
	            	// 전송 대상이 존재하지 않도록 과거로 잡아놓음
	            	//paramInfo.put("CRTN_YY", uDate.format(cal.getTime()).substring(1, 4));
	            	paramInfo.put("ZBUDCA", "A");
	            	//System.out.println("회계연도(디폴트처리)::" + uDate.format(cal.getTime()).substring(1, 4));
	            	System.out.println("예산종류(디폴트처리)::A");
	            }
	            
	            if (!"".equals(StringUtil.isNullToString(paramInfo.get("BATCH_ARG8")))) {
	            	paramInfo.put("ZSERIA", paramInfo.get("BATCH_ARG8").toString());
	            	System.out.println("차수::" + paramInfo.get("BATCH_ARG8").toString());
	            } else {
	            	paramInfo.put("ZSERIA", "01");
	            	System.out.println("차수(디폴트처리)::01");
	            }	            
	            
	            Map<String,Object> returnParam = batSendBugtInterfaceService.selectSendBugtList(paramInfo);
	            
	            if (!returnParam.isEmpty()) {
		            List<Map<String,Object>> sendIFCO008List = (List<Map<String, Object>>) returnParam.get("IFCO008");
		            List<Map<String,Object>> sendIFCO014List = (List<Map<String, Object>>) returnParam.get("IFCO014");
		            
		            if (sendIFCO008List.size() > 0) {
						// 1. SOAP 통신으로 승인셰산정보  정보 송신 
						IFCO008_BGT_S_DTITEM[] sendBugtRow = new IFCO008_BGT_S_DTITEM[sendIFCO008List.size()];
						
						int rowCnt = 0;
			           	for (Map<String, Object> sendBugtMap : sendIFCO008List) {
			           		IFCO008_BGT_S_DTITEM sendBugt = new IFCO008_BGT_S_DTITEM();
			           		
			                sendBugt.setBUKRS(StringUtil.isNullToString(sendBugtMap.get("BUKRS")));
			                sendBugt.setZBUDCA(StringUtil.isNullToString(sendBugtMap.get("ZBUDCA")));
			                sendBugt.setZSERIA(StringUtil.isNullToString(sendBugtMap.get("ZSERIA")));
			                sendBugt.setZOTYPE(StringUtil.isNullToString(sendBugtMap.get("ZOTYPE")));
			                sendBugt.setAKOSTL(StringUtil.isNullToString(sendBugtMap.get("AKOSTL")));
			                sendBugt.setBKOSTL(StringUtil.isNullToString(sendBugtMap.get("BKOSTL")));
			                sendBugt.setAUFNR(StringUtil.isNullToString(sendBugtMap.get("AUFNR")));
			                sendBugt.setKSTAR(StringUtil.isNullToString(sendBugtMap.get("KSTAR")));
			                sendBugt.setGJAHR(StringUtil.isNullToString(sendBugtMap.get("GJAHR")));
			                sendBugt.setZSALES(StringUtil.isNullToString(sendBugtMap.get("ZSALES")));
			                sendBugt.setZSATYP(StringUtil.isNullToString(sendBugtMap.get("ZSATYP")));
			                sendBugt.setWKG001(StringUtil.isNullToString(sendBugtMap.get("WKG001")));
			                sendBugt.setWKG002(StringUtil.isNullToString(sendBugtMap.get("WKG002")));
			                sendBugt.setWKG003(StringUtil.isNullToString(sendBugtMap.get("WKG003")));
			                sendBugt.setWKG004(StringUtil.isNullToString(sendBugtMap.get("WKG004")));
			                sendBugt.setWKG005(StringUtil.isNullToString(sendBugtMap.get("WKG005")));
			                sendBugt.setWKG006(StringUtil.isNullToString(sendBugtMap.get("WKG006")));
			                sendBugt.setWKG007(StringUtil.isNullToString(sendBugtMap.get("WKG007")));
			                sendBugt.setWKG008(StringUtil.isNullToString(sendBugtMap.get("WKG008")));
			                sendBugt.setWKG009(StringUtil.isNullToString(sendBugtMap.get("WKG009")));
			                sendBugt.setWKG010(StringUtil.isNullToString(sendBugtMap.get("WKG0010")));
			                sendBugt.setWKG011(StringUtil.isNullToString(sendBugtMap.get("WKG0011")));
			                sendBugt.setWKG012(StringUtil.isNullToString(sendBugtMap.get("WKG0012")));
			                
			                sendBugtRow[rowCnt] = sendBugt;
			                rowCnt++;
			           	}
			           	
						// 1. SOAP 통신으로 공급업체  정보 추출 
			            IFCO008_BGT_SOServiceLocator sl = new IFCO008_BGT_SOServiceLocator();
			            IFCO008_BGT_SOBindingStub bs    = (IFCO008_BGT_SOBindingStub)sl.getHTTP_Port();
			            IFCO008_BGT_S_DT_response res   = new IFCO008_BGT_S_DT_response();
			        	
			        	// USER ID/PW 셋팅
			           	String sapId= PropertiesUtil.getProperty("sap.id");
			           	String sapPw= PropertiesUtil.getProperty("sap.pw");
			           	bs.setUsername(sapId);
			           	bs.setPassword(sapPw); 
			        	
			        	res = bs.IFCO008_BGT_SO(sendBugtRow);
			           	ifFlag = StringUtil.isNullToString(res.getIF_FLAG());
			           	ifMgs  = StringUtil.isNullToString(res.getIF_MSG());
			           	
			           	// 성공유무 확인
			           	if ("S".equals(ifFlag)) {
							batchSucc = true;
							batchResult.put("ERR_MSG", "");	           		
			           	} else if ("E".equals(ifFlag)) {
			           		batchSucc = false;
			           		batchResult.put("ERR_MSG", ifMgs);
			           		batchErrMsg = ifMgs;
			           	}		           	
		            }
		            
		            if (sendIFCO014List.size() > 0) {
						// 2. SOAP 통신으로 유통품목별 상세  정보 전송 
						IFCO014_BGT_S_DTITEM[] sendBugtRow = new IFCO014_BGT_S_DTITEM[sendIFCO014List.size()];
						
						int rowCnt = 0;
			           	for (Map<String, Object> sendBugtMap : sendIFCO014List) {
			           		IFCO014_BGT_S_DTITEM sendBugt = new IFCO014_BGT_S_DTITEM();
			           		
			                sendBugt.setBUKRS(StringUtil.isNullToString(sendBugtMap.get("BUKRS")));
			                sendBugt.setZBUDCA(StringUtil.isNullToString(sendBugtMap.get("ZBUDCA")));
			                sendBugt.setZSERIA(StringUtil.isNullToString(sendBugtMap.get("ZSERIA")));
			                sendBugt.setKOSTL(StringUtil.isNullToString(sendBugtMap.get("KOSTL")));
			                sendBugt.setVTWEG(StringUtil.isNullToString(sendBugtMap.get("VTWEG")));
			                sendBugt.setZLEVEL(StringUtil.isNullToString(sendBugtMap.get("ZLEVEL")));
			                sendBugt.setZPRODH(StringUtil.isNullToString(sendBugtMap.get("ZPRODH")));
			                sendBugt.setKSTAR(StringUtil.isNullToString(sendBugtMap.get("KSTAR")));
			                sendBugt.setGJAHR(StringUtil.isNullToString(sendBugtMap.get("GJAHR")));
			                sendBugt.setZSATYP(StringUtil.isNullToString(sendBugtMap.get("ZSATYP")));
			                sendBugt.setWKG001(StringUtil.isNullToString(sendBugtMap.get("WKG001")));
			                sendBugt.setWKG002(StringUtil.isNullToString(sendBugtMap.get("WKG002")));
			                sendBugt.setWKG003(StringUtil.isNullToString(sendBugtMap.get("WKG003")));
			                sendBugt.setWKG004(StringUtil.isNullToString(sendBugtMap.get("WKG004")));
			                sendBugt.setWKG005(StringUtil.isNullToString(sendBugtMap.get("WKG005")));
			                sendBugt.setWKG006(StringUtil.isNullToString(sendBugtMap.get("WKG006")));
			                sendBugt.setWKG007(StringUtil.isNullToString(sendBugtMap.get("WKG007")));
			                sendBugt.setWKG008(StringUtil.isNullToString(sendBugtMap.get("WKG008")));
			                sendBugt.setWKG009(StringUtil.isNullToString(sendBugtMap.get("WKG009")));
			                sendBugt.setWKG010(StringUtil.isNullToString(sendBugtMap.get("WKG0010")));
			                sendBugt.setWKG011(StringUtil.isNullToString(sendBugtMap.get("WKG0011")));
			                sendBugt.setWKG012(StringUtil.isNullToString(sendBugtMap.get("WKG0012")));
			                
			                sendBugtRow[rowCnt] = sendBugt;
			                rowCnt++;
			           	}
			           	
						// 1. SOAP 통신으로 공급업체  정보 추출 
			            IFCO014_BGT_SOServiceLocator sl = new IFCO014_BGT_SOServiceLocator();
			            IFCO014_BGT_SOBindingStub bs    = (IFCO014_BGT_SOBindingStub)sl.getHTTP_Port();
			            IFCO014_BGT_S_DT_response res   = new IFCO014_BGT_S_DT_response();
			        	
			        	// USER ID/PW 셋팅
			           	String sapId= PropertiesUtil.getProperty("sap.id");
			           	String sapPw= PropertiesUtil.getProperty("sap.pw");
			           	bs.setUsername(sapId);
			           	bs.setPassword(sapPw);
			        	
			        	res = bs.IFCO014_BGT_SO(sendBugtRow);
			           	ifFlag = StringUtil.isNullToString(res.getIF_FLAG());
			           	ifMgs  = StringUtil.isNullToString(res.getIF_MSG());
			           	
			           	// 성공유무 확인
			           	if ("S".equals(ifFlag)) {
							batchSucc = true;
							batchResult.put("ERR_MSG", "");	           		
			           	} else if ("E".equals(ifFlag)) {
			           		batchSucc = false;
			           		batchResult.put("ERR_MSG", ifMgs);
			           		batchErrMsg = ifMgs;
			           	}		           	
		            }
	            }
	            
	           	
				batchSucc = true;
				batchResult.put("ERR_MSG", "");	           	
	           	
	       	} catch (RemoteException e) {
				batchSucc = false;
				batchErrMsg = e.toString();
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
