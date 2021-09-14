package com.app.ildong.auth.controller;
import java.util.Locale;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.AccountExpiredException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.bind.annotation.AuthenticationPrincipal;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ecbank.framework.exception.BizException;


@Controller
@RequestMapping("/auth")
public class AuthController {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	private HttpSessionRequestCache httpSessionRequestCache = new HttpSessionRequestCache();
	
	/**
     * 로그인 페이지 이동
     */
	@RequestMapping("/")
    public String init(){
    	return "auth/login";
    }
	
	
	/**
	 * 로그 처리 성공 후 업무에서 필요한 작업을 할 수 있는 메소드
	 * - 사용자 정보를 조회하여 필요한 정보를 session, fwk 에 입력
	 * - 이전 사용자의 비밀번호 실패 횟수를 초기화함
	 * - 로그인 전 요청한 페이지가 있을 경우 redirect uri 정보 전달 TODO Json ???
	 * @param vo
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/loginSuccess")
	public String loginSuccess(@AuthenticationPrincipal User user, HttpServletRequest servletRequest, HttpServletResponse servletResponse) {
		if (logger.isInfoEnabled()) {
			logger.info(" User ID     : {}", user.getUsername());
			logger.info(" Authorities : {}", user.getAuthorities());
		}
		// 로그인 페이지 호출 전 화면 URL 정보 취득
		SavedRequest request = httpSessionRequestCache.getRequest(servletRequest, servletResponse);
		if (null != request) {
			if (logger.isDebugEnabled()) {
				logger.debug("save request [redirect uri = {}]", request.getRedirectUrl());
			}
			return "redirect:" + request.getRedirectUrl();
		}
		return "auth/main";
	}

	
	/**
     * 로그 처리 중 실패시 업무에서 필요한 작업을 할 수 있는 메소드
     * - 계정이 없는 경우 : 사용자가 등록되지 않았다는 메시지를 전송
     * - 계정 유효기간이 만료된 경우 : 사용이 종료된 사용자라고 메시지 전송
     * - 비밀번호 휴효기간 만료된 경우 : 비밀번호가 만료되어 변경 할 수 있는 페이지로 이동
     * - 계정이 잠겨 있을 경우 : 계정이 잠겨 있으므로 관리자에게 요청하라는 메시지 전송
     * - 계정이 disabled(계정 종료) : 사용자가 없다는 메시지 전송
     * - 비밀번호가 틀릴 경우 : 비밀번호가 틀렸다는 메시지가 틀린 횟수 및 틀릿 횟수는 업데이트함
     * - 그 외는 실패 메시지 전송 
     * @param vo
     * @param servletRequest
     * @param session
     * @param model
     */
	@RequestMapping(value="/loginFailure")
    public void loginFailure(ServletRequest servletRequest, Locale locale) throws Exception{
        Exception exception = (Exception) servletRequest.getAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
        String errorMessageCode = "M1000004";
        if(exception instanceof UsernameNotFoundException){// 사용자 없음
         	errorMessageCode = "M1000004";
        }else if(exception instanceof AccountExpiredException){// 계정 유효기간 만료 여부
        	errorMessageCode = "M1000007";
        }else if(exception instanceof CredentialsExpiredException){// 비밀번호 유효기간 만료 여부
        	errorMessageCode = "M1000024";
        }else if(exception instanceof LockedException){// 사용자 Lock여부
        	errorMessageCode = "M1000023";
        }else if(exception instanceof DisabledException){// 사용자 disabled 여부
        	errorMessageCode = "M1000005";
        }else if(exception instanceof BadCredentialsException){// 비밀번호 오류
        	errorMessageCode = "M1000012";
        }else{
        	errorMessageCode = "M1000022";
        }
        throw new BizException(errorMessageCode, exception);
    }

		
	/**
	 * 로그인 아웃 처리 후 업무에서 필요한 후 처리를 할 수 있는 메소드
	 * @param servletRequest
	 * @param model
	 */
	@RequestMapping(value="/logoutSuccess")
	public String logoutSuccess(){
		System.out.println("--------- logoutSuccess in ----------");
		return "redirect:/loginView.do";// 메인 홈페이지 호출
	}

	
	/**
     * 로그인 한 사용자 중 권한 없는 페이지 및 서비스를 요청할 경우 권한 오류를 받아서 처리하는 메소드
     * @param servletRequest
     * @param model
     */
	@RequestMapping(value="/accessDenied")
    public String accessDenied(ServletRequest servletRequest) throws Exception{
        throw new BizException("M1000015", (Exception) servletRequest.getAttribute(WebAttributes.ACCESS_DENIED_403));
    }

	
	/**
     * 로그인을 하지 않는 사용자가 권한이 필요한 페이지 및 서비스를 요청할 경우 로그인 페이지 및 로그인 요청 메시지를 전송하는 메소드
     * @param servletRequest
     * @param model
     */
	@RequestMapping(value="/logingFormUrl")
    public String logingFormUrl(ServletRequest servletRequest){
		throw new BizException("M1000015", (Exception) servletRequest.getAttribute(WebAttributes.ACCESS_DENIED_403));
    }


	/**
     * 로그인 된 사용자가 비정상적으로 세션 아웃된 경우 호출되는 에러 처리 메소드
     * @param servletRequest
     * @param model
     */
	@RequestMapping(value="/expiredUrl")
    public String expiredUrl(){
    	return "auth/login";
    }
	
}
