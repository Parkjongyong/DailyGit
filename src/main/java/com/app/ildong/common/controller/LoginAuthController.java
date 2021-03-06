package com.app.ildong.common.controller;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.mail.Session;
import javax.naming.Context;
import javax.naming.NamingEnumeration;
import javax.naming.directory.Attribute;
import javax.naming.directory.Attributes;
import javax.naming.directory.SearchControls;
import javax.naming.directory.SearchResult;
import javax.naming.ldap.InitialLdapContext;
import javax.naming.ldap.LdapContext;
import javax.servlet.ServletRequest;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AccountExpiredException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.WebAttributes;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.app.ildong.common.auth.DefaultUserDetails;
import com.app.ildong.common.model.JsonData;
import com.app.ildong.common.model.mvc.BaseController;
import com.app.ildong.common.service.LoginAuthService;
import com.app.ildong.common.session.UserSessionUtil;
import com.app.ildong.common.util.PropertiesUtil;
import com.app.ildong.common.util.StringUtil;
import com.app.ildong.sys.service.SysMainImageService;
import com.ecbank.framework.exception.BizException;
import com.ildong.EPSEncryption;
import com.nets.sso.agent.AuthCheck;
import com.nets.sso.agent.enums.AuthStatus;

@Controller
public class LoginAuthController extends BaseController {
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private LoginAuthService loginAuthService;
	
