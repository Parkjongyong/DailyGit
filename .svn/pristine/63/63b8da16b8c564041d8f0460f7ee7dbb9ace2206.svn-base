package com.app.ildong.common.model.mvc;


import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.app.ildong.common.session.UserSessionUtil;
import com.app.ildong.common.util.PropertiesUtil;
import com.app.ildong.common.util.WebUtil;

public class BaseService extends CommonService {


   /**
    * request정보를 구한다.
    * 
    * @param String  attribute key name
    * @return Object attribute obj
    */
   public static HttpServletRequest getRequest() {

	   return ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
   }	
	
	/**
	 * Servlet Request 정보를 구한다.
	 * 
	 * @return
	 */
	public ServletRequestAttributes getServletRequestAttributes() throws Exception{

		return (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
	}


	
	/**
	 * @return UserSession 이 특정값 리턴
	 */
	public Object getSessionAttribute(String key) throws Exception {
		Map<String,Object> userinfo  = UserSessionUtil.getUserSession(this.getRequest());
		return userinfo.get(key);
	}
	
	/**
	 * @return the userId
	 */
	public String getUserId() throws Exception {
		Map<String,Object> userinfo  = null;
		try {
			userinfo  = UserSessionUtil.getUserSession(this.getRequest());
			return (String)userinfo.get("USER_ID");
		} catch (Exception e) {
			return "system";
		}
	}
	
	/**
	 * @return the compCd
	 */
	public String getCompCd() throws Exception {
		Map<String,Object> userinfo  = null;
		try {
			userinfo  = UserSessionUtil.getUserSession(this.getRequest());
			if (null==userinfo || "".equals((String)userinfo.get("COMP_CD"))) {
				return PropertiesUtil.getProperty("COMP_CD");
			} else {
				return (String)userinfo.get("COMP_CD");
			}
		} catch (Exception e) {
			return PropertiesUtil.getProperty("COMP_CD");
		}
	}
	
	/**
	 * @return the userNm
	 */
	public String getUserNm() throws Exception {
		Map<String,Object> userinfo  = null;
		try {
			userinfo  = UserSessionUtil.getUserSession(this.getRequest());
			if (null==userinfo) {
				return "system";
			} else {
				return (String)userinfo.get("USER_NM");
			}
		} catch (Exception e) {
			return "system";
		}
	}
	
	
	/**
	 * @return the userDept
	 */
	public String getDeptCd() throws Exception  {
		Map<String,Object> userinfo  = UserSessionUtil.getUserSession(this.getRequest());
		return (String)userinfo.get("DEPT_CD");
	}
	
	/**
	 * @return the userDeptNm
	 */
	public String getDeptNm() throws Exception  {
		Map<String,Object> userinfo  = UserSessionUtil.getUserSession(this.getRequest());
		return (String)userinfo.get("DEPT_NM");
	}
	
	
	/**
	 * @return the userIp
	 */
	public String getUserIp() throws Exception  {

		return WebUtil.getClientIP(this.getRequest());
	}
	
	/**
	 * @return the REP_USER_YN 
	 */
	public String getRepUserYn() throws Exception  {
		Map<String,Object> userinfo  = UserSessionUtil.getUserSession(this.getRequest());
		return (String)userinfo.get("REP_USER_YN");
	}
	
	
	/**
	 * @return 공급업체 코드( 공급사 사이트에서만 사용)
	 */
	public String getVndCd() throws Exception  {
		Map<String,Object> userinfo  = UserSessionUtil.getUserSession(this.getRequest());
		return (String)userinfo.get("VND_CD");
	}
	
	/**
	 * @return 공급업체 대표사용자 여부( 공급사 사이트에서만 사용)
	 */
	public String getCmpnyUsryn() throws Exception  {
		Map<String,Object> userinfo  = UserSessionUtil.getUserSession(this.getRequest());
		return (String)userinfo.get("REP_USER_YN");
	}
	
	public String getServerName() throws Exception {
		return getRequest().getScheme()+"://"+getRequest().getServerName()+":"+getRequest().getServerPort();
	}
	
	public void setSessionParam(Map<String, Object> paramMap) {
		try {
			//부서정보
			paramMap.put("SS_USER_DEPT_CD", getDeptCd());
			//부서정보
			paramMap.put("SS_USER_DEPT_NM", getDeptNm());
			//사용자ID
			paramMap.put("SS_USER_ID", getUserId());
			//사용자명
			paramMap.put("SS_USER_NM", getUserNm());
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
}