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
import com.app.ildong.wrh.dao.WrhVendorInfoDAO;

@Service("wrhVendorInfoService")
public class WrhVendorInfoService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private WrhVendorInfoDAO wrhVendorInfoDAO;
	
	public List<Map<String,Object>> selectVendorPurchOrgList(Map<String,Object> paramMap) {
        return wrhVendorInfoDAO.selectVendorPurchOrgList(paramMap);
    }
	
	public Map<String,Object> selectVendorInfo(Map<String,Object> paramMap) {
        return wrhVendorInfoDAO.selectVendorInfo(paramMap);
    }	
	
	public List<Map<String,Object>> selectVendorUserList(Map<String,Object> paramMap) {
        return wrhVendorInfoDAO.selectVendorUserList(paramMap);
    }
	
    public Map<String,Object> saveVendorUser(Map<String,Object> paramMap) throws ServiceException, Exception {
        
        Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
        List<Map<String, Object>> updList = (List<Map<String, Object>>)dataMap.get("UPDATED");
        List<Map<String, Object>> insList = (List<Map<String, Object>>)dataMap.get("CREATED");
        
        
        if (null != updList && 0 < updList.size()) {
            for (Map<String, Object> updData: updList) {
            	updData.put("MOD_USER"   , getUserId());
            	wrhVendorInfoDAO.updateVendorUser(updData);
            }
        }        
        
        if (null != insList && 0 < insList.size()) {
            for (Map<String, Object> insData: insList) {
            	insData.put("CRE_USER"   , getUserId());
            	insData.put("MOD_USER"   , getUserId());
            	wrhVendorInfoDAO.insertVendorUser(insData);
            }
        }
        
    	return paramMap;
    }
    
    public Map<String,Object> deleteVendorUser(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> delList = (List<Map<String, Object>>)dataMap.get("DELETED");
    	
    	if (null != delList && 0 < delList.size()) {
    		for (Map<String, Object> delData: delList) {
    			delData.put("CRE_USER"   , getUserId());
    			delData.put("MOD_USER"   , getUserId());
    			wrhVendorInfoDAO.deleteVendorUser(delData);
    		}
    	}
    	
    	return paramMap;
    }   
}