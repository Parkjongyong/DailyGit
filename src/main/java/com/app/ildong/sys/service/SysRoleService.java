/**
 * 시스템관리 > 권한 관리 Service
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

import java.util.ArrayList;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ecbank.framework.exception.BizException;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.common.util.StringUtil;
import com.app.ildong.sys.dao.SysRoleDAO;


@Service("sysRoleService")
public class SysRoleService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private SysRoleDAO roleDAO;

	/**
	 * @param paramMap
	 * @return
	 * @throws Exception 
	 */
	public List<Map<String, Object>> selectRoleList(Map<String, Object> paramMap) throws Exception
	{
		return roleDAO.selectRoleList(paramMap);
	}
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectRoleDetailList(Map<String, Object> paramMap){
		return roleDAO.selectRoleDetailList(paramMap);
	}
	
	/**
	 * @param paramMap
	 * @return
	 * @throws BizException, Exception 
	 */
	@Transactional(rollbackFor=ServiceException.class)
	public Map<String, Object> updateRoleMenuList(Map<String, Object> paramMap) throws BizException, Exception{
	    String UP_MENU_CD = "ROOT";
	    
	    //권한 삭제
        roleDAO.deleteRoleMenuList(paramMap);
		if (paramMap.get("ITEM_LIST") != null) {
		    
		    for (Map<String, Object> dataMap : (List<Map<String, Object>>)paramMap.get("ITEM_LIST")) {
	                
		        Map <String,Object> oMap = new  HashMap();
		        
		        oMap.put("REG_ID" , getUserId());
                oMap.put("ROLE_CD", paramMap.get("ROLE_CD"));
		        
//		        if( (!"ROOT".equals(StringUtil.nvl(dataMap.get("UP_MENU_CD"), "")) && (!UP_MENU_CD.equals(StringUtil.nvl(dataMap.get("UP_MENU_CD"), ""))))){
//		            UP_MENU_CD = StringUtil.nvl(dataMap.get("UP_MENU_CD"), "");
//		            
//		            oMap.put("MENU_CD", UP_MENU_CD);
//		            roleDAO.insertRoleMenuList(oMap);
//		        }
	                
		        oMap.put("MENU_CD", dataMap.get("MENU_CD"));
		        
		        roleDAO.insertRoleMenuList(oMap); 
		    }
		}
			
		return paramMap;
	}

	/**
	 * @param paramMap
	 * @return
	 */
	public Map<String, Object> deleteRoleList(Map<String, Object> paramMap) throws BizException, Exception
	{
		paramMap.put("COMP_CD", getCompCd());
		
		//권한 삭제처리
		String [] roleArr = paramMap.get("roleCdArr").toString().split(",");
		
		if(roleArr != null && roleArr.length != 0)
		{
			for(String roleCd : roleArr)
			{
				paramMap.put("ROLE_CD", roleCd);
				roleDAO.deleteRoleList(paramMap);
			}
		}
			
		return paramMap;
	}
	
	/**
	 * @param paramMap
	 * @return
	 */
	@Transactional(rollbackFor=ServiceException.class)
	public Map<String, Object> updateRoleList(Map<String, Object> paramMap)throws BizException, Exception{
        
        Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
        List<Map<String, Object>> updList = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> insList = new ArrayList<Map<String, Object>>();
        
        if(!StringUtil.isEmpty( dataMap )){
            updList = (List<Map<String, Object>>)dataMap.get("UPDATED");
            insList = (List<Map<String, Object>>)dataMap.get("CREATED");
        }
        
        if (null != updList && 0 < updList.size()) {
            for (Map<String, Object> data: updList) {
                data.put("MOD_ID"   , getUserId());
                roleDAO.updateRoleList(data);
            }
        }
        
        if (null != insList && 0 < insList.size()) {
            for (Map<String, Object> data: insList) {
                data.put("INS_ID"   , getUserId());
                int checkList = roleDAO.selectCheckRoleCdExist(data);
                logger.error(checkList);
                if (0==checkList) {
                    roleDAO.insertRoleList(data);
                } else {
                    throw new ServiceException(getMessage("EBSYS0003", new Object [] {(String)data.get("ROLE_CD")}));
                }
            }
        }
		
		return paramMap;
	}
	
	/**
	 * @param paramMap
	 * @return
	 */
	@Transactional(rollbackFor=ServiceException.class)
	public Map<String, Object> delRoleList(Map<String, Object> paramMap)throws BizException, Exception{
		
		Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
        List<Map<String, Object>> delList = new ArrayList<Map<String, Object>>();
		
		if(!StringUtil.isEmpty( dataMap )){
            delList = (List<Map<String, Object>>)dataMap.get("DELETED");
		}
		
        if (null != delList && 0 < delList.size()) {
            for (Map<String, Object> data: delList) {
                data.put("MOD_ID"   , getUserId());
                roleDAO.deleteRoleList(data);
            }
        }
		
		return paramMap;
	}
	
	/**
	 * Role 할당 사용자 목록
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectRoleAssignmentUserList(Map<String, Object> paramMap) throws BizException, Exception
	{
		paramMap.put("COMP_CD", getCompCd());
		return roleDAO.selectRoleAssignmentUserList(paramMap);
	}
	
	/**
	 * Role 비할당 사용자 목록
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectRoleUnassignedUserList(Map<String, Object> paramMap) throws BizException, Exception{
		return roleDAO.selectRoleUnassignedUserList(paramMap);
	}
	
	/**
	 * Role 비할당 유저에게 권한 할당
	 * @param paramMap
	 * @return
	 * @throws BizException
	 * @throws Exception
	 */
	@Transactional(rollbackFor=ServiceException.class)
	public Map<String, Object> updateRoleUser(Map<String, Object> paramMap) throws BizException, Exception{
		
		int rCnt = 0;
        
        if (paramMap.get("ITEM_LIST") != null) {

            roleDAO.deleteRoleUser(paramMap);
            
            for (Map<String, Object> dataMap : (List<Map<String, Object>>)paramMap.get("ITEM_LIST")) {
                
                Map <String,Object> oMap = new  HashMap();
                
                oMap.put("USER_ID", dataMap.get("USER_ID"));
                oMap.put("ROLE_CD", paramMap.get("ROLE_CD"));
                oMap.put("INS_ID",  getUserId());
                
                rCnt += roleDAO.insertRoleUser(oMap);
            }
        }
        
        return paramMap;
	}
	
	/**
	 * Role 비할당 부서 목록 조회
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectRoleUnassignedDeptList(Map<String, Object> paramMap)
	{
		return roleDAO.selectRoleUnassignedDeptList(paramMap);
	}
	
	/**
	 * Role 할당 부서목록 조회
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectRoleAssignmentDeptList(Map<String, Object> paramMap)
	{
		return roleDAO.selectRoleAssignmentDeptList(paramMap);
	}
	
	/**
	 * 권한별 부서 할당.
	 * @param paramMap
	 * @return
	 * @throws BizException
	 * @throws Exception
	 */
	@Transactional(rollbackFor=ServiceException.class)
	public Map<String, Object> updateRoleDept(Map<String, Object> paramMap) throws BizException, Exception{
		
		int rCnt = 0;
        
        if (paramMap.get("ITEM_LIST") != null) {

            roleDAO.deleteRoleDept(paramMap);
            
            for (Map<String, Object> dataMap : (List<Map<String, Object>>)paramMap.get("ITEM_LIST")) {
                
                Map <String,Object> oMap = new  HashMap();
                
                oMap.put("DEPT_CD", dataMap.get("DEPT_CD"));
                oMap.put("ROLE_CD", paramMap.get("ROLE_CD"));
                oMap.put("INS_ID",  getUserId());
                
                rCnt += roleDAO.insertRoleDept(oMap);
            }
        }
        
        return paramMap;
	}
	
	/**
	 * 비할당 Role 조회(사용자별)
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectUnassignedRoleList(Map<String, Object> paramMap)
	{
		return roleDAO.selectUnassignedRoleList(paramMap);
	}
	
	/**
	 * 할당 Role 조회(사용자별)
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectAssignedRoleList(Map<String, Object> paramMap)
	{
		return roleDAO.selectAssignedRoleList(paramMap);
	}
	
	@Transactional(rollbackFor=ServiceException.class)
	public Map<String, Object> updateUserRole(Map<String, Object> paramMap) throws BizException, Exception{
	    int rCnt = 0;
        
        if (paramMap.get("ITEM_LIST") != null) {

            roleDAO.deleteUserRole(paramMap);
            
            for (Map<String, Object> dataMap : (List<Map<String, Object>>)paramMap.get("ITEM_LIST")) {
                
                Map <String,Object> oMap = new  HashMap();
                
                oMap.put("USER_ID", paramMap.get("S_USER_ID"));
                oMap.put("ROLE_CD", dataMap.get("ROLE_CD"));
                oMap.put("INS_ID",  getUserId());
                
                rCnt += roleDAO.insertUserRole(oMap);
            }
        }
		
		return paramMap;
	}
	
	/**
	 * 비할당 Role 조회(부서별)
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectUnassignedDeptRoleList(Map<String, Object> paramMap)
	{
		return roleDAO.selectUnassignedDeptRoleList(paramMap);
	}
	
	/**
	 * 할당 Role 조회(부서별)
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectAssignedDeptRoleList(Map<String, Object> paramMap)
	{
		return roleDAO.selectAssignedDeptRoleList(paramMap);
	}
	
	/**
	 * 부서별 권한 수정
	 * @param paramMap
	 * @return
	 * @throws BizException
	 * @throws Exception
	 */
	public Map<String, Object> updateDeptRole(Map<String, Object> paramMap) throws BizException, Exception{
	    int rCnt = 0;
        
        if (paramMap.get("ITEM_LIST") != null) {

            roleDAO.deleteDeptRole(paramMap);
            
            for (Map<String, Object> dataMap : (List<Map<String, Object>>)paramMap.get("ITEM_LIST")) {
                
                Map <String,Object> oMap = new  HashMap();
                
                oMap.put("DEPT_CD", paramMap.get("S_DEPT_CD"));
                oMap.put("ROLE_CD", dataMap.get("ROLE_CD"));
                oMap.put("INS_ID",  getUserId());
                
                rCnt += roleDAO.insertDeptRole(oMap);
            }
        }
        
        return paramMap;
	}
	
	public List<Map<String, Object>> selectDeptList(Map<String, Object> paramMap) {
        return roleDAO.selectDeptList(paramMap);
    }
	
	/**
	 * @param paramMap
	 * @return
	 * @throws BizException, Exception 
	 */
	@Transactional(rollbackFor=ServiceException.class)
	public Map<String, Object> updateUserMenuList(Map<String, Object> paramMap) throws BizException, Exception{
		
		//사용자별 메뉴 저장
		if (paramMap.get("ITEM_LIST") != null) {
			
			for (Map<String, Object> dataMap : (List<Map<String, Object>>)paramMap.get("ITEM_LIST")) {
				
				Map <String,Object> oMap = new  HashMap();
				
				oMap.put("INS_ID" , getUserId());
				
				oMap.put("USER_ID", paramMap.get("USER_ID"));
				oMap.put("MENU_CD", dataMap.get("MENU_CD"));
				oMap.put("MENU_USE_YN", dataMap.get("MENU_USE_YN"));
				roleDAO.updateUserMenuList(oMap);
			}
		}
		
		return paramMap;
	}

	/**
	 * @param paramMap
	 * @return
	 * @throws BizException, Exception 
	 */
	@Transactional(rollbackFor=ServiceException.class)
	public Map<String, Object> resetUserMenuList(Map<String, Object> paramMap) throws BizException, Exception{
		roleDAO.resetUserMenuList(paramMap);
		return paramMap;
	}
	
	public List<Map<String, Object>> selectUserViewList(Map<String, Object> paramMap) {
		Map<String,Object> oChkMap = roleDAO.userMenuCnt(paramMap);
		if(!"0".equals(String.valueOf(oChkMap.get("CNT")))) {
			return roleDAO.selectUserViewList(paramMap);	
		} else {
			return roleDAO.selectDeptViewList(paramMap);
		}
	}
	

}
