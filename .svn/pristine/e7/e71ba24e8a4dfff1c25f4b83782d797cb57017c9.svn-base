package com.app.ildong.common.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.app.ildong.common.model.mvc.BaseController;
import com.app.ildong.common.session.UserSessionUtil;

@Controller
public class DefaultController extends BaseController {

	protected final Log logger = LogFactory.getLog(getClass());
	
	private static String MAIN_URL = "main.do";
	
	@RequestMapping("/goMenu.do")
	public ModelAndView  goMenu( @RequestParam Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws Exception{

		if( logger.isDebugEnabled()) {
			logger.debug(  "paramMap = " + paramMap);
		}
		String contextPath = request.getContextPath();
		
		Map<String,Object> loginInfo =  UserSessionUtil.getUserSession(request);
		
		String topMenuNo = StringUtils.defaultIfBlank(request.getParameter("G_TOP_MENU_CD"), "");
		String topMenuNm = StringUtils.defaultIfBlank(request.getParameter("G_TOP_MENU_NM"), "");
		String upMenuCd = StringUtils.defaultIfBlank(request.getParameter("G_UP_MENU_CD"), "");
		String menuNo = StringUtils.defaultIfBlank(request.getParameter("G_MENU_CD"), "");
		
		String targetUrl = null;
		if( ! "".equals( menuNo)) {
			Map<String,Object> menuMap = (Map<String,Object>)loginInfo.get("MENU_MAP");
			Map<String,Object> menuInfo = (Map<String,Object>)menuMap.get(menuNo);
			
			if( menuInfo != null ) {
				targetUrl = StringUtils.defaultIfBlank((String)menuInfo.get("LINK_URL"), "");
			}
			
			if( "".equals(topMenuNo) ) {
				topMenuNo = StringUtils.defaultIfBlank((String)menuInfo.get("UP_MENU_CD"), "");
			}
			targetUrl = contextPath.concat("/").concat(targetUrl);
		}
		
		
		if( targetUrl == null || "".equals(targetUrl) || "/".equals(targetUrl) ) {
			targetUrl = contextPath.concat("/").concat(MAIN_URL);
		}
		
		model.addAllAttributes(paramMap);
		
		model.addAttribute("G_TOP_MENU_CD", topMenuNo);
		model.addAttribute("G_TOP_MENU_NM", topMenuNm);
		model.addAttribute("G_UP_MENU_CD" , upMenuCd);
		
		ModelAndView mav = new ModelAndView();
		mav.setView(new RedirectView( targetUrl ));

		return mav;
	}
}
