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

import com.app.ildong.bdg.dao.BdgDeptSampleMgtDAO;
import com.app.ildong.common.dao.CommonDAO;
import com.app.ildong.common.dao.CommonSelectDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.common.util.StringUtil;
import org.apache.commons.codec.binary.Base64;
@Service("bdgDeptSampleMgtService")
public class BdgDeptSampleMgtService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BdgDeptSampleMgtDAO bdgDeptSampleMgtDAO;
	
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
	public List<Map<String, Object>> selectDeptSampleMgtList(Map<String, Object> paramMap){
		return bdgDeptSampleMgtDAO.selectDeptSampleMgtList(paramMap);
	}
	
	
	public Map<String, Object> selectCctrCode(Map<String, Object> paramMap) {
        return bdgDeptSampleMgtDAO.selectCctrCode(paramMap);
    }	
	
	
	public List<Map<String, Object>> selectDeptSampleMgtListPop(Map<String, Object> paramMap){
		return bdgDeptSampleMgtDAO.selectDeptSampleMgtListPop(paramMap);
	}
	
	public List<Map<String, Object>> selectSendDeptSampleMgtList(Map<String, Object> paramMap){
		return bdgDeptSampleMgtDAO.selectSendDeptSampleMgtList(paramMap);
	}	
	
	public List<Map<String, Object>> selectMatList(Map<String, Object> paramMap){
		return bdgDeptSampleMgtDAO.selectMatList(paramMap);
	}	
	
    public Map<String,Object> saveDeptSampleMgt(Map<String,Object> paramMap) throws ServiceException, Exception {
        
    	Map<String, Object> itemMap          = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> detaList = (List<Map<String, Object>>) itemMap.get("CHECK_LIST");
    	
		DefaultTransactionDefinition def =  new DefaultTransactionDefinition();
		def.setName("saveApmTransMgt-Transaction");
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRES_NEW);
		TransactionStatus status = transactionManager.getTransaction(def);
        
		try {
	        // header ????????????
	        if (null != detaList && 0 < detaList.size()) {
	            for (Map<String, Object> data: detaList) {
	            	
	            	data.put("GUBN" , paramMap.get("GUBN").toString());
	            	Map<String, Object> retrunParam = bdgDeptSampleMgtDAO.selectFlagYn(data);
	            	
                	if ("N".equals(retrunParam.get("FLAG_YN").toString())) {
                		System.out.println("FLAG_YN = N");
                		// ????????? Exception ??????
                		paramMap.put("SUCC_YN", "N");
                		
                		if ("SA".equals(paramMap.get("GUBN").toString())) {
                    		paramMap.put("ERR_MSG", "[?????????/??????] ??????????????? ?????????????????????.");                		
                    		throw new Exception("[?????????/??????] ??????????????? ?????????????????????.");	
                		} else if ("AR".equals(paramMap.get("GUBN").toString())) {
                    		paramMap.put("ERR_MSG", "[?????????] ??????????????? ???????????????????????????.");                		
                    		throw new Exception("[?????????] ??????????????? ???????????????????????????.");	               			
                		}
                		
                	} else {
                		System.out.println("FLAG_YN = Y");
                		// ??????????????? ?????? ?????? ??????
                		if ("XXXXXXXXXX".equals(retrunParam.get("SD_SEND_NO").toString())) {
                			System.out.println("SD_SEND_NO = ''");
                			data.put("TB_TODAY"   , paramMap.get("TB_TODAY").toString());
                			Map<String, Object> sendNoParam = bdgDeptSampleMgtDAO.selectSendNo(data);
                			
                			data.put("SD_SEND_NO"   , sendNoParam.get("SEND_NO"));
                		}
                		
    	                data.put("CRE_USER"   , getUserId());
    	                data.put("MOD_USER"   , getUserId());
    	                
                		bdgDeptSampleMgtDAO.saveDeptSampleMgt(data);
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
    
    public Map<String,Object> deleteDeptSampleMgt(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	Map<String, Object> deleteMap   = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> deleteList   = (List<Map<String, Object>>) deleteMap.get("DELETED");
        
		DefaultTransactionDefinition def =  new DefaultTransactionDefinition();
		def.setName("deleteApmTransMgt-Transaction");
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRES_NEW);
		TransactionStatus status = transactionManager.getTransaction(def);
        
		try {
	        // ????????????
	        if (null != deleteList && 0 < deleteList.size()) {
	            for (Map<String, Object> data: deleteList) {
	            	
	            	data.put("GUBN" , paramMap.get("GUBN").toString());
	            	Map<String, Object> retrunParam = bdgDeptSampleMgtDAO.selectFlagYn(data);
	            	
                	if ("N".equals(retrunParam.get("FLAG_YN").toString())) {
                		// ????????? Exception ??????
                		paramMap.put("SUCC_YN", "N");
                		paramMap.put("ERR_MSG", "????????? ???????????? ?????????????????????.");                		
                		throw new Exception("???????????? ???????????? ?????????????????????.");                		
                	} else {
                		
    	                data.put("CRE_USER"   , getUserId());
    	                data.put("MOD_USER"   , getUserId());
    	                
                		 bdgDeptSampleMgtDAO.deleteDeptSampleMgt(data);
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
    		paramMap.put("DOC_GUBN"   , "JD"); // DOC_GUBN ?????? ??????
        	// HEAD?????? ???????????? ?????????????????? ??????
        	Map<String, Object> docNoInfo = commonSelectDAO.selectDocNo(paramMap);
    		paramMap.put("EPS_DOC_NO"   , docNoInfo.get("DOC_NO"));    		
    	}
		
        // ???????????? ?????? ??????
        if (null != dataList && 0 < dataList.size()) {
            for (Map<String, Object> data: dataList) {
            		
	            data.put("CRE_USER"   , getUserId());
	            data.put("MOD_USER"   , getUserId());
	            data.put("STATUS"     , paramMap.get("STATUS").toString());
	            data.put("EPS_DOC_NO" , paramMap.get("EPS_DOC_NO").toString());
	            
	        	//STATUS??? ????????? ?????? ????????? ??????????????? ??????
	        	// ?????? UPDATE!!                
	            bdgDeptSampleMgtDAO.updatDeptSampleMgtStatus(data);
            }
        }
        paramMap.put("SABUN"   , getUserId());
        paramMap.put("CRE_USER", getUserId());
        commonDAO.insertEpsHistory(paramMap);
        
    	return paramMap;
    }
    
    public Map<String,Object> updatDeptSampleMgtStatus6(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	// ?????? SAP ?????? ?????? UPDATE!!                
        bdgDeptSampleMgtDAO.updatDeptSampleMgtStatus6(paramMap);
    	return paramMap;
    }
    
    public Map<String,Object> updatDeptSampleMgtStatus6All(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	// ?????? SAP ?????? ?????? UPDATE!!                
        bdgDeptSampleMgtDAO.updatDeptSampleMgtStatus6All(paramMap);
    	return paramMap;
    }    
    
    public Map<String,Object> updatSendFlag(Map<String,Object> paramMap) throws ServiceException, Exception {
    	// SAP ?????? Y UPDATE!!!!               
    	bdgDeptSampleMgtDAO.updatSendFlag(paramMap);
    	return paramMap;
    }     
    
	public Map<String, Object> selectDeptSampleStatus(Map<String, Object> paramMap) {
        return bdgDeptSampleMgtDAO.selectDeptSampleStatus(paramMap);
    } 
	
    public Map<String,Object> saveEpsHistory(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	// ???????????? ????????? ??????
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
    	//DRAFT:??????/APPROVAL:??????/COMPLETE:??????/ REJECT:??????/ WITHDRAW:??????
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
    	
    	bdgDeptSampleMgtDAO.updatDeptSampleMgtEpsStatus(paramMap);
    	return paramMap;
    }	
   
}