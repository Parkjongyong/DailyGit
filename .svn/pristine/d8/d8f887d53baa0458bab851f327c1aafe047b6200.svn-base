package com.app.ildong.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.app.ildong.common.util.PropertiesUtil;

/**
 * 개발자만 접근가능 인터셉터
 *
 */
public class IpCheckInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = LoggerFactory.getLogger(IpCheckInterceptor.class);

	/**
	 * 운영서버에는 개발자만 접근가능하도록
	 * @throws ModelAndViewDefiningException 
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws ModelAndViewDefiningException {
		try {
			logger.debug("현재 아이피 : " + request.getRemoteHost());
			String smUserIps = PropertiesUtil.getProperty("sm.user.ip");
		    if(PropertiesUtil.isRealMode()) {
		    	if(smUserIps.indexOf(request.getRemoteHost()) == -1) {
		    		throw new Exception("지금은 시스템을 이용할 수 없습니다.");
		    	}
		    }
		} catch (Exception e) {
			logger.info(e.getMessage());
			ModelAndView modelAndView = new ModelAndView("redirect:/");
			throw new ModelAndViewDefiningException(modelAndView);
		}
		return true;
	}
}
