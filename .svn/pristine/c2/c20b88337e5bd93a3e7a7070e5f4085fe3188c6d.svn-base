package com.app.ildong.bdg.service;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;
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

import com.app.ildong.bdg.dao.BdgApmTransMgtDAO;
import com.app.ildong.common.dao.CommonDAO;
import com.app.ildong.common.dao.CommonSelectDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.common.util.StringUtil;

@Service("bdgApmTransMgtService")
public class BdgApmTransMgtService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BdgApmTransMgtDAO bdgApmTransMgtDAO;
	
    @Autowired
    private CommonDAO commonDAO;	
	
    @Autowired
    private CommonSelectDAO commonSelectDAO;	
	
	@Autowired
	private DataSourceTransactionManager transactionManager;	
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectApmTransMgtHeadList(Map<String, Object> paramMap){
		return bdgApmTransMgtDAO.selectApmTransMgtHeadList(paramMap);
	}
	
	public List<Map<String, Object>> selectApmTransMgtDetailList(Map<String, Object> paramMap){
		return bdgApmTransMgtDAO.selectApmTransMgtDetailList(paramMap);
	}
	
	public Map<String, Object> selectStatusHeader(Map<String, Object> paramMap) {
        return bdgApmTransMgtDAO.selectStatusHeader(paramMap);
    }
	
	public Map<String, Object> selectStatusCnt(Map<String, Object> paramMap) {
        return bdgApmTransMgtDAO.selectStatusCnt(paramMap);
    }		
	
    public Map<String,Object> saveApmTransMgt(Map<String,Object> paramMap) throws ServiceException, Exception {
        
    	Map<String, Object> headMap          = (Map<String, Object>) paramMap.get("HEAD_LIST");
    	Map<String, Object> detailMap        = (Map<String, Object>) paramMap.get("DETAIL_LIST");
    	List<Map<String, Object>> headList   = (List<Map<String, Object>>) headMap.get("CHECK_LIST");
    	List<Map<String, Object>> detailList = (List<Map<String, Object>>) detailMap.get("CHECK_LIST");
    	
		DefaultTransactionDefinition def =  new DefaultTransactionDefinition();
		def.setName("saveApmTransMgt-Transaction");
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRES_NEW);
		TransactionStatus status = transactionManager.getTransaction(def);
        
		try {
	        // header 저장로직
	        if (null != headList && 0 < headList.size()) {
	            for (Map<String, Object> data: headList) {
	            	
	            	data.put("GUBN" , paramMap.get("GUBN").toString());
	            	Map<String, Object> retrunParam = bdgApmTransMgtDAO.selectFlagYn(data);
	            	
                	if ("N".equals(retrunParam.get("FLAG_YN").toString())) {
                		// 강제로 Exception 발생
                		paramMap.put("SUCC_YN", "N");
                		paramMap.put("ERR_MSG", "작성중 상태에서 저장가능합니다.");                		
                		throw new Exception("작성중인 상태에서 저장가능합니다.");                		
                	} else {
                		
    	                data.put("CRE_USER"   , getUserId());
    	                data.put("MOD_USER"   , getUserId());
    	                
                		bdgApmTransMgtDAO.saveApmTransHeadMgt(data);
                	}
                	
	            }
	        }
	        // detail 저장로직
	        if (null != detailList && 0 < detailList.size()) {
	            for (Map<String, Object> data: detailList) {
	            	
	                data.put("CRE_USER"   , getUserId());
	                data.put("MOD_USER"   , getUserId());
	                
            		bdgApmTransMgtDAO.saveApmTransDetailMgt(data);
	            }
	        }	        
	        
            transactionManager.commit(status);
            paramMap.put("SUCC_YN", "Y");
            
		} catch (Exception e1) {
			transactionManager.rollback(status);
		}
        
    	return paramMap;
    }
    
    public Map<String,Object> deleteApmTransMgt(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	Map<String, Object> deleteMap   = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> deleteList   = (List<Map<String, Object>>) deleteMap.get("DELETED");
        
		DefaultTransactionDefinition def =  new DefaultTransactionDefinition();
		def.setName("deleteApmTransMgt-Transaction");
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRES_NEW);
		TransactionStatus status = transactionManager.getTransaction(def);
        
		try {
	        // 삭제로직
	        if (null != deleteList && 0 < deleteList.size()) {
	            for (Map<String, Object> data: deleteList) {
	            	
	            	data.put("GUBN" , paramMap.get("GUBN").toString());
	            	Map<String, Object> retrunParam = bdgApmTransMgtDAO.selectFlagYn(data);
	            	
                	if ("N".equals(retrunParam.get("FLAG_YN").toString())) {
                		// 강제로 Exception 발생
                		paramMap.put("SUCC_YN", "N");
                		paramMap.put("ERR_MSG", "작성중 상태에서 삭제가능합니다.");                		
                		throw new Exception("작성중인 상태에서 삭제가능합니다.");                		
                	} else {
                		
    	                data.put("CRE_USER"   , getUserId());
    	                data.put("MOD_USER"   , getUserId());
    	                
                		 bdgApmTransMgtDAO.deleteApmTransHeadMgt(data);
                		 bdgApmTransMgtDAO.deleteApmTransDetailMgt(data);
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
    
    public Map<String,Object> apprApmBasicMgt(Map<String,Object> paramMap) throws ServiceException, Exception {

		paramMap.put("COMP_CD"    , paramMap.get("SB_COMP_CD"));
		paramMap.put("CRTN_YYMM"  , paramMap.get("TB_CRTN_YYMM"));
		paramMap.put("ORG_CD"     , paramMap.get("TB_ORG_CD"));
		
		paramMap.put("DOC_GUBN"   , "JR"); // DOC_GUBN 변경 필요
		
		paramMap.put("SABUN"      , getUserId());
    	paramMap.put("CRE_USER"   , getUserId());
    	paramMap.put("MOD_USER"   , getUserId());
    	
    	// HEAD정보 기준으로 문서관리번호 채번
    	Map<String, Object> docNoInfo = commonSelectDAO.selectDocNo(paramMap);
    	
    	paramMap.put("EPS_DOC_NO" , docNoInfo.get("DOC_NO")); // DOC_GUBN 변경 필요
    	commonDAO.insertEpsHistory(paramMap);

    	paramMap.put("STATUS"   , "2"); // 상태코드 변경처리
    	bdgApmTransMgtDAO.apprApmTransMgt(paramMap);
    	
    	return paramMap;
    }    
    
    public Map<String,Object> updatApmTransMgtStatus(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	Map<String, Object> dataMap        = (Map<String, Object>) paramMap.get("HEAD_LIST");
    	List<Map<String, Object>> dataList = (List<Map<String, Object>>) dataMap.get("CHECK_LIST");
        
		DefaultTransactionDefinition def =  new DefaultTransactionDefinition();
		def.setName("updatApmTransMgtStatus-Transaction");
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRES_NEW);
		TransactionStatus status = transactionManager.getTransaction(def);
        
		try {
	        // 상태변경 처리 로직
	        if (null != dataList && 0 < dataList.size()) {
	            for (Map<String, Object> data: dataList) {
	            	// 기본값 셋팅
	            	// 확정은 ROW 데이터의 값에 따라 분기처리[확정/재작성확정 처리]
	            	data.put("GUBN" , paramMap.get("GUBN").toString());
	                if ("SA".equals(paramMap.get("GUBN").toString())) {
	                	data.put("STATUS" , "5");
	                } else if ("RR".equals(paramMap.get("GUBN").toString())) {
	                	data.put("STATUS" , "6");
	                } else if ("RC".equals(paramMap.get("GUBN").toString())) {
	                	data.put("STATUS" , "7");
	                }
	            	
	                // 상태체크
	            	Map<String, Object> retrunParam = bdgApmTransMgtDAO.selectFlagYn(data);
                	if ("N".equals(retrunParam.get("FLAG_YN").toString())) {
                		// 강제로 Exception 발생
                		paramMap.put("SUCC_YN", "N");
                		
                		if ("SA".equals(data.get("GUBN").toString())) {
                			paramMap.put("ERR_MSG", "확정은 작성중 상태에서 가능합니다."); 
    	                } else if ("RR".equals(data.get("GUBN").toString())) {
    	                	paramMap.put("ERR_MSG", "재작성요청은 확정 상태에서 가능합니다."); 
    	                } else if ("RC".equals(data.get("GUBN").toString())) {
    	                	paramMap.put("ERR_MSG", "재작성확정은 재작성요청 상태에서 가능합니다."); 
    	                }
                		throw new Exception(paramMap.get("ERR_MSG").toString());                		
                	} else {
                		
                        data.put("CRE_USER" , getUserId());
                        data.put("MOD_USER" , getUserId());
                        
                    	//STATUS는 화면의 버튼 기능에 가변적으로 처리
                    	// 상태 UPDATE!!                
                        bdgApmTransMgtDAO.updatApmTransMgtStatus(data);
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
    
    public Map<String,Object> updatApmTransMgtStatus2(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	List<Map<String, Object>> dataList = (List<Map<String, Object>>) paramMap.get("ITEM_LIST");
        
		try {
	        // 삭제로직
	        if (null != dataList && 0 < dataList.size()) {
	        	
	        	String SYS_MGMT_NO = "";
	        	int cnt = 1;
	            for (Map<String, Object> data: dataList) {
	            	
                    data.put("CRE_USER" , getUserId());
                    data.put("MOD_USER" , getUserId());
                    
                    if (cnt == 1) {
                    	//STATUS는 화면의 버튼 기능에 가변적으로 처리
                    	// 상태 UPDATE!!
                        bdgApmTransMgtDAO.updatApmTransMgtStatus3(data);
                        SYS_MGMT_NO = data.get("SYS_MGMT_NO").toString();
                        //System.out.println("SYS_MGMT_NO(1)::" + SYS_MGMT_NO);
                    } else {
                    	if (SYS_MGMT_NO.equals(data.get("SYS_MGMT_NO").toString())) {
                    		// 동일한 이관사번정보는 한번만  UPDATE!!!
                    		//System.out.println("SYS_MGMT_NO일치(" + cnt + ")::" + data.get("SYS_MGMT_NO").toString());
                    	} else {
                            bdgApmTransMgtDAO.updatApmTransMgtStatus3(data);
                            SYS_MGMT_NO = data.get("SYS_MGMT_NO").toString();
                            //System.out.println("SYS_MGMT_NO불일치(" + cnt + ")::" + data.get("SYS_MGMT_NO").toString());
                    	}
                    }
                    
                    cnt++;
	            }
	        }
	        
            paramMap.put("SUCC_YN", "Y");
            
		} catch (Exception e1) {
			paramMap.put("SUCC_YN", "N");
			paramMap.put("ERR_MSG", "SAP전송 후 상태변경에 실패했습니다."); 
		}
        
    	return paramMap;
    }    
    
	public List<Map<String, Object>> selectSendApmTransData(Map<String, Object> paramMap){
		
		List<Map<String, Object>> dataList = bdgApmTransMgtDAO.selectSendApmTransData(paramMap);
		List<Map<String, Object>> sendList = new ArrayList<Map<String, Object>>(); 
		
		String oldCompCd    = "";
		String oldCrtnYyMm  = "";
		String oldOrgCd     = "";
		String oldChcEtcGbn = "";
		String oldSendSabun = "";
		
		int cnt = 1;
		String DOC_NO = "";
        for (Map<String, Object> data: dataList) {
        	
    		DefaultTransactionDefinition def =  new DefaultTransactionDefinition();
    		def.setName("selectSendApmTransData-" + cnt + "-Transaction");
    		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRES_NEW);
    		TransactionStatus status = transactionManager.getTransaction(def); 
    		
    		data.put("DOC_GUBN", "T");
    		
    		if (cnt == 1) {
    			oldCompCd    = data.get("COMP_CD").toString();
    			oldCrtnYyMm  = data.get("CRTN_YYMM").toString();
    			oldOrgCd     = data.get("ORG_CD").toString();
    			oldChcEtcGbn = data.get("CHC_ETC_GBN").toString();
    			oldSendSabun = data.get("SEND_SABUN").toString();
    			
            	// HEAD정보 기준으로 시스템관리번호  채번후 전송
            	Map<String, Object> docNoInfo = commonSelectDAO.selectDocNo(data);
            	DOC_NO = docNoInfo.get("DOC_NO").toString();
            	data.put("LEGACYNO", DOC_NO);
            	data.put("SYS_MGMT_NO", DOC_NO);
            	sendList.add(data);    			
    		} else {
    			// PK가 같은 경우는 동일한 시스템관리번호로 채번
    			if (   oldCompCd.equals(data.get("COMP_CD").toString())
    				&& oldCrtnYyMm.equals(data.get("CRTN_YYMM").toString())
    				&& oldOrgCd.equals(data.get("ORG_CD").toString())
    				&& oldChcEtcGbn.equals(data.get("CHC_ETC_GBN").toString())
    				&& oldSendSabun.equals(data.get("SEND_SABUN").toString())) {
                	data.put("LEGACYNO", DOC_NO);
                	data.put("SYS_MGMT_NO", DOC_NO);
                	sendList.add(data); 
    			} else {
    				
    				// HEAD정보 기준으로 시스템관리번호  채번후 전송
                	Map<String, Object> docNoInfo = commonSelectDAO.selectDocNo(data);
                	DOC_NO = docNoInfo.get("DOC_NO").toString();
                	data.put("LEGACYNO", DOC_NO);
                	data.put("SYS_MGMT_NO", DOC_NO);
                	sendList.add(data);     				
    				
    				// 다른경우 비교 값에 등록
        			oldCompCd    = data.get("COMP_CD").toString();
        			oldCrtnYyMm  = data.get("CRTN_YYMM").toString();
        			oldOrgCd     = data.get("ORG_CD").toString();
        			oldChcEtcGbn = data.get("CHC_ETC_GBN").toString();
        			oldSendSabun = data.get("SEND_SABUN").toString();
    			}
    		}
        	
        	cnt++;
        	transactionManager.commit(status);
        }
        
		return sendList;
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
    	bdgApmTransMgtDAO.updateStatus(paramMap);
    	return paramMap;
    }
    
	public List<Map<String, Object>> selectApmTransMgtPop(Map<String, Object> paramMap){
		return bdgApmTransMgtDAO.selectApmTransMgtPop(paramMap);
	} 

    public Map<String,Object> rejectApmTransMgt(Map<String,Object> paramMap) throws ServiceException, Exception {
    	paramMap.put("MOD_USER"   , getUserId());
    	bdgApmTransMgtDAO.rejectApmTransMgt(paramMap);
    	return paramMap;
    }  	
    
}