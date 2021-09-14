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

import com.app.ildong.bdg.dao.BdgEstCostReqDAO;
import com.app.ildong.common.dao.CommonDAO;
import com.app.ildong.common.dao.CommonSelectDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.common.util.StringUtil;
import org.apache.commons.codec.binary.Base64;
@Service("bdgEstCostReqService")
public class BdgEstCostReqService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BdgEstCostReqDAO bdgEstCostReqDAO;
	
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
	public List<Map<String, Object>> selectEstCostReqList(Map<String, Object> paramMap){
		return bdgEstCostReqDAO.selectEstCostReqList(paramMap);
	}
	
	public List<Map<String, Object>> selectEstCostReqListPop(Map<String, Object> paramMap){
		return bdgEstCostReqDAO.selectEstCostReqListPop(paramMap);
	}
	
	public List<Map<String, Object>> selectEstCostReqDetail(Map<String, Object> paramMap){
		return bdgEstCostReqDAO.selectEstCostReqDetail(paramMap);
	}
	
	public Map<String, Object> selectStatusHeader(Map<String, Object> paramMap) {
    	return bdgEstCostReqDAO.selectStatusHeader(paramMap);
    }
	
	public List<Map<String, Object>> selectSendEstCostReqList(Map<String, Object> paramMap){
		return bdgEstCostReqDAO.selectSendEstCostReqList(paramMap);
	}	
	
    public Map<String,Object> saveEstCostReq(Map<String,Object> paramMap) throws ServiceException, Exception {
    	Map<String,Object> docNoMap = new HashMap<>();
    	Map<String,Object> dataMap  = new HashMap<>();
    	
    	if(!"".equals(paramMap.get("TB_REQ_DOC_NO"))) {
    		paramMap.put("CRE_USER" , getUserId());
    		paramMap.put("MOD_USER" , getUserId());
    		bdgEstCostReqDAO.updateEstCostReq(paramMap);
    	} else {
    		docNoMap = bdgEstCostReqDAO.getReqDocNo();
    		paramMap.put("CRE_USER" , getUserId());
    		paramMap.put("MOD_USER" , getUserId());    		
    		paramMap.put("TB_REQ_DOC_NO", docNoMap.get("REQ_DOC_NO"));
    		bdgEstCostReqDAO.insertEstCostReq(paramMap);
    	}
    	
    	bdgEstCostReqDAO.deleteEstCostDetail(paramMap);
    	
    	List<Map<String, Object>> insertList = new ArrayList<Map<String, Object>>();
    	
    	if(!"".equals(paramMap.get("TB_STAND_DESC0"))) {
    		dataMap = new HashMap<>();
    		dataMap.put("SB_COMP_CD"   , paramMap.get("SB_COMP_CD"));
    		dataMap.put("TB_ORG_CD"    , paramMap.get("TB_ORG_CD"));
    		dataMap.put("TB_REQ_DOC_NO", paramMap.get("TB_REQ_DOC_NO"));
    		dataMap.put("TB_STAND_DESC", paramMap.get("TB_STAND_DESC0"));
    		dataMap.put("TB_CTRN_YMD"  , paramMap.get("TB_CTRN_YMD"));
    		insertList.add(dataMap);
    	} 
    	
    	if (!"".equals(paramMap.get("TB_STAND_DESC1"))) {
    		dataMap = new HashMap<>();
    		dataMap.put("SB_COMP_CD"   , paramMap.get("SB_COMP_CD"));
    		dataMap.put("TB_ORG_CD"    , paramMap.get("TB_ORG_CD"));
    		dataMap.put("TB_REQ_DOC_NO", paramMap.get("TB_REQ_DOC_NO"));
    		dataMap.put("TB_STAND_DESC", paramMap.get("TB_STAND_DESC1"));
    		dataMap.put("TB_CTRN_YMD"  , paramMap.get("TB_CTRN_YMD"));
    		insertList.add(dataMap);
    	}
    	
    	if (!"".equals(paramMap.get("TB_STAND_DESC2"))) {
    		dataMap = new HashMap<>();
    		dataMap.put("SB_COMP_CD"   , paramMap.get("SB_COMP_CD"));
    		dataMap.put("TB_ORG_CD"    , paramMap.get("TB_ORG_CD"));
    		dataMap.put("TB_REQ_DOC_NO", paramMap.get("TB_REQ_DOC_NO"));
    		dataMap.put("TB_STAND_DESC", paramMap.get("TB_STAND_DESC2"));
    		dataMap.put("TB_CTRN_YMD"  , paramMap.get("TB_CTRN_YMD"));
    		insertList.add(dataMap);
    	}
    	
    	if (!"".equals(paramMap.get("TB_STAND_DESC3"))) {
    		dataMap = new HashMap<>();
    		dataMap.put("SB_COMP_CD"   , paramMap.get("SB_COMP_CD"));
    		dataMap.put("TB_ORG_CD"    , paramMap.get("TB_ORG_CD"));
    		dataMap.put("TB_REQ_DOC_NO", paramMap.get("TB_REQ_DOC_NO"));
    		dataMap.put("TB_STAND_DESC", paramMap.get("TB_STAND_DESC3"));
    		dataMap.put("TB_CTRN_YMD"  , paramMap.get("TB_CTRN_YMD"));
    		insertList.add(dataMap);
    	}
    	
    	if (!"".equals(paramMap.get("TB_STAND_DESC4"))) {
    		dataMap = new HashMap<>();
    		dataMap.put("SB_COMP_CD"   , paramMap.get("SB_COMP_CD"));
    		dataMap.put("TB_ORG_CD"    , paramMap.get("TB_ORG_CD"));
    		dataMap.put("TB_REQ_DOC_NO", paramMap.get("TB_REQ_DOC_NO"));
    		dataMap.put("TB_STAND_DESC", paramMap.get("TB_STAND_DESC4"));
    		dataMap.put("TB_CTRN_YMD"  , paramMap.get("TB_CTRN_YMD"));
    		insertList.add(dataMap);
    	}
    	
    	if (!"".equals(paramMap.get("TB_STAND_DESC5"))) {
    		dataMap = new HashMap<>();
    		dataMap.put("SB_COMP_CD"   , paramMap.get("SB_COMP_CD"));
    		dataMap.put("TB_ORG_CD"    , paramMap.get("TB_ORG_CD"));
    		dataMap.put("TB_REQ_DOC_NO", paramMap.get("TB_REQ_DOC_NO"));
    		dataMap.put("TB_STAND_DESC", paramMap.get("TB_STAND_DESC5"));
    		dataMap.put("TB_CTRN_YMD"  , paramMap.get("TB_CTRN_YMD"));
    		insertList.add(dataMap);
    	}
    	
    	if (!"".equals(paramMap.get("TB_STAND_DESC6"))) {
    		dataMap = new HashMap<>();
    		dataMap.put("SB_COMP_CD"   , paramMap.get("SB_COMP_CD"));
    		dataMap.put("TB_ORG_CD"    , paramMap.get("TB_ORG_CD"));
    		dataMap.put("TB_REQ_DOC_NO", paramMap.get("TB_REQ_DOC_NO"));
    		dataMap.put("TB_STAND_DESC", paramMap.get("TB_STAND_DESC6"));
    		dataMap.put("TB_CTRN_YMD"  , paramMap.get("TB_CTRN_YMD"));
    		insertList.add(dataMap);
    	}
    	
    	if (!"".equals(paramMap.get("TB_STAND_DESC7"))) {
    		dataMap = new HashMap<>();
    		dataMap.put("SB_COMP_CD"   , paramMap.get("SB_COMP_CD"));
    		dataMap.put("TB_ORG_CD"    , paramMap.get("TB_ORG_CD"));
    		dataMap.put("TB_REQ_DOC_NO", paramMap.get("TB_REQ_DOC_NO"));
    		dataMap.put("TB_STAND_DESC", paramMap.get("TB_STAND_DESC7"));
    		dataMap.put("TB_CTRN_YMD"  , paramMap.get("TB_CTRN_YMD"));
    		insertList.add(dataMap);
    	}
    	
    	if (!"".equals(paramMap.get("TB_STAND_DESC8"))) {
    		dataMap = new HashMap<>();
    		dataMap.put("SB_COMP_CD"   , paramMap.get("SB_COMP_CD"));
    		dataMap.put("TB_ORG_CD"    , paramMap.get("TB_ORG_CD"));
    		dataMap.put("TB_REQ_DOC_NO", paramMap.get("TB_REQ_DOC_NO"));
    		dataMap.put("TB_STAND_DESC", paramMap.get("TB_STAND_DESC8"));
    		dataMap.put("TB_CTRN_YMD"  , paramMap.get("TB_CTRN_YMD"));
    		insertList.add(dataMap);
    	}
    	
    	if (!"".equals(paramMap.get("TB_STAND_DESC9"))) {
    		dataMap = new HashMap<>();
    		dataMap.put("SB_COMP_CD"   , paramMap.get("SB_COMP_CD"));
    		dataMap.put("TB_ORG_CD"    , paramMap.get("TB_ORG_CD"));
    		dataMap.put("TB_REQ_DOC_NO", paramMap.get("TB_REQ_DOC_NO"));
    		dataMap.put("TB_STAND_DESC", paramMap.get("TB_STAND_DESC9"));
    		dataMap.put("TB_CTRN_YMD"  , paramMap.get("TB_CTRN_YMD"));
    		insertList.add(dataMap);
    	}
    	
    	int seqNo = 0;
        for (Map<String, Object> data: insertList) {
        	
            data.put("CRE_USER" , getUserId());
            data.put("MOD_USER" , getUserId());
            data.put("SEQ_NO"   , seqNo);
            data.put("TB_STAND_DESC", data.get("TB_STAND_DESC"));
            
            seqNo++;
            bdgEstCostReqDAO.insertEstCostDetail(data);
        }
    	
        paramMap.put("SUCC_YN", "Y");
        return paramMap;
    }
    
    public Map<String,Object> apprEstCost(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	Map<String, Object> saveMap          = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> saveList   = (List<Map<String, Object>>) saveMap.get("CHECK_LIST");
    	
    	paramMap.put("DOC_GUBN"   , "JC"); // DOC_GUBN 변경 필요
    	
    	// HEAD정보 기준으로 문서관리번호 채번
    	Map<String, Object> docNoInfo = commonSelectDAO.selectDocNo(paramMap);  
    	paramMap.put("EPS_DOC_NO" , docNoInfo.get("DOC_NO")); // DOC_GUBN 변경 필요
		paramMap.put("SABUN"      , getUserId());
    	paramMap.put("CRE_USER"   , getUserId());
    	paramMap.put("MOD_USER"   , getUserId());
    	
    	// EPS 결재 기록 생성
    	commonDAO.insertEpsHistory(paramMap);
    	
        if (null != saveList && 0 < saveList.size()) {
            for (Map<String, Object> data: saveList) {
            	data.put("CRE_USER"   , getUserId());
            	data.put("MOD_USER"   , getUserId());
            	data.put("EPS_DOC_NO" , docNoInfo.get("DOC_NO")); // DOC_GUBN 변경 필요
            	bdgEstCostReqDAO.apprEstCost(data);
            }
        }

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
    	bdgEstCostReqDAO.updateStatus(paramMap);
    	return paramMap;
    }    
    
    public Map<String,Object> deleteEstCostReq(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	Map<String, Object> deleteMap   = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> deleteList   = (List<Map<String, Object>>) deleteMap.get("DELETED");
	        // 삭제로직
        if (null != deleteList && 0 < deleteList.size()) {
            for (Map<String, Object> data: deleteList) {
                data.put("CRE_USER"   , getUserId());
                data.put("MOD_USER"   , getUserId());
                bdgEstCostReqDAO.deleteEstCostReq(data);
            }
        }
        
        bdgEstCostReqDAO.deleteEstCostDetail(deleteList.get(0));
        
        
        paramMap.put("SUCC_YN", "Y");	        
    	return paramMap;
    }
    
    public Map<String,Object> deleteEstCostDetail(Map<String,Object> paramMap) throws ServiceException, Exception {
    	bdgEstCostReqDAO.deleteEstCostHead(paramMap);
    	bdgEstCostReqDAO.deleteEstCostDetail(paramMap);
    	paramMap.put("SUCC_YN", "Y");	        
    	return paramMap;
    } 
    
    public Map<String,Object> updateEstCostReqStatus6All(Map<String,Object> paramMap) throws ServiceException, Exception {
    	// 상태 SAP 전송 오류 UPDATE!!                
    	bdgEstCostReqDAO.updateEstCostReqStatus6All(paramMap);
    	return paramMap;
    }
    
    public Map<String,Object> updateEstCostReqStatus6(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	// 상태 SAP 전송 오류 UPDATE!!                
    	bdgEstCostReqDAO.updateEstCostReqStatus6(paramMap);
    	return paramMap;
    }
    
    public Map<String,Object> updatSendFlag(Map<String,Object> paramMap) throws ServiceException, Exception {
    	// SAP 전송 Y UPDATE!!!!               
    	bdgEstCostReqDAO.updatSendFlag(paramMap);
    	return paramMap;
    }     
 
	public Map<String, Object> selectEstCostCnt(Map<String, Object> paramMap){
		return bdgEstCostReqDAO.selectEstCostCnt(paramMap);
	}
 
	public List<Map<String, Object>> selectEstCostReqDetailResult(Map<String, Object> paramMap){
		return bdgEstCostReqDAO.selectEstCostReqDetailResult(paramMap);
	}
	

}