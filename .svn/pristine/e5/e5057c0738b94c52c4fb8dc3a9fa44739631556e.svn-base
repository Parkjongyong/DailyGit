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
import com.app.ildong.bat.service.BatSendInvestInterfaceService;
import com.app.ildong.common.model.mvc.BaseJobBean;
import com.app.ildong.common.service.CommonSelectService;
import com.app.ildong.common.util.PropertiesUtil;
import com.app.ildong.common.util.StringUtil;
import com.app.ildong.sys.service.SysCmmLogMgmtService;
import com.ildong.CO.BGT_ERP.IFCO003_BGT_SOBindingStub;
import com.ildong.CO.BGT_ERP.IFCO003_BGT_SOServiceLocator;
import com.ildong.CO.BGT_ERP.IFCO003_BGT_S_DTITEM;
import com.ildong.CO.BGT_ERP.IFCO003_BGT_S_DT_response;

@Controller
public class makeSendInvestDataController extends BaseJobBean {
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BatMasterService batMasterService;
	
	@Autowired
	private BatLogService batLogService;
	
	@Autowired
	private BatSendInvestInterfaceService batSendInvestInterfaceService;
	
    @Autowired
    private SysCmmLogMgmtService sysCmmLogMgmtService;	
	
	@Autowired
	private CommonSelectService commonSelectService;
	
	private String _BATCH_JOB_ID	= "MAKE_SEND_INVEST_DATA";
	
	@Override
	protected void executeInternal(JobExecutionContext arg0) throws JobExecutionException {
		try {
			String currTime = getTimeString(getCurrentTime());
			logger.debug("executeInternal 1 ( 5 second): currentTiem = " + currTime);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void makeSendInvestDataJobRun(LinkedHashMap<String, Object> serviceParams) throws Exception {
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
	            	paramInfo.put("ORG_CD", paramInfo.get("BATCH_ARG7").toString());
	            	System.out.println("부서::" + paramInfo.get("BATCH_ARG7").toString());
	            }	            
	            
	            List<Map<String,Object>> sendInvestList = batSendInvestInterfaceService.selectSendAssetList(paramInfo);
	            
	            if (sendInvestList.size() > 0) {
					// 1. SOAP 통신으로 공급업체  정보 추출 
					IFCO003_BGT_S_DTITEM[] sendInvestRow = new IFCO003_BGT_S_DTITEM[sendInvestList.size()];
					
					int rowCnt = 0;
		           	for (Map<String, Object> sendInvestMap : sendInvestList) {
		           		IFCO003_BGT_S_DTITEM sendInvest = new IFCO003_BGT_S_DTITEM();
		           		
		                sendInvest.setBUKRS(StringUtil.isNullToString(sendInvestMap.get("BUKRS")));
		                sendInvest.setZINVNR(StringUtil.isNullToString(sendInvestMap.get("ZINVNR")));
		                sendInvest.setGJAHR(StringUtil.isNullToString(sendInvestMap.get("GJAHR")));
		                sendInvest.setKTEXT(StringUtil.isNullToString(sendInvestMap.get("KTEXT")));
		                sendInvest.setKOSTV(StringUtil.isNullToString(sendInvestMap.get("KOSTV")));
		                sendInvest.setANLKL(StringUtil.isNullToString(sendInvestMap.get("ANLKL")));
		                sendInvest.setAKTIV(StringUtil.isNullToString(sendInvestMap.get("AKTIV")));
		                sendInvest.setWKG001(StringUtil.isNullToString(sendInvestMap.get("WKG001")));
		                sendInvest.setWKG002(StringUtil.isNullToString(sendInvestMap.get("WKG002")));
		                sendInvest.setWKG003(StringUtil.isNullToString(sendInvestMap.get("WKG003")));
		                sendInvest.setWKG004(StringUtil.isNullToString(sendInvestMap.get("WKG004")));
		                sendInvest.setWKG005(StringUtil.isNullToString(sendInvestMap.get("WKG005")));
		                sendInvest.setWKG006(StringUtil.isNullToString(sendInvestMap.get("WKG006")));
		                sendInvest.setWKG007(StringUtil.isNullToString(sendInvestMap.get("WKG007")));
		                sendInvest.setWKG008(StringUtil.isNullToString(sendInvestMap.get("WKG008")));
		                sendInvest.setWKG009(StringUtil.isNullToString(sendInvestMap.get("WKG009")));
		                sendInvest.setWKG010(StringUtil.isNullToString(sendInvestMap.get("WKG0010")));
		                sendInvest.setWKG011(StringUtil.isNullToString(sendInvestMap.get("WKG0011")));
		                sendInvest.setWKG012(StringUtil.isNullToString(sendInvestMap.get("WKG0012")));
		                
		                sendInvestRow[rowCnt] = sendInvest;
		                rowCnt++;
		           	}
		           	
					// 1. SOAP 통신으로 공급업체  정보 추출 
		            IFCO003_BGT_SOServiceLocator sl = new IFCO003_BGT_SOServiceLocator();
		            IFCO003_BGT_SOBindingStub bs    = (IFCO003_BGT_SOBindingStub)sl.getHTTP_Port();
		            IFCO003_BGT_S_DT_response res   = new IFCO003_BGT_S_DT_response();
		        	
		        	// USER ID/PW 셋팅
		           	String sapId= PropertiesUtil.getProperty("sap.id");
		           	String sapPw= PropertiesUtil.getProperty("sap.pw");
		           	bs.setUsername(sapId);
		           	bs.setPassword(sapPw);
		        	
		        	res = bs.IFCO003_BGT_SO(sendInvestRow);
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
