/**
 * 시스템관리 > 공통코드 관리 Service
 * @author 박종용
 * @since 2020.06.22
 *
 * << 개정이력(Modification Information) >>
 *  -------------------------------------------------
 *  수정일                    수정자            수정내용
 *  ----------   -------- ---------------------------
 *  2020.06.22   박종용            최초생성
 *  -------------------------------------------------
 */
package com.app.ildong.sys.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.sys.dao.SysCmmCodeMgmtDAO;



@Service("SysCmmCodeMgmtService")
public class SysCmmCodeMgmtService extends BaseService {
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private SysCmmCodeMgmtDAO sysCmmCodeMgmtDAO;	
	
    public List<Map<String,Object>> selectGrpCdList(Map<String,Object> paramMap) throws ServiceException, Exception{
    	paramMap.put("COMP_CD", getCompCd());
        return sysCmmCodeMgmtDAO.selectGrpCdList(paramMap);
    }
    
    public List<Map<String,Object>> selectDetlCdList(Map<String,Object> paramMap) throws ServiceException, Exception {
    	paramMap.put("COMP_CD", getCompCd());
        return sysCmmCodeMgmtDAO.selectDetlCdList(paramMap);
    }
    
    public Map<String,Object> saveGrpCd(Map<String,Object> paramMap) throws ServiceException, Exception {
        
        Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
        List<Map<String, Object>> updList = (List<Map<String, Object>>)dataMap.get("UPDATED");
        List<Map<String, Object>> insList = (List<Map<String, Object>>)dataMap.get("CREATED");
        
        if (null != updList && 0 < updList.size()) {
            for (Map<String, Object> data: updList) {
                data.put("MOD_ID"   , getUserId());
                updateGrpCd(data);
            }
        }
        
        if (null != insList && 0 < insList.size()) {
            for (Map<String, Object> data: insList) {
                data.put("INS_ID"   , getUserId());
                data.put("S_CODE_GRP" , data.get("CODE_GRP"));
                int checkList = sysCmmCodeMgmtDAO.selectCheckGrpCdExist(data);
                logger.error(checkList);
                if (0==checkList) {
                    insertGrpCd(data);
                } else {
                    throw new ServiceException(getMessage("EBSYS0001", new Object [] {(String)data.get("CODE_GRP")}));
                }
            }
        }
        
    	return paramMap;
    }
    
    public Map<String,Object> delGrpCd(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> delList = (List<Map<String, Object>>)dataMap.get("DELETED");
    	
    	if (null != delList && 0 < delList.size()) {
    		for (Map<String, Object> data: delList) {
    			deleteGrpCd(data);
    			deleteDetlGrp(data);
    		}
    	}
    	
    	return paramMap;
    }
    
    public Map<String,Object> saveDetlCd(Map<String,Object> paramMap) throws ServiceException, Exception {    	
        
        Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
        List<Map<String, Object>> updList = (List<Map<String, Object>>)dataMap.get("UPDATED");
        List<Map<String, Object>> insList = (List<Map<String, Object>>)dataMap.get("CREATED");
        
        
        if (null != updList && 0 < updList.size()) {
            for (Map<String, Object> data: updList) {
                data.put("MOD_ID"   , getUserId());
                updateDetlCd(data);
            }
        }
        
        if (null != insList && 0 < insList.size()) {
            for (Map<String, Object> data: insList) {
                
                data.put("INS_ID"   , getUserId());
                data.put("S_CODE_GRP", data.get("CODE_GRP"));
                data.put("S_CODE"    , data.get("CODE"));
                int checkList = sysCmmCodeMgmtDAO.selectCheckDetlCdExist(data);
                if (0==checkList) {
                    insertDetlCd(data);
                } else {
                    throw new ServiceException(getMessage("EBSYS0002", new Object [] {(String)data.get("CODE")}));
                    //throw new ServiceException("내가 원하는 메시지");
                }
            }
        }
        
    	return paramMap;
    }
    
    public Map<String,Object> delDetlCd(Map<String,Object> paramMap) throws ServiceException, Exception {    	
    	
    	Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> delList = (List<Map<String, Object>>)dataMap.get("DELETED");
    	
    	
    	if (null != delList && 0 < delList.size()) {
    		for (Map<String, Object> data: delList) {
    			data.put("MOD_ID"   , getUserId());
    			deleteDetlCd(data);
    		}
    	}
    	
    	return paramMap;
    }
    
    private void insertGrpCd(Map<String,Object> itemMap) throws ServiceException, Exception {
    	itemMap.put("COMP_CD", getCompCd());
		itemMap.put("USER_ID", getUserId());
    	sysCmmCodeMgmtDAO.insertGrpCd(itemMap);
    	
    }
    
    private void updateGrpCd(Map<String,Object> itemMap) throws ServiceException, Exception {
    	itemMap.put("COMP_CD", getCompCd());
		itemMap.put("USER_ID", getUserId());
		sysCmmCodeMgmtDAO.updateGrpCd(itemMap);
    }
    
    private void deleteGrpCd(Map<String,Object> itemMap) throws ServiceException, Exception {
    	itemMap.put("COMP_CD", getCompCd());
		itemMap.put("USER_ID", getUserId());
		sysCmmCodeMgmtDAO.deleteGrpCd(itemMap);
    }
 
    private void insertDetlCd(Map<String,Object> itemMap) throws ServiceException, Exception {
    	itemMap.put("COMP_CD", getCompCd());
		itemMap.put("USER_ID", getUserId());
		sysCmmCodeMgmtDAO.insertDetlCd(itemMap);
    }

    private void updateDetlCd(Map<String,Object> itemMap) throws ServiceException, Exception {
    	itemMap.put("COMP_CD", getCompCd());
		itemMap.put("USER_ID", getUserId());
		sysCmmCodeMgmtDAO.updateDetlCd(itemMap);
    }
    
    private void deleteDetlCd(Map<String,Object> itemMap) throws ServiceException, Exception {
    	itemMap.put("COMP_CD", getCompCd());
		itemMap.put("USER_ID", getUserId());
		sysCmmCodeMgmtDAO.deleteDetlCd(itemMap);
    }

    private void deleteDetlGrp(Map<String,Object> itemMap) throws ServiceException, Exception {
    	itemMap.put("COMP_CD", getCompCd());
    	itemMap.put("USER_ID", getUserId());
    	sysCmmCodeMgmtDAO.deleteDetlGrp(itemMap);
    }
    
}
