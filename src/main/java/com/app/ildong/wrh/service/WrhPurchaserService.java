package com.app.ildong.wrh.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.wrh.dao.WrhPurchaserDAO;

@Service("wrhPurchaserService")
public class WrhPurchaserService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private WrhPurchaserDAO purchaserDAO;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectPurchaserList(Map<String, Object> paramMap){
		return purchaserDAO.selectPurchaserList(paramMap);
	}
	
	
    public Map<String,Object> savePurchaser(Map<String,Object> paramMap) throws ServiceException, Exception {
        
        Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
//        List<Map<String, Object>> updList = (List<Map<String, Object>>)dataMap.get("UPDATED");
        List<Map<String, Object>> insList = (List<Map<String, Object>>)dataMap.get("CREATED");
        
//        if (null != updList && 0 < updList.size()) {
//            for (Map<String, Object> data: updList) {
//                data.put("MOD_ID"   , getUserId());
//                purchaserDAO.updatePurchaser(data);
//            }
//        }
        
        if (null != insList && 0 < insList.size()) {
            for (Map<String, Object> data: insList) {
                data.put("CRE_USER"   , getUserId());
                data.put("MOD_USER"   , getUserId());
            	purchaserDAO.insertPurchaser(data);
            }
        }
        
    	return paramMap;
    }
    
    public Map<String,Object> deletePurchaser(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> delList = (List<Map<String, Object>>)dataMap.get("DELETED");
    	
    	if (null != delList && 0 < delList.size()) {
    		for (Map<String, Object> data: delList) {
                data.put("CRE_USER"   , getUserId());
                data.put("MOD_USER"   , getUserId());
            	purchaserDAO.deletePurchaser(data);
    		}
    	}
    	
    	return paramMap;
    }	
}