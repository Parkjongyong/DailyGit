package com.app.ildong.common.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ecbank.framework.exception.BizException;
import com.app.ildong.common.crypt.DigestUtil;
import com.app.ildong.common.dao.LoginAuthDAO;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.common.util.PropertiesUtil;


@Service("LoginAuthService")
public class LoginAuthService extends BaseService {

	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private LoginAuthDAO loginAuthDAO;
	
	@Autowired
    private DigestUtil digestUtil;
	
	@SuppressWarnings("static-access")
	public Map<String, Object> actionLogin(Map<String,Object> paramMap) throws BizException, Exception {
		paramMap.put("COMP_CD"	, getCompCd());
		paramMap.put("ROLE_PUR"	, PropertiesUtil.getProperty("ROLE_PUR"));
		
		Map<String,Object> userInfo = loginAuthDAO.selectUserLoginInfo(paramMap);
		
        System.out.println("=======================================");
        System.out.println("=actionLogin MODULE_TYPE=" + userInfo.get("MODULE_TYPE"));
        System.out.println("=======================================");
        paramMap.put("MODULE_TYPE", userInfo.get("MODULE_TYPE"));
		
		String userId = null;
		if( userInfo != null ) {
			//사용자 아이디 체크
			userId = StringUtils.defaultIfBlank( (String)userInfo.get("USER_ID"), "");
			if( "".equals(userId) ) {
				logger.error( "User Not Found Error : USER_ID is NULL");
				throw new BizException(getMessage("M1000005"));
			}
		} else {
			logger.error( "User Not Found Error : USER_INFO is NULL");
			throw new BizException(getMessage("M1000005"));
		}

		String loginPwd = (String)paramMap.get("USER_PWD");
		String userPwd = StringUtils.defaultIfBlank( (String)userInfo.get("PASSWORD"), "");

		// 패스워드 체크 LTYPE=CKATO&FWD_URL
		String ltype = paramMap.get("FWD_TYPE")==null?"":(String)paramMap.get("FWD_TYPE");
		if (!"CKATO".equals(ltype)) {
			if( digestUtil.matches(loginPwd, userPwd, userId ) == false) {
				String encryptedLoginPwd = digestUtil.digest(loginPwd, userId);
				if(userInfo.get("PASSWORD").equals(encryptedLoginPwd) == false) {
					logger.debug("PASSWORD = " + userInfo.get("PASSWORD"));
					logger.debug("USER_PWD = " + encryptedLoginPwd);
					throw new BizException(getMessage("M1000005"));
				}
				logger.error( "passwd not equals = " + encryptedLoginPwd);
				//if(!PropertiesUtil.isLocalMode()) {
				if(PropertiesUtil.isRealMode()) {
					throw new BizException(getMessage("M1000012"));
				}
			}
		}

		loginAuthDAO.updateUserLoginDt(paramMap);
		
		userInfo.remove("PASSWORD");
		return userInfo;
	}
	
	@SuppressWarnings("static-access")
	public Map<String, Object> actionSsoLogin(Map<String,Object> paramMap) throws BizException, Exception {
		paramMap.put("COMP_CD"	, getCompCd());
		paramMap.put("ROLE_PUR"	, PropertiesUtil.getProperty("ROLE_PUR"));
		
		Map<String,Object> userInfo = loginAuthDAO.selectSsoUserLoginInfo(paramMap);
		
		String userId = null;
		if( userInfo != null ) {
			//사용자 아이디 체크
			userId = StringUtils.defaultIfBlank( (String)userInfo.get("USER_ID"), "");
			if( "".equals(userId) ) {
				logger.error( "User Not Found Error : USER_ID is NULL");
				throw new BizException(getMessage("M1000005"));
			}
		} else {
			logger.error( "User Not Found Error : USER_INFO is NULL");
			throw new BizException(getMessage("M1000005"));
		}

		loginAuthDAO.updateUserLoginDt(paramMap);
		
		userInfo.remove("PASSWORD");
		return userInfo;
	}
	
	/**
	 * 사용자 Role 목록을 조회한다.
	 */
	public List<String> selectUserRoleListForLogin(Map<String, Object> paramMap) throws BizException, Exception  {
		
		return loginAuthDAO.selectUserRoleListForLogin(paramMap);

	}

	/**
	 * 사용자 Role 목록을 조회한다.
	 */
	public List<String> selectDeptRoleListForLogin(Map<String, Object> paramMap) throws BizException, Exception  {
		
		return loginAuthDAO.selectDeptRoleListForLogin(paramMap);

	}	
	
	/**
	 * 사용자 메뉴 목록을 조회한다.
	 */
	public List<Map<String,Object>> selectUserMenuList(Map<String, Object> paramMap) throws BizException, Exception  {
		
		return loginAuthDAO.selectUserMenuList(paramMap);
	}
	
	
	/**
	 * 사용자 이력을 저장한다.
	 */
	public void insertAccessHist(Map<String,Object> paramMap) throws BizException, Exception  {
		loginAuthDAO.insertAccessHist(paramMap);
	}
	
	/**
	 * 사용자 로그인 처리한다.
	 * 
	 * @return
	 * @throws Exception
	 */
	public Map<String,Object> actionLoginForInnerUser(Map<String, Object> paramMap) throws BizException, Exception  {
			
		Map<String,Object> userInfo = loginAuthDAO.selectUserLoginInfo(paramMap);
		
        System.out.println("=======================================");
        System.out.println("=actionLoginForInnerUser MODULE_TYPE=" + userInfo.get("MODULE_TYPE"));
        System.out.println("=======================================");
        paramMap.put("MODULE_TYPE", userInfo.get("MODULE_TYPE"));		
		
		String userId = null;
		if( userInfo != null ) {
			
			//사용자 아이디 체크
			userId = StringUtils.defaultIfBlank( (String)userInfo.get("USER_ID"), "");
			if( "".equals(userId) ) {
				logger.error( "User Not Found Error : USER_ID is NULL");
				throw new BizException(getMessage("M1000005"));
			}

		} else {
			logger.error( "User Not Found Error : USER_INFO is NULL");
			throw new BizException(getMessage("M1000005"));
		}

//		String loginPwd = (String)paramMap.get("USER_PWD");
//		String userPwd = StringUtils.defaultIfBlank( (String)userInfo.get("USER_PWD"), "");

		loginAuthDAO.updateUserLoginDt(paramMap);
		
		return userInfo;
	}

	public List<Map<String, Object>> selectUserFavoriteMenuList(Map<String, Object> paramMap) {
		return loginAuthDAO.selectUserFavoriteMenuList(paramMap);
	}
	
	public int insertUserFavoriteMenu(Map<String,Object> paramMap) throws Exception {
		return loginAuthDAO.insertUserFavoriteMenu(paramMap);
	}
	
	public int deleteUserFavoriteMenu(Map<String,Object> paramMap) throws Exception {
		return loginAuthDAO.deleteUserFavoriteMenu(paramMap);
	}
	
	public int allDeleteUserFavoriteMenu(Map<String,Object> paramMap) throws Exception {
		return loginAuthDAO.allDeleteUserFavoriteMenu(paramMap);
	}	
	
	public List<Map<String, Object>> selectNoticeList(Map<String, Object> paramMap) {
		return loginAuthDAO.selectNoticeList(paramMap);
	}
	
	public List<Map<String, Object>> selectTodoInfoList(Map<String, Object> paramMap) {
		return loginAuthDAO.selectTodoInfoList(paramMap);
	}
	
}
