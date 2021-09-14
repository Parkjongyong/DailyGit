package com.app.ildong.wrh.service;

import java.util.ArrayList;
import java.util.HashMap;
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

import com.app.ildong.common.dao.CommonSelectDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.wrh.dao.WrhStockDueDateRegistDAO;

@Service("wrhStockDueDateRegistService")
public class WrhStockDueDateRegistService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private WrhStockDueDateRegistDAO wrhStockDueDateRegistDAO;
	
    @Autowired
    private CommonSelectDAO commonSelectDAO;	
    
	@Autowired
	private DataSourceTransactionManager transactionManager;    
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectWhrStockDueDateRegistList(Map<String, Object> paramMap){
		return wrhStockDueDateRegistDAO.selectWhrStockDueDateRegistList(paramMap);
	}
	
	public List<Map<String, Object>> selectPltQty(Map<String, Object> paramMap){
		
		Map<String, Object> dataMap       = (Map<String, Object>) paramMap.get("ITEM_LIST");
		List<Map<String, Object>> dataList = (List<Map<String, Object>>)dataMap.get("ALLDATA");
		List<Map<String, Object>> returnList = new ArrayList<Map<String, Object>>();
		// 박스입수, PLT 입상수 추가
		for (Map<String, Object> data: dataList) {
			Map<String, Object> returnMap =  wrhStockDueDateRegistDAO.selectPltQty(data);
			System.out.println("selectPltQty 조회!!");
			if (null != returnMap) {
				if (null != returnMap.get("BOX_QTY")) {
					data.put("BOX_QTY", returnMap.get("BOX_QTY").toString());
				}
				
				if (null != returnMap.get("PLT_QTY")) {
					data.put("PLT_QTY", returnMap.get("PLT_QTY").toString());
				}
				
				returnList.add(data);
			}
		}
		return returnList;
	}	
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectWhrStockDueDateRegistDetailList(Map<String, Object> paramMap){
		return wrhStockDueDateRegistDAO.selectWhrStockDueDateRegistDetailList(paramMap);
	}
	
	public Map<String, Object> selectWhrStockDueDateRegistheaderInfo(Map<String, Object> paramMap){
		return wrhStockDueDateRegistDAO.selectWhrStockDueDateRegistheaderInfo(paramMap);
	}
	
	public Map<String, Object> selectStatusDueDateRegist(Map<String, Object> paramMap){
		return wrhStockDueDateRegistDAO.selectStatusDueDateRegist(paramMap);
	}	
	
	
	
    public Map<String,Object> saveDueDateRegist(Map<String,Object> paramMap) throws ServiceException, Exception {
        
        Map<String, Object> dataMap       = (Map<String, Object>) paramMap.get("ITEM_LIST");
        List<Map<String, Object>> allList = (List<Map<String, Object>>)dataMap.get("ALLDATA");
        
    	// 데이터 존재유무 확인
        paramMap.put("CRE_USER"   , getUserId());
        paramMap.put("CRE_USER"   , getUserId());
        
		DefaultTransactionDefinition def =  new DefaultTransactionDefinition();
		def.setName("SaveDueDateRegist-Transaction");
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRES_NEW);
		TransactionStatus status = transactionManager.getTransaction(def);
		
		try {
	        // DOC NO가 없는 경우(신규)
			paramMap.put("MOD_USER"       , getUserId());
	        if ("".equals(paramMap.get("TB_DOC_NO")) || null == paramMap.get("TB_DOC_NO")) {
	        	paramMap.put("DOC_GUBN", "IP");
	        	Map<String, Object> docNoInfo = commonSelectDAO.selectDocNo(paramMap);
	        	paramMap.put("TB_DOC_NO", docNoInfo.get("DOC_NO"));
	        	
	        	// GR_DELIVERY_HEAD INSERT!!
	            wrhStockDueDateRegistDAO.insertDeliveryHead(paramMap);
	        	
	        	// GR_DELIVERY_ITEM INSERT 및 STORAGE_SPACE MERGE!!
	            if (null != allList && 0 < allList.size()) {
	                for (Map<String, Object> data: allList) {
	                	// 필수 데이터 셋팅
	                    data.put("CRE_USER"       , getUserId());
	                    data.put("MOD_USER"       , getUserId());
	                    data.put("TB_DOC_NO"      , paramMap.get("TB_DOC_NO"));
	                    data.put("TB_COMP_CD"     , paramMap.get("TB_COMP_CD"));
	                    data.put("TB_PLANT_CODE"  , paramMap.get("TB_PLANT_CODE"));
	                    data.put("TB_LOCATION"    , paramMap.get("TB_LOCATION"));
	                    data.put("TB_GR_DELY_DATE", paramMap.get("TB_GR_DELY_DATE"));
	                    
	                    // INSERT
	                    wrhStockDueDateRegistDAO.insertDeliveryItem(data);
	                    
	                    Map<String, Object> strorageInfo =  wrhStockDueDateRegistDAO.checkStorageSpace(data);
	                    
	                    if (!"".equals(strorageInfo.get("CHK_YN")) && null != strorageInfo.get("CHK_YN")) {
	                    	// 등록된 데이터가 존재하는 경우, 창고 여유공간이 없으면 강제로 롤백처리
	                    	if ("N".equals(strorageInfo.get("CHK_YN"))) {
	                    		paramMap.put("SUCC_YN", "N");
	                    		paramMap.put("ERR_MSG", "해당 요청일의 창고여유공간이 부족합니다. 확인 후 작업하세요.");
	                    		// 강제로 Exception 발생
	                    		throw new Exception("해당 요청일의 창고여유공간이 부족합니다. 확인 후 작업하세요.");
	                    	}
	                    }	                    
	                }
	                
	                // 예정일이 공백이 아닌 경우 창고예유를 잡기 위해 체크
	                if (!"".equals(paramMap.get("TB_GR_DELY_DATE")) && null != paramMap.get("TB_GR_DELY_DATE")) {
	                    
	                	Map<String,Object> storageSpace = new HashMap<>();
	                    // 필수 데이터 셋팅
	                	storageSpace.put("COMP_CD"    , paramMap.get("TB_COMP_CD"));
	                	storageSpace.put("PLANT_CD"   , paramMap.get("TB_PLANT_CODE"));
	                	storageSpace.put("STORAGE_CD" , paramMap.get("TB_LOCATION"));                    	
	                	storageSpace.put("STRD_DATE"  , paramMap.get("TB_GR_DELY_DATE"));
	                	
	                	storageSpace.put("CRE_USER"   , getUserId());
	                	storageSpace.put("MOD_USER"   , getUserId());
	                	// 창고 여유 MERGE
	                    wrhStockDueDateRegistDAO.mergeStorageSpace(storageSpace);
	                    // 기등록된 예정일이 졵하는 경우 체크
	                    if (!"".equals(paramMap.get("TB_GR_DELY_DATE_OLD")) && null != paramMap.get("TB_GR_DELY_DATE_OLD")) {
	                    	// 기등록된 데이터와 현재 예정일이 다른 경우
	                    	if (!paramMap.get("TB_GR_DELY_DATE").equals(paramMap.get("TB_GR_DELY_DATE_OLD"))) {
	                            // 창고 여유 MERGE
	                    		storageSpace.put("STRD_DATE", paramMap.get("TB_GR_DELY_DATE_OLD"));
	                            wrhStockDueDateRegistDAO.mergeStorageSpace(storageSpace);
	                    	}
	                    }
	                }                
	            }        	
	        } else {
	        	// GR_DELIVERY_HEAD UPDATE!!
	            wrhStockDueDateRegistDAO.updateDeliveryHead(paramMap);
	        	
	        	// GR_DELIVERY_HEAD DELETE!!
	            wrhStockDueDateRegistDAO.deleteAllDeliveryItem(paramMap);            
	            // GR_DELIVERY_ITEM INSERT 및 STORAGE_SPACE MERGE!!
	            if (null != allList && 0 < allList.size()) {
	                for (Map<String, Object> data: allList) {
	                	// 필수 데이터 셋팅
	                    data.put("MOD_USER"   , getUserId());
	                    data.put("TB_DOC_NO"  , paramMap.get("TB_DOC_NO"));
	                    data.put("TB_COMP_CD"     , paramMap.get("TB_COMP_CD"));
	                    data.put("TB_PLANT_CODE"  , paramMap.get("TB_PLANT_CODE"));
	                    data.put("TB_LOCATION"    , paramMap.get("TB_LOCATION"));
	                    data.put("TB_GR_DELY_DATE", paramMap.get("TB_GR_DELY_DATE"));
	                    Map<String, Object> strorageInfo =  wrhStockDueDateRegistDAO.checkStorageSpace(data);
	                    
	                    if (!"".equals(strorageInfo.get("CHK_YN")) && null != strorageInfo.get("CHK_YN")) {
	                    	// 등록된 데이터가 존재하는 경우, 창고 여유공간이 없으면 강제로 롤백처리
	                    	if ("N".equals(strorageInfo.get("CHK_YN"))) {
	                    		// 강제로 Exception 발생
	                    		paramMap.put("SUCC_YN", "N");
	                    		paramMap.put("ERR_MSG", "해당 요청일의 창고여유공간이 부족합니다. 확인 후 작업하세요.");
	                    		throw new Exception("해당 요청일의 창고여유공간이 부족합니다. 확인 후 작업하세요.");
	                    	}
	                    }	                    
	                    // INSERT
	                    wrhStockDueDateRegistDAO.insertDeliveryItem(data);
	                }
	                
	                // 예정일이 공백이 아닌 경우 창고예유를 잡기 위해 체크
	                if (!"".equals(paramMap.get("TB_GR_DELY_DATE")) && null != paramMap.get("TB_GR_DELY_DATE")) {
	                    
	                	Map<String,Object> storageSpace = new HashMap<>();
	                    // 필수 데이터 셋팅
	                	storageSpace.put("COMP_CD"    , paramMap.get("TB_COMP_CD"));
	                	storageSpace.put("PLANT_CD"   , paramMap.get("TB_PLANT_CODE"));
	                	storageSpace.put("STORAGE_CD" , paramMap.get("TB_LOCATION"));                    	
	                	storageSpace.put("STRD_DATE"  , paramMap.get("TB_GR_DELY_DATE"));
	                	storageSpace.put("CRE_USER"   , getUserId());
	                	storageSpace.put("MOD_USER"   , getUserId());
	                	// 창고 여유 MERGE
	                    wrhStockDueDateRegistDAO.mergeStorageSpace(storageSpace);
	                    // 기등록된 예정일이 졵하는 경우 체크
	                    if (!"".equals(paramMap.get("TB_GR_DELY_DATE_OLD")) && null != paramMap.get("TB_GR_DELY_DATE_OLD")) {
	                    	// 기등록된 데이터와 현재 예정일이 다른 경우
	                    	if (!paramMap.get("TB_GR_DELY_DATE").equals(paramMap.get("TB_GR_DELY_DATE_OLD"))) {
	                            // 창고 여유 MERGE
	                    		storageSpace.put("STRD_DATE", paramMap.get("TB_GR_DELY_DATE_OLD"));
	                            wrhStockDueDateRegistDAO.mergeStorageSpace(storageSpace);
	                    	}
	                    }
	                } 
	            }          	
	        }
	        
	        paramMap.put("SUCC_YN", "Y");
			transactionManager.commit(status);
		} catch (Exception e1) {
			transactionManager.rollback(status);
		}
        
    	return paramMap;
    }
    
    public Map<String,Object> deleteDueDateRegist(Map<String,Object> paramMap) throws ServiceException, Exception {
        
        Map<String, Object> dataMap       = (Map<String, Object>) paramMap.get("ITEM_LIST");
        List<Map<String, Object>> delList = (List<Map<String, Object>>)dataMap.get("DELETED");
        
    	// GR_DELIVERY_ITEM DELETE!!
        if (null != delList && 0 < delList.size()) {
            for (Map<String, Object> data: delList) {
                wrhStockDueDateRegistDAO.deleteDeliveryItem(data);
            }
            
            // 예정일이 공백이 아닌 경우 창고예유를 잡기 위해 체크
            if (!"".equals(paramMap.get("TB_GR_DELY_DATE")) && null != paramMap.get("TB_GR_DELY_DATE")) {
                
            	Map<String,Object> storageSpace = new HashMap<>();
                // 필수 데이터 셋팅
            	storageSpace.put("COMP_CD"    , paramMap.get("TB_COMP_CD"));
            	storageSpace.put("PLANT_CD"   , paramMap.get("TB_PLANT_CODE"));
            	storageSpace.put("STORAGE_CD" , paramMap.get("TB_LOCATION"));                    	
            	storageSpace.put("STRD_DATE"  , paramMap.get("TB_GR_DELY_DATE"));
            	storageSpace.put("CRE_USER"   , getUserId());
            	storageSpace.put("MOD_USER"   , getUserId());
            	// 창고 여유 MERGE
                wrhStockDueDateRegistDAO.mergeStorageSpace(storageSpace);
                // 기등록된 예정일이 졵하는 경우 체크
                if (!"".equals(paramMap.get("TB_GR_DELY_DATE_OLD")) && null != paramMap.get("TB_GR_DELY_DATE_OLD")) {
                	// 기등록된 데이터와 현재 예정일이 다른 경우
                	if (!paramMap.get("TB_GR_DELY_DATE").equals(paramMap.get("TB_GR_DELY_DATE_OLD"))) {
                        // 창고 여유 MERGE
                		storageSpace.put("STRD_DATE", paramMap.get("TB_GR_DELY_DATE_OLD"));
                        wrhStockDueDateRegistDAO.mergeStorageSpace(storageSpace);
                	}
                }
            }             
            
        }          	
        
    	return paramMap;
    }    
    
    public Map<String,Object> requestDueDateRegist(Map<String,Object> paramMap) throws ServiceException, Exception {
    	paramMap.put("MOD_USER"   , getUserId());
        paramMap.put("TB_DOC_STATUS", "2");
    	// GR_DELIVERY_HEAD 승인요청 상태 FLAG UPDATE!!
        wrhStockDueDateRegistDAO.updateDeliveryHeadStatus(paramMap);        
        
    	return paramMap;
    }
    
    public Map<String,Object> cancelDueDateRegist(Map<String,Object> paramMap) throws ServiceException, Exception {
    	paramMap.put("MOD_USER"   , getUserId());
        paramMap.put("TB_DOC_STATUS", "1");
    	// GR_DELIVERY_HEAD 승인요청 상태 FLAG UPDATE!!
        wrhStockDueDateRegistDAO.updateDeliveryHeadStatus(paramMap);        
        
    	return paramMap;
    }    
    
    
	public List<Map<String, Object>> selectWhrStockDueDateReceiverList(Map<String, Object> paramMap){
		return wrhStockDueDateRegistDAO.selectWhrStockDueDateReceiverList(paramMap);
	}
	
	
    public Map<String,Object> insertSmsData(Map<String,Object> paramMap) throws ServiceException, Exception {
    	List<Map<String,Object>> receiverSmsList = wrhStockDueDateRegistDAO.selectWhrStockDueDateReceiverSmsList(paramMap);
    	
        for (Map<String, Object> smsData: receiverSmsList) {
        	wrhStockDueDateRegistDAO.insertSmsData(smsData);
        }

    	return paramMap;
    }
	
	
}