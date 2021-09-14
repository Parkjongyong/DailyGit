package com.app.ildong.wrh.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.wrh.dao.WrhSerialRegisterDAO;

@Service("wrhSerialRegisterService")
public class WrhSerialRegisterService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private WrhSerialRegisterDAO wrhSerialRegisterDAO;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectWrhSerialRegisterList(Map<String, Object> paramMap){
		return wrhSerialRegisterDAO.selectWrhSerialRegisterList(paramMap);
	}
	
	
    public Map<String,Object> saveSerialRegister(Map<String,Object> paramMap) throws ServiceException, Exception {
        
        Map<String, Object> dataMap        = (Map<String, Object>) paramMap.get("ITEM_LIST");
        List<Map<String, Object>> dataList = (List<Map<String, Object>>) dataMap.get("CHECK_LIST");
        wrhSerialRegisterDAO.deleteSerialRegisterH(paramMap);
        
        if (null != dataList && 0 < dataList.size()) {
            for (Map<String, Object> data: dataList) {
                data.put("CRE_USER"     , getUserId());
                data.put("MOD_USER"     , getUserId());
                data.put("VENDOR_CD"    , paramMap.get("TB_VENDOR_CD"));
                data.put("GR_DELY_DATE" , paramMap.get("TB_GR_DELY_DATE"));
                data.put("GR_DELY_TIME" , paramMap.get("TB_GR_DELY_TIME"));
                wrhSerialRegisterDAO.insertSerialRegister(data);
            }
        }
	        
		return paramMap;
    }
    
    public Map<String,Object> deleteSerialRegister(Map<String,Object> paramMap) throws ServiceException, Exception {
        
        Map<String, Object> dataMap       = (Map<String, Object>) paramMap.get("ITEM_LIST");
        List<Map<String, Object>> delList = (List<Map<String, Object>>)dataMap.get("DELETED");
        if (null != delList && 0 < delList.size()) {
            for (Map<String, Object> data: delList) {
                wrhSerialRegisterDAO.deleteSerialRegister(data);
            }
        }          	
        
    	return paramMap;
    }    
 
	public List<Map<String, Object>> selectDateTime(Map<String, Object> paramMap){
		return wrhSerialRegisterDAO.selectDateTime(paramMap);
	}
	
    
}