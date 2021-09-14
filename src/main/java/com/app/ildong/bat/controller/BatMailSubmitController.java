package com.app.ildong.bat.controller;


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
import com.app.ildong.common.service.MessageSendService;

@Controller
public class BatMailSubmitController extends BaseJobBean {
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BatMasterService batMasterService;
	
	@Autowired
	private BatLogService batLogService;
	
	@Autowired
	private CommonSelectService commonSelectService;
	
	@Autowired
	private MessageSendService mailService;
	
	private String _BATCH_JOB_ID	= "MAIL_SMS_SUBMIT";
	
	@Override
	protected void executeInternal(JobExecutionContext arg0) throws JobExecutionException {
		try {
			String currTime = getTimeString(getCurrentTime());
			logger.debug("executeInternal 1 ( 5 second): currentTiem = " + currTime);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void mailSubmitJobRun(LinkedHashMap<String, Object> serviceParams) throws Exception {
		String compCd		= "";
		String runIp		= "";
		
		boolean goBatchRun 	= true;
		boolean batchSucc	= true;
		String batchErrMsg	= "";
		
		Map<String,Object> batchInfo = new HashMap<>();
		
		try {
			compCd		= getCompCd();
			runIp		= getServerIp();
			
//			if (!batMasterService.selectIsBatchWorking(compCd, _BATCH_JOB_ID, runIp)) {
//				if (logger.isDebugEnabled()) {
//					logger.debug("NOT FIND FOR THIS BATCH : [BATCH_ID:" + _BATCH_JOB_ID +"][RUN_IP:"+ runIp + "]");
//				}
//				goBatchRun = false;
//			}
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
			 * 메일전송 일괄배치 처리
			 */
			
			Map<String,Object> batchResult = new HashMap<>();
			try {
				Map<String,Object> paramMap = new HashMap<>();
				//batchResult = mailService.sendMailBatch(paramMap);
				batchResult.put("RESULT", "S");
				batchResult.put("ERR_MSG", "");
				
				if (!"S".equals((String)batchResult.get("RESULT"))) {
					batchSucc = false;
					batchErrMsg = (String)batchResult.get("ERR_MSG");
				}
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
