package com.app.ildong.bdg.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.app.ildong.bdg.dao.BdgFamilyEventDAO;
import com.app.ildong.common.dao.CommonSelectDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;

@Service("BdgFamilyEventService")
public class BdgFamilyEventService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BdgFamilyEventDAO familyEvent;
	
	@Autowired
	private CommonSelectDAO commonSelectDAO;
	
	@Autowired
	private DataSourceTransactionManager transactionManager;	
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectFamilyEvent(Map<String, Object> paramMap){
		return familyEvent.selectFamilyEvent(paramMap);
		
	}
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectFamilyEventM(Map<String, Object> paramMap){
		return familyEvent.selectFamilyEvent(paramMap);
	}
	
	public List<Map<String, Object>> selectOpAccountList(Map<String, Object> paramMap){
		return familyEvent.selectOpAccountList(paramMap);
	}
	
	public List<Map<String, Object>> selectOpDeptList(Map<String, Object> paramMap){
		return familyEvent.selectOpDeptList(paramMap);
	}
	
	
    public Map<String,Object> applyFamilyEvent(Map<String,Object> paramMap) throws ServiceException, Exception {
    	

    	Map<String, Object> dataMap       = (Map<String, Object>) paramMap.get("ITEM_LIST");
        List<Map<String, Object>> updList = (List<Map<String, Object>>)dataMap.get("CHECK_LIST");
        
        if (null != updList && 0 < updList.size()) {
            for (Map<String, Object> updData: updList) {
            	updData.put("MOD_USER"   , getUserId());
            	familyEvent.applyFamilyEvent(updData);
            }
        }
    	
    	return paramMap;
    }
    
    public Map<String,Object> confirmFamilyEvent(Map<String,Object> paramMap) throws ServiceException, Exception {
        Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
        List<Map<String, Object>> updList = (List<Map<String, Object>>)dataMap.get("CHECK_LIST");
        
        if (null != updList && 0 < updList.size()) {
            for (Map<String, Object> updData: updList) {
            	updData.put("MOD_USER"   , getUserId());
            	familyEvent.confirmFamilyEvent(updData);
            }
        }
    	
    	return paramMap;
    }

    public Map<String,Object> saveFamilyEvent(Map<String,Object> paramMap) throws ServiceException, Exception {
        
        Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
        List<Map<String, Object>> updList = (List<Map<String, Object>>)dataMap.get("UPDATED");
        List<Map<String, Object>> insList = (List<Map<String, Object>>)dataMap.get("CREATED");
        
		DefaultTransactionDefinition def =  new DefaultTransactionDefinition();
		def.setName("saveFamilyEvent-Transaction");
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRES_NEW);
		TransactionStatus status = transactionManager.getTransaction(def);
		try {
	        if (null != updList && 0 < updList.size()) {
	            for (Map<String, Object> updData: updList) {
	            	Map<String, Object> checkParam = familyEvent.selectCheckData(updData);
	            	if (!"0".equals(checkParam.get("CNT").toString())) {
	            		// 강제로 Exception 발생
	            		paramMap.put("SUCC_YN", "N");
	        			paramMap.put("ERR_MSG", "기등록된 경조내용이 존재합니다. 확인 후 작업하세요.");
	        			throw new Exception("기등록된 경조내용이 존재합니다. 확인 후 작업하세요.");                		
	            		
	            	} else {
	                	updData.put("MOD_USER"   , getUserId());
	                	familyEvent.updateFamilyEvent(updData);
	            	}
	            }
	        }        
	        
	        if (null != insList && 0 < insList.size()) {
	            for (Map<String, Object> insData: insList) {
	            	Map<String, Object> checkParam = familyEvent.selectCheckData(insData);
	            	if (!"0".equals(checkParam.get("CNT").toString())) {
	            		// 강제로 Exception 발생
	            		paramMap.put("SUCC_YN", "N");
	        			paramMap.put("ERR_MSG", "기등록된 경조내용이 존재합니다. 확인 후 작업하세요.");
	        			throw new Exception("기등록된 경조내용이 존재합니다. 확인 후 작업하세요.");                		
	            		
	            	} else {
	                	insData.put("CRE_USER"   , getUserId());
	                	insData.put("MOD_USER"   , getUserId());
	                	familyEvent.insertFamilyEvent(insData);
	            	}            	
	            }
	        }
	        
	        transactionManager.commit(status);
	        paramMap.put("SUCC_YN", "Y");
		} catch (Exception e1) {
			transactionManager.rollback(status);
		}
		       
    	return paramMap;
    }
        
    public Map<String,Object> delFamilyEvent(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	Map<String, Object> dataMap       = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> delList = (List<Map<String, Object>>)dataMap.get("DELETED");
    	if (null != delList && 0 < delList.size()) {
    		for (Map<String, Object> data: delList) {
    			familyEvent.delFamilyEvent(data);
    		}
    	}
        
    	
    	return paramMap;
    }

}