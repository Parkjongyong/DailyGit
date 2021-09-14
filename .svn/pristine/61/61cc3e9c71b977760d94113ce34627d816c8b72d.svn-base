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

import com.app.ildong.bdg.dao.BdgUsersDeptMgtDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;

@Service("bdgUsersDeptMgtService")
public class BdgUsersDeptMgtService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BdgUsersDeptMgtDAO bdgUsersDeptMgtDAO;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectUsersMgtList(Map<String, Object> paramMap){
		return bdgUsersDeptMgtDAO.selectUsersMgtList(paramMap);
	}
	
	public List<Map<String, Object>> selectDeptMgtList(Map<String, Object> paramMap){
		return bdgUsersDeptMgtDAO.selectDeptMgtList(paramMap);
	}
	
    public Map<String,Object> insertUsersMgt(Map<String,Object> paramMap) throws ServiceException, Exception {
        
    	Map<String, Object> saveMap          = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> saveList   = (List<Map<String, Object>>) saveMap.get("CHECK_LIST");
    	
        // 저장로직
        if (null != saveList && 0 < saveList.size()) {
            for (Map<String, Object> data: saveList) {
        	
                data.put("CRE_USER"   , getUserId());
                data.put("MOD_USER"   , getUserId());
                
        		bdgUsersDeptMgtDAO.insertUsersMgt(data);
            }
        }
    
    	return paramMap;
    }
    
    public Map<String,Object> deleteUsersMgt(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	Map<String, Object> deleteMap   = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> deleteList   = (List<Map<String, Object>>) deleteMap.get("DELETED");
        
        // 삭제로직
        if (null != deleteList && 0 < deleteList.size()) {
            for (Map<String, Object> data: deleteList) {
            	
        		bdgUsersDeptMgtDAO.deleteUsersMgt(data);
            	
            }
        }
        
    	return paramMap;
    }
    
    public Map<String,Object> deleteDeptMgt(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	Map<String, Object> deleteMap   = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> deleteList   = (List<Map<String, Object>>) deleteMap.get("DELETED");
    	
    	// 삭제로직
    	if (null != deleteList && 0 < deleteList.size()) {
    		for (Map<String, Object> data: deleteList) {
    			
    			bdgUsersDeptMgtDAO.deleteDeptMgt(data);
    			
    		}
    	}
    	
    	return paramMap;
    } 
     
}