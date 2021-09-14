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

import com.app.ildong.bdg.dao.BdgSupRegDAO;
import com.app.ildong.common.dao.CommonSelectDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;

@Service("BdgSupRegService")
public class BdgSupRegService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BdgSupRegDAO supReg;
	
	@Autowired
	private CommonSelectDAO commonSelectDAO;
	
	@Autowired
	private DataSourceTransactionManager transactionManager;	
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectSupReg(Map<String, Object> paramMap){
		return supReg.selectSupReg(paramMap);
		
	}
	
	public Map<String, Object> selectSendSapSupReg(Map<String, Object> paramMap) {
        return supReg.selectSendSapSupReg(paramMap);
    }
	
	public Map<String, Object> selectCheckSupReg(Map<String, Object> paramMap) {
        return supReg.selectCheckSupReg(paramMap);
    }	
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectSupRegM(Map<String, Object> paramMap){
		return supReg.selectSupReg(paramMap);
	}
	
    public Map<String,Object> saveSupReg(Map<String,Object> paramMap) throws ServiceException, Exception {
    	paramMap.put("CRE_USER"   , getUserId());
    	paramMap.put("MOD_USER"   , getUserId());
    	if(((Map<String, Object>) paramMap.get("ITEM_LIST")).isEmpty()) {
    		supReg.insertSupReg(paramMap);
    	} else {
    		Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
            List<Map<String, Object>> updList = (List<Map<String, Object>>)dataMap.get("CHECK_LIST");
            paramMap.put("COMP_CD", updList.get(0).get("COMP_CD"));
            paramMap.put("ORG_CD", updList.get(0).get("ORG_CD"));
            paramMap.put("CRTN_YMD", updList.get(0).get("CRTN_YMD"));
            paramMap.put("POBUSI_NO", updList.get(0).get("POBUSI_NO"));
       		supReg.updateSupReg(paramMap);
    	}
    	
    	return paramMap;
    }
    
    public Map<String,Object> updateStatusSupReg(Map<String,Object> paramMap) throws ServiceException, Exception {
    	paramMap.put("CRE_USER"   , getUserId());
    	paramMap.put("MOD_USER"   , getUserId());
    	
    	supReg.updateStatusSupReg(paramMap);
    	
    	return paramMap;
    }    
        
	public List<Map<String, Object>> selectOpAccountList(Map<String, Object> paramMap){
		return supReg.selectOpAccountList(paramMap);
	}
	
	public List<Map<String, Object>> selectOpDeptList(Map<String, Object> paramMap){
		return supReg.selectOpDeptList(paramMap);
	}
	
	
    public Map<String,Object> applySupReg(Map<String,Object> paramMap) throws ServiceException, Exception {
    	

    	Map<String, Object> dataMap       = (Map<String, Object>) paramMap.get("ITEM_LIST");
        List<Map<String, Object>> updList = (List<Map<String, Object>>)dataMap.get("CHECK_LIST");
        
        if (null != updList && 0 < updList.size()) {
            for (Map<String, Object> updData: updList) {
            	updData.put("MOD_USER"   , getUserId());
            	supReg.applySupReg(updData);
            }
        }
    	
    	return paramMap;
    }
    
    public Map<String,Object> applyCancelSupReg(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	
    	Map<String, Object> dataMap       = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> updList = (List<Map<String, Object>>)dataMap.get("CHECK_LIST");
    	
    	if (null != updList && 0 < updList.size()) {
    		for (Map<String, Object> updData: updList) {
    			updData.put("MOD_USER"   , getUserId());
    			supReg.applyCancelSupReg(updData);
    		}
    	}
    	
    	return paramMap;
    }
    
    public Map<String,Object> returnSupReg(Map<String,Object> paramMap) throws ServiceException, Exception {
        Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
        List<Map<String, Object>> updList = (List<Map<String, Object>>)dataMap.get("CHECK_LIST");
        
        if (null != updList && 0 < updList.size()) {
            for (Map<String, Object> updData: updList) {
            	updData.put("MOD_USER"   , getUserId());
            	supReg.returnSupReg(updData);
            }
        }
    	
    	return paramMap;
    }

    public Map<String,Object> delSupReg(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	Map<String, Object> dataMap       = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> delList = (List<Map<String, Object>>)dataMap.get("DELETED");
    	if (null != delList && 0 < delList.size()) {
    		for (Map<String, Object> data: delList) {
    			supReg.delSupReg(data);
    		}
    	}
        
    	
    	return paramMap;
    }

}