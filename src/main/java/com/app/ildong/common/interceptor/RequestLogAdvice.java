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
			logMap.put("SERVER_IP"  , getServerIp());		//???????????????
			logMap.put("SYS_ID"     , PropertiesUtil.getProperty("system.id"));  //????????? ID
			logMap.put("TYPE_ID"    , "REQUEST");		//???????????? - request.getDispatcherType()
			logMap.put("USER_ID"    , getUserId());		//????????? ID
			logMap.put("USER_IP"    , getUserIp());	//????????? IP  //request.getRemoteAddr()
			logMap.put("SUCC_YN"    , "");	//????????????
			logMap.put("ERR_MSG"    , "");	//???????????????
			logMap.put("URL"        , request.getRequestURI());	//?????? URL
			logMap.put("MENU_CD"    , request.getParameter("G_MENU_CD")); //????????????
			logMap.put("SESSION_ID" , request.getSession().getId());	//?????? ???
			logMap.put("PROC_START_TIME" , timeFormat.format(new Date(startTm))); //??????????????????
			logMap.put("PROC_END_TIME"   , timeFormat.format(new Date(endTm))); //??????????????????
			logMap.put("PROC_DELAY_TIME" , endTm - startTm);	//??????????????????
			  
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
