package com.app.ildong.bat.service;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.bat.dao.BatLogDAO;

@Service("BatLogService")
public class BatLogService {
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BatLogDAO batLogDAO;
	
	public Map<String,Object> insertBatchLogOnStart(String compCd, String batchId, String runIp, String batchStartTime) {
		Map<String,Object> paramMap	= new HashMap<>();
		
		paramMap.put("COMP_CD"			, compCd);
		paramMap.put("BATCH_ID"			, batchId);
		paramMap.put("RUN_IP"			, runIp);
		paramMap.put("BATCH_START_TIME"	, batchStartTime);
		
		this.insertBatchLogOnStart(paramMap);
		
		return paramMap;
		
	}
	
	public Map<String,Object> insertBatchLogOnStart(Map<String,Object> paramMap) {
		batLogDAO.insertBatchLogOnStart(paramMap);
		
		return paramMap;
	}
	
	
	
	public Map<String,Object> updateBatchLogOnEnd(String compCd, String batchSeq, String batchEndTime, String batchSuccYn, String batchErrMsg, Map<String,Object> batchResult) {
		Map<String,Object> paramMap	= new HashMap<>();
		
		paramMap.put("COMP_CD"			, compCd);
		paramMap.put("BATCH_SEQ"		, batchSeq);
		paramMap.put("BATCH_END_TIME"	, batchEndTime);
		paramMap.put("BATCH_SUCC_YN"	, batchSuccYn);
		paramMap.put("BATCH_ERR_MSG"	, batchErrMsg);
		
		if (null!=batchResult) {
			paramMap.put("SUCC_CNT"		, batchResult.get("SUCC_CNT"));
			paramMap.put("FAIL_CNT"		, batchResult.get("FAIL_CNT"));
			paramMap.put("TOTAL_CNT"	, batchResult.get("TOTAL_CNT"));
			paramMap.put("PROC_ID"		, batchResult.get("PROC_ID"));
		} else {
			paramMap.put("SUCC_CNT"		, "0");
			paramMap.put("FAIL_CNT"		, "0");
			paramMap.put("TOTAL_CNT"	, "0");
			paramMap.put("PROC_ID"		, "");
		}
		
		return this.updateBatchLogOnEnd(paramMap);
		
	}
	
	public Map<String,Object> updateBatchLogOnEnd(String compCd, String batchSeq, String batchEndTime, Map<String,Object> batchResult) {
		return this.updateBatchLogOnEnd(compCd, batchSeq, batchEndTime, "S", "", batchResult);
	}
	
	public Map<String,Object> updateBatchLogOnEnd(String compCd, String batchSeq, String batchEndTime, String batchSuccYn, String batchErrMsg) {
		return this.updateBatchLogOnEnd(compCd, batchSeq, batchEndTime, batchSuccYn, batchErrMsg, null);
		
	}
	
	public Map<String,Object> updateBatchLogOnEnd(String compCd, String batchSeq, String batchEndTime) {
		return this.updateBatchLogOnEnd(compCd, batchSeq, batchEndTime, "S", "", null);
		
	}
	
	
	
	public Map<String,Object> updateBatchLogOnEnd(Map<String,Object> paramMap) {
		batLogDAO.updateBatchLogOnEnd(paramMap);
		return paramMap;
	}
	
	
}
