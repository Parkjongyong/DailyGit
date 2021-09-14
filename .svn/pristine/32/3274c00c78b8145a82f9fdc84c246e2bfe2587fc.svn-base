package com.app.ildong.bdg.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.bat.dao.BatHRBugtDAO;
import com.app.ildong.bdg.dao.BdgBasicMgtDAO;
import com.app.ildong.common.dao.CommonDAO;
import com.app.ildong.common.dao.CommonSelectDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.common.util.StringUtil;
import org.apache.commons.codec.binary.Base64;
@Service("BdgBasicMgtService")
public class BdgBasicMgtService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BdgBasicMgtDAO basicMgtDAO;
	
    @Autowired
    private CommonDAO commonDAO;	
	
    @Autowired
    private CommonSelectDAO commonSelectDAO;	
    
	@Autowired
	private BatHRBugtDAO batHRBugtDAO;
	
	@Autowired
	private BatHRBugtDAO batBugtDAO;	
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectBasicMgtHeader(Map<String, Object> paramMap){
		return basicMgtDAO.selectBasicMgtHeader(paramMap);
	}
	
	public List<Map<String, Object>> selectBbugdet(Map<String, Object> paramMap){
		return basicMgtDAO.selectBbugdet(paramMap);
	}
	
	public Map<String, Object> selectStatusHeader(Map<String, Object> paramMap) {
        return basicMgtDAO.selectStatusHeader(paramMap);
    }
	
	public Map<String, Object> selectBugtSumData(Map<String, Object> paramMap) {
        return basicMgtDAO.selectBugtSumData(paramMap);
    }	
	
	public Map<String, Object> selectStatusHeader2(Map<String, Object> paramMap) {
        return basicMgtDAO.selectStatusHeader2(paramMap);
    }	
	
	public List<Map<String, Object>> selectBasicMgtDetail(Map<String, Object> paramMap){
		return basicMgtDAO.selectBasicMgtDetail(paramMap);
	}
	
	public List<Map<String, Object>> selectAccountList(Map<String, Object> paramMap){
		return basicMgtDAO.selectAccountList(paramMap);
	}
	
	public List<Map<String, Object>> selectDeptList(Map<String, Object> paramMap){
		return basicMgtDAO.selectDeptList(paramMap);
	}
	
	public List<Map<String, Object>> selectProjList(Map<String, Object> paramMap){
		return basicMgtDAO.selectProjList(paramMap);
	}
	
	
    public Map<String,Object> saveHeader(Map<String,Object> paramMap) throws ServiceException, Exception {
        
        Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
        if(paramMap.get("ITEM_LIST") != null) {
            List<Map<String, Object>> updList = (List<Map<String, Object>>)dataMap.get("UPDATED");
            if (updList != null && 0 < updList.size()) {
                for (Map<String, Object> data: updList) {
                    data.put("MOD_USER"   , getUserId());
                    basicMgtDAO.saveHeader(data);
                }
            }
        }
        
    	return paramMap;
    }
    
    public Map<String,Object> saveBasicMaster(Map<String,Object> paramMap) throws ServiceException, Exception {
    	basicMgtDAO.saveBasicMaster(paramMap);
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
    		paramMap.put("STATUS" , "1");
    	} else if ("WITHDRAW".equals(statusCode)) {
    		paramMap.put("STATUS" , "1");
    	}
    	basicMgtDAO.updateHeader(paramMap);
    	return paramMap;
    }    
    
    public Map<String,Object> delBasicH(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	Map<String, Object> dataMap       = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> delList = (List<Map<String, Object>>)dataMap.get("DELETED");
    	if (null != delList && 0 < delList.size()) {
    		for (Map<String, Object> data: delList) {
    			data.put("CRE_USER"   , getUserId());
    			data.put("MOD_USER"   , getUserId());
    			basicMgtDAO.delBasicH(data);
    			basicMgtDAO.delBasicD(data);
    		}
    	}
        
    	
    	return paramMap;
    }
    
    public Map<String,Object> delBasicMgt(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	Map<String, Object> dataMap       = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> delList = (List<Map<String, Object>>)dataMap.get("DELETED");
    	if (null != delList && 0 < delList.size()) {
    		for (Map<String, Object> data: delList) {
    			basicMgtDAO.delBasicMgtDetail(data);
    		}
    	}
    	paramMap.put("CRE_USER"   , getUserId());
    	paramMap.put("MOD_USER"   , getUserId());
    	basicMgtDAO.saveBasicMgtHeader(paramMap);
    	
    	return paramMap;
    }
    
    public Map<String,Object> apprBasicMgt(Map<String,Object> paramMap) throws ServiceException, Exception {

		paramMap.put("COMP_CD"    , paramMap.get("SB_COMP_CD"));
		paramMap.put("CRTN_YY"    , paramMap.get("TB_CRTN_YY"));
		paramMap.put("ORG_CD"     , paramMap.get("TB_DEPT_CD"));
		
		paramMap.put("DOC_GUBN"   , "JB"); // DOC_GUBN 변경 필요
		
		paramMap.put("SABUN"      , getUserId());
    	paramMap.put("CRE_USER"   , getUserId());
    	paramMap.put("MOD_USER"   , getUserId());
    	
    	// HEAD정보 기준으로 문서관리번호 채번
    	Map<String, Object> docNoInfo = commonSelectDAO.selectDocNo(paramMap);
    	
    	paramMap.put("EPS_DOC_NO" , docNoInfo.get("DOC_NO")); // DOC_GUBN 변경 필요
    	commonDAO.insertEpsHistory(paramMap);

    	paramMap.put("STATUS"   , "2"); // 상태코드 변경처리
    	basicMgtDAO.apprBasicMgtHeader(paramMap);
    	
    	return paramMap;
    }
    
    public Map<String,Object> returnBasicMgt(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	paramMap.put("COMP_CD"    , paramMap.get("SB_COMP_CD"));
    	paramMap.put("CRTN_YY"    , paramMap.get("TB_CRTN_YY"));
    	paramMap.put("ORG_CD"     , paramMap.get("TB_DEPT_CD"));
    	paramMap.put("CRE_USER"   , getUserId());
    	paramMap.put("MOD_USER"   , getUserId());
    	basicMgtDAO.returnBasicMgtHeader(paramMap);
    	
    	return paramMap;
    }

    public Map<String,Object> saveBasicMgt(Map<String,Object> paramMap) throws ServiceException, Exception {
        
        Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
        if(paramMap.get("ITEM_LIST") != null) {
            List<Map<String, Object>> allList = (List<Map<String, Object>>)dataMap.get("ALLDATA");
            if (allList != null && 0 < allList.size()) {
                for (Map<String, Object> data: allList) {
                    data.put("CRE_USER"   , getUserId());
                    data.put("MOD_USER"   , getUserId());
                    data.put("COMP_CD"    , paramMap.get("SB_COMP_CD"));
                    data.put("CRTN_YY"    , paramMap.get("TB_CRTN_YY"));
                    data.put("CCTR_CD"    , paramMap.get("SB_CCTR_CD"));
                    data.put("ACCOUNT_NO" , paramMap.get("TB_ACCOUNT_NO"));
                    basicMgtDAO.saveBasicMgtDetail(data);
                }
            }
        }
        
        paramMap.put("CRE_USER"   , getUserId());
        paramMap.put("MOD_USER"   , getUserId());
        basicMgtDAO.saveBasicMgtHeader(paramMap);
    	return paramMap;
    }
    
    public Map<String,Object> apprBasicMgt2(Map<String,Object> paramMap) throws ServiceException, Exception {

		paramMap.put("COMP_CD"    , paramMap.get("SB_COMP_CD"));
		paramMap.put("CRTN_YY"    , paramMap.get("TB_CRTN_YY"));
		paramMap.put("ORG_CD"     , paramMap.get("TB_DEPT_CD"));
		paramMap.put("EPS_DOC_NO" , paramMap.get("EPS_DOC_NO"));
    	paramMap.put("CRE_USER"   , getUserId());
    	paramMap.put("MOD_USER"   , getUserId());
    	basicMgtDAO.apprBasicMgtHeader2(paramMap);
    	
    	return paramMap;
    }

	public List<Map<String, Object>> selectBasicMgtHeaderPop(Map<String, Object> paramMap){
		return basicMgtDAO.selectBasicMgtHeaderPop(paramMap);
	}
	
	public Map<String, Object> selectEpsInfoData(Map<String, Object> paramMap) {
        return basicMgtDAO.selectEpsInfoData(paramMap);
    }		

    public Map<String,Object> ReceiveHrBugt(Map<String,Object> paramMap) throws ServiceException, Exception {
        

		List<Map<String, Object>> selectList = batHRBugtDAO.selectHRBugtIfData(paramMap);
		List<Map<String, Object>> insertList = new ArrayList<Map<String, Object>>();
		
		try {
			
			// I/F 초기화
			batHRBugtDAO.deleteHRBugtIfData(paramMap);
			
			int cCnt = 0;
	        // I/F에 저장
	        if (null != selectList && 0 < selectList.size()) {
	            for (Map<String, Object> data: selectList) {
	            	
	    			insertList.add(data);
	    			cCnt++;
	    			if (cCnt % 500 == 0 || selectList.size() == cCnt) {
	    				System.out.println("cCnt::" + cCnt);
	    				// 일괄 등록
	    				batHRBugtDAO.batchHRBugtIfData(insertList);
	    				//초기화
	    				insertList = new ArrayList<Map<String, Object>>();
	    			}
                	
	            }
	            
	        }
	        
	        // 기본예산 HR예산계정 전체 삭제
	        batBugtDAO.deleteHRBugtBasicData(paramMap);
	        // HR I/F 기준으로 데이터 생성	        
	        batBugtDAO.mergeHRBugtData(paramMap);
	        
	        paramMap.put("SUCC_YN", "Y");
		} catch (Exception e) {
			paramMap.put("SUCC_YN", "N");
		}
		
    	return paramMap;
    }	
    
}