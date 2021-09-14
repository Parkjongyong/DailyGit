package com.app.ildong.wrh.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.common.dao.CommonDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.common.util.StringUtil;
import com.app.ildong.wrh.dao.WrhPurchaseRecApprDAO;
import com.app.ildong.wrh.dao.WrhStockDueDateRegistDAO;

@Service("WrhPurchaseRecApprService")
public class WrhPurchaseRecApprService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private WrhPurchaseRecApprDAO purchaseRecApprDAO;
	
	@Autowired
	private WrhStockDueDateRegistDAO wrhStockDueDateRegistDAO;
	
    @Autowired
    private CommonDAO commonDAO;	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectPurchaseRecAppr(Map<String, Object> paramMap){
		return purchaseRecApprDAO.selectPurchaseRecAppr(paramMap);
	}
	
	
    public Map<String,Object> apprPurchaseReceived(Map<String,Object> paramMap) throws ServiceException, Exception {
        
        Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
        List<Map<String, Object>> updList = (List<Map<String, Object>>)dataMap.get("UPDATED");
    	String remark = (String) paramMap.get("REMARK");
        Map<String,Object> storageSpace = new HashMap<>();
        
        if (null != updList && 0 < updList.size()) {
            for (Map<String, Object> data: updList) {
                data.put("CRE_USER"   , getUserId());
                data.put("MOD_USER"   , getUserId());
    			data.put("APPROVE_DOC_TXT", remark);
    			
    			// 로긴 부서정보 셋팅
    			data.put("ORG_CD"     , getDeptCd());
                Map<String, Object> purchaseUserInfo =  purchaseRecApprDAO.checkPurchaseUser(data);
                
                if ("0".equals(StringUtil.isNullToString(purchaseUserInfo.get("CNT")))) {
            		paramMap.put("SUCC_YN", "N");
            		paramMap.put("ERR_MSG", "구매담당자로 등록되지 않은 사용자입니다. 확인 후 작업하세요.");
            		// 강제로 Exception 발생
            		throw new Exception("구매담당자로 등록되지 않은 사용자입니다. 확인 후 작업하세요.");
                }	
                
                purchaseRecApprDAO.apprPurchaseReceived(data);
                
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
        
        paramMap.put("SUCC_YN", "Y");
        
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
    			data.put("ORG_RETURN_DESC", remark);
    			
    			// 로긴 부서정보 셋팅
    			data.put("ORG_CD"     , getDeptCd());
                Map<String, Object> purchaseUserInfo =  purchaseRecApprDAO.checkPurchaseUser(data);
                
                if ("0".equals(StringUtil.isNullToString(purchaseUserInfo.get("CNT")))) {
            		paramMap.put("SUCC_YN", "N");
            		paramMap.put("ERR_MSG", "구매담당자로 등록되지 않은 사용자입니다. 확인 후 작업하세요.");
            		// 강제로 Exception 발생
            		throw new Exception("구매담당자로 등록되지 않은 사용자입니다. 확인 후 작업하세요.");
                }    			
    			
    			purchaseRecApprDAO.returnReceived(data);
    			
        		// 반려 이력에 사용할 용도 데이터 셋팅
        		data.put("REMARK", remark); 
        		data.put("DOC_STATUS", "3");
                // 이력 남기기
                commonDAO.insertDeliveryHistory(data);    			
    		}
    	}
    	
    	return paramMap;
    }
    
}