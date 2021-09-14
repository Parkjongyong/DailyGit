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
import com.app.ildong.wrh.dao.WrhStockDueDateInfoDAO;
import com.app.ildong.wrh.dao.WrhStockDueDateRegistDAO;

@Service("wrhStockDueDateInfoService")
public class WrhStockDueDateInfoService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private WrhStockDueDateInfoDAO wrhStockDueDateInfoDAO;
	
	@Autowired
	private WrhStockDueDateRegistDAO wrhStockDueDateRegistDAO;	
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectStockDueDateInfoList(Map<String, Object> paramMap){
		return wrhStockDueDateInfoDAO.selectStockDueDateInfoList(paramMap);
	}
	
	public List<Map<String, Object>> selectDueDateInfo(Map<String, Object> paramMap){
		return wrhStockDueDateInfoDAO.selectDueDateInfo(paramMap);
	}	
	
    public Map<String,Object> saveDueDateInfo(Map<String,Object> paramMap) throws ServiceException, Exception {
        
        Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
        List<Map<String, Object>> updList = (List<Map<String, Object>>)dataMap.get("UPDATED");
        
        if (null != updList && 0 < updList.size()) {
            for (Map<String, Object> data: updList) {
            	data.put("MOD_USER"   , getUserId());
            	data.put("DOC_STATUS", "1");
            	// GR_DELIVERY_HEAD 승인요청 상태 FLAG UPDATE!!
                wrhStockDueDateInfoDAO.updateDeliveryHeadStatus(data);
                
                // 예정일이 공백이 아닌 경우 창고예유를 잡기 위해 체크
                if (!"".equals(data.get("GR_DELY_DATE")) && null != data.get("GR_DELY_DATE")) {
                    
                	Map<String,Object> storageSpace = new HashMap<>();
                    // 필수 데이터 셋팅
                	storageSpace.put("COMP_CD"    , data.get("COMP_CD"));
                	storageSpace.put("PLANT_CD"   , data.get("PLANT_CODE"));
                	storageSpace.put("STORAGE_CD" , data.get("LOCATION"));                    	
                	storageSpace.put("STRD_DATE"  , data.get("GR_DELY_DATE"));
                	storageSpace.put("CRE_USER"   , getUserId());
                	storageSpace.put("MOD_USER"   , getUserId());
                	// 창고 여유 MERGE
                    wrhStockDueDateRegistDAO.mergeStorageSpace(storageSpace);
                    // 기등록된 예정일이 졵하는 경우 체크
                    if (!"".equals(data.get("GR_DELY_DATE_OLD")) && null != data.get("GR_DELY_DATE_OLD")) {
                    	// 기등록된 데이터와 현재 예정일이 다른 경우
                    	if (!data.get("GR_DELY_DATE").equals(data.get("GR_DELY_DATE_OLD"))) {
                            // 창고 여유 MERGE
                    		storageSpace.put("STRD_DATE", data.get("GR_DELY_DATE_OLD"));
                            wrhStockDueDateRegistDAO.mergeStorageSpace(storageSpace);
                    	}
                    }
                }                
            }
        }
        
    	return paramMap;
    }
    
    public Map<String,Object> delDueDateInfo(Map<String,Object> paramMap) throws ServiceException, Exception {
        
        Map<String, Object> dataMap       = (Map<String, Object>) paramMap.get("ITEM_LIST");
        List<Map<String, Object>> delList = (List<Map<String, Object>>)dataMap.get("DELETED");
        
        	
    	// GR_DELIVERY_ITEM DELETE!!
        if (null != delList && 0 < delList.size()) {
            for (Map<String, Object> data: delList) {
            	// 상태 체크
            	data.put("TB_DOC_NO"   , data.get("DOC_NO"));
        		Map<String,Object> statusMap = wrhStockDueDateRegistDAO.selectStatusDueDateRegist(data);
        		if (   "1".equals(statusMap.get("DOC_STATUS"))
        			|| "3".equals(statusMap.get("DOC_STATUS"))
        			|| "4".equals(statusMap.get("DOC_STATUS"))) {
                	wrhStockDueDateInfoDAO.delDeliveryHead(data);
                	wrhStockDueDateInfoDAO.delDeliveryItem(data);
                	
                    // 예정일이 공백이 아닌 경우 창고예유를 잡기 위해 체크
                    if (!"".equals(data.get("GR_DELY_DATE")) && null != data.get("GR_DELY_DATE")) {
                        
                    	Map<String,Object> storageSpace = new HashMap<>();
                        // 필수 데이터 셋팅
                    	storageSpace.put("COMP_CD"    , data.get("COMP_CD"));
                    	storageSpace.put("PLANT_CD"   , data.get("PLANT_CODE"));
                    	storageSpace.put("STORAGE_CD" , data.get("LOCATION"));                    	
                    	storageSpace.put("STRD_DATE"  , data.get("GR_DELY_DATE_OLD"));
                    	storageSpace.put("CRE_USER"   , getUserId());
                    	storageSpace.put("MOD_USER"   , getUserId());
                    	// 창고 여유 MERGE
                        wrhStockDueDateRegistDAO.mergeStorageSpace(storageSpace);
                        // 기등록된 예정일이 졵하는 경우 체크
                        if (!"".equals(data.get("GR_DELY_DATE_OLD")) && null != data.get("GR_DELY_DATE_OLD")) {
                        	// 기등록된 데이터와 현재 예정일이 다른 경우
                        	if (!data.get("GR_DELY_DATE").equals(data.get("GR_DELY_DATE_OLD"))) {
                                // 창고 여유 MERGE
                        		storageSpace.put("STRD_DATE", data.get("GR_DELY_DATE_OLD"));
                                wrhStockDueDateRegistDAO.mergeStorageSpace(storageSpace);
                        	}
                        }
                    }                 	
        		}
            }
        }        	
        
    	return paramMap;
    }    
	
    public Map<String,Object> requestDueDateInfo(Map<String,Object> paramMap) throws ServiceException, Exception {
        
        Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
        List<Map<String, Object>> updList = (List<Map<String, Object>>)dataMap.get("UPDATED");
        
        if (null != updList && 0 < updList.size()) {
            for (Map<String, Object> data: updList) {
            	data.put("MOD_USER"   , getUserId());
            	data.put("DOC_STATUS", "2");
            	// GR_DELIVERY_HEAD 승인요청 상태 FLAG UPDATE!!
                wrhStockDueDateInfoDAO.updateDeliveryHeadStatus(data);
            }
        }
        
    	return paramMap;
    }
    
    public Map<String,Object> cancelDueDateInfo(Map<String,Object> paramMap) throws ServiceException, Exception {
        
        Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
        List<Map<String, Object>> updList = (List<Map<String, Object>>)dataMap.get("UPDATED");
        
        if (null != updList && 0 < updList.size()) {
            for (Map<String, Object> data: updList) {
            	// 상태 체크
            	data.put("TB_DOC_NO"   , data.get("DOC_NO"));
        		Map<String,Object> statusMap = wrhStockDueDateRegistDAO.selectStatusDueDateRegist(data);
        		if ("2".equals(statusMap.get("DOC_STATUS"))) {
        			data.put("MOD_USER"   , getUserId());
        			data.put("DOC_STATUS", "1");
                	// GR_DELIVERY_HEAD 승인요청 상태 FLAG UPDATE!!
                    wrhStockDueDateInfoDAO.updateDeliveryHeadStatus(data);		
        		}
            }
        }
        
    	return paramMap;
    }
    
	public List<Map<String, Object>> selectAccountInfoList(Map<String, Object> paramMap){
		return wrhStockDueDateInfoDAO.selectAccountInfoList(paramMap);
	}
	
	
}