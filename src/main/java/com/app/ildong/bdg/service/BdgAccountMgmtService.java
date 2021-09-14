package com.app.ildong.bdg.service;

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

import com.app.ildong.bdg.dao.BdgAccountMgmtDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.common.util.StringUtil;

@Service("bdgAccountMgmtService")
public class BdgAccountMgmtService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BdgAccountMgmtDAO bdgAccountMgmtDAO;
	
	@Autowired
	private DataSourceTransactionManager transactionManager;	
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectAccountMgmtList(Map<String, Object> paramMap){
		return bdgAccountMgmtDAO.selectAccountMgmtList(paramMap);
	}
	
	public List<Map<String, Object>> selectProjList(Map<String, Object> paramMap){
		return bdgAccountMgmtDAO.selectProjList(paramMap);
	}	
	
	
	
    public Map<String,Object> saveAccountMgmt(Map<String,Object> paramMap) throws ServiceException, Exception {
        
    	Map<String, Object> saveMap          = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> saveList   = (List<Map<String, Object>>) saveMap.get("CHECK_LIST");
    	
		DefaultTransactionDefinition def =  new DefaultTransactionDefinition();
		def.setName("saveAccountMgmt-Transaction");
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRES_NEW);
		TransactionStatus status = transactionManager.getTransaction(def);
		
		int cnt = 1;
		
		try {
	        // 저장로직
	        if (null != saveList && 0 < saveList.size()) {
	            for (Map<String, Object> data: saveList) {
	                
	                data.put("CRE_USER"   , getUserId());
	                data.put("MOD_USER"   , getUserId());
	            	// 신규
	            	if ("I".equals(data.get("CRUD").toString())) {
	            		Map<String, Object> retrunParam = bdgAccountMgmtDAO.selectCountData(data);
	            		
	                	if ("N".equals(retrunParam.get("CNT").toString())) {
	                		// 강제로 Exception 발생
	                		paramMap.put("SUCC_YN", "N");
	                		paramMap.put("ERR_MSG", "기등록된 데이터가 존재합니다. 확인 후 작업하세요.");                		
	                		throw new Exception("기등록된 데이터가 존재합니다. 확인 후 작업하세요.");                		
	                	} else {
	                		 bdgAccountMgmtDAO.insertAccountMgmt(data);
	                	}
	            	// 기등록
	            	} else {
	            		bdgAccountMgmtDAO.updateAccountMgmt(data);
	            	}
	            	
	            	Map<String, Object> distribYnParam = bdgAccountMgmtDAO.selectDistribYn(data);
	                System.out.println(Integer.parseInt(distribYnParam.get("CNT").toString()) > cnt);
                	if (Integer.parseInt(distribYnParam.get("CNT").toString()) > cnt) {
                		// 강제로 Exception 발생
                		paramMap.put("SUCC_YN", "N");
                		paramMap.put("ERR_MSG", "유통판촉비 계정 Y인 데이터가 한건 존재합니다. 확인 후 작업하세요.");                		
                		throw new Exception("유통판촉비 계정 Y인 데이터가 한건 존재합니다. 확인 후 작업하세요.");
                	}
	            	
	            }
	            transactionManager.commit(status);
	            paramMap.put("SUCC_YN", "Y");
	        }
		} catch (Exception e1) {
			transactionManager.rollback(status);
		}

        
    	return paramMap;
    }
    
    public Map<String,Object> deleteAccontMgmt(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	Map<String, Object> deleteMap   = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> deleteList   = (List<Map<String, Object>>) deleteMap.get("DELETED");
        
        // 삭제로직
        if (null != deleteList && 0 < deleteList.size()) {
            for (Map<String, Object> data: deleteList) {
            	
                bdgAccountMgmtDAO.deleteAccountMgmt(data);
            }
        }
        
    	return paramMap;
    } 
    
}