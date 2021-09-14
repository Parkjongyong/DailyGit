package com.app.ildong.bat.controller;

import java.rmi.RemoteException;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.app.ildong.bat.service.BatLogService;
import com.app.ildong.bat.service.BatMasterService;
import com.app.ildong.common.model.mvc.BaseJobBean;
import com.app.ildong.common.service.CommonSelectService;
import com.app.ildong.common.util.PropertiesUtil;
import com.app.ildong.common.util.StringUtil;
import com.ildong.FI.BGT_ERP.IFFI057_BGT_SOBindingStub;
import com.ildong.FI.BGT_ERP.IFFI057_BGT_SOServiceLocator;
import com.ildong.FI.BGT_ERP.IFFI057_BGT_S_DTIT_VEND;
import com.ildong.FI.BGT_ERP.IFFI057_BGT_S_DT_responseRETURN;

@Controller
public class makePurchOrderMasterDataController extends BaseJobBean {
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BatMasterService batMasterService;
	
	@Autowired
	private BatLogService batLogService;
	
	@Autowired
	private CommonSelectService commonSelectService;
	
	private String _BATCH_JOB_ID	= "MAKE_PURCH_ORDER_MASTER_DATA";
	
	@Override
	protected void executeInternal(JobExecutionContext arg0) throws JobExecutionException {
		try {
			String currTime = getTimeString(getCurrentTime());
			logger.debug("executeInternal 1 ( 5 second): currentTiem = " + currTime);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void makePurchOrderMasterDataJobRun(LinkedHashMap<String, Object> serviceParams) throws Exception {
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
			String lifnr  = "";
			try {
				
				// 1. SOAP 통신으로 공급업체  정보 추출 
				IFFI057_BGT_S_DTIT_VEND[] dataRow   = new IFFI057_BGT_S_DTIT_VEND[1];
				IFFI057_BGT_S_DTIT_VEND data = new IFFI057_BGT_S_DTIT_VEND();
	        	
				data.setLIFNR("");
				data.setRLTYP("");
				data.setTYPE("");
				data.setBUKRS("");
				data.setEKORG("");
				data.setKTOKK("");
				data.setNAME1("");
				data.setNAME2("");
				data.setSORTL("");
				data.setPSTLZ("");
				data.setSTRAS("");
				data.setORT01("");
				data.setLAND1("");
				data.setREGIO("");
				data.setSPRAS("");
				data.setTELF1("");
				data.setTELFX("");
				data.setSMTP_ADDR("");
				data.setBPKIND("");
				data.setVBUND("");
				data.setDATAB("");
				data.setTAXTYPE("");
				data.setSTCD1("");
				data.setSTCD2("");
				data.setREPRESN("");
				data.setGESTYPN("");
				data.setINDTYPN("");
				data.setAKONT("");
				data.setZUAWA("");
				data.setZTERM("");
				data.setREPRF("");
				data.setZWELS("");
				data.setEIKTO("");
				data.setZSABE("");
				data.setTLFNS("");
				data.setTLFXS("");
				data.setINTAD("");
				data.setWAERS("");
				
				dataRow[0] = data;
	            
	            IFFI057_BGT_SOServiceLocator sl = new IFFI057_BGT_SOServiceLocator();
	            IFFI057_BGT_SOBindingStub bs    = (IFFI057_BGT_SOBindingStub)sl.getHTTP_Port();
	        	
	        	// USER ID/PW 셋팅
	           	String sapId= PropertiesUtil.getProperty("sap.id");
	           	String sapPw= PropertiesUtil.getProperty("sap.pw");
	           	bs.setUsername(sapId);
	           	bs.setPassword(sapPw); 
	        	IFFI057_BGT_S_DT_responseRETURN[] res = bs.IFFI057_BGT_SO(dataRow);
	        	
	        	// 리턴 개수별로 확인
	        	for (int i=0; i < res.length; i++) {
	        		lifnr  = StringUtil.isNullToString(res[i].getLIFNR());
	        		ifFlag = StringUtil.isNullToString(res[i].getIF_FLAG());
	        		ifMgs  = StringUtil.isNullToString(res[i].getIF_MSG());
	        		System.out.println("-------------------------------------");
	        		System.out.println("R LIFNR::" + lifnr);
	        		System.out.println("R IF_FLAG::" + ifFlag);
	        		System.out.println("R IF_MSG::" + ifMgs);
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
