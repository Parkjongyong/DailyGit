package com.app.ildong.bdg.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.app.ildong.bdg.dao.BdgVendBankMgtDAO;
import com.app.ildong.common.dao.CommonDAO;
import com.app.ildong.common.dao.CommonSelectDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.common.util.StringUtil;

@Service("bdgVendBankMgtService")
public class BdgVendBankMgtService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BdgVendBankMgtDAO bdgVendBankMgtDAO;
	
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
	public List<Map<String, Object>> selectVendBankMgtHeadList(Map<String, Object> paramMap){
		return bdgVendBankMgtDAO.selectVendBankMgtHeadList(paramMap);
	}
	
	public List<Map<String, Object>> selectApprVendBankList(Map<String, Object> paramMap){
		return bdgVendBankMgtDAO.selectApprVendBankList(paramMap);
	}	
	
	public List<Map<String, Object>> selectVendBankMgtDetailList(Map<String, Object> paramMap){
		return bdgVendBankMgtDAO.selectVendBankMgtDetailList(paramMap);
	}
	
	public List<Map<String, Object>> selectVendBankMgtHeadListPop(Map<String, Object> paramMap){
		return bdgVendBankMgtDAO.selectVendBankMgtHeadListPop(paramMap);
	}
	
	public List<Map<String, Object>> selectVendBankMgtDetailListPop(Map<String, Object> paramMap){
		return bdgVendBankMgtDAO.selectVendBankMgtDetailListPop(paramMap);
	}	
	
	public List<Map<String, Object>> selectSendVendBankData(Map<String, Object> paramMap){
		return bdgVendBankMgtDAO.selectSendVendBankData(paramMap);
	}
	
	public Map<String, Object> selectCheckVendBankMgt(Map<String, Object> paramMap) {
        return bdgVendBankMgtDAO.selectCheckVendBankMgt(paramMap);
    }	
	
    public Map<String,Object> saveVendBankMgt(Map<String,Object> paramMap) throws ServiceException, Exception {
        
    	Map<String, Object> headMap          = (Map<String, Object>) paramMap.get("HEAD_LIST");
    	Map<String, Object> detailMap        = (Map<String, Object>) paramMap.get("DETAIL_LIST");
    	List<Map<String, Object>> headList   = (List<Map<String, Object>>) headMap.get("CHECK_LIST");
    	List<Map<String, Object>> detailList = (List<Map<String, Object>>) detailMap.get("ALLDATA");
    	
		DefaultTransactionDefinition def =  new DefaultTransactionDefinition();
		def.setName("saveVendBankMgt-Transaction");
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRES_NEW);
		TransactionStatus status = transactionManager.getTransaction(def);
        
		try {
	        // header 저장로직
	        if (null != headList && 0 < headList.size()) {
	            for (Map<String, Object> data: headList) {
	            	
	            	Map<String, Object> retrunParam = bdgVendBankMgtDAO.selectHeadFlagYn(data);
	            	
                	if ("N".equals(retrunParam.get("FLAG_YN").toString())) {
                		// 강제로 Exception 발생
                		paramMap.put("SUCC_YN", "N");
                		paramMap.put("ERR_MSG", "작성중 상태에서 저장가능합니다.");                		
                		throw new Exception("작성중인 상태에서 저장가능합니다.");                		
                	} else {
                		
    	                data.put("CRE_USER"   , getUserId());
    	                data.put("MOD_USER"   , getUserId());
    	                
                		bdgVendBankMgtDAO.saveVendBankHeadMgt(data);
                	}
                	
	            }
	        }
	        
	        // detail 저장로직
	        if (null != detailList && 0 < detailList.size()) {
	            for (Map<String, Object> data: detailList) {
	            	
	            	data.put("GUBN" , paramMap.get("GUBN").toString());
	            	Map<String, Object> retrunParam = bdgVendBankMgtDAO.selectDetailFlagYn(data);	
	            	
                	if ("N".equals(retrunParam.get("FLAG_YN").toString())) {
                		// 강제로 Exception 발생
                		paramMap.put("SUCC_YN", "N");
                		paramMap.put("ERR_MSG", "작성중 상태에서 저장가능합니다.");                		
                		throw new Exception("작성중인 상태에서 저장가능합니다.");                		
                	} else {
                		
    	                data.put("CRE_USER"   , getUserId());
    	                data.put("MOD_USER"   , getUserId());
    	                
                		bdgVendBankMgtDAO.saveVendBankDetailMgt(data);
                	}	            	
	            }
	        }
	        
            transactionManager.commit(status);
            paramMap.put("SUCC_YN", "Y");
            
		} catch (Exception e1) {
			transactionManager.rollback(status);
		}
        
    	return paramMap;
    }
    
    public Map<String,Object> deleteVendBankMgt(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	Map<String, Object> deleteMap   = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> deleteList   = (List<Map<String, Object>>) deleteMap.get("DELETED");
        
		DefaultTransactionDefinition def =  new DefaultTransactionDefinition();
		def.setName("deleteVendBankHeadMgt-Transaction");
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRES_NEW);
		TransactionStatus status = transactionManager.getTransaction(def);
        
		try {
	        // 삭제로직
	        if (null != deleteList && 0 < deleteList.size()) {
	            for (Map<String, Object> data: deleteList) {
	            	
	            	data.put("GUBN" , paramMap.get("GUBN").toString());
	            	Map<String, Object> retrunParam = bdgVendBankMgtDAO.selectHeadFlagYn(data);
	            	
                	if ("N".equals(retrunParam.get("FLAG_YN").toString())) {
                		// 강제로 Exception 발생
                		paramMap.put("SUCC_YN", "N");
                		paramMap.put("ERR_MSG", "작성중 상태에서 삭제가능합니다.");                		
                		throw new Exception("작성중인 상태에서 삭제가능합니다.");                		
                	} else {
                		
    	                data.put("CRE_USER"   , getUserId());
    	                data.put("MOD_USER"   , getUserId());
    	                
                		 bdgVendBankMgtDAO.deleteVendBankHeadMgt(data);
                		 // detail 일괄 삭제
                		 bdgVendBankMgtDAO.deleteVendBankDetailMgt2(data);
                	}
	            }
	        }
	        
            transactionManager.commit(status);
            paramMap.put("SUCC_YN", "Y");	        
		} catch (Exception e1) {
			transactionManager.rollback(status);
		}
        
    	return paramMap;
    }
    
    public Map<String,Object> deleteVendBankDetailMgt(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	Map<String, Object> deleteMap   = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> deleteList   = (List<Map<String, Object>>) deleteMap.get("DELETED");
        
		DefaultTransactionDefinition def =  new DefaultTransactionDefinition();
		def.setName("deleteVendBankDetailMgt-Transaction");
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRES_NEW);
		TransactionStatus status = transactionManager.getTransaction(def);
        
		try {
	        // 삭제로직
	        if (null != deleteList && 0 < deleteList.size()) {
	            for (Map<String, Object> data: deleteList) {
	            	
	            	data.put("GUBN" , paramMap.get("GUBN").toString());
	            	Map<String, Object> retrunParam = bdgVendBankMgtDAO.selectDetailFlagYn(data);
	            	
                	if ("N".equals(retrunParam.get("FLAG_YN").toString())) {
                		// 강제로 Exception 발생
                		paramMap.put("SUCC_YN", "N");
                		paramMap.put("ERR_MSG", "작성중 상태에서 삭제가능합니다.");                		
                		throw new Exception("작성중인 상태에서 삭제가능합니다.");                		
                	} else {
                		
    	                data.put("CRE_USER"   , getUserId());
    	                data.put("MOD_USER"   , getUserId());
    	                
                		 // detail 일괄 삭제
                		 bdgVendBankMgtDAO.deleteVendBankDetailMgt(data);
                	}
	            }
	        }
	        
            transactionManager.commit(status);
            paramMap.put("SUCC_YN", "Y");	        
		} catch (Exception e1) {
			transactionManager.rollback(status);
		}
        
    	return paramMap;
    }    
    
    public Map<String,Object> updatDeptSampleMgtStatus(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	Map<String, Object> dataMap        = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> dataList = (List<Map<String, Object>>) dataMap.get("CHECK_LIST");
    	

    	if ("AR".equals(paramMap.get("GUBN").toString())) {
    		paramMap.put("DOC_GUBN"   , "JK"); // DOC_GUBN 변경 필요
        	// HEAD정보 기준으로 문서관리번호 채번
        	Map<String, Object> docNoInfo = commonSelectDAO.selectDocNo(paramMap);
    		paramMap.put("EPS_DOC_NO"   , docNoInfo.get("DOC_NO"));    		
    	}
		
        // 상태변경 처리 로직
        if (null != dataList && 0 < dataList.size()) {
            for (Map<String, Object> data: dataList) {
            		
	            data.put("CRE_USER"   , getUserId());
	            data.put("MOD_USER"   , getUserId());
	            data.put("STATUS"     , paramMap.get("STATUS").toString());
	            data.put("EPS_DOC_NO" , paramMap.get("EPS_DOC_NO").toString());
	            
	        	//STATUS는 화면의 버튼 기능에 가변적으로 처리
	        	// 상태 UPDATE!!                
	            bdgVendBankMgtDAO.updatVendBankMgtStatus(data);
            }
        }
        paramMap.put("USER_ID"    , getUserId());
        commonDAO.insertEpsHistory(paramMap);
        
    	return paramMap;
    }
    
    public Map<String,Object> updatSendFlag(Map<String,Object> paramMap) throws ServiceException, Exception {
    	// SAP 전송 Y UPDATE!!!!               
    	bdgVendBankMgtDAO.updatSendFlag(paramMap);
    	return paramMap;
    } 
    
    public Map<String,Object> updatVendBankMgtStatus6(Map<String,Object> paramMap) throws ServiceException, Exception {
    	// SAP전송 실패  UPDATE               
    	bdgVendBankMgtDAO.updatVendBankMgtStatus6(paramMap);
    	return paramMap;
    }    
    
    
    
    public Map<String,Object> saveEpsHistory(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	// 전달받은 데이터 셋팅
    	paramMap.put("EPS_DOC_NO"      , StringUtil.isNullToString(paramMap.get("key")));
    	paramMap.put("EPS_MAIN_KEY"    , StringUtil.isNullToString(paramMap.get("fiid")));
    	paramMap.put("EPS_PROCESS_KEY" , StringUtil.isNullToString(paramMap.get("piid")));
    	paramMap.put("STATUS"          , StringUtil.isNullToString(paramMap.get("appstatus")));
    	paramMap.put("EPS_FORM_ID"     , StringUtil.isNullToString(paramMap.get("legacyFormID")));
    	paramMap.put("APPROVAL_ID"     , StringUtil.isNullToString(paramMap.get("approverId")));
    	paramMap.put("APPROVAL_NAME"   , StringUtil.isNullToString(paramMap.get("approverName")));
    	if(paramMap.get("appComment") == null || paramMap.get("appComment") == "") {
    		paramMap.put("APPROVAL_DESC"   , StringUtil.isNullToString((paramMap.get("appComment"))));	
    	} else {
    		paramMap.put("APPROVAL_DESC"   , Base64.decodeBase64(StringUtil.isNullToString((String) (paramMap.get("appComment")))));	
    	}
    	paramMap.put("APPROVAL_DATE"   , StringUtil.isNullToString(paramMap.get("approverDate")));
    	
    	commonDAO.insertEpsHistory(paramMap);
    	
    	String statusCode = paramMap.get("STATUS").toString();
    	//DRAFT:기안/APPROVAL:결재/COMPLETE:완료/ REJECT:반려/ WITHDRAW:회수
    	if (   "DRAFT".equals(statusCode)
    		|| "APPROVAL".equals(statusCode)) {
    		paramMap.put("STATUS" , "3");
    	} else if ("COMPLETE".equals(statusCode)) {
    		paramMap.put("STATUS" , "5");
    	} else if ("REJECT".equals(statusCode)) {
    		paramMap.put("STATUS" , "4");
    	} else if ("WITHDRAW".equals(statusCode)) {
    		paramMap.put("STATUS" , "1");
    	}    	
    	bdgVendBankMgtDAO.updatVendBankMgtEpsStatus(paramMap);
    	return paramMap;
    }
    
}