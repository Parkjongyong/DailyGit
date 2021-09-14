package com.app.ildong.common.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.common.dao.CommonSelectDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.common.util.PropertiesUtil;
import com.app.ildong.common.util.StringUtil;


@Service("CommonSelectService")
public class CommonSelectService extends BaseService {

	protected final Log logger = LogFactory.getLog(getClass());
	
    @Autowired
    private CommonSelectDAO commonSelectDAO;
    
	/** 
	 * 특정 codeId에 의 코드 목록을 조회한다.
	 * @param codeId
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCodeList(Map<String,Object> paramMap) throws Exception {
	    List<Map<String, Object>> result = commonSelectDAO.selectCodeList(paramMap);
    	return result;
	}
	
	public List<Map<String, Object>> selectCodeNmList(Map<String,Object> paramMap) throws Exception {
        List<Map<String, Object>> result = commonSelectDAO.selectCodeNmList(paramMap);
        return result;
    }
	
	/** 
	 * 특정 code그룹의 전체 코드 목록을 조회한다.
	 * @param codeId
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCodeListAll(Map<String,Object> paramMap) throws Exception {
	    List<Map<String, Object>> result = commonSelectDAO.selectCodeListAll(paramMap);
    	return result;
	}
	
	/** 
	 * 특정 codeId에 의 코드 목록을 조회한다.
	 * @param codeId
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCodeList(String grpCodeId) throws Exception {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("CODE_GRP", grpCodeId);
	    return selectCodeList(paramMap);
	}
	
    public Map<String, Object> selectCodeList(String[] arrCodes) throws ServiceException, Exception {
    	Map<String, Object> mapResult = new HashMap<>();;
    	
    	for (String strCode : arrCodes) {
    		Map<String, Object> paramMap = new HashMap<>();
    		paramMap.put("USG_YN"	, "Y");
    		paramMap.put("CODE_GRP"	, strCode);
    		
    		mapResult.put("CODELIST_".concat(strCode), selectCodeList(paramMap));
    	}
    	return mapResult;
    }
    
    public Map<String, Object> selectPlandCodeList(String Code) throws ServiceException, Exception {
    	Map<String, Object> mapResult = new HashMap<>();
		Map<String, Object> paramMap  = new HashMap<>();
		
    	mapResult.put("CODELIST_".concat(Code), commonSelectDAO.selectPlantCodeList(paramMap));
    	return mapResult;
    }
    
    public Map<String, Object> selectStorageCodeList(String Code) throws ServiceException, Exception {
    	Map<String, Object> mapResult = new HashMap<>();
		Map<String, Object> paramMap  = new HashMap<>();
		
    	mapResult.put("CODELIST_".concat(Code), commonSelectDAO.selectStorageCodeList(paramMap));
    	return mapResult;
    }
    
    public Map<String, Object> selectOpAccountCodeList(String Code) throws ServiceException, Exception {
    	Map<String, Object> mapResult = new HashMap<>();
		Map<String, Object> paramMap  = new HashMap<>();
		
    	mapResult.put("CODELIST_".concat(Code), commonSelectDAO.selectOpAccountCodeList(paramMap));
    	return mapResult;
    }
    
    public Map<String, Object> selectOpAccountCodeList2(String Code) throws ServiceException, Exception {
    	Map<String, Object> mapResult = new HashMap<>();
		Map<String, Object> paramMap  = new HashMap<>();
		
    	mapResult.put("CODELIST_".concat(Code), commonSelectDAO.selectOpAccountCodeList2(paramMap));
    	return mapResult;
    }    
    
    
    public Map<String, Object> selectUserDeptCodeList(String Code) throws ServiceException, Exception {
    	Map<String, Object> mapResult = new HashMap<>();
		Map<String, Object> paramMap  = new HashMap<>();
		//paramMap.put("COMP_CD", getCompCd());
		paramMap.put("USER_ID", getUserId());
		
    	mapResult.put("CODELIST_".concat(Code), commonSelectDAO.selectUserDeptCodeList(paramMap));
    	return mapResult;
    } 
    
    public Map<String, Object> selectUserDeptCodeList2(Map<String, Object> paramMap) throws ServiceException, Exception {
    	Map<String, Object> mapResult = new HashMap<>();
		
    	mapResult.put("CODELIST_".concat(paramMap.get("CODE").toString()), commonSelectDAO.selectUserDeptCodeList(paramMap));
    	return mapResult;
    }     
    
    public Map<String, Object> selectCodeNmList(String[] arrCodes) throws ServiceException, Exception {
        Map<String, Object> mapResult = new HashMap<>();;
        
        for (String strCode : arrCodes) {
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("USG_YN"   , "Y");
            paramMap.put("CODE_GRP" , strCode);
            
            mapResult.put("CODELIST_".concat(strCode), selectCodeNmList(paramMap));
        }
        return mapResult;
    }
    
    public List<Map<String, Object>> selectPurUserRoleList() throws ServiceException, Exception {
    	return this.selectRoleUserList(PropertiesUtil.getProperty("ROLE_PUR"));
    }
    
	/** 
	 * Role을 가진 사용자를 구한다.

	 */
	public List<Map<String, Object>> selectRoleUserList(String roleCd) throws ServiceException, Exception {
		
		
		String[] arrRoleCd = roleCd.split(",");
		Map<String, Object> paramMap = new HashMap<>();
		
		if (0==arrRoleCd.length) {
			return null;
		} else if (1==arrRoleCd.length) {
			paramMap.put("ROLE_CD", arrRoleCd);
		} else {
			paramMap.put("ROLE_CD", arrRoleCd);
		}
		
		return commonSelectDAO.selectRoleUserList(paramMap);
	}
	
