package com.app.ildong.bdg.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.bdg.dao.BdgOpSupplementDAO;
import com.app.ildong.common.dao.CommonSelectDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;

@Service("BdgOpSupplementService")
public class BdgOpSupplementService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BdgOpSupplementDAO opSupplementDAO;
	
	@Autowired
	private CommonSelectDAO commonSelectDAO;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectOpSupplement(Map<String, Object> paramMap){
		return opSupplementDAO.selectOpSupplement(paramMap);
	}
	
	public List<Map<String, Object>> selectOpDeptList(Map<String, Object> paramMap){
		return opSupplementDAO.selectOpDeptList(paramMap);
	}
	
    public Map<String,Object> delOpSupplement(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	Map<String, Object> dataMap       = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> delList = (List<Map<String, Object>>)dataMap.get("DELETED");
    	if (null != delList && 0 < delList.size()) {
    		for (Map<String, Object> data: delList) {
    			opSupplementDAO.delOpSupplement(data);
    		}
    	}
        
    	
    	return paramMap;
    }
    
    public Map<String,Object> confirmOpSupplement(Map<String,Object> paramMap) throws ServiceException, Exception {
    	Map<String, Object> retrunParam = opSupplementDAO.selectStatusHeader(paramMap);
        // 확정은 작성중에서만 가능
		if ("1".equals(retrunParam.get("STATUS").toString())) {
			paramMap.put("STATUS" , "2");
			paramMap.put("CRE_USER" , getUserId());
			paramMap.put("MOD_USER" , getUserId());
        	//STATUS는 화면의 버튼 기능에 가변적으로 처리
        	// 상태 UPDATE!!                
        	opSupplementDAO.confirmOpSupplement(paramMap);
            paramMap.put("SUCC_YN", "Y");
		} else {
			paramMap.put("SUCC_YN", "N");
			paramMap.put("ERR_MSG", "확정은 작성중 상태에서 가능합니다.");
			throw new Exception(paramMap.get("ERR_MSG").toString()); 
		}
    	
    	return paramMap;
    }

    public Map<String,Object> confirmCancelOpSupplement(Map<String,Object> paramMap) throws ServiceException, Exception {
    	Map<String, Object> retrunParam = opSupplementDAO.selectStatusHeader(paramMap);
        // 확정은 작성중에서만 가능
		if ("2".equals(retrunParam.get("STATUS").toString())) {
			paramMap.put("STATUS" , "1");
			paramMap.put("CRE_USER" , getUserId());
			paramMap.put("MOD_USER" , getUserId());
        	//STATUS는 화면의 버튼 기능에 가변적으로 처리
        	// 상태 UPDATE!!                
			opSupplementDAO.confirmCancelOpSupplement(paramMap);
            paramMap.put("SUCC_YN", "Y");
		} else {
			paramMap.put("SUCC_YN", "N");
			paramMap.put("ERR_MSG", "확정취소는 확정 상태에서 가능합니다.");
			throw new Exception(paramMap.get("ERR_MSG").toString()); 
		}
		
    	return paramMap;
    }
    
    public Map<String,Object> saveOpSupplement(Map<String,Object> paramMap) throws ServiceException, Exception {
        
        Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
        List<Map<String, Object>> updList = (List<Map<String, Object>>)dataMap.get("UPDATED");
        List<Map<String, Object>> insList = (List<Map<String, Object>>)dataMap.get("CREATED");
        
        
        if (null != updList && 0 < updList.size()) {
            for (Map<String, Object> updData: updList) {
            	updData.put("MOD_USER"   , getUserId());
            	opSupplementDAO.updateOpSupplement(updData);
            }
        }        
        
        if (null != insList && 0 < insList.size()) {
            for (Map<String, Object> insData: insList) {
            	insData.put("CRE_USER"   , getUserId());
            	insData.put("MOD_USER"   , getUserId());
            	opSupplementDAO.insertOpSupplement(insData);
            }
        }
    	return paramMap;
    }
 
	public List<Map<String, Object>> selectOpSupplementAmt(Map<String, Object> paramMap){
		return opSupplementDAO.selectOpSupplementAmt(paramMap);
	}
	
	public List<Map<String, Object>> selectOpDistribList(Map<String, Object> paramMap){
		return commonSelectDAO.selectOpDistribList(paramMap);
	}
	
    public Map<String,Object> returnOpSupplement(Map<String,Object> paramMap) throws ServiceException, Exception {
        Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
        List<Map<String, Object>> updList = (List<Map<String, Object>>)dataMap.get("UPDATED");
    	
        if (null != updList && 0 < updList.size()) {
            for (Map<String, Object> updData: updList) {
            	updData.put("MOD_USER"   , getUserId());
            	opSupplementDAO.returnOpSupplement(paramMap);
            }
        }        
    	
    	return paramMap;
    }
 
    public Map<String,Object> updateOpSupplementSap(Map<String,Object> paramMap) throws ServiceException, Exception {
    	Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> updList = (List<Map<String, Object>>)dataMap.get("UPDATED");
    	
    	if (null != updList && 0 < updList.size()) {
    		for (Map<String, Object> updData: updList) {
    			updData.put("MOD_USER"   , getUserId());
    			opSupplementDAO.updateOpSupplementSap(updData);
    		}
    	}
    	
    	return paramMap;
    }

    public Map<String,Object> sendOpSupplement(Map<String,Object> paramMap) throws ServiceException, Exception {
    	Map<String, Object> dataMap = new HashMap<String, Object>();
    	dataMap.put("COMP_CD", paramMap.get("SB_COMP_CD"));
    	dataMap.put("CRTN_YMD", paramMap.get("TB_CRTN_YMD"));
    	dataMap.put("CRE_USER"   , getUserId());
    	dataMap.put("MOD_USER"   , getUserId());
		int cnt = opSupplementDAO.sendCheckCnt(dataMap);
		if(cnt > 0) {
			throw new Exception("기등록된 데이터가 존재합니다. 전송취소 후 작업하세요.");
		} else {
			opSupplementDAO.sendOpSupplement(dataMap);
			opSupplementDAO.updatSendOpSupplement(paramMap);
		}
    	
    	return paramMap;
    }
    
    public Map<String,Object> sendCancelOpSupplement(Map<String,Object> paramMap) throws ServiceException, Exception {
    	Map<String, Object> dataMap = new HashMap<String, Object>();
    	dataMap.put("COMP_CD", paramMap.get("SB_COMP_CD"));
    	dataMap.put("CRTN_YMD", paramMap.get("TB_CRTN_YMD"));
    	dataMap.put("CRE_USER"   , getUserId());
    	dataMap.put("MOD_USER"   , getUserId());
    	int cnt = opSupplementDAO.sendCheckCnt(dataMap);
    	if(cnt == 0) {
    		throw new Exception("전송취소 할 데이터가 존재하지 않습니다.");
    	} else {
    		opSupplementDAO.sendCancelOpSupplement(dataMap);
    		opSupplementDAO.updateCancelOpSupplement(paramMap);
    	}
    	
    	return paramMap;
    }
        
}