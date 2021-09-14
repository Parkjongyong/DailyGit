package com.app.ildong.bdg.service;

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

import com.app.ildong.bdg.dao.BdgApmBasicMgtDAO;
import com.app.ildong.common.dao.CommonDAO;
import com.app.ildong.common.dao.CommonSelectDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.common.util.StringUtil;
import org.apache.commons.codec.binary.Base64;
@Service("BdgApmBasicMgtService")
public class BdgApmBasicMgtService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BdgApmBasicMgtDAO apmBasicMgt;
	
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
	public List<Map<String, Object>> selectApmBasicMgt(Map<String, Object> paramMap){
		return apmBasicMgt.selectApmBasicMgt(paramMap);
	}
	
	public Map<String, Object> selectCheckStatusApmBasic(Map<String, Object> paramMap){
		return apmBasicMgt.selectCheckStatusApmBasic(paramMap);
	}
	
	public Map<String, Object> selectStatusHeader(Map<String, Object> paramMap) {
        return apmBasicMgt.selectStatusHeader(paramMap);
    }
	
	public Map<String, Object> selectStatusCnt(Map<String, Object> paramMap) {
        return apmBasicMgt.selectStatusCnt(paramMap);
    }	
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectApmBasicMgtM(Map<String, Object> paramMap){
		return apmBasicMgt.selectApmBasicMgt(paramMap);
	}
	
	public List<Map<String, Object>> selectOpAccountList(Map<String, Object> paramMap){
		return apmBasicMgt.selectOpAccountList(paramMap);
	}
	
	public List<Map<String, Object>> selectOpDeptList(Map<String, Object> paramMap){
		return apmBasicMgt.selectOpDeptList(paramMap);
	}
	
	public List<Map<String, Object>> selectSendApmBasicMgt(Map<String, Object> paramMap){
		
		List<Map<String, Object>> dataList = apmBasicMgt.selectSendApmBasicMgt(paramMap);
		List<Map<String, Object>> sendList = new ArrayList<Map<String, Object>>(); 
		
		int cnt = 1;
		
        for (Map<String, Object> data: dataList) {
        	
    		DefaultTransactionDefinition def =  new DefaultTransactionDefinition();
    		def.setName("selectSendApmBasicMgt-" + cnt + "-Transaction");
    		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRES_NEW);
    		TransactionStatus status = transactionManager.getTransaction(def);
    		
        	Map<String, Object> docNoInfo = new HashMap<>();
        	// 전송건별로 시스템관리번호  채번후 전송
        	docNoInfo = commonSelectDAO.selectDocNo(data);
        	data.put("LEGACYNO"   , docNoInfo.get("DOC_NO").toString());
        	data.put("SYS_MGMT_NO", docNoInfo.get("DOC_NO").toString());
        	sendList.add(data);
        	cnt++;
        	transactionManager.commit(status);
        }
        
        
        
		return sendList;
	}	
	
    public Map<String,Object> delApmBasicMgt(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	Map<String, Object> dataMap       = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> delList = (List<Map<String, Object>>)dataMap.get("DELETED");
    	if (null != delList && 0 < delList.size()) {
    		for (Map<String, Object> data: delList) {
    			apmBasicMgt.delApmBasicMgt(data);
    		}
    	}
        
    	
    	return paramMap;
    }
    
    public Map<String,Object> confirmApmBasicMgt(Map<String,Object> paramMap) throws ServiceException, Exception {
        Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
        List<Map<String, Object>> updList = (List<Map<String, Object>>)dataMap.get("CHECK_LIST");
        
        if (null != updList && 0 < updList.size()) {
            for (Map<String, Object> updData: updList) {
            	updData.put("MOD_USER"   , getUserId());
            	apmBasicMgt.confirmApmBasicMgt(updData);
            }
        }
    	
    	return paramMap;
    }

    public Map<String,Object> confirmCancelApmBasicMgt(Map<String,Object> paramMap) throws ServiceException, Exception {
    	Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> updList = (List<Map<String, Object>>)dataMap.get("UPDATED");
    	
    	if (null != updList && 0 < updList.size()) {
    		for (Map<String, Object> updData: updList) {
    			updData.put("MOD_USER"   , getUserId());
    			apmBasicMgt.confirmCancelApmBasicMgt(updData);
    		}
    	}
    	
    	return paramMap;
    }
    
    public Map<String,Object> saveApmBasicMgt(Map<String,Object> paramMap) throws ServiceException, Exception {
        
        Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
        List<Map<String, Object>> updList = (List<Map<String, Object>>)dataMap.get("UPDATED");
        List<Map<String, Object>> insList = (List<Map<String, Object>>)dataMap.get("CREATED");
        
        if (null != updList && 0 < updList.size()) {
            for (Map<String, Object> updData: updList) {
            	updData.put("MOD_USER"   , getUserId());
            	apmBasicMgt.updateApmBasicMgt(updData);
            }
        }        
        
        if (null != insList && 0 < insList.size()) {
            for (Map<String, Object> insData: insList) {
            	insData.put("CRE_USER"   , getUserId());
            	insData.put("MOD_USER"   , getUserId());
            	apmBasicMgt.insertApmBasicMgt(insData);
            }
        }
    	return paramMap;
    }
 
	public List<Map<String, Object>> selectApmBasicMgtAmt(Map<String, Object> paramMap){
		return apmBasicMgt.selectApmBasicMgtAmt(paramMap);
	}
	
    public Map<String,Object> apprApmBasicMgt(Map<String,Object> paramMap) throws ServiceException, Exception {

		paramMap.put("COMP_CD"    , paramMap.get("SB_COMP_CD"));
		paramMap.put("CRTN_YYMM"  , paramMap.get("TB_CRTN_YYMM"));
		paramMap.put("ORG_CD"     , paramMap.get("TB_DEPT_CD"));
		
		paramMap.put("DOC_GUBN"   , "JA"); // DOC_GUBN 변경 필요
		
		paramMap.put("SABUN"      , getUserId());
    	paramMap.put("CRE_USER"   , getUserId());
    	paramMap.put("MOD_USER"   , getUserId());
    	
    	// HEAD정보 기준으로 문서관리번호 채번
    	Map<String, Object> docNoInfo = commonSelectDAO.selectDocNo(paramMap);
    	
    	paramMap.put("EPS_DOC_NO" , docNoInfo.get("DOC_NO")); // DOC_GUBN 변경 필요
    	commonDAO.insertEpsHistory(paramMap);

    	paramMap.put("STATUS"   , "2"); // 상태코드 변경처리
    	apmBasicMgt.apprApmBasicMgt(paramMap);
    	
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
    	apmBasicMgt.updateStatus(paramMap);
    	return paramMap;
    }    
	
    public Map<String,Object> returnApmBasicMgt(Map<String,Object> paramMap) throws ServiceException, Exception {
        Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
        List<Map<String, Object>> updList = (List<Map<String, Object>>)dataMap.get("CHECK_LIST");
    	
        if (null != updList && 0 < updList.size()) {
            for (Map<String, Object> updData: updList) {
            	updData.put("MOD_USER"   , getUserId());
            	apmBasicMgt.returnApmBasicMgt(updData);
            }
        }        
    	
    	return paramMap;
    }
    
    public Map<String,Object> rejectApmBasicMgt(Map<String,Object> paramMap) throws ServiceException, Exception {
    	paramMap.put("MOD_USER"   , getUserId());
    	apmBasicMgt.rejectApmBasicMgt(paramMap);
    	return paramMap;
    }    
 
    public Map<String,Object> updateApmBasicMgtSap(Map<String,Object> paramMap, List<Map<String, Object>> dataList) throws ServiceException, Exception {
    	
		try {
	        // 상태코드 변경 처리
	        if (null != dataList && 0 < dataList.size()) {
	            for (Map<String, Object> data: dataList) {
	            	// 기본값 셋팅
	            	
                    data.put("CRE_USER" , getUserId());
                    data.put("MOD_USER" , getUserId());
                    
                	//STATUS는 화면의 버튼 기능에 가변적으로 처리
                	// 상태 UPDATE!!                
                    apmBasicMgt.updateApmBasicMgtSap(data);
	            }
	        }
	        
            paramMap.put("SUCC_YN", "Y");
            
		} catch (Exception e1) {
			paramMap.put("SUCC_YN", "N");
			paramMap.put("ERR_MSG", "SAP전송 후 상태변경에 실패했습니다."); 
		}
        
    	return paramMap;    	
    	
    }

    public Map<String,Object> sendApmBasicMgt(Map<String,Object> paramMap) throws ServiceException, Exception {
    	Map<String, Object> dataMap = new HashMap<String, Object>();
    	dataMap.put("COMP_CD", paramMap.get("SB_COMP_CD"));
    	dataMap.put("CRTN_YMD", paramMap.get("TB_CRTN_YMD"));
    	dataMap.put("CRE_USER"   , getUserId());
    	dataMap.put("MOD_USER"   , getUserId());
		int cnt = apmBasicMgt.sendCheckCnt(dataMap);
		if(cnt > 0) {
			throw new Exception("기등록된 데이터가 존재합니다. 전송취소 후 작업하세요.");
		} else {
			apmBasicMgt.sendApmBasicMgt(dataMap);
		}
    	
    	return paramMap;
    }
    
    public Map<String,Object> sendCancelApmBasicMgt(Map<String,Object> paramMap) throws ServiceException, Exception {
    	Map<String, Object> dataMap = new HashMap<String, Object>();
    	dataMap.put("COMP_CD", paramMap.get("SB_COMP_CD"));
    	dataMap.put("CRTN_YMD", paramMap.get("TB_CRTN_YMD"));
    	dataMap.put("CRE_USER"   , getUserId());
    	dataMap.put("MOD_USER"   , getUserId());
    	int cnt = apmBasicMgt.sendCheckCnt(dataMap);
    	if(cnt == 0) {
    		throw new Exception("전송취소 할 데이터가 존재하지 않습니다.");
    	} else {
    		apmBasicMgt.sendCancelApmBasicMgt(dataMap);
    	}
    	
    	return paramMap;
    }
    
    public Map<String,Object> makeApmIfData(Map<String,Object> paramMap, List<Map<String, Object>> apmIfList) throws ServiceException, Exception {

    	// 기등록 데이터 삭제
    	apmBasicMgt.delAllApmIf(paramMap);
    	apmBasicMgt.delAllApmBasicMgt(paramMap);
    	
    	if (null != apmIfList && 0 < apmIfList.size()) {
    		for (Map<String, Object> data: apmIfList) {
    			data.put("CRE_USER"   , getUserId());
    			data.put("MOD_USER"   , getUserId());    			
    			data.put("ORG_CD"     , paramMap.get("TB_DEPT_CD"));
    			data.put("TB_CRTN_YYMM" , paramMap.get("TB_CRTN_YYMM"));
    			apmBasicMgt.insertApmIf(data);
    			apmBasicMgt.insertApmBasic(data);
    		}
    	}    	
    	
    	return paramMap;
    }
 
    
	public List<Map<String, Object>> selectApmBasicMgtPop(Map<String, Object> paramMap){
		return apmBasicMgt.selectApmBasicMgtPop(paramMap);
	}

}