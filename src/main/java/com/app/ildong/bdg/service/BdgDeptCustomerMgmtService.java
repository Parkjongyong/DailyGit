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

import com.app.ildong.bdg.dao.BdgDeptCustomerMgmtDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;

@Service("bdgDeptCustomerMgmtService")
public class BdgDeptCustomerMgmtService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BdgDeptCustomerMgmtDAO bdgDeptCustomerMgmtDAO;
	
	@Autowired
	private DataSourceTransactionManager transactionManager;	
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectDeptCustomerMgmtList(Map<String, Object> paramMap){
		return bdgDeptCustomerMgmtDAO.selectDeptCustomerMgmtList(paramMap);
	}
	
	public Map<String, Object> selectDeptCustomerData(Map<String, Object> paramMap){
		return bdgDeptCustomerMgmtDAO.selectDeptCustomerData(paramMap);
	}	
	
    public Map<String,Object> saveDeptCustomerMgmt(Map<String,Object> paramMap) throws ServiceException, Exception {
        
    	Map<String, Object> saveMap          = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> saveList   = (List<Map<String, Object>>) saveMap.get("CHECK_LIST");
    	
		DefaultTransactionDefinition def =  new DefaultTransactionDefinition();
		def.setName("saveDeptCustomer-Transaction");
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRES_NEW);
		TransactionStatus status = transactionManager.getTransaction(def);
		
		try {
	        // 저장로직
	        if (null != saveList && 0 < saveList.size()) {
	            for (Map<String, Object> data: saveList) {
	                
	                data.put("CRE_USER"   , getUserId());
	                data.put("MOD_USER"   , getUserId());
	            	// 신규
	            	if ("I".equals(data.get("CRUD").toString())) {
	            		Map<String, Object> retrunParam = bdgDeptCustomerMgmtDAO.selectCountData(data);
	            		
	                	if ("N".equals(retrunParam.get("CNT").toString())) {
	                		// 강제로 Exception 발생
	                		paramMap.put("SUCC_YN", "N");
	                		paramMap.put("ERR_MSG", "기등록된 데이터가 존재합니다. 확인 후 작업하세요.");                		
	                		throw new Exception("기등록된 데이터가 존재합니다. 확인 후 작업하세요.");                		
	                	} else {
	                		 bdgDeptCustomerMgmtDAO.insertDeptCustomerMgmt(data);
	                	}
	            	// 기등록
	            	} else {
	            		bdgDeptCustomerMgmtDAO.updateDeptCustomerMgmt(data);
	            	}
	            }
	            transactionManager.commit(status);
	            paramMap.put("SUCC_YN", "Y");
	        }
		} catch (Exception e1) {
			paramMap.put("SUCC_YN", "N");
			transactionManager.rollback(status);
		}

        
    	return paramMap;
    }
    
    public Map<String,Object> deleteDeptCustomerMgmt(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	Map<String, Object> deleteMap   = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> deleteList   = (List<Map<String, Object>>) deleteMap.get("DELETED");
        
        // 삭제로직
        if (null != deleteList && 0 < deleteList.size()) {
            for (Map<String, Object> data: deleteList) {
            	
                bdgDeptCustomerMgmtDAO.deleteDeptCustomerMgmt(data);
            }
        }
        
    	return paramMap;
    } 
    
}