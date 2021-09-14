package com.app.ildong.bdg.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.common.dao.CommonDAO;
import com.app.ildong.common.dao.CommonSelectDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.common.util.StringUtil;
import com.app.ildong.bdg.dao.BdgSupplementDAO;
import org.apache.commons.codec.binary.Base64;
@Service("BdgSupplementService")
public class BdgSupplementService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BdgSupplementDAO supplementDAO;
	
    @Autowired
    private CommonDAO commonDAO;	
	
    @Autowired
    private CommonSelectDAO commonSelectDAO;	
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectSupplement(Map<String, Object> paramMap){
		return supplementDAO.selectSupplement(paramMap);
	}
	
	public List<Map<String, Object>> selectSupplementDetail(Map<String, Object> paramMap){
		return supplementDAO.selectSupplementDetail(paramMap);
	}
	
	public List<Map<String, Object>> selectAccountList(Map<String, Object> paramMap){
		return supplementDAO.selectAccountList(paramMap);
	}
	
	public List<Map<String, Object>> selectDeptList(Map<String, Object> paramMap){
		return supplementDAO.selectDeptList(paramMap);
	}
	
	public Map<String, Object> selectStatusHeader(Map<String, Object> paramMap) {
        return supplementDAO.selectStatusHeader(paramMap);
    }		
	
	public int selectApprStatus(Map<String, Object> paramMap) {
		return supplementDAO.selectApprStatus(paramMap);
	}
	
	public List<Map<String, Object>> selectApprList(Map<String, Object> paramMap){
		return supplementDAO.selectApprList(paramMap);
	}	
	
    public Map<String,Object> delSupplement(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	Map<String, Object> dataMap       = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> delList = (List<Map<String, Object>>)dataMap.get("DELETED");
    	if (null != delList && 0 < delList.size()) {
    		for (Map<String, Object> data: delList) {
    			supplementDAO.delSupplement(data);
    		}
    	}
    	return paramMap;
    }
    
    public Map<String,Object> delSupplementDetail(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	Map<String, Object> dataMap       = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> delList = (List<Map<String, Object>>)dataMap.get("DELETED");
    	if (null != delList && 0 < delList.size()) {
    		for (Map<String, Object> data: delList) {
    			supplementDAO.delSupplementDetail(data);
    		}
    	}
    	return paramMap;
    }    
    
    public Map<String,Object> apprSupplement(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
		paramMap.put("COMP_CD"    , paramMap.get("SB_COMP_CD"));
		paramMap.put("CRTN_YMD"   , paramMap.get("TB_CRTN_YMD"));
		paramMap.put("ORG_CD"     , paramMap.get("TB_DEPT_CD"));
		
		paramMap.put("DOC_GUBN"   , "JS"); // DOC_GUBN 변경 필요
		
		paramMap.put("SABUN"      , getUserId());
    	paramMap.put("CRE_USER"   , getUserId());
    	paramMap.put("MOD_USER"   , getUserId());
    	
    	// HEAD정보 기준으로 문서관리번호 채번
    	Map<String, Object> docNoInfo = commonSelectDAO.selectDocNo(paramMap);
    	
    	paramMap.put("EPS_DOC_NO" , docNoInfo.get("DOC_NO")); // DOC_GUBN 변경 필요
    	commonDAO.insertEpsHistory(paramMap);

    	paramMap.put("STATUS"   , "2"); // 상태코드 변경처리
    	supplementDAO.apprSupplement(paramMap);
    	
    	return paramMap;
    }

    public Map<String,Object> saveSupplement(Map<String,Object> paramMap) throws ServiceException, Exception {
        
        Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
        List<Map<String, Object>> updList = (List<Map<String, Object>>)dataMap.get("UPDATED");
        List<Map<String, Object>> insList = (List<Map<String, Object>>)dataMap.get("CREATED");
        
        
        if (null != updList && 0 < updList.size()) {
            for (Map<String, Object> updData: updList) {
            	updData.put("MOD_USER"   , getUserId());
            	updData.put("REQUEST_DESC"   , paramMap.get("TB_REQUEST_DESC"));
            	supplementDAO.updateSupplement(updData);
            }
        }        
        
        if (null != insList && 0 < insList.size()) {
            for (Map<String, Object> insData: insList) {
            	insData.put("REQUEST_DESC"   , paramMap.get("TB_REQUEST_DESC"));
            	insData.put("CRE_USER"   , getUserId());
            	insData.put("MOD_USER"   , getUserId());
            	supplementDAO.insertSupplement(insData);
            }
        }
    	return paramMap;
    }
    
    public Map<String,Object> saveSupplementDetail(Map<String,Object> paramMap) throws ServiceException, Exception {
        
        Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
        List<Map<String, Object>> updList = (List<Map<String, Object>>)dataMap.get("UPDATED");
        List<Map<String, Object>> insList = (List<Map<String, Object>>)dataMap.get("CREATED");
        
        
        if (null != updList && 0 < updList.size()) {
            for (Map<String, Object> updData: updList) {
            	updData.put("MOD_USER"   , getUserId());
            	updData.put("REQUEST_DESC"   , paramMap.get("TB_REQUEST_DESC"));
            	supplementDAO.updateSupplementDetail(updData);
            }
        }        
        
        if (null != insList && 0 < insList.size()) {
            for (Map<String, Object> insData: insList) {
            	insData.put("CRE_USER"   , getUserId());
            	insData.put("MOD_USER"   , getUserId());
            	supplementDAO.insertSupplementDetail(insData);
            }
        }
    	return paramMap;
    }    
    
 
	public List<Map<String, Object>> selectSupplementAmt(Map<String, Object> paramMap){
		return supplementDAO.selectSupplementAmt(paramMap);
	}
	
	public Map<String, Object> selectEpsInfoData(Map<String, Object> paramMap) {
        return supplementDAO.selectEpsInfoData(paramMap);
    }	
	
    public Map<String,Object> returnSupplement(Map<String,Object> paramMap) throws ServiceException, Exception {
        Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
        List<Map<String, Object>> updList = (List<Map<String, Object>>)dataMap.get("UPDATED");
    	
        if (null != updList && 0 < updList.size()) {
            for (Map<String, Object> updData: updList) {
            	updData.put("MOD_USER"   , getUserId());
            	supplementDAO.returnSupplement(updData);
            }
        }        
    	
    	return paramMap;
    }
 
    public Map<String,Object> updateSupplementSap(Map<String,Object> paramMap) throws ServiceException, Exception {
    	Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> updList = (List<Map<String, Object>>)dataMap.get("UPDATED");
    	
    	if (null != updList && 0 < updList.size()) {
    		for (Map<String, Object> updData: updList) {
    			updData.put("MOD_USER"   , getUserId());
    			supplementDAO.updateSupplementSap(updData);
    		}
    	}
    	
    	return paramMap;
    }
    
	public List<Map<String, Object>> selectSupplementPop(Map<String, Object> paramMap){
		return supplementDAO.selectSupplementPop(paramMap);
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
    		paramMap.put("STATUS" , "1");
    	} else if ("WITHDRAW".equals(statusCode)) {
    		paramMap.put("STATUS" , "1");
    	}
    	supplementDAO.updateHeader(paramMap);
    	return paramMap;
    } 	
	

}