    @Autowired 
    private SysMainImageService sysMainImageService;
	
	
	/**
	 * ?????? ????????? ???????????? ????????????
	 */
	@RequestMapping(value = {"/", "/loginView.do"})
	public String loginView(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws Exception {
		String srvType 		= "";
		String srvTypeName 	= "";
		System.out.println("-----------------------------");
		System.out.println("RealMode : " + PropertiesUtil.isRealMode());
		System.out.println("DevMode : " + PropertiesUtil.isDevMode());
		System.out.println("LocalMode : " + PropertiesUtil.isLocalMode());
		System.out.println("-----------------------------");
		
		HttpSession session = request.getSession();
		Cookie cookies[] =  request.getCookies();
		
		if(cookies != null) {
			for(int i = 0; i < cookies.length; i++) {
				if("JSESSIONID".equals(cookies[i].getName())) {
					session.setAttribute("JSESSIONID", cookies[i].getValue());
				}
			}
		}

		if (PropertiesUtil.isRealMode()) {
			srvType		=	"production";
			srvTypeName =	"????????????"; 
//			String smUserIps = PropertiesUtil.getProperty("sm.user.ip");
//		    if(smUserIps.indexOf(request.getRemoteHost()) == -1 && !"127.0.0.1".equals(request.getRemoteHost())) {
//		    	ModelAndView modelAndView = new ModelAndView("redirect:/common/error/noauth.jsp");
//	        	throw new ModelAndViewDefiningException(modelAndView);
//		    }
			
		} else if (PropertiesUtil.isDevMode()) {
			srvType		=	"dev";
			srvTypeName =	"????????????";
		} else if (PropertiesUtil.isLocalMode()) {
			srvType		=	"local";
			srvTypeName =	"LOCAL SYSTEM";
		} else {
			srvType		=	"NONE";
			srvTypeName =	"WHAT[" + PropertiesUtil.getProperty("runtime.mode") + "]";
		}
		model.put("SRV_TYPE"	, srvType);
		model.put("SRV_TYPE_NM"	, srvTypeName);
		
		return "loginView";
	}
	
	/**
	 * ?????? ????????? ???????????? ????????????
	 */
	@RequestMapping(value = {"/", "/loginViewExternal.do"})
	public String loginViewExternal(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws Exception {
		String srvType 		= "";
		String srvTypeName 	= "";
		System.out.println("-----------------------------");
		System.out.println("RealMode : " + PropertiesUtil.isRealMode());
		System.out.println("DevMode : " + PropertiesUtil.isDevMode());
		System.out.println("LocalMode : " + PropertiesUtil.isLocalMode());
		System.out.println("-----------------------------");
		
		if (PropertiesUtil.isRealMode()) {
			srvType		=	"production";
			srvTypeName =	"????????????"; 
//			String smUserIps = PropertiesUtil.getProperty("sm.user.ip");
//			if(smUserIps.indexOf(request.getRemoteHost()) == -1 && !"127.0.0.1".equals(request.getRemoteHost())) {
//				ModelAndView modelAndView = new ModelAndView("redirect:/common/error/noauth.jsp");
//				throw new ModelAndViewDefiningException(modelAndView);
//			}
			
		} else if (PropertiesUtil.isDevMode()) {
			srvType		=	"dev";
			srvTypeName =	"????????????";
		} else if (PropertiesUtil.isLocalMode()) {
			srvType		=	"local";
			srvTypeName =	"LOCAL SYSTEM";
		} else {
			srvType		=	"NONE";
			srvTypeName =	"WHAT[" + PropertiesUtil.getProperty("runtime.mode") + "]";
		}
		model.put("SRV_TYPE"	, srvType);
		model.put("SRV_TYPE_NM"	, srvTypeName);

		List<Map<String,Object>> noticeInfo = loginAuthService.selectNoticeList(paramMap);
    	model.addAttribute("noticeInfo", noticeInfo);
    	
    	model.addAttribute("outImgList", sysMainImageService.selectOutImageList(paramMap));

		
		return "loginViewExternal";
	}
	
	/**
	 * ?????? ???????????? ????????????
	 * @param vo - ?????????, ??????????????? ?????? LoginVO
	 * @param request - ??????????????? ?????? HttpServletRequest
	 * @return result - ???????????????(????????????)
	 * @exception Exception
	 */
	@RequestMapping(value = "/login.do")
	public String actionLogin(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, ModelMap model, RedirectAttributes redirectAttr) throws Exception {
		System.out.println("----------------- actionLogin in ------------");
		paramMap.put("COMP_CD", getCompCd());
		String _userId    = StringUtils.defaultIfBlank( (String)paramMap.get("USER_ID"), "");
		String _passWord  = StringUtils.defaultIfBlank( (String)paramMap.get("USER_PWD"), "");
		String _linkParam = StringUtils.defaultIfBlank( (String)paramMap.get("LINK_PARAM1"), "");
		String _userCls   = StringUtils.defaultIfBlank( (String)paramMap.get("USER_CLS"), "");
		
		HttpSession session = request.getSession();
		Cookie cookies[] =  request.getCookies();
		
		if(cookies != null) {
			for(int i = 0; i < cookies.length; i++) {
				if("JSESSIONID".equals(cookies[i].getName())) {
					if(!session.getAttribute("JSESSIONID").equals(cookies[i].getValue())) {
						logger.info("######SESSION ERROR######");
						return "redirect:/common/error/noaccess.jsp";
					}
				}
			}
		} else {
			logger.info("######cookies is null######");
			return "redirect:/common/error/noaccess.jsp";
		}
		
		Map<String,Object> userinfo  = null;
		try {
			userinfo  = UserSessionUtil.getUserSession(request);
			
			// ???????????? param??? ???????????? ?????? ????????? ??????????????? ?????? ??????
			if (!"".equals(_linkParam)) {
				EPSEncryption epsenc = new EPSEncryption();
				_userId = epsenc.decode(StringUtil.isNullToString((String) (paramMap.get("LINK_PARAM1"))));
				if (_userId.trim().length() == 6) {
					paramMap.put("USER_ID"   , _userId);
					paramMap.put("FWD_TYPE"  , "CKATO");					
				}
			} else {
				// ?????????????????? AD??????
//				if ("B".equals(_userCls)) {
//					HashMap<String, Object> resultMap = null;
//					
//					Hashtable<String, String> usrEnv = new Hashtable<String, String>();
//					usrEnv.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
//					usrEnv.put(Context.PROVIDER_URL, PropertiesUtil.getProperty("ldap.Url"));
//					usrEnv.put(Context.SECURITY_AUTHENTICATION, "simple");			
//					usrEnv.put(Context.SECURITY_CREDENTIALS, _passWord);
//					usrEnv.put(Context.SECURITY_PRINCIPAL, _userId+"@"+PropertiesUtil.getProperty("ldap.Domain"));
//					//System.out.println("ldap.Url::" + PropertiesUtil.getProperty("ldap.Url"));
//					//System.out.println("ldap.Domain::" + PropertiesUtil.getProperty("ldap.Domain"));
//					//System.out.println("ldap.SearchBase1::" + PropertiesUtil.getProperty("ldap.SearchBase1"));
//					//System.out.println("ldap.SearchBase2::" + PropertiesUtil.getProperty("ldap.SearchBase2"));
//					
//					LdapContext userCtx = new InitialLdapContext(usrEnv, null);
//					
//					SearchControls sc = new SearchControls();
//					sc.setSearchScope(SearchControls.SUBTREE_SCOPE);
//					
//					NamingEnumeration<?> results = userCtx.search("DC="+ PropertiesUtil.getProperty("ldap.SearchBase1") + ",DC=" + PropertiesUtil.getProperty("ldap.SearchBase2"), "sAMAccountName=" + _userId, sc);
//					
//					while (results.hasMoreElements()) {
//						SearchResult sr = (SearchResult) results.next();
//						Attributes attrs = sr.getAttributes();
//						
//						if (attrs != null) {
//							resultMap = new HashMap<String, Object>();
//							NamingEnumeration<?> ne = attrs.getAll();
//							while (ne.hasMore()) {
//								Attribute attr = (Attribute) ne.next();
//								System.out.println(attr.getID() + " : " +  attr.get());
//								resultMap.put(attr.getID(), attr.get());
//							}
//							ne.close();
//						}
//					}
//					// ?????? ????????? ???????????? ?????? 
//					if (_userId.equals(StringUtil.isNullToString(resultMap.get("cn")).trim())) {
//						paramMap.put("USER_ID"   , _userId);
//						paramMap.put("FWD_TYPE"  , "CKATO");						
//					}
//				}					
			}
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}	
		if (null!=userinfo)	{
			if (((String)paramMap.get("USER_ID")).equals((String)userinfo.get("USER_ID"))) {
				return "redirect:/main.do";	
			}
		}
			
		try {
			if( logger.isDebugEnabled()) {
				logger.debug("paramMap = " + paramMap);
				logger.debug("getRequestedSessionId = " + request.getRequestedSessionId());
			}
			
			Map<String,Object> userInfo = loginAuthService.actionLogin(paramMap);
				
				
			if( logger.isDebugEnabled()) {
				logger.debug("userInfo = " + userInfo);
			}
			boolean isValidUser = false;
			
			if (userInfo != null ) {
				String userId = (String)userInfo.get("USER_ID");
				
				if( userId != null ) {
					isValidUser = true;
				} 
			}
				
			if( isValidUser == true ) {
				System.out.println("isValidUser == true IN");
				List<String> userRoleList = loginAuthService.selectUserRoleListForLogin(paramMap);
				
				System.out.println("userRoleList.size()::" + userRoleList.size());
				if (0==userRoleList.size()){
					try {
						insertAccessHist(_userId, "N", "???????????? ??????");
					} catch (Exception e) {
						logger.error(e.getMessage());
					}
					
					model.addAttribute("message", getMessage("M1000022"));
					return "loginView";
				}
				
				userInfo.put("ROLE_LIST", userRoleList);
				userInfo.put("PUR_USER", "N");
				if(userRoleList.contains("PUR002") || userRoleList.contains("PUR003") || userRoleList.contains("SYS001")) {
					//????????? ??????
					userInfo.put("PUR_USER", "Y");
				}
				
				List<String> deptRoleList = loginAuthService.selectDeptRoleListForLogin(paramMap);
				userInfo.put("DEPT_ROLE", deptRoleList);
				
				paramMap.put("ROLE_LIST", userRoleList);
				List<Map<String,Object>> userMenuList = loginAuthService.selectUserMenuList(paramMap);
	
				LinkedHashMap<String,Object> topMenuLinkedMap = new LinkedHashMap<String,Object>();
				LinkedHashMap<String,Object> subMenuLinkedMap = new LinkedHashMap<String,Object>();
				
				LinkedHashMap<String,Object> menuLinkedMap = new LinkedHashMap<String,Object>();
				
				String firstTopMenuNo   = "";
				String firstTopMenuName = "";
				
				if( userMenuList != null ) {
					String currTopMenuNo   = "";
					
					String currSubTopMenuNo = "";
					
					List<Map<String,Object>> childMenuList    = null;
					List<Map<String,Object>> subChildMenuList = null;
					for( int i = 0, nSize = userMenuList.size(); i < nSize; i++) {
						Map<String,Object> menuInfo = userMenuList.get(i);
						String menuNo   = StringUtils.defaultIfBlank((String)menuInfo.get("MENU_CD"), "");
						String menuName = StringUtils.defaultIfBlank((String)menuInfo.get("MENU_NM"), "");
						if( ! "".equals(menuNo)) {
							menuLinkedMap.put(menuNo, menuInfo);
							
							// top ????????? ?????? ????????? ??????no
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
				
				userInfo.put("TOP_MENU_MAP"   , topMenuLinkedMap);
				userInfo.put("FIRST_MENU_NO"  , firstTopMenuNo);
				userInfo.put("FIRST_MENU_NAME", firstTopMenuName);
				userInfo.put("SUB_MENU_MAP"   , subMenuLinkedMap);
				userInfo.put("MENU_MAP"       , menuLinkedMap);
				
				List<Map<String,Object>> userFavoriteMenuList = loginAuthService.selectUserFavoriteMenuList(paramMap);
				userInfo.put("MY_MENU", userFavoriteMenuList);
				
				String srvType		=	"";
				String srvTypeName	=	"";
				if (PropertiesUtil.isRealMode()) {
					srvType		=	"REAL";
					srvTypeName =	""; 
				} else if (PropertiesUtil.isDevMode()) {
					srvType		=	"DEV";
					srvTypeName =	"????????????";
				} else {
					srvType		=	"LOCAL";
					srvTypeName =	"LOCAL SYSTEM";
				}
				userInfo.put("SRV_TYPE", srvType);
				userInfo.put("SRV_TYPE_NM", srvTypeName);
				
				UserSessionUtil.setUserSession(request, userInfo);
	
				if( logger.isDebugEnabled()) {
					logger.debug( "LOGIN_INFO =" + UserSessionUtil.getUserSession(request) );
				}
				
				try {
					insertAccessHist(_userId, "Y","");
				} catch (Exception e) {
					logger.error(e.getMessage());
				}
				
				//model.addAllAttributes(paramMap);
				redirectAttr.addFlashAttribute(paramMap);
				
				String fwdUrl = paramMap.get("FWD_URL")==null?"":(String)paramMap.get("FWD_URL");
				if (!"".equals(fwdUrl)) {
					return "redirect:/foward.do";
				}
				
				return "redirect:/main.do";
				
			} else {
				System.out.println("isValidUser == false IN");
				try {
					insertAccessHist(_userId, "N", "????????? ?????? ??????");
				} catch (Exception e) {
					logger.error(e.getMessage());
				}
				
				model.addAttribute("message", getMessage("M1000022"));
				return "loginView";
			}
		} catch (BizException se) {
        	logger.error(se.getMessage());
        	model.addAttribute("message",se.getMessage());
        	
			try {
				insertAccessHist(_userId, "N",se.getMessage());
			} catch (Exception e) {
				logger.error(e.getMessage());
			}
			model.addAttribute("message", getMessage("M1000012"));
			if("S".equals(paramMap.get("USER_CLS"))) {
				return "loginViewExternal";
			} else {
				return "loginView";
			}

		} catch( Exception e) {
			logger.error(e.getMessage());
			model.addAttribute("message", getMessage("M1000022"));
			try {
				insertAccessHist(_userId, "N", e.getMessage());
			} catch (Exception e1) {
				logger.error(e.getMessage());
			}
			return "loginView";
		}	
	}
	
	/**
	 * SSO ???????????? ????????????
	 * @param vo - ?????????
	 * @param request - ??????????????? ?????? HttpServletRequest
	 * @return result - ???????????????(????????????)
	 * @exception Exception
	 */
	@RequestMapping(value = "/ssoLogin.do")
	public String actionSsoLogin(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, HttpServletResponse response, ModelMap model, RedirectAttributes redirectAttr) throws Exception {
		String ssoEmpNo = null;
		AuthCheck auth = new AuthCheck(request, response);
		AuthStatus status = auth.checkLogon();
		if(status == AuthStatus.SSOSuccess) {
			ssoEmpNo = auth.userID();
			paramMap.put("COMP_CD", getCompCd());
			
			Map<String,Object> userinfo  = null;
			try {
				userinfo  = UserSessionUtil.getUserSession(request);
			} catch (Exception e) {
				logger.error(e.getMessage());
			}	
			
			if (null!=userinfo)	{
				if (ssoEmpNo.equals((String)userinfo.get("EMP_NO"))) {
					logger.info("?????? ???????????? ?????????(SSO)");
					return "redirect:/main.do";	
				}
			}
			String _userId = null;
			try {
				paramMap.put("SSO_EMP_NO", ssoEmpNo);
				Map<String,Object> userInfo = loginAuthService.actionSsoLogin(paramMap);
				
				_userId = StringUtils.defaultIfBlank((String)userInfo.get("USER_ID"), "");
				
				boolean isValidUser = false;
				
				if (userInfo != null ) {
					String userId = (String)userInfo.get("USER_ID");
					
					if( userId != null ) {
						isValidUser = true;
					} 
				}
				if( isValidUser == true ) {
					paramMap.put("USER_ID", _userId);
					List<String> userRoleList = loginAuthService.selectUserRoleListForLogin(paramMap);
					if (0==userRoleList.size()) 
					{
						try {
							insertSSOAccessHist(_userId, "N", "???????????? ??????(SSO)");
						} catch (Exception e) {
							logger.error(e.getMessage());
						}
						logger.error("???????????? ??????(SSO)");
						model.addAttribute("message", getMessage("M1000022"));
						return "redirect:/common/error/noaccess.jsp";	
					}
					
					userInfo.put("ROLE_LIST", userRoleList);
	
					userInfo.put("PUR_USER", "N");
					if(userRoleList.contains("PUR002") || userRoleList.contains("PUR003") || userRoleList.contains("SYS001")) {
						//????????? ??????
						userInfo.put("PUR_USER", "Y");
					}
					
					List<String> deptRoleList = loginAuthService.selectDeptRoleListForLogin(paramMap);
					userInfo.put("DEPT_ROLE", deptRoleList);
					
					paramMap.put("ROLE_LIST", userRoleList);
					List<Map<String,Object>> userMenuList = loginAuthService.selectUserMenuList(paramMap);
	
					LinkedHashMap<String,Object> topMenuLinkedMap = new LinkedHashMap<String,Object>();
					
					LinkedHashMap<String,Object> menuLinkedMap = new LinkedHashMap<String,Object>();
					
					if( userMenuList != null ) {
						String currTopMenuNo = "";
						
						List<Map<String,Object>> childMenuList = null;
						for( int i = 0, nSize = userMenuList.size(); i < nSize; i++) {
							Map<String,Object> menuInfo = userMenuList.get(i);
							String menuNo = StringUtils.defaultIfBlank((String)menuInfo.get("MENU_CD"), "");
							if( ! "".equals(menuNo)) {
								menuLinkedMap.put(menuNo, menuInfo);
								
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
								}
							}
						}
					}
					
					userInfo.put("TOP_MENU_MAP", topMenuLinkedMap);
					userInfo.put("MENU_MAP", menuLinkedMap);
					
					List<Map<String,Object>> userFavoriteMenuList = loginAuthService.selectUserFavoriteMenuList(paramMap);
					userInfo.put("MY_MENU", userFavoriteMenuList);
					
					String srvType		=	"";
					String srvTypeName	=	"";
					if (PropertiesUtil.isRealMode()) {
						srvType		=	"REAL";
						srvTypeName =	""; 
					} else if (PropertiesUtil.isDevMode()) {
						srvType		=	"DEV";
						srvTypeName =	"????????????";
					} else {
						srvType		=	"LOCAL";
						srvTypeName =	"LOCAL SYSTEM";
					}
					userInfo.put("SRV_TYPE", srvType);
					userInfo.put("SRV_TYPE_NM", srvTypeName);
					
					UserSessionUtil.setUserSession(request, userInfo);
	
					if( logger.isDebugEnabled()) {
						logger.debug( "LOGIN_INFO =" + UserSessionUtil.getUserSession(request) );
					}
					
					try {
						insertSSOAccessHist(_userId, "Y","");
					} catch (Exception e) {
						logger.error(e.getMessage());
					}
					
					//model.addAllAttributes(paramMap);
					redirectAttr.addFlashAttribute(paramMap);
					
					String fwdUrl = paramMap.get("FWD_URL")==null?"":(String)paramMap.get("FWD_URL");
					if (!"".equals(fwdUrl)) {
						return "redirect:/foward.do";
					}
					
					return "redirect:/main.do";
				} else {
					try {
						insertSSOAccessHist(_userId, "N", "????????? ?????? ??????(SSO ????????? ?????? ??????)");
					} catch (Exception e) {
						logger.error(e.getMessage());
					}
					logger.error("SSO ????????? ?????? ??????");
					model.addAttribute("message", getMessage("M1000022"));
					return "redirect:/common/error/noauth.jsp";
				}
			
			} catch (BizException se) {
	        	logger.error(se.getMessage());
	        	model.addAttribute("message",se.getMessage());
	        	
				try {
					insertSSOAccessHist(_userId, "N",se.getMessage());
				} catch (Exception e) {
					logger.error(e.getMessage());
				}
	        	return "redirect:/common/error/noauth.jsp";
			} catch( Exception e) {
				logger.error(e.getMessage());
				model.addAttribute("message", getMessage("M1000022"));
				try {
					insertSSOAccessHist(_userId, "N", e.getMessage());
				} catch (Exception e1) {
					logger.error(e.getMessage());
				}
				return "redirect:/common/error/noauth.jsp";
			}	
		}else {
			try {
				insertSSOAccessHist("", "N", "????????? ?????? ??????(SSO ?????? ??????)");
			} catch (Exception e) {
				logger.error(e.getMessage());
			}
			logger.error("SSO ?????? ??????");
			model.addAttribute("message", getMessage("M1000022"));
			return "redirect:/common/error/noauth.jsp";
		}
	}
	
	

	/**
	 * ??????????????????.
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value = "/logout.do")
	public String actionLogout(HttpServletRequest request, ModelMap model) throws Exception {
		Map<String,Object> userinfo  = UserSessionUtil.getUserSession(request);
		model.addAttribute("USER_CLS", (String)userinfo.get("USER_CLS"));
		System.out.println("USER_CLS  ---------------------> " + (String)userinfo.get("USER_CLS"));
		UserSessionUtil.removeUserSession(request);
		return "logOutView";
	}
	
	@RequestMapping(value = "/foward.do")
	public String actionFoward(HttpServletRequest request, ModelMap model) throws Exception {
		logger.debug("actionFoward:" + model);
		return "auth/foward";
	}
	
    /**
     * init
     * "/" Path??? ????????? ????????? ?????????????????? ??????
     * @param userAgent
     * @param device
     * @param model
     * @return String
     */
    @RequestMapping("/common/main.do")
    public String main(HttpServletRequest request, Model model) {
		return "loginView";
    }   
    
    @RequestMapping("/loginSuccess.do")
    public void loginSuccess(HttpSession session) {
		DefaultUserDetails userDetails = (DefaultUserDetails)SecurityContextHolder.getContext().getAuthentication().getDetails();
        
        session.setAttribute("userLoginInfo", userDetails);
    }
    
    @RequestMapping("/loginFailure.do")
    public void loginFailure(ServletRequest servletRequest, HttpSession session) {
    	Exception exception = (Exception) servletRequest.getAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
        String errorMessageCode = "M1000004";
        if(exception instanceof UsernameNotFoundException){// ????????? ??????
         	errorMessageCode = "M1000004";
        }else if(exception instanceof AccountExpiredException){// ?????? ???????????? ?????? ??????
        	errorMessageCode = "M1000007";
        }else if(exception instanceof CredentialsExpiredException){// ???????????? ???????????? ?????? ??????
        	errorMessageCode = "M1000024";
        }else if(exception instanceof LockedException){// ????????? Lock??????
        	errorMessageCode = "M1000023";
        }else if(exception instanceof DisabledException){// ????????? disabled ??????
        	errorMessageCode = "M1000005";
        }else if(exception instanceof BadCredentialsException){// ???????????? ??????
        	errorMessageCode = "M1000012";
        }else{
        	errorMessageCode = "M1000022";
        }
        throw new BizException(errorMessageCode, exception);
    }
    
/*	@RequestMapping(value="/loginProcess.do")
    public String logingFormUrl(ServletRequest servletRequest){
		throw new BizException("M1000015", (Exception) servletRequest.getAttribute(WebAttributes.ACCESS_DENIED_403));
    }
    */
    
	public void insertAccessHist(String userId, String succYn, String errMsg) {
		try {
			Map<String, Object> histMap = new HashMap<>();
			histMap.put("SERVER_IP"	, getServerIp());
			
			histMap.put("SYS_ID"	, PropertiesUtil.getProperty("system.id"));
			histMap.put("TYPE_ID"	, "LOGIN");
			histMap.put("USER_ID"	, userId);
			histMap.put("USER_IP"	, getUserIp());
			histMap.put("SUCC_YN"	, succYn);
			histMap.put("ERR_MSG"	, errMsg);
			loginAuthService.insertAccessHist(histMap);
		} catch (Exception e) {
			logger.error("Access?????? ?????? ??????",e);
		}
	}
	
	public void insertSSOAccessHist(String userId, String succYn, String errMsg) {
		try {
			Map<String, Object> histMap = new HashMap<>();
			histMap.put("SERVER_IP"	, getServerIp());
			
			histMap.put("SYS_ID"	, PropertiesUtil.getProperty("system.id"));
			histMap.put("TYPE_ID"	, "SSO");
			histMap.put("USER_ID"	, userId);
			histMap.put("USER_IP"	, getUserIp());
			histMap.put("SUCC_YN"	, succYn);
			histMap.put("ERR_MSG"	, errMsg);
			loginAuthService.insertAccessHist(histMap);
		} catch (Exception e) {
			logger.error("SSO Access?????? ?????? ??????",e);
		}
	}
	
	@RequestMapping(value="/addMyMenu.do")
	@ResponseBody
	public JsonData addFavoriteMenu(@RequestBody Map<String,Object> paramMap, HttpServletRequest request) {
		JsonData jsonData = new JsonData();
		try {
			paramMap.put("USER_ID", getUserId());
			loginAuthService.insertUserFavoriteMenu(paramMap);
		} catch (Exception e) {
			logger.error("???????????? ?????? ?????? ??????",e);
			jsonData.setErrMsg(e.getMessage());
		} finally {
			List<Map<String,Object>> userFavoriteMenuList = loginAuthService.selectUserFavoriteMenuList(paramMap);
			Map<String, Object> userinfo = null;
			try {
				userinfo = UserSessionUtil.getUserSession(request);
				userinfo.put("MY_MENU", userFavoriteMenuList);
				UserSessionUtil.setUserSession(request, userinfo);
				jsonData.addFields("myMenuList", userFavoriteMenuList);
			} catch (Exception e) {
				logger.debug(e.getMessage());
			}
		}
		return jsonData;
	}
	
	@RequestMapping(value="/allDelMyMenu.do")
	@ResponseBody
	public JsonData allDelFavoriteMenu(@RequestBody Map<String,Object> paramMap, HttpServletRequest request) {
		JsonData jsonData = new JsonData();
		try {
			paramMap.put("USER_ID", getUserId());
			loginAuthService.allDeleteUserFavoriteMenu(paramMap);
		} catch (Exception e) {
			logger.error("?????? ?????? ?????? ?????? ??????",e);
			jsonData.setErrMsg(e.getMessage());
		} finally {
			List<Map<String,Object>> userFavoriteMenuList = loginAuthService.selectUserFavoriteMenuList(paramMap);
			Map<String, Object> userinfo = null;
			try {
				userinfo = UserSessionUtil.getUserSession(request);
				userinfo.put("MY_MENU", userFavoriteMenuList);
				UserSessionUtil.setUserSession(request, userinfo);
				jsonData.addFields("myMenuList", userFavoriteMenuList);
			} catch (Exception e) {
				logger.debug(e.getMessage());
			}
		}
		return jsonData;
	}	
	
	@RequestMapping(value="/delMyMenu.do")
	@ResponseBody
	public JsonData delFavoriteMenu(@RequestBody Map<String,Object> paramMap, HttpServletRequest request) {
		JsonData jsonData = new JsonData();
		try {
			paramMap.put("USER_ID", getUserId());
			loginAuthService.deleteUserFavoriteMenu(paramMap);
			
		} catch (Exception e) {
			logger.error("?????? ?????? ?????? ??????",e);
			jsonData.setErrMsg(e.getMessage());
		} finally {
			List<Map<String,Object>> userFavoriteMenuList = loginAuthService.selectUserFavoriteMenuList(paramMap);
			Map<String, Object> userinfo = null;
			try {
				userinfo = UserSessionUtil.getUserSession(request);
				userinfo.put("MY_MENU", userFavoriteMenuList);
				UserSessionUtil.setUserSession(request, userinfo);
				jsonData.addFields("myMenuList", userFavoriteMenuList);
			} catch (Exception e) {
				logger.debug(e.getMessage());
			}
		}
		return jsonData;
	}
	
}
