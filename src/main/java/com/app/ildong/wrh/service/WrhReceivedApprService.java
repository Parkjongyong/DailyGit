package com.app.ildong.wrh.service;

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
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.app.ildong.common.dao.CommonDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.common.util.StringUtil;
import com.app.ildong.wrh.dao.WrhReceivedApprDAO;
import com.app.ildong.wrh.dao.WrhStockDueDateRegistDAO;

@Service("WrhReceivedApprService")
public class WrhReceivedApprService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private WrhReceivedApprDAO receivedApprDAO;
	
	@Autowired
	private WrhStockDueDateRegistDAO wrhStockDueDateRegistDAO;	
	
	@Autowired
	private DataSourceTransactionManager transactionManager;
	
    @Autowired
    private CommonDAO commonDAO;
    
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectReceivedAppr(Map<String, Object> paramMap){
		return receivedApprDAO.selectReceivedAppr(paramMap);
	}
	
    public Map<String,Object> apprReceived(Map<String,Object> paramMap) throws ServiceException, Exception {
        
        Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
        List<Map<String, Object>> updList = (List<Map<String, Object>>)dataMap.get("UPDATED");
    	String remark = (String) paramMap.get("REMARK");
        Map<String,Object> storageSpace = new HashMap<>();
        
        if (null != updList && 0 < updList.size()) {
            for (Map<String, Object> data: updList) {
                data.put("CRE_USER"   , getUserId());
                data.put("MOD_USER"   , getUserId());
        		data.put("TB_APPROVE_DOC_TXT", remark);
        		
        		
    			// 로긴 부서정보 셋팅
                Map<String, Object> purchaseUserInfo =  receivedApprDAO.checkConfirmUser(data);
                
                if ("0".equals(StringUtil.isNullToString(purchaseUserInfo.get("CNT")))) {
            		paramMap.put("SUCC_YN", "N");
            		paramMap.put("ERR_MSG", "입고담당자로 등록되지 않은 사용자입니다. 확인 후 작업하세요.");
            		// 강제로 Exception 발생
            		throw new Exception("입고담당자로 등록되지 않은 사용자입니다. 확인 후 작업하세요.");
                }

                receivedApprDAO.apprReceived(data);
                
        		// 승인 이력에 사용할 용도 데이터 셋팅
        		data.put("REMARK", remark); 
        		data.put("DOC_STATUS", "5");
                // 이력 남기기
                commonDAO.insertDeliveryHistory(data);
                
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
        
    	return paramMap;
    }
    
    public Map<String,Object> returnReceived(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	Map<String, Object> dataMap   = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> updList = (List<Map<String, Object>>)dataMap.get("UPDATED");
    	String remark = (String) paramMap.get("REMARK");
    	if (null != updList && 0 < updList.size()) {
    		for (Map<String, Object> data: updList) {
    			data.put("CRE_USER"   , getUserId());
    			data.put("MOD_USER"   , getUserId());
    			data.put("LOC_RETURN_DESC", remark);
    			
    			// 로긴 부서정보 셋팅
                Map<String, Object> purchaseUserInfo =  receivedApprDAO.checkConfirmUser(data);
                
                if ("0".equals(StringUtil.isNullToString(purchaseUserInfo.get("CNT")))) {
            		paramMap.put("SUCC_YN", "N");
            		paramMap.put("ERR_MSG", "입고담당자로 등록되지 않은 사용자입니다. 확인 후 작업하세요.");
            		// 강제로 Exception 발생
            		throw new Exception("입고담당자로 등록되지 않은 사용자입니다. 확인 후 작업하세요.");
                }    			
    			
    			receivedApprDAO.returnReceived(data);
    			
        		// 반려 이력에 사용할 용도 데이터 셋팅
        		data.put("REMARK", remark); 
        		data.put("DOC_STATUS", "3");
                // 이력 남기기
                commonDAO.insertDeliveryHistory(data);    			
    		}
    	}
    	
    	return paramMap;
    }

    public Map<String,Object> apprReceivedDetail(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	Map<String, Object> data    = new HashMap<>();
		data.put("TB_COMP_CD", paramMap.get("TB_COMP_CD"));
		data.put("TB_LOCATION", paramMap.get("TB_LOCATION"));
		data.put("TB_LOCATION_OLD", paramMap.get("TB_LOCATION_OLD"));
		data.put("TB_PLANT_CODE", paramMap.get("TB_PLANT_CODE"));
		data.put("TB_VENDOR_CD", paramMap.get("TB_VENDOR_CD"));
		data.put("TB_VENDOR_NM", paramMap.get("TB_VENDOR_NM"));
		data.put("TB_GR_DELY_DATE", paramMap.get("TB_GR_DELY_DATE"));
		data.put("MOD_USER"   , getUserId());
		data.put("DOC_NO", paramMap.get("TB_DOC_NO"));
		data.put("TB_APPROVE_DOC_TXT", paramMap.get("TB_APPROVE_DOC_TXT"));
		
    	receivedApprDAO.apprReceived(data);
    	
		// 승인 이력에 사용할 용도 데이터 셋팅
		data.put("REMARK", paramMap.get("TB_APPROVE_DOC_TXT")); 
		data.put("DOC_STATUS", "5");
        // 이력 남기기
        commonDAO.insertDeliveryHistory(data);

        Map<String,Object> storageSpace = new HashMap<>();
        
        // 필수 데이터 셋팅
    	storageSpace.put("COMP_CD"       , paramMap.get("TB_COMP_CD"));
    	storageSpace.put("PLANT_CD"      , paramMap.get("TB_PLANT_CODE"));
    	storageSpace.put("STORAGE_CD"    , paramMap.get("TB_LOCATION"));                    	
    	storageSpace.put("STRD_DATE"     , paramMap.get("TB_GR_DELY_DATE"));
    	storageSpace.put("GR_DELY_DATE"  , paramMap.get("TB_GR_DELY_DATE"));
    	storageSpace.put("GR_DELY_TIME"  , paramMap.get("TB_GR_DELY_TIME"));
    	storageSpace.put("CRE_USER"      , getUserId());
    	storageSpace.put("MOD_USER"      , getUserId());

//    	int cnt = receivedApprDAO.selectDeliveryHeaderInfo(storageSpace);
//    	
//    	if(cnt > 0) {
//    		paramMap.put("SUCC_YN", "N");
//    		paramMap.put("ERR_MSG", "해당 요청일의 창고여유공간이 부족합니다. 확인 후 작업하세요.");
//			transactionManager.rollback(status);
//    		// 강제로 Exception 발생
//    		throw new ServiceException("해당 요청일의 창고여유공간이 부족합니다. 확인 후 작업하세요.");
//    	}
    	
        Map<String, Object> strorageInfo =  wrhStockDueDateRegistDAO.checkStorageSpace(data);
        
        if (!"".equals(strorageInfo.get("CHK_YN")) && null != strorageInfo.get("CHK_YN")) {
        	// 등록된 데이터가 존재하는 경우, 창고 여유공간이 없으면 강제로 롤백처리
        	if ("N".equals(strorageInfo.get("CHK_YN"))) {
        		paramMap.put("SUCC_YN", "N");
        		paramMap.put("ERR_MSG", "해당 요청일의 창고여유공간이 부족합니다. 확인 후 작업하세요.");
        		// 강제로 Exception 발생
        		throw new ServiceException("해당 요청일의 창고여유공간이 부족합니다. 확인 후 작업하세요.");
        		
        	}
        }

    	
    	// 창고 여유 MERGE
        wrhStockDueDateRegistDAO.mergeStorageSpace(storageSpace);
    	// 기등록된 데이터와 현재 입고장소가 다른 경우
    	if (!data.get("TB_LOCATION").equals(data.get("TB_LOCATION_OLD"))) {
            // 창고 여유 MERGE
    		storageSpace.put("STORAGE_CD", data.get("TB_LOCATION_OLD"));
            wrhStockDueDateRegistDAO.mergeStorageSpace(storageSpace);
    	}
    	
        paramMap.put("SUCC_YN", "Y");
    	return paramMap;
    }
    
    public Map<String,Object> returnReceivedApprDetail(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	Map<String, Object> data    = new HashMap();
    	String remark               = (String) paramMap.get("REMARK");
    	
		data.put("MOD_USER"   , getUserId());
		data.put("DOC_NO", paramMap.get("TB_DOC_NO"));
		
		if("WRH162".equals(paramMap.get("G_MENU_CD"))) {
			data.put("LOC_RETURN_DESC", remark);
			receivedApprDAO.returnReceived(data);
		} else {
			data.put("ORG_RETURN_DESC", remark);
			receivedApprDAO.returnReceivedPo(data);
		}
		
		// 반려 이력에 사용할 용도 데이터 셋팅
		data.put("REMARK", remark); 
		data.put("DOC_STATUS", "3");
        // 이력 남기기
        commonDAO.insertDeliveryHistory(data);   	
    	
    	return paramMap;
    }

	public List<Map<String, Object>> selectSendList(Map<String, Object> paramMap){
		return receivedApprDAO.selectSendList(paramMap);
	}
	

    
}