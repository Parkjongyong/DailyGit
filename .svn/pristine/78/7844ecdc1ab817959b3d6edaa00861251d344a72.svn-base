package com.app.ildong.bdg.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.bdg.dao.BdgOpExecBugtMgtDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;

@Service("bdgOpExecBugtMgtService")
public class BdgOpExecBugtMgtService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BdgOpExecBugtMgtDAO bdgOpExecBugtMgtDAO;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectOpExec(Map<String, Object> paramMap){
		return bdgOpExecBugtMgtDAO.selectOpExec(paramMap);
	}
	
    public Map<String,Object> saveOpExec(Map<String,Object> paramMap) throws ServiceException, Exception {
        
        Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
        List<Map<String, Object>> updList = (List<Map<String, Object>>)dataMap.get("UPDATED");
        List<Map<String, Object>> insList = (List<Map<String, Object>>)dataMap.get("CREATED");
        
        
        if (null != updList && 0 < updList.size()) {
            for (Map<String, Object> updData: updList) {
            	
            	updData.put("GUBN"          , paramMap.get("GUBN").toString());
            	
            	updData.put("MOD_USER"   , getUserId());
            	bdgOpExecBugtMgtDAO.updateOpExec(updData);
            }
        }        
        
        if (null != insList && 0 < insList.size()) {
            for (Map<String, Object> insData: insList) {
            	insData.put("CRE_USER"   , getUserId());
            	insData.put("MOD_USER"   , getUserId());
            	
            	bdgOpExecBugtMgtDAO.insertOpExec(insData);
            	
//            	// 수정기본 예산에 해당 계정이 있는지 체크
//            	Map<String, Object> modifyHeadParam = bdgOpExecBugtMgtDAO.selectModifyHeadCountData(insData);
//            	// 없는 경우 head정보 생성
//            	if ("0".equals(modifyHeadParam.get("CNT").toString())) {
//            		bdgOpExecBugtMgtDAO.insertModifyData(insData);
//            		bdgOpExecBugtMgtDAO.insertOpModifyData(insData);
//            	}
            }
        }

    	return paramMap;
    }
    
    public Map<String,Object> deleteOpExec(Map<String,Object> paramMap) throws ServiceException, Exception {
        
        Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
        List<Map<String, Object>> delList = (List<Map<String, Object>>)dataMap.get("DELETED");
        
        if (null != delList && 0 < delList.size()) {
            for (Map<String, Object> insData: delList) {
            	insData.put("CRE_USER"   , getUserId());
            	insData.put("MOD_USER"   , getUserId());
            	
            	bdgOpExecBugtMgtDAO.deleteOpExec(insData);
            	
//            	// 수정기본 예산에 해당 계정이 있는지 체크
//            	Map<String, Object> modifyHeadParam = bdgOpExecBugtMgtDAO.selectModifyHeadCountData(insData);
//            	// 없는 경우 head정보 생성
//            	if ("1".equals(modifyHeadParam.get("CNT").toString())) {
//            		// 경영예산 수정기본에 해당 계정이 있는지 체크
//            		Map<String, Object> opModifyHeadParam = bdgOpExecBugtMgtDAO.selectOpModifyData(insData);
//            		// 실행예산에서 만든계정이면 데이터 삭제
//            		if ("0".equals(opModifyHeadParam.get("CNT").toString())) {
//            			bdgOpExecBugtMgtDAO.deleteModifyData(insData);
//            			bdgOpExecBugtMgtDAO.deleteOpModifyData(insData);
//            		}
//            		
//            	}
            }
        }

    	return paramMap;
    }
    
    public Map<String,Object> createOpExecBugtMgt(Map<String,Object> paramMap) throws ServiceException, Exception {
    	// 회사/년월 기준으로 기 등록 데이터 삭제
    	bdgOpExecBugtMgtDAO.createOpExecBugtMgt(paramMap);
        
    	return paramMap;
    }     
    
    public Map<String,Object> confirmOpExec(Map<String,Object> paramMap) throws ServiceException, Exception {
    	Map<String, Object> retrunParam = bdgOpExecBugtMgtDAO.selectStatusHeader(paramMap);
        
        // 확정은 작성중에서만 가능
		if ("1".equals(retrunParam.get("STATUS").toString())) {
			paramMap.put("STATUS" , "2");
			paramMap.put("CRE_USER" , getUserId());
			paramMap.put("MOD_USER" , getUserId());
        	//STATUS는 화면의 버튼 기능에 가변적으로 처리
        	// 상태 UPDATE!!                
			bdgOpExecBugtMgtDAO.confirmOpExec(paramMap);				
            paramMap.put("SUCC_YN", "Y");
		} else {
			paramMap.put("SUCC_YN", "N");
			paramMap.put("ERR_MSG", "확정은 작성중 상태에서 가능합니다.");
			throw new Exception(paramMap.get("ERR_MSG").toString()); 
		}
    	
    	return paramMap;
    }
    
    public Map<String,Object> confirmCancelOpExec(Map<String,Object> paramMap) throws ServiceException, Exception {
    	Map<String, Object> retrunParam = bdgOpExecBugtMgtDAO.selectStatusHeader(paramMap);
        
		if ("2".equals(retrunParam.get("STATUS").toString())) {
			paramMap.put("STATUS" , "1");
			paramMap.put("CRE_USER" , getUserId());
			paramMap.put("MOD_USER" , getUserId());
        	//STATUS는 화면의 버튼 기능에 가변적으로 처리
        	// 상태 UPDATE!!                
			bdgOpExecBugtMgtDAO.confirmCancelOpExec(paramMap);
            paramMap.put("SUCC_YN", "Y");
		} else {
			paramMap.put("SUCC_YN", "N");
			paramMap.put("ERR_MSG", "확정취소는 확정 상태에서 가능합니다.");
			throw new Exception(paramMap.get("ERR_MSG").toString()); 
		}
    	
    	return paramMap;
    }
    
    public Map<String,Object> sendOpExec(Map<String,Object> paramMap) throws ServiceException, Exception {
    	Map<String, Object> dataMap = new HashMap<String, Object>();
    	dataMap.put("COMP_CD", paramMap.get("SB_COMP_CD"));
    	dataMap.put("CRTN_YYMM", paramMap.get("TB_CRTN_YYMM"));
    	dataMap.put("CRE_USER"   , getUserId());
    	dataMap.put("MOD_USER"   , getUserId());
		int cnt = bdgOpExecBugtMgtDAO.sendCheckCnt(dataMap);
		if(cnt > 0) {
			throw new Exception("기등록된 데이터가 존재합니다. 전송취소 후 작업하세요.");
		} else {
			bdgOpExecBugtMgtDAO.sendOpExecHead(dataMap);
			bdgOpExecBugtMgtDAO.sendOpExecDetail(dataMap);
			bdgOpExecBugtMgtDAO.updatSendOpExecBudgetMgt(paramMap);
		}
    	
    	return paramMap;
    }
    
    public Map<String,Object> sendCancelOpExec(Map<String,Object> paramMap) throws ServiceException, Exception {
    	Map<String, Object> dataMap = new HashMap<String, Object>();
    	dataMap.put("COMP_CD", paramMap.get("SB_COMP_CD"));
    	dataMap.put("CRTN_YYMM", paramMap.get("TB_CRTN_YYMM"));
    	dataMap.put("CRE_USER"   , getUserId());
    	dataMap.put("MOD_USER"   , getUserId());
    	int cnt = bdgOpExecBugtMgtDAO.sendCheckCnt(dataMap);
    	if(cnt == 0) {
    		throw new Exception("전송취소 할 데이터가 존재하지 않습니다.");
    	} else {
    		bdgOpExecBugtMgtDAO.sendCancelOpExecHead(dataMap);
    		bdgOpExecBugtMgtDAO.sendCancelOpExecDetail(dataMap);
    		bdgOpExecBugtMgtDAO.updatCancelOpExecBudgetMgt(paramMap);
    	}
    	
    	return paramMap;
    }
    
}