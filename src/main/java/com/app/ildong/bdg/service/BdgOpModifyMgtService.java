package com.app.ildong.bdg.service;

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

import com.app.ildong.bdg.dao.BdgOpModifyMgtDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;

@Service("bdgOpModifyMgtService")
public class BdgOpModifyMgtService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BdgOpModifyMgtDAO bdgOpModifyMgtDAO;
	
	@Autowired
	private DataSourceTransactionManager transactionManager;	
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectOpModifyMgtList(Map<String, Object> paramMap){
		return bdgOpModifyMgtDAO.selectOpModifyMgtList(paramMap);
	}
	
    public Map<String,Object> saveOpModifyMgt(Map<String,Object> paramMap) throws ServiceException, Exception {
        
    	Map<String, Object> saveMap          = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> saveList   = (List<Map<String, Object>>) saveMap.get("CHECK_LIST");
    	
		DefaultTransactionDefinition def =  new DefaultTransactionDefinition();
		def.setName("saveOpModifyMgt-Transaction");
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRES_NEW);
		TransactionStatus status = transactionManager.getTransaction(def);
        
		try {
	        // 저장로직
	        if (null != saveList && 0 < saveList.size()) {
	            for (Map<String, Object> data: saveList) {
	            	
	            	data.put("GUBN"          , paramMap.get("GUBN").toString());
	            	Map<String, Object> retrunParam = bdgOpModifyMgtDAO.selectFlagYn(data);
	            	
                	if ("N".equals(retrunParam.get("FLAG_YN").toString())) {
                		// 강제로 Exception 발생
                		paramMap.put("SUCC_YN", "N");
            			paramMap.put("ERR_MSG", "작성중 상태에서 저장가능합니다.");
            			throw new Exception("작성중인 상태에서 저장가능합니다.");            		
                	} else {
                		
    	                data.put("CRE_USER"   , getUserId());
    	                data.put("MOD_USER"   , getUserId());
    	                
                		bdgOpModifyMgtDAO.saveOpBugtModifyMgmt(data);
                	}
                	
	            }
	            transactionManager.commit(status);
	            paramMap.put("SUCC_YN", "Y");
	        }
		} catch (Exception e1) {
			transactionManager.rollback(status);
		}
        
    	return paramMap;
    }
    
    public Map<String,Object> deleteOpModifyMgt(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	Map<String, Object> deleteMap   = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> deleteList   = (List<Map<String, Object>>) deleteMap.get("DELETED");
        
		DefaultTransactionDefinition def =  new DefaultTransactionDefinition();
		def.setName("saveOpModifyMgt-Transaction");
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRES_NEW);
		TransactionStatus status = transactionManager.getTransaction(def);
        
		try {
	        // 삭제로직
	        if (null != deleteList && 0 < deleteList.size()) {
	            for (Map<String, Object> data: deleteList) {
	            	
	            	data.put("GUBN"          , paramMap.get("GUBN").toString());
	            	Map<String, Object> retrunParam = bdgOpModifyMgtDAO.selectFlagYn(data);
	            	
                	if ("N".equals(retrunParam.get("FLAG_YN").toString())) {
                		// 강제로 Exception 발생
                		paramMap.put("SUCC_YN", "N");
            			paramMap.put("ERR_MSG", "작성중 상태에서 삭제가능합니다.");
            			throw new Exception("작성중인 상태에서 삭제가능합니다.");              		
                	} else {
                		
    	                data.put("CRE_USER"   , getUserId());
    	                data.put("MOD_USER"   , getUserId());
    	                
                		 bdgOpModifyMgtDAO.deleteOpBugtModifyMgmt(data);
                	}
                	
	            }
	            transactionManager.commit(status);
	            paramMap.put("SUCC_YN", "Y");
	        }
		} catch (Exception e1) {
			transactionManager.rollback(status);
		}
        
    	return paramMap;
    } 
    
    public Map<String,Object> confirmOpModifyMgt(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	Map<String, Object> retrunParam = bdgOpModifyMgtDAO.selectStatusHeader(paramMap);
        
        // 확정은 작성중에서만 가능
		if ("1".equals(retrunParam.get("STATUS").toString())) {
			paramMap.put("STATUS" , "2");
			paramMap.put("CRE_USER" , getUserId());
			paramMap.put("MOD_USER" , getUserId());
        	//STATUS는 화면의 버튼 기능에 가변적으로 처리
        	// 상태 UPDATE!!                
            bdgOpModifyMgtDAO.confirmOpModifyMgt(paramMap);				
            paramMap.put("SUCC_YN", "Y");
		} else {
			paramMap.put("SUCC_YN", "N");
			paramMap.put("ERR_MSG", "확정은 작성중 상태에서 가능합니다.");
			throw new Exception(paramMap.get("ERR_MSG").toString()); 
		}
		
        return paramMap;
    }
    
    public Map<String,Object> cancelOpModifyMgt(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	Map<String, Object> retrunParam = bdgOpModifyMgtDAO.selectStatusHeader(paramMap);
        
        // 확정취소은 작성중에서만 가능
		if ("2".equals(retrunParam.get("STATUS").toString())) {
			paramMap.put("STATUS" , "1");
			paramMap.put("CRE_USER" , getUserId());
			paramMap.put("MOD_USER" , getUserId());
        	//STATUS는 화면의 버튼 기능에 가변적으로 처리
        	// 상태 UPDATE!!                
            bdgOpModifyMgtDAO.cancelOpModifyMgt(paramMap);				
            paramMap.put("SUCC_YN", "Y");
		} else {
			paramMap.put("SUCC_YN", "N");
			paramMap.put("ERR_MSG", "확정취소는 확정 상태에서 가능합니다.");
			throw new Exception(paramMap.get("ERR_MSG").toString()); 
		}
		
        return paramMap;
    }    
    
    public Map<String,Object> sendCancelOpModifyMgt(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	Map<String, Object> retrunParam = bdgOpModifyMgtDAO.selectBugtDataCount(paramMap);
    	
    	// 기등록 데이터가 존재하지 않는 경우
    	if ("0".equals(retrunParam.get("CNT").toString())) {
    		paramMap.put("SUCC_YN", "N");
    		paramMap.put("ERR_MSG", "전송된 데이터가 존재하지 않습니다. 확인 후 작업하세요."); 
    		throw new Exception(paramMap.get("ERR_MSG").toString());   
    	} else {
    		
            paramMap.put("CRE_USER" , getUserId());
            paramMap.put("MOD_USER" , getUserId());        
        	paramMap.put("STATUS_OLD" , "3");
        	paramMap.put("STATUS_NEW" , "2");    		
        	//기등록된 예산신청정보를 삭제
            bdgOpModifyMgtDAO.deleteOpBugtModifyHead(paramMap);
            bdgOpModifyMgtDAO.deleteOpBugtModifyDetail(paramMap);
        	// 상태 UPDATE!!                
            bdgOpModifyMgtDAO.updateOpModifyMgtStatus2(paramMap); 
    	}
    	
    	paramMap.put("SUCC_YN", "Y");
        return paramMap;
    } 
    
    public Map<String,Object> sendOpModifyMgt(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	Map<String, Object> retrunParam = bdgOpModifyMgtDAO.selectBugtDataCount(paramMap);
    	
    	// 기등록 데이터가 존재하지 않는 경우
    	if (!"0".equals(retrunParam.get("CNT").toString())) {
    		paramMap.put("SUCC_YN", "N");
    		paramMap.put("ERR_MSG", "전송된 데이터가 존재합니다. 전송 취소후 다시 작업하세요."); 
    		throw new Exception(paramMap.get("ERR_MSG").toString()); 
    	} else {
    		
            paramMap.put("CRE_USER" , getUserId());
            paramMap.put("MOD_USER" , getUserId());         
        	paramMap.put("STATUS_OLD" , "2");
        	paramMap.put("STATUS_NEW" , "3");
        	
        	//기등록된 예산신청정보를 삭제
            bdgOpModifyMgtDAO.insertOpBugtModifyHead(paramMap);
            bdgOpModifyMgtDAO.insertOpBugtModifyDetail(paramMap);
        	// 상태 UPDATE!!                
            bdgOpModifyMgtDAO.updateOpModifyMgtStatus2(paramMap);   
    	}
    	paramMap.put("SUCC_YN", "Y");
        return paramMap;
    }
    
	public List<Map<String, Object>> selectOpModifyMgtExcel(Map<String, Object> paramMap) throws ServiceException, Exception {
		paramMap.put("CRE_USER", getUserId());
		return bdgOpModifyMgtDAO.selectOpModifyMgtExcel(paramMap);
	}

    public Map<String,Object> saveOpModifyMgtExcel(Map<String,Object> paramMap) throws ServiceException, Exception {
    	paramMap.put("CRE_USER", getUserId());
		bdgOpModifyMgtDAO.deleteOpModifyMgtExcel(paramMap);
		
		int i = 0;
		Map<String, Object> saveMap          = (Map<String, Object>) paramMap.get("ITEM_LIST");
		List<Map<String, Object>> saveList   = (List<Map<String, Object>>) saveMap.get("CHECK_LIST");
		
        if (paramMap.get("ITEM_LIST") != null) {

            for (Map<String, Object> dataMap : saveList) {
            	dataMap.put("SB_COMP_CD", paramMap.get("SB_COMP_CD"));
            	dataMap.put("TB_CRTN_YY", paramMap.get("TB_CRTN_YY"));
            	dataMap.put("SB_BELONG_CCTR_CD", paramMap.get("SB_BELONG_CCTR_CD"));
            	dataMap.put("CRE_USER", getUserId());
            	dataMap.put("SEQ", i);
                bdgOpModifyMgtDAO.insertOpModifyMgtExcel(dataMap);
            	i++;
            }
        }
		
    	return paramMap;
    }
	
}