package com.app.ildong.wrh.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.wrh.dao.WrhConfirmUserDAO;

@Service("WrhConfirmUserService")
public class WrhConfirmUserService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private WrhConfirmUserDAO confirmUserDAO;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectConfirmUserList(Map<String, Object> paramMap){
		return confirmUserDAO.selectConfirmUserList(paramMap);
	}
	
	
    public Map<String,Object> saveConfirmUser(Map<String,Object> paramMap) throws ServiceException, Exception {
        
        Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
//        List<Map<String, Object>> updList = (List<Map<String, Object>>)dataMap.get("UPDATED");
        List<Map<String, Object>> insList = (List<Map<String, Object>>)dataMap.get("CREATED");
        
        if (null != insList && 0 < insList.size()) {
            for (Map<String, Object> data: insList) {
                data.put("CRE_USER"   , getUserId());
                data.put("MOD_USER"   , getUserId());
                confirmUserDAO.insertConfirmUser(data);
            }
        }
        
    	return paramMap;
    }
    
    public Map<String,Object> deleteConfirmUser(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> delList = (List<Map<String, Object>>)dataMap.get("DELETED");
    	
    	if (null != delList && 0 < delList.size()) {
    		for (Map<String, Object> data: delList) {
                data.put("CRE_USER"   , getUserId());
                data.put("MOD_USER"   , getUserId());
                confirmUserDAO.deleteConfirmUser(data);
    		}
    	}
    	
    	return paramMap;
    }	
}