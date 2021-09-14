package com.app.ildong.auth.controller;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
public class TestController {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	
	/**
     * 로그인 페이지 이동
     */
	@RequestMapping( value = "/admin/**" , method = {RequestMethod.GET})
    public String doAdmin(){
		logger.error("ROLE_ADMIN 권한이 있는 사용자만 메소드를 호출 할 수 있습니다.");
    	return "redirect:/";
    }
	
	
	/**
     * 로그인 페이지 이동
     */
	@RequestMapping( value = "/user/**" , method = {RequestMethod.GET})
    public String doUser(){
		logger.error("ROLE_USER or ROLE_ADMIN 권한이 있는 사용자만 메소드를 호출 할 수 있습니다.");
		return "redirect:/";
    }

	/**
	 * Spring security annotation으로 접근제한 적용 예제
	 * ROLE_ADMIN 권한을 가진 사용자의 접근만 허용
	 */
	@PreAuthorize("hasAuthority('ROLE_ADMIN')")
	@RequestMapping(value="/adminPage")
	public String adminPage() {
		logger.info("URL패턴과 별개로 메소드의 Annotation으로 ROLE_ADMIN 권한이 주어진 사용자만 호출할 수 있습니다.");
		return "redirect:/menuPreparer/bcm/auth/sampleAuthorityCheck.do";
	}
	
	/**
	 * Spring security annotation으로 접근제한 적용 예제
	 * ROLE_USER 권한을 가진 사용자의 접근만 허용
	 */
	@PreAuthorize("hasAuthority('ROLE_USER')")
	@RequestMapping(value="/userPage")
	public String userPage() {
		logger.info("URL패턴과 별개로 메소드의 Annotation으로 ROLE_USER 권한이 주어진 사용자만 호출할 수 있습니다.");
		return "redirect:/menuPreparer/bcm/auth/sampleAuthorityCheck.do";
	}
	
	/**
	 * Spring security annotation으로 접근제한 적용 예제
	 * 익명 권한을 가진 사용자의 접근만 허용
	 */
	@PreAuthorize("isAnonymous()")
	@RequestMapping(value="/anonymousPage")
	public String anonymousPage() {
		logger.info("URL패턴과 별개로 메소드의 Annotation으로 익명 사용자가 호출할 수 있습니다.");
		return "redirect:/menuPreparer/bcm/auth/sampleAuthorityCheck.do";
	}
    
}
