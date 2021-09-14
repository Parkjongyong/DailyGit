package com.app.ildong.common.model.mvc;


import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.ObjectUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.app.ildong.common.service.CommonSelectService;
import com.app.ildong.common.session.UserSessionUtil;
import com.app.ildong.common.util.PropertiesUtil;
import com.app.ildong.common.util.WebUtil;
import com.ecbank.framework.exception.BizException;

public class BaseController extends CommonController {

	int _default_start_row 		= 0;
	int _default_max_page_size 	= 999999;
	
	@Autowired
    private CommonSelectService commonSelectService;	
	
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
	 * @param paramMap
	 * @return
	 * @throws BizException
	 * @throws Exception
	 */
	public void checkEndData(Map<String,Object> paramMap) throws BizException, Exception {
		
		Map<String,Object> oChkMap = commonSelectService.selectCheckEndData(paramMap);
		if(!"Y".equals(String.valueOf(oChkMap.get("USE_YN")))) {
			System.out.println("CHK_END_DATA       - N");
			throw new Exception("마감기한이 지났습니다. 확인 후 작업하세요.");//마감기한이 지났습니다. 확인 후 작업하세요.
		} else {
			System.out.println("CHK_END_DATA       - Y");
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
	 * @return the userId
	 */
	public String getUserId() throws Exception {
		
		Map<String,Object> userinfo  = UserSessionUtil.getUserSession(this.getRequest());

		return (String)userinfo.get("USER_ID");
	}
	
	/**
	 * @return the userNm
	 */
	public String getUserNm() throws Exception {
		
		Map<String,Object> userinfo  = UserSessionUtil.getUserSession(this.getRequest());

		return (String)userinfo.get("USER_NM");
	}
	
	/**
	 * @return the vendCode
	 */
	public String getVendCode() throws Exception {
		
		Map<String,Object> userinfo  = UserSessionUtil.getUserSession(this.getRequest());

		return (String)userinfo.get("VENDOR_CD");
	}
	
	/**
	 * @return the userNm
	 */
	public String getVendName() throws Exception {
		
		Map<String,Object> userinfo  = UserSessionUtil.getUserSession(this.getRequest());

		return (String)userinfo.get("VENDOR_NM");
	}	

	
	/**
	 * @return the userDept
	 */
	public String getDeptCd() throws Exception  {
		Map<String,Object> userinfo  = UserSessionUtil.getUserSession(this.getRequest());
		
		return String.valueOf( userinfo.get("DEPT_CD") );
	}
	
	/**
	 * @return the userDeptNm
	 */
	public String getDeptNm() throws Exception  {
		Map<String,Object> userinfo  = UserSessionUtil.getUserSession(this.getRequest());
		return (String)userinfo.get("DEPT_NM");
	}
	
	/**
	 * @return the userDeptRole
	 */
	@SuppressWarnings("unchecked")
	public List<String> getDeptRole() throws Exception  {
		Map<String,Object> userinfo  = UserSessionUtil.getUserSession(this.getRequest());
		return (List<String>)userinfo.get("DEPT_ROLE");
	}
	
	@SuppressWarnings("unchecked")
	public List<String> getUserRole() throws Exception  {
		Map<String,Object> userinfo  = UserSessionUtil.getUserSession(this.getRequest());
		return (List<String>)userinfo.get("ROLE_LIST");
	}
	
	@SuppressWarnings("unchecked")
	public String getUserCls() throws Exception  {
		Map<String,Object> userinfo  = UserSessionUtil.getUserSession(this.getRequest());
		return (String)userinfo.get("USER_CLS");
	}	
	
	
	/**
	 * @return the userIp
	 */
	public String getUserIp() throws Exception  {

		return WebUtil.getClientIP(this.getRequest());
	}
	
	public String getServerIp() throws Exception {
		try
		{
		    for (Enumeration<NetworkInterface> en = NetworkInterface.getNetworkInterfaces(); en.hasMoreElements();)
		    {
		        NetworkInterface intf = en.nextElement();
		        for (Enumeration<InetAddress> enumIpAddr = intf.getInetAddresses(); enumIpAddr.hasMoreElements();)
		        {
		            InetAddress inetAddress = enumIpAddr.nextElement();
		            if (!inetAddress.isLoopbackAddress() && !inetAddress.isLinkLocalAddress() && inetAddress.isSiteLocalAddress())
		            {
		            	return inetAddress.getHostAddress().toString();
		            }
		        }
		    }
		}
		catch (SocketException ex) {}
		return null;
	}
	
	public String getServerName() throws Exception {
		return getRequest().getScheme()+"://"+getRequest().getServerName()+":"+getRequest().getServerPort();
	}
	
	/**
	 * @return the userId
	 */
	public String getUserBiz() throws Exception {
		
		Map<String,Object> userinfo  = UserSessionUtil.getUserSession(this.getRequest());

		return (String)userinfo.get("BIZ");
	}
	
	
	/**
	 * 저장 권한 체크
	 * @param request
	 * @return
	 */
	public void checkAuthSave(Map<String,Object>paramMap) throws BizException, Exception {

		try {
			String gMenuNo = StringUtils.defaultIfBlank((String)paramMap.get("G_MENU_NO"), "");
	
			Boolean existSaveAuth = false;
			if( ! "".equals(gMenuNo) ) {
				Map<String,Object> menuMap = (Map<String,Object>)this.getSessionAttribute("MENU_MAP");
				if( menuMap != null && menuMap.containsKey(gMenuNo)) {
					Map<String,Object> menuInfo = (Map<String,Object>)menuMap.get(gMenuNo);
					
					if( menuInfo != null ) {
						String authSave = StringUtils.defaultIfBlank((String)menuInfo.get("AUTH_SAVE") , "N");
						
						if( "Y".equals( authSave)) {
							existSaveAuth = true;
						} 
					}
				}
			}
			
			if( existSaveAuth == false) {
				throw new BizException( getMessage( "NOT_EXIST_AUTH_SAVE") );
			}
		} catch( Exception e) {
			throw e;
		}
		
	}
	
	
	
	/**
	 * @return the REP_USER_YN 
	 */
	public String getRepUserYn() throws Exception  {
		Map<String,Object> userinfo  = UserSessionUtil.getUserSession(this.getRequest());
		return (String)userinfo.get("REP_USER_YN");
	}
	

	/**
	 * @return the PUR_USER_YN 구매업무 롤 유저여부 
	 */
	public String getPurUserYn() throws Exception  {
		Map<String,Object> userinfo  = UserSessionUtil.getUserSession(this.getRequest());
		return (String)userinfo.get("PUR_USER");
	}

	
	/**
	 * @return 공급업체 대표사용자 여부( 공급사 사이트에서만 사용)
	 */
	public String getCmpnyUsryn() throws Exception  {
		Map<String,Object> userinfo  = UserSessionUtil.getUserSession(this.getRequest());
		return (String)userinfo.get("REP_USER_YN");
	}
	
	public int getStartRow(Map<String, Object> paramMap) throws Exception {
		int startRow = _default_start_row;
		if (null!=paramMap && null!=paramMap.get("page") && null!=paramMap.get("rows") 
				&& ""!=(String)paramMap.get("page") && ""!=(String)paramMap.get("rows")) {
			int page	= Integer.parseInt((String)ObjectUtils.defaultIfNull(paramMap.get("page"), "0"));
			int pageSize= Integer.parseInt((String)ObjectUtils.defaultIfNull(paramMap.get("rows"), "0"));
			
			startRow 	= (page - 1) * pageSize;
		}
		
		return startRow;
	}
	
	public int getPageSize(Map<String, Object> paramMap) throws Exception {
		int pageSize = _default_max_page_size;
		if (null!=paramMap && null!=paramMap.get("page") && null!=paramMap.get("rows") 
				&& ""!=(String)paramMap.get("page") && ""!=(String)paramMap.get("rows")) {
			pageSize= Integer.parseInt((String)ObjectUtils.defaultIfNull(paramMap.get("rows"), "0"));
		}
		return pageSize;
	}
	
	public void setSessionParam(Map<String, Object> paramMap) {
		try {
			//구매권한롤 유저여부
			paramMap.put("SS_PUR_USER_YN", getPurUserYn());
			//부서정보
			paramMap.put("SS_USER_DEPT_CD", getDeptCd());
			//부서정보
			paramMap.put("SS_USER_DEPT_NM", getDeptNm());
			//사용자ID
			paramMap.put("SS_USER_ID", getUserId());
			//사용자명
			paramMap.put("SS_USER_NM", getUserNm());
			
			//시스템관리자
			paramMap.put("SS_SYSADMIN_YN", StringUtils.indexOf(String.join(",",getUserRole()),"SYS001") != -1?"Y":"N");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
