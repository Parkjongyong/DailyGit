package com.app.ildong.bdg.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.bdg.dao.BdgExecBugtMgtDAO;
import com.app.ildong.common.dao.CommonDAO;
import com.app.ildong.common.dao.CommonSelectDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.common.util.StringUtil;
import org.apache.commons.codec.binary.Base64;
@Service("bdgExecBugtMgtService")
public class BdgExecBugtMgtService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BdgExecBugtMgtDAO bdgExecBugtMgtDAO;
	
    @Autowired
    private CommonDAO commonDAO;	
	
    @Autowired
    private CommonSelectDAO commonSelectDAO;	
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectExecBugtMgtHeadList(Map<String, Object> paramMap){
		return bdgExecBugtMgtDAO.selectExecBugtMgtHeadList(paramMap);
	}
	
	public List<Map<String, Object>> selectApprList(Map<String, Object> paramMap){
		return bdgExecBugtMgtDAO.selectApprList(paramMap);
	}	
	
	public Map<String, Object> selectStatusHeader(Map<String, Object> paramMap) {
        return bdgExecBugtMgtDAO.selectStatusHeader(paramMap);
    }
	
	public Map<String, Object> selectStatusHeader2(Map<String, Object> paramMap) {
        return bdgExecBugtMgtDAO.selectStatusHeader2(paramMap);
    }	
	
	public List<Map<String, Object>> selectExecBugtMgtDetailList(Map<String, Object> paramMap){
		
		List<Map<String, Object>> modifyDetailList = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> prevDetailList   = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> execDetailList   = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> detailList       = new ArrayList<Map<String, Object>>();
		
		modifyDetailList = bdgExecBugtMgtDAO.selectModifyBudgetDetailList(paramMap);
		prevDetailList   = bdgExecBugtMgtDAO.selectPreExecBudgetDetailList(paramMap);
		execDetailList   = bdgExecBugtMgtDAO.selectExecBudgetDetailList(paramMap);
		
		// 저장된 실행예산 내역이 존재하지 않는 경우
//		if (execDetailList.size() == 0) {
//			execDetailList = bdgExecBugtMgtDAO.selectExecBudgetDetailList2(paramMap);
//		}
		
        
		detailList.addAll(modifyDetailList);
		detailList.addAll(prevDetailList);
		detailList.addAll(execDetailList);
		
		return detailList;
		
	}
	
	public List<Map<String, Object>> selectExecBugtMgtTotalList(Map<String, Object> paramMap){
		
		List<Map<String, Object>> modifyDetailList = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> prevDetailList   = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> execDetailList   = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> detailList       = new ArrayList<Map<String, Object>>();
		
		modifyDetailList = bdgExecBugtMgtDAO.selectModifyBudgetTotalList(paramMap);
		prevDetailList   = bdgExecBugtMgtDAO.selectPreExecBudgetTotalList(paramMap);
		execDetailList   = bdgExecBugtMgtDAO.selectExecBudgetTotalList(paramMap);
		
		detailList.addAll(modifyDetailList);
		detailList.addAll(prevDetailList);
		detailList.addAll(execDetailList);
		
		return detailList;
		
	}	
	
	
	
    public Map<String,Object> saveExecBugtMgtDetail(Map<String,Object> paramMap) throws ServiceException, Exception {
        
        Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
        List<Map<String, Object>> allList = (List<Map<String, Object>>)dataMap.get("ALLDATA");
        
       
        
        if (null != allList && 0 < allList.size()) {
            for (Map<String, Object> data: allList) {
            	
            	 Map<String, Object> retrunParam = bdgExecBugtMgtDAO.selectFlagYn(data);
            	 
            	 if ("N".equals(retrunParam.get("FLAG_YN").toString())) {
             		// 강제로 Exception 발생
             		paramMap.put("SUCC_YN", "N");
         			paramMap.put("ERR_MSG", "작성중/반려 상태인 건만 저장 가능합니다.");
         			throw new Exception("작성중/반려 상태인 건만 저장 가능합니다.");
            	 } else {
                     data.put("CRE_USER"   , getUserId());
                     data.put("MOD_USER"   , getUserId());
                     
                     bdgExecBugtMgtDAO.saveExecBugtMgtDetail(data);
            	 }
            }
        }
        
        paramMap.put("SUCC_YN", "Y");
        
    	return paramMap;
    }
    
    public Map<String,Object> saveExecBugtMgtDetailM(Map<String,Object> paramMap) throws ServiceException, Exception {
        
        Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
        List<Map<String, Object>> allList = (List<Map<String, Object>>)dataMap.get("ALLDATA");
        
        if (null != allList && 0 < allList.size()) {
            for (Map<String, Object> data: allList) {
                data.put("CRE_USER"   , getUserId());
                data.put("MOD_USER"   , getUserId());
                
                bdgExecBugtMgtDAO.saveExecBugtMgtDetail(data);
            }
        }
        
        paramMap.put("SUCC_YN", "Y");
        
    	return paramMap;
    }    
    
    public Map<String,Object> rejectExecBugtMgt(Map<String,Object> paramMap) throws ServiceException, Exception {
    	paramMap.put("MOD_USER" , getUserId());
    	//STATUS는 화면의 버튼 기능에 가변적으로 처리
    	// 상태 UPDATE!!
        bdgExecBugtMgtDAO.rejectExecBugtMgt(paramMap);        
        
    	return paramMap;
    }    
    
    public Map<String,Object> apprExecBugtMgt(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
		paramMap.put("COMP_CD"      , paramMap.get("SB_COMP_CD"));
		paramMap.put("TB_CRTN_YYMM" , paramMap.get("TB_CRTN_YYMM"));
		paramMap.put("ORG_CD"       , paramMap.get("TB_DEPT_CD"));
		
		paramMap.put("DOC_GUBN"   , "JE"); // DOC_GUBN 변경 필요
		
		paramMap.put("SABUN"      , getUserId());
    	paramMap.put("CRE_USER"   , getUserId());
    	paramMap.put("MOD_USER"   , getUserId());
    	
    	// HEAD정보 기준으로 문서관리번호 채번
    	Map<String, Object> docNoInfo = commonSelectDAO.selectDocNo(paramMap);
    	
    	paramMap.put("EPS_DOC_NO" , docNoInfo.get("DOC_NO")); // DOC_GUBN 변경 필요
    	commonDAO.insertEpsHistory(paramMap);

    	paramMap.put("STATUS"   , "2"); // 상태코드 변경처리
    	bdgExecBugtMgtDAO.apprExecBugtMgt(paramMap);
    	
    	return paramMap;
    }
    
    public Map<String,Object> createExecBugtMgt(Map<String,Object> paramMap) throws ServiceException, Exception {
    	paramMap.put("CRE_USER" , getUserId());
    	paramMap.put("MOD_USER" , getUserId());
    	
    	// 회사/년월 기준으로 기 등록 데이터 삭제
        //bdgExecBugtMgtDAO.deletExecBugtMgtHead(paramMap);        
        //bdgExecBugtMgtDAO.deletExecBugtMgtDetail(paramMap);
        // 회사/년월 기준으로 데이터 생성 
        bdgExecBugtMgtDAO.createExecBugtMgtDetail(paramMap);
        
        bdgExecBugtMgtDAO.createExecBugtMgtHead(paramMap);
        
    	return paramMap;
    } 
    
    public Map<String,Object> updateExecMaster(Map<String,Object> paramMap) throws ServiceException, Exception {
    	paramMap.put("CRE_USER" , getUserId());
    	paramMap.put("MOD_USER" , getUserId());
    	
        // 회사/년월 기준으로 데이터 생성 
        bdgExecBugtMgtDAO.updateExecMaster(paramMap);
        
    	return paramMap;
    }     
    
	public List<Map<String, Object>> selectExecBugtMgtHeadListPop(Map<String, Object> paramMap){
		return bdgExecBugtMgtDAO.selectExecBugtMgtHeadListPop(paramMap);
	}
	
	public Map<String, Object> selectEpsInfoData(Map<String, Object> paramMap) {
        return bdgExecBugtMgtDAO.selectEpsInfoData(paramMap);
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
    	bdgExecBugtMgtDAO.updateHeader(paramMap);
    	return paramMap;
    } 	
    
}