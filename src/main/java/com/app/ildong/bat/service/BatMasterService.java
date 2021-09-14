package com.app.ildong.bat.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.bat.dao.BatMasterDAO;
import com.app.ildong.common.model.mvc.BaseService;

@Service("BatMasterService")
public class BatMasterService extends BaseService {
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BatMasterDAO batMasterDAO;
	
	public Map<String,Object> selectIsBatchWorking(Map<String, Object> paramMap) {
		try {
			
			Map<String,Object> batchInfo = batMasterDAO.selectBatchMaster(paramMap);
		
			if (null==batchInfo) {
				paramMap.put("BATCH_YN", "N");
			} else {
				paramMap.put("BATCH_ARG1" , batchInfo.get("BATCH_ARG1" ));
				paramMap.put("BATCH_ARG2" , batchInfo.get("BATCH_ARG2" ));
				paramMap.put("BATCH_ARG3" , batchInfo.get("BATCH_ARG3" ));
				paramMap.put("BATCH_ARG4" , batchInfo.get("BATCH_ARG4" ));
				paramMap.put("BATCH_ARG5" , batchInfo.get("BATCH_ARG5" ));
				paramMap.put("BATCH_ARG6" , batchInfo.get("BATCH_ARG6" ));
				paramMap.put("BATCH_ARG7" , batchInfo.get("BATCH_ARG7" ));
				paramMap.put("BATCH_ARG8" , batchInfo.get("BATCH_ARG8" ));
				paramMap.put("BATCH_ARG9" , batchInfo.get("BATCH_ARG9" ));
				paramMap.put("BATCH_ARG10", batchInfo.get("BATCH_ARG10"));
			}
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return paramMap;
	}
	
	public Map<String,Object> selectIsBatchWorking(String compCd, String batchId, String runIp) {
		Map<String,Object> paramMap = new HashMap<>();
		
		paramMap.put("COMP_CD"	, compCd);
		paramMap.put("BATCH_ID"	, batchId);
		paramMap.put("RUN_IP"	, runIp);
		paramMap.put("BATCH_YN"	, "Y");
		
		return this.selectIsBatchWorking(paramMap);
	}
	
	public List<Map<String, Object>> selectCompCd() {
		Map<String,Object> paramMap = new HashMap<>();
		paramMap.put("CODE_GRP"	, "SYS001");
		List<Map<String, Object>> compInfo = batMasterDAO.selectCompCd(paramMap);
		return compInfo;
	}
	

}
