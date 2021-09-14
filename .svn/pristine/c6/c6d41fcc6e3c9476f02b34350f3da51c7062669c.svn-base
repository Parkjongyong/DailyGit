package com.app.ildong.bdg.service;

import java.util.ArrayList;
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

import com.app.ildong.bdg.dao.BdgCostMgtDAO;
import com.app.ildong.common.dao.CommonDAO;
import com.app.ildong.common.dao.CommonSelectDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.common.util.StringUtil;
import org.apache.commons.codec.binary.Base64;
@Service("bdgCostMgtService")
public class BdgCostMgtService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BdgCostMgtDAO bdgCostMgtDAO;
	
    @Autowired
    private CommonSelectDAO commonSelectDAO;	
    
    @Autowired
    private CommonDAO commonDAO;    
	
	@Autowired
	private DataSourceTransactionManager transactionManager;	
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectCostMgtList(Map<String, Object> paramMap){
		return bdgCostMgtDAO.selectCostMgtList(paramMap);
	}
	
	public List<Map<String, Object>> selectCostMgtListPop(Map<String, Object> paramMap){
		return bdgCostMgtDAO.selectCostMgtListPop(paramMap);
	}
	
    public Map<String,Object> saveCostMgt(Map<String,Object> paramMap) throws ServiceException, Exception {
        
    	
        Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
        List<Map<String, Object>> updList = (List<Map<String, Object>>)dataMap.get("UPDATED");
        List<Map<String, Object>> insList = (List<Map<String, Object>>)dataMap.get("CREATED");
        
        if (null != updList && 0 < updList.size()) {
            for (Map<String, Object> data: updList) {
                data.put("MOD_ID"   , getUserId());
                bdgCostMgtDAO.updateCostMgt(data);
            }
        }
        
        if (null != insList && 0 < insList.size()) {
            for (Map<String, Object> data: insList) {
                data.put("INS_ID"   , getUserId());
                data.put("MOD_ID"   , getUserId());
                bdgCostMgtDAO.insertCostMgt(data);
            }
        }
    	
         paramMap.put("SUCC_YN", "Y");
         return paramMap;
    }
    
    public Map<String,Object> deleteCostMgt(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	Map<String, Object> deleteMap   = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> deleteList   = (List<Map<String, Object>>) deleteMap.get("DELETED");
	        // 삭제로직
        if (null != deleteList && 0 < deleteList.size()) {
            for (Map<String, Object> data: deleteList) {
                data.put("CRE_USER"   , getUserId());
                data.put("MOD_USER"   , getUserId());
                bdgCostMgtDAO.deleteCostMgt(data);
            }
        }
        paramMap.put("SUCC_YN", "Y");	        
    	return paramMap;
    } 
   
}