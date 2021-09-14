package com.app.ildong.sys.service;

import java.math.BigDecimal;
import com.app.ildong.common.crypt.DigestUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ecbank.framework.exception.BizException;
import com.app.ildong.common.dao.LoginAuthDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.common.service.LoginAuthService;
import com.app.ildong.common.util.PropertiesUtil;
import com.app.ildong.common.util.StringUtil;
import com.app.ildong.sys.dao.SysUserDAO;

@Service("sysUserService")
public class SysUserService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private SysUserDAO userDAO;
	
	@Autowired
    private LoginAuthDAO loginAuthDAO;
	
	@Autowired
    private LoginAuthService loginAuthService;
	
	@Autowired
    private DigestUtil digestUtil;

	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectUserList(Map<String, Object> paramMap){
		return userDAO.selectUserList(paramMap);
	}
	
	public Integer selectUserListCount( Map<String,Object> paramMap ) throws Exception {
    	return userDAO.selectUserListCount(paramMap);
    }
	
	public List<Map<String,Object>> selectUsersList(Map<String,Object> paramMap) {
		
		try {
			if ("PUR".equals((String)paramMap.get("SRCH_ROLE"))) {
				String[] arrRoleCd = PropertiesUtil.getProperty("ROLE_PUR").split(",");
				paramMap.put("ROLE_LIST", arrRoleCd);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return userDAO.selectUsersList(paramMap);
	}
	
	public List<Map<String,Object>> selectPerUsersList(Map<String,Object> paramMap) {
        return userDAO.selectPerUsersList(paramMap);
    }
	
	public Map<String,Object> sendUserInfo(Map<String,Object> paramMap) {
        return userDAO.sendUserInfo(paramMap);
    }
	
	/**
     * 공급업체 사용자전환
     * @param paramMap
     * @return
     * @throws BizException
     * @throws Exception
     */
    public Map<String, Object> selectUserLoginInfo(Map<String, Object> paramMap) throws BizException, Exception{
        
        Map<String, Object> userInfo = new HashMap<String, Object>();

        String USER_ID = StringUtil.nvl(paramMap.get("PASSWD"), "");
        
        if(!"".equals( USER_ID )){
            USER_ID = USER_ID.replace("@00", "");
            
            paramMap.put("USER_ID", USER_ID);
            
            userInfo = loginAuthDAO.selectUserLoginInfo(paramMap);
            
            System.out.println("=======================================");
            System.out.println("=selectUserLoginInfo MODULE_TYPE=" + userInfo.get("MODULE_TYPE"));
            System.out.println("=======================================");
            paramMap.put("MODULE_TYPE", userInfo.get("MODULE_TYPE"));
            
            List<String> userRoleList = loginAuthService.selectUserRoleListForLogin(paramMap);
            userInfo.remove("PASSWORD");
            
            paramMap.put("ROLE_LIST", userRoleList);
            userInfo.put("ROLE_LIST", userRoleList);
            userInfo.put("PUR_USER", "N");
            if(userRoleList.contains("PUR002") || userRoleList.contains("PUR003") || userRoleList.contains("SYS001")) {
                //구매롤 유저
                userInfo.put("PUR_USER", "Y");
            }
            
            List<String> deptRoleList = loginAuthService.selectDeptRoleListForLogin(paramMap);
            userInfo.put("DEPT_ROLE", deptRoleList);
            paramMap.put("ROLE_LIST", userRoleList);
            
            List<Map<String,Object>> userMenuList = loginAuthService.selectUserMenuList(paramMap);

            LinkedHashMap<String,Object> topMenuLinkedMap = new LinkedHashMap<String,Object>();
            LinkedHashMap<String,Object> menuLinkedMap = new LinkedHashMap<String,Object>();
            LinkedHashMap<String,Object> subMenuLinkedMap = new LinkedHashMap<String,Object>();
			String firstTopMenuNo   = "";
			String firstTopMenuName = "";

            
            if( userMenuList != null ) {
                String currTopMenuNo = "";
                String currSubTopMenuNo = "";
                
                List<Map<String,Object>> childMenuList = null;
                List<Map<String,Object>> subChildMenuList = null;
                for( int i = 0, nSize = userMenuList.size(); i < nSize; i++) {
                    Map<String,Object> menuInfo = userMenuList.get(i);
                    String menuNo = StringUtils.defaultIfBlank((String)menuInfo.get("MENU_CD"), "");
					String menuName = StringUtils.defaultIfBlank((String)menuInfo.get("MENU_NM"), "");
                    if( ! "".equals(menuNo)) {
                        menuLinkedMap.put(menuNo, menuInfo);
						// top 메뉴중 가장 왼쪽의 메뉴no
						if (i == 0) {
							firstTopMenuNo   = menuNo;
							firstTopMenuName = menuName;
						}
                        
                        BigDecimal bdMenuDepth = new BigDecimal(String.valueOf(menuInfo.get("MENU_DEPTH")));
						if( bdMenuDepth.compareTo( new BigDecimal(1)) == 0 ) {
							if( ! currTopMenuNo.equals( menuNo )) {
								currTopMenuNo = menuNo;
								childMenuList = new ArrayList<Map<String,Object>>();
								
								menuInfo.put("CHILD_MENU_LIST", childMenuList);
								topMenuLinkedMap.put(menuNo, menuInfo);
							}
						} else {
							if( childMenuList != null ) {
								childMenuList.add(menuInfo);
							}
							
							if( bdMenuDepth.compareTo( new BigDecimal(2)) == 0 ) {
								if( ! currSubTopMenuNo.equals( menuNo )) {
									currSubTopMenuNo = menuNo;
									subChildMenuList = new ArrayList<Map<String,Object>>();
									
									menuInfo.put("SUB_CHILD_MENU_LIST", subChildMenuList);
									subMenuLinkedMap.put(menuNo, menuInfo);
								}									
								
							} else {
								if( subChildMenuList != null ) {
									subChildMenuList.add(menuInfo);
								}
							}
						}
                    }
                }
            }
            userInfo.put("TOP_MENU_MAP", topMenuLinkedMap);
			userInfo.put("FIRST_MENU_NO"  , firstTopMenuNo);
			userInfo.put("FIRST_MENU_NAME", firstTopMenuName);
            userInfo.put("MENU_MAP", menuLinkedMap);
			userInfo.put("SUB_MENU_MAP"   , subMenuLinkedMap);
            
            List<Map<String,Object>> userFavoriteMenuList = loginAuthService.selectUserFavoriteMenuList(paramMap);
            userInfo.put("FAVORITE_MENU", userFavoriteMenuList);
        }
        
        if( userInfo == null){
            throw new ServiceException("로그인 정보가 없습니다.");
        }
        
        return userInfo;
    }
    
    public Map<String,Object> saveInitPw(Map<String,Object> paramMap) throws ServiceException, Exception {
    	String userId            =  (String) paramMap.get("USER_ID");
		String encryptedPwd      = digestUtil.digest("#"+userId, userId);
		paramMap.put("USER_PW", encryptedPwd);
        userDAO.saveInitPw(paramMap);
        
    	return paramMap;
    }
    
}