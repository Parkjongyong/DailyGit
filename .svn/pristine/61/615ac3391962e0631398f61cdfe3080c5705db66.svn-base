package com.app.ildong.bdg.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.bdg.dao.BdgVehicleMgtDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;

@Service("bdgVehicleMgtService")
public class BdgVehicleMgtService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BdgVehicleMgtDAO bdgVehicleMgtDAO;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectVehicleMgtList(Map<String, Object> paramMap){
		return bdgVehicleMgtDAO.selectVehicleMgtList(paramMap);
	}
	
	public List<Map<String, Object>> selectVehicleOpList(Map<String, Object> paramMap){
		return bdgVehicleMgtDAO.selectVehicleOpList(paramMap);
	}
	
    public Map<String,Object> saveVehicleMgt(Map<String,Object> paramMap) throws ServiceException, Exception {
        
    	Map<String, Object> itemMap          = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> insertList = (List<Map<String, Object>>) itemMap.get("CREATED");
    	List<Map<String, Object>> updateList = (List<Map<String, Object>>) itemMap.get("UPDATED");
    	
        // 신규 저장로직
        if (null != insertList && 0 < insertList.size()) {
            for (Map<String, Object> data: insertList) {
                data.put("CRE_USER"   , getUserId());
                data.put("MOD_USER"   , getUserId());	            	
            	bdgVehicleMgtDAO.insertVehicleMgt(data);
            }
        }
        // 기등록  저장로직
        if (null != updateList && 0 < updateList.size()) {
            for (Map<String, Object> data: updateList) {
            	
                data.put("CRE_USER"   , getUserId());
                data.put("MOD_USER"   , getUserId());
                
        		bdgVehicleMgtDAO.updateVehicleMgt(data);
            }
        }	        
        
    	return paramMap;
    }
    
    public Map<String,Object> deleteVehicleMgt(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	Map<String, Object> deleteMap   = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> deleteList   = (List<Map<String, Object>>) deleteMap.get("DELETED");
        
        // 삭제로직
        if (null != deleteList && 0 < deleteList.size()) {
            for (Map<String, Object> data: deleteList) {
            	
        		 bdgVehicleMgtDAO.deleteVehicleMgt(data);
            }
        }
        
    	return paramMap;
    }
    
    public Map<String,Object> saveVehicleOp(Map<String,Object> paramMap) throws ServiceException, Exception {
        
    	Map<String, Object> itemMap          = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> insertList = (List<Map<String, Object>>) itemMap.get("CREATED");
    	List<Map<String, Object>> updateList = (List<Map<String, Object>>) itemMap.get("UPDATED");
    	
        // 신규 저장로직
        if (null != insertList && 0 < insertList.size()) {
            for (Map<String, Object> data: insertList) {
                data.put("CRE_USER"   , getUserId());
                data.put("MOD_USER"   , getUserId());	            	
            	bdgVehicleMgtDAO.insertVehicleOp(data);
            }
        }
        // 기등록  저장로직
        if (null != updateList && 0 < updateList.size()) {
            for (Map<String, Object> data: updateList) {
            	
                data.put("CRE_USER"   , getUserId());
                data.put("MOD_USER"   , getUserId());
                
        		bdgVehicleMgtDAO.updateVehicleOp(data);
            }
        }	        
        
    	return paramMap;
    }
    
    public Map<String,Object> deleteVehicleOp(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	Map<String, Object> deleteMap   = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> deleteList   = (List<Map<String, Object>>) deleteMap.get("DELETED");
        
        // 삭제로직
        if (null != deleteList && 0 < deleteList.size()) {
            for (Map<String, Object> data: deleteList) {
            	
        		 bdgVehicleMgtDAO.deleteVehicleOp(data);
            }
        }
        
    	return paramMap;
    }    
    
}