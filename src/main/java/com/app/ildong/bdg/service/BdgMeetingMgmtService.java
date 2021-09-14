package com.app.ildong.bdg.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.common.util.StringUtil;
import com.app.ildong.bdg.dao.BdgMeetingMgmtDAO;

@Service("BdgMeetingMgmtService")
public class BdgMeetingMgmtService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BdgMeetingMgmtDAO meetingMgmtDAO;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectMeetingMgmt(Map<String, Object> paramMap){
		List<Map<String, Object>> returnList  = new ArrayList<Map<String, Object>>();
		String dataGubn = StringUtil.isNullToString(paramMap.get("SB_GUBN_CD"));
		if ("4".equals(dataGubn)) {
			returnList = meetingMgmtDAO.selectMeetingMgmt(paramMap);
		} else {
			returnList = meetingMgmtDAO.selectMeetingMgmt2(paramMap);
		}
		return returnList;
	}
	
    public Map<String,Object> saveMeetingMgmt(Map<String,Object> paramMap) throws ServiceException, Exception {
        
    	Map<String, Object> saveMap          = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> saveList   = (List<Map<String, Object>>) saveMap.get("CHECK_LIST");
    	
        // 저장로직
        if (null != saveList && 0 < saveList.size()) {
            for (Map<String, Object> data: saveList) {
                data.put("CRE_USER"   , getUserId());
                data.put("MOD_USER"   , getUserId());
                data.put("G_GUBN"     , paramMap.get("SB_GUBN_CD"));
            	meetingMgmtDAO.insertMeetingMgmt(data);
            }
        }
        
    	return paramMap;
    }
    
    public Map<String,Object> deleteMeetingMgmt(Map<String,Object> paramMap) throws ServiceException, Exception {
        
    	Map<String, Object> delteMap          = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> delList   = (List<Map<String, Object>>) delteMap.get("DELETED");
    	
        // 삭제로직
        if (null != delList && 0 < delList.size()) {
            for (Map<String, Object> data: delList) {
            	meetingMgmtDAO.deleteMeetingMgmt(data);
            }
        }
        
    	return paramMap;
    }    

}