	public List<Map<String, Object>> selectRoleUserList(Map<String, Object> paramMap) throws Exception {
		return commonSelectDAO.selectRoleUserList(paramMap);
	}

	
	/**
	 * 지정 Role 권한을 가진 부서목록을 조회
	 * @param roleCd
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<Map<String, Object>> selectRoleDeptList(String roleCd) throws Exception {
		Map<String, Object> paramMap = new HashMap();
		paramMap.put("ROLE_CD", roleCd);
		
		return commonSelectDAO.selectRoleDeptList(paramMap);
	}
	
	public String selectDbTime() throws Exception {
		return commonSelectDAO.selectDbTime();
	}

	public List<Map<String, Object>> setCommMap(String[] strs) throws Exception {
		String[] defaultStrs = {"CODE_GRP", "ATTR01", "ATTR02", "ATTR03", "ATTR04"};
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("USG_YN", "Y");
		
		for(int i = 0; i< strs.length; i++){
			paramMap.put(defaultStrs[i], strs[i]);
		}
		
		List<Map<String, Object>> result = commonSelectDAO.selectCodeList(paramMap);
    	return result;
	}
	
    public Map<String, Object> selectCostList() throws ServiceException, Exception {
    	Map<String, Object> mapResult = new HashMap<>();;
    	
    		Map<String, Object> paramMap = new HashMap<>();
    		paramMap.put("COMP_CD"	, getCompCd());
    		paramMap.put("ORG_CD"	, getDeptCd());
    		paramMap.put("USER_ID"	, getUserId());
    		mapResult.put("COSTLIST", commonSelectDAO.selectCostList(paramMap));
    	return mapResult;
    }
    
    public Map<String, Object> selectCompList() throws ServiceException, Exception {
    	Map<String, Object> mapResult = new HashMap<>();;
    	
    	Map<String, Object> paramMap = new HashMap<>();
    	paramMap.put("COMP_CD"	, getCompCd());
    	paramMap.put("ORG_CD"	, getDeptCd());
    	mapResult.put("COMPLIST", commonSelectDAO.selectCompList(paramMap));
    	return mapResult;
    }
    
    public Map<String, Object> selectCostListPop(Map<String, Object> paramMap) throws ServiceException, Exception {
    	Map<String, Object> mapResult = new HashMap<>();;
    		paramMap.put("COMP_CD"	, paramMap.get("SB_COMP_CD"));
    		paramMap.put("ORG_CD"	, paramMap.get("ORG_CD"));
    		paramMap.put("USER_ID"	, paramMap.get("USER_ID"));
    		mapResult.put("COSTLIST", commonSelectDAO.selectCostList(paramMap));
    	return mapResult;
    }
    
    public Map<String, Object> selectCompListPop(Map<String, Object> paramMap) throws ServiceException, Exception {
    	Map<String, Object> mapResult = new HashMap<>();;
    	paramMap.put("COMP_CD"	, paramMap.get("SB_COMP_CD"));
    	paramMap.put("ORG_CD"	, paramMap.get("ORG_CD"));
    	mapResult.put("COMPLIST", commonSelectDAO.selectCompList(paramMap));
    	return mapResult;
    }
    
    public Map<String, Object> selectCheckEndData(Map<String, Object> paramMap) throws ServiceException, Exception {
    	Map<String, Object> mapResult = new HashMap<>();;
    	mapResult.putAll(commonSelectDAO.selectCheckEndData(paramMap));
    	return mapResult;
    }    

    public Map<String, Object> selectRequestItemList(Map<String, Object> paramMap) throws ServiceException, Exception {
    	Map<String, Object> mapResult = new HashMap<>();;
    	mapResult.put("REQUESTITEM1", commonSelectDAO.selectRequestItemList1(paramMap));
    	mapResult.put("REQUESTITEM2", commonSelectDAO.selectRequestItemList2(paramMap));
    	mapResult.put("REQUESTITEM3", commonSelectDAO.selectRequestItemList3(paramMap));
    	return mapResult;
    }    

    public Map<String, Object> selectStorageCompList(String Code) throws ServiceException, Exception {
    	Map<String, Object> mapResult = new HashMap<>();
		Map<String, Object> paramMap  = new HashMap<>();
		paramMap.put("CONFIRM_USER"	, getUserId());
    	mapResult.put("CODELIST_".concat(Code), commonSelectDAO.selectStorageCompList(paramMap));
    	return mapResult;
    }
    
    public Map<String, Object> selectStoragePlantList(String Code) throws ServiceException, Exception {
    	Map<String, Object> mapResult = new HashMap<>();
    	Map<String, Object> paramMap  = new HashMap<>();
    	paramMap.put("CONFIRM_USER"	, getUserId());
    	mapResult.put("CODELIST_".concat(Code), commonSelectDAO.selectStoragePlantList(paramMap));
    	return mapResult;
    }
    
    public Map<String, Object> selectStorageList(String Code) throws ServiceException, Exception {
    	Map<String, Object> mapResult = new HashMap<>();
    	Map<String, Object> paramMap  = new HashMap<>();
    	paramMap.put("CONFIRM_USER"	, getUserId());
    	mapResult.put("CODELIST_".concat(Code), commonSelectDAO.selectStorageList(paramMap));
    	return mapResult;
    }
    
    
}
