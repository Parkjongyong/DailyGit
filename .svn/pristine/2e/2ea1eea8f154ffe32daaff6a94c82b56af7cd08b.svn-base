package com.app.ildong.wrh.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.common.dao.CommonSelectDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.wrh.dao.WrhStorageSpaceMgmtDAO;

@Service("wrhStorageSpaceMgmtService")
public class WrhStorageSpaceMgmtService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private WrhStorageSpaceMgmtDAO wrhStorageSpaceMgmtDAO;
	
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectWhrStorageSpaceMgmtList(Map<String, Object> paramMap){
		return wrhStorageSpaceMgmtDAO.selectWhrStorageSpaceMgmtList(paramMap);
	}
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectwrhStorageSpacePopList(Map<String, Object> paramMap){
		return wrhStorageSpaceMgmtDAO.selectwrhStorageSpacePopList(paramMap);
	}	
	
    public Map<String,Object> saveWhrStorageSpace(Map<String,Object> paramMap) throws ServiceException, Exception {
        
    	List<Map<String, Object>> saveList = (List<Map<String, Object>>) paramMap.get("ITEM_LIST");
        
        if (null != saveList && 0 < saveList.size()) {
            for (Map<String, Object> data: saveList) {
                data.put("CRE_USER"   , getUserId());
                data.put("MOD_USER"   , getUserId());
                
                data.put("COMP_CD"    , paramMap.get("SB_COMP_CD"));
                data.put("PLANT_CD"   , paramMap.get("SB_PLANT_CD"));
                data.put("STORAGE_CD" , paramMap.get("SB_STORAGE_CD"));
                
                wrhStorageSpaceMgmtDAO.saveWhrStorageSpace(data);
            }
        }
        
    	return paramMap;
    }	
	
	
}