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
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseJobBean;
import com.app.ildong.common.service.CommonSelectService;
import com.app.ildong.common.util.PropertiesUtil;
import com.ildong.FI.BGT_ERP.IFFI017_BGT_SOBindingStub;
import com.ildong.FI.BGT_ERP.IFFI017_BGT_SOServiceLocator;
import com.ildong.FI.BGT_ERP.IFFI017_BGT_S_DT;
import com.ildong.FI.BGT_ERP.IFFI017_BGT_S_DTIN_DETAIL;
import com.ildong.FI.BGT_ERP.IFFI017_BGT_S_DTIN_HEAD;
import com.ildong.FI.BGT_ERP.IFFI017_BGT_S_DT_responseRETURN;
import com.ildong.MM.BGT_ERP.IFMM037_BGT_S_DT_responseET_ITEM;

@Controller
public class makePostingDataController extends BaseJobBean {
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BatMasterService batMasterService;
	
	@Autowired
	private BatLogService batLogService;
	
	@Autowired
	private CommonSelectService commonSelectService;
	
	private String _BATCH_JOB_ID	= "MAKE_POSTING_DATA";
	
	@Override
	protected void executeInternal(JobExecutionContext arg0) throws JobExecutionException {
		try {
			String currTime = getTimeString(getCurrentTime());
			logger.debug("executeInternal 1 ( 5 second): currentTiem = " + currTime);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void makePostingDataJobRun(LinkedHashMap<String, Object> serviceParams) throws Exception {
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
				
				// 1. SOAP 통신으로 공급업체  정보 추출 
				IFFI017_BGT_S_DTIN_HEAD[] inheadRow   = new IFFI017_BGT_S_DTIN_HEAD[1];
				IFFI017_BGT_S_DTIN_HEAD inhead = new IFFI017_BGT_S_DTIN_HEAD();
				IFFI017_BGT_S_DTIN_DETAIL[] inDetailRow = new IFFI017_BGT_S_DTIN_DETAIL[2];
				IFFI017_BGT_S_DTIN_DETAIL inDetail = new IFFI017_BGT_S_DTIN_DETAIL();
	        	IFFI017_BGT_S_DT dt = new IFFI017_BGT_S_DT();	
	        	
	        	inhead.setBUKRS("1100");
	        	inhead.setGJAHR("2020");
	        	inhead.setLEGACYNO("BGM000101");
	        	inhead.setZACTYTYPE("P");
	        	inhead.setBLDAT("20200710");
	        	inhead.setBUDAT("20200710");
	        	inhead.setBLART("AB");
	        	inhead.setWAERS("KRW");
	        	inhead.setZEMPL_CO("SYSADMIN");
	        	inhead.setZEMPL_DES("시스템관리자");
	        	inhead.setZCCTR_CO("P2001000");
	        	inhead.setZCCTR_DES("시스템관리자");
	        	inhead.setXBLNR("HEAD_REF");
	        	inhead.setBKTXT("HEAD_TEXT");
	        	inheadRow[0] = inhead;
	            dt.setIN_HEAD(inheadRow);
	            
	            inDetail.setBUKRS("1100");
	            inDetail.setGJAHR("2020");
	            inDetail.setLEGACYNO("BGM000101");
	            inDetail.setBUZEI("1");
	            inDetail.setKOART("S");
	            inDetail.setSHKZG("H");
	            inDetail.setHKONT("0020020100");
	            inDetail.setLIFNR("0000300012");
	            inDetail.setWRBTR("11000");
	            inDetail.setDMBTR("");
	            inDetail.setBUPLA("1110");
	            inDetail.setMWSKZ("V1");
	            inDetail.setWMWST("1000");
	            inDetail.setKOSTL("");
	            inDetail.setSGTXT("TEST");
	            inDetailRow[0] = inDetail;
	            
	            inDetail = new IFFI017_BGT_S_DTIN_DETAIL();
	            
	            inDetail.setBUKRS("1100");
	            inDetail.setGJAHR("2020");
	            inDetail.setLEGACYNO("BGM000101");
	            inDetail.setBUZEI("2");
	            inDetail.setKOART("S");
	            inDetail.setSHKZG("S");
	            inDetail.setHKONT("0051006030");
	            inDetail.setLIFNR("");
	            inDetail.setWRBTR("10000");
	            inDetail.setDMBTR("");
	            inDetail.setBUPLA("1110");
	            inDetail.setMWSKZ("");
	            inDetail.setWMWST("");
	            inDetail.setKOSTL("0002020010");
	            inDetail.setSGTXT("TEST2");
	            inDetailRow[1] = inDetail;
	            dt.setIN_DETAIL(inDetailRow);
	            
	            IFFI017_BGT_SOServiceLocator sl = new IFFI017_BGT_SOServiceLocator();
	            IFFI017_BGT_SOBindingStub bs    = (IFFI017_BGT_SOBindingStub)sl.getHTTP_Port();
	        	
	        	// USER ID/PW 셋팅
	           	String sapId= PropertiesUtil.getProperty("sap.id");
	           	String sapPw= PropertiesUtil.getProperty("sap.pw");
	           	bs.setUsername(sapId);
	           	bs.setPassword(sapPw);
	           	
	        	IFFI017_BGT_S_DT_responseRETURN[] res = bs.IFFI017_BGT_SO(dt);
	        	for (int i=0; i < res.length; i++) {
	        		ifFlag = res[i].getIF_FLAG();
	        		ifMgs  = res[i].getIF_MSG();
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
				
				if (batchSucc)
					batLogService.updateBatchLogOnEnd(compCd, String.valueOf(batchInfo.get("BATCH_SEQ")), endTime, batchResult);
				else 
					batLogService.updateBatchLogOnEnd(compCd, String.valueOf(batchInfo.get("BATCH_SEQ")), endTime, "N", batchErrMsg, batchResult);
			} catch (Exception e) {
				e.printStackTrace();
				if (logger.isDebugEnabled()) {
					logger.debug("배치 종료정보 기록 실패");
				}
			}
		}
	}
}
