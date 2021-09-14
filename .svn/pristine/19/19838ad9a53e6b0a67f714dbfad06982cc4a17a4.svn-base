package com.app.ildong.common.interceptor;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.app.ildong.common.dao.CommonDAO;
import com.app.ildong.common.model.mvc.BaseController;
import com.app.ildong.common.service.LoginAuthService;
import com.app.ildong.common.util.PropertiesUtil;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;

import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

public class RequestLogAdvice  extends BaseController implements MethodInterceptor {

	private Log logger = LogFactory.getLog(this.getClass());

	@Autowired
	private DataSourceTransactionManager transactionManager;

	@Autowired
	private LoginAuthService loginAuthService;
	

	@Override
	public Object invoke(MethodInvocation invocation) throws Throwable {
		SimpleDateFormat timeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		long startTm = System.currentTimeMillis();
		Object ret = invocation.proceed();
		long endTm = System.currentTimeMillis();
		try {
			
			if ("mgtAccessLogList".equals(invocation.getMethod().getName())) {
				return ret;
			}else if("selectMgtAccessLogList".equals(invocation.getMethod().getName())) {
				return ret;
			}else if("main".equals(invocation.getMethod().getName())) {
				return ret;
			}
	
			HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
			
			
			Map<String, Object> logMap = new HashMap<>();
			logMap.put("SERVER_IP"  , getServerIp());		//서버아이피
			logMap.put("SYS_ID"     , PropertiesUtil.getProperty("system.id"));  //시스템 ID
			logMap.put("TYPE_ID"    , "REQUEST");		//접속타입 - request.getDispatcherType()
			logMap.put("USER_ID"    , getUserId());		//접속자 ID
			logMap.put("USER_IP"    , getUserIp());	//접속자 IP  //request.getRemoteAddr()
			logMap.put("SUCC_YN"    , "");	//성공여부
			logMap.put("ERR_MSG"    , "");	//에러메세지
			logMap.put("URL"        , request.getRequestURI());	//호출 URL
			logMap.put("MENU_CD"    , request.getParameter("G_MENU_CD")); //메뉴코드
			logMap.put("SESSION_ID" , request.getSession().getId());	//세션 값
			logMap.put("PROC_START_TIME" , timeFormat.format(new Date(startTm))); //처리시작시간
			logMap.put("PROC_END_TIME"   , timeFormat.format(new Date(endTm))); //처리종료시간
			logMap.put("PROC_DELAY_TIME" , endTm - startTm);	//처리지연시간
			  
			logger.debug(logMap);

//			System.out.println("----------------===============--------------------");

			DefaultTransactionDefinition def =  new DefaultTransactionDefinition();
			def.setName("RequestLogAdvice-Transaction");
			def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRES_NEW);
			TransactionStatus status = transactionManager.getTransaction(def);
			try {
				loginAuthService.insertAccessHist(logMap);
				transactionManager.commit(status);
			} catch (Exception e1) {
				transactionManager.rollback(status);
			}
	
		} catch (Exception e) {}
		return ret;
	}

}
