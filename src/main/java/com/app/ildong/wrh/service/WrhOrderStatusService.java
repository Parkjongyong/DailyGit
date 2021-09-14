package com.app.ildong.wrh.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.wrh.dao.WrhOrderStatusDAO;

@Service("wrhOrderStatusService")
public class WrhOrderStatusService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private WrhOrderStatusDAO orderStatusDAO;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectOrderStatusList(Map<String, Object> paramMap){
		return orderStatusDAO.selectOrderStatusList(paramMap);
	}
    
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectOrderStatusDetail(Map<String, Object> paramMap){
		return orderStatusDAO.selectOrderStatusDetail(paramMap);
	}
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectOrderStatusDetailOne(Map<String, Object> paramMap){
		return orderStatusDAO.selectOrderStatusDetailOne(paramMap);
	}
	
    public Map<String,Object> wrhOrderStatusDetailConfirm(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
        Map<String, Object> dataMap       = (Map<String, Object>) paramMap.get("ITEM_LIST");
        List<Map<String, Object>> delList = (List<Map<String, Object>>)dataMap.get("ALLDATA");
        
    	// HEADER 및 ITEM 저장
        if (null != delList && 0 < delList.size()) {
        	try {
                for (Map<String, Object> data: delList) {
                	data.put("MOD_USER", getUserId());
                	orderStatusDAO.wrhOrderStatusHeaderConfirm(data);
                	orderStatusDAO.wrhOrderStatusItemConfirm(data);
                }
        	} catch (Exception e) {
        		paramMap.put("SUCC_YN", "N");
    		}

        }          	
        
        paramMap.put("SUCC_YN", "Y");
    	return paramMap;
    }
    
    public int wrhOrderStatusDetailConfirmCancel(Map<String,Object> paramMap) throws ServiceException, Exception {
    	return orderStatusDAO.wrhOrderStatusDetailConfirmCancel(paramMap);
    }    
    
    
	
}