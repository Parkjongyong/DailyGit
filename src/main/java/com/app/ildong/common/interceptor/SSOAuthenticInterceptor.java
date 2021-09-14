package com.app.ildong.common.interceptor;

import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.app.ildong.common.session.UserSessionUtil;
import com.app.ildong.common.util.PropertiesUtil;
import com.nets.sso.agent.AuthCheck;
import com.nets.sso.agent.enums.AuthStatus;

/**
 * SSo 인증여부 체크 인터셉터
 *
 */
public class SSOAuthenticInterceptor extends HandlerInterceptorAdapter {
	protected final Log logger = LogFactory.getLog(getClass());
	/**
	 * SSO로그인 정보 혹은 로컬 로그인정보가 있는 지 체크한다.
	 * 로그인정보가 없다면, 에러 페이지로 이동한다.
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws ServletException {

		AuthCheck auth;
		try {
			auth = new AuthCheck(request, response);
			AuthStatus status = auth.checkLogon();
			
			if(status != AuthStatus.SSOSuccess) {
				throw new Exception("SSO 로그인 에러");
			}
			
		} catch(Exception e) {
			Map<String, Object> userinfo;
			try {
				userinfo = UserSessionUtil.getUserSession(request);
				if(userinfo == null || ((String)userinfo.get("USER_ID")) == null) {
					ModelAndView modelAndView = new ModelAndView("redirect:/common/error/noauth.jsp");
					throw new ModelAndViewDefiningException(modelAndView);
				}
			} catch (Exception e1) {
				logger.error(e1.getMessage());
				ModelAndView modelAndView = new ModelAndView("redirect:/common/error/error.jsp");
				throw new ModelAndViewDefiningException(modelAndView);
			}
		}
		return true;
	}
}
