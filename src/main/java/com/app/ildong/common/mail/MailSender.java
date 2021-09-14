package com.app.ildong.common.mail;

import org.apache.commons.mail.Email;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;


import com.app.ildong.common.util.PropertiesUtil;

public class MailSender {
	protected final Log logger = LogFactory.getLog(getClass());
	
	private String _RUNTIME_MODE	= PropertiesUtil.getProperty("runtime.mode");
	
	private String _SMTP_SERVER	    = PropertiesUtil.getProperty("email.smtp.host.ip");
	private String _SMTP_PORT		= PropertiesUtil.getProperty("email.smtp.port");
	private String _CHARSET		    = "utf-8";
	private String _CONTENT_TYPE	= "text/html; charset=utf-8";
	
	public String sendMail(String senderEmail, String receiverEmail, String subject, String contents) {
		return sendMail(senderEmail, receiverEmail, subject, contents, null);
	}
	
	public String sendMail(String senderEmail, String receiverEmail, String subject, String contents, String ccEmail) {
//		if ("local".equals(_RUNTIME_MODE)) {
//			return "";
//		}
		
		String serverResponse = new String();
		
		Email email = new SimpleEmail();
		//email.setAuthentication(_SMTP_ID, _SMTP_PW);
		//TODO UKKIM ssl설정 확인 필요
		//email.setSSL(true);
		email.setCharset(_CHARSET); // 한글 인코딩 
		email.setHostName(_SMTP_SERVER); //SMTP서버 설정
		email.setSmtpPort(Integer.parseInt(_SMTP_PORT));  //포트번호
		
		email.setSubject(subject ); //메일 제목
		email.setContent(contents, _CONTENT_TYPE);
		
		try {
			//email.setFrom(senderEmail);
			email.setFrom(senderEmail	, "일동제약(주)");
			//email.addTo(receiverEmail);
			//수신자가 여러명인경우
	        String[] tokens = receiverEmail.split(",");
	        for (int ii = 0; ii < tokens.length; ii++) {
				email.addTo(tokens[ii]);
	        }
	        //CC
	        if (StringUtils.isNotEmpty(ccEmail)) {
	        	String[] ccs = StringUtils.split(ccEmail,",");
	        	for(String cc : ccs) {
	        		email.addCc(cc);
	        	}
	        }
	        
			email.send();
			
			serverResponse = "S";
		} catch (EmailException e) {
			logger.error("########## ERROR IN SMSSender - EmailException : "+ this.getClass());
			logger.error(e);
			e.printStackTrace();
			
			serverResponse = "F";
		} catch (Exception e) {
			logger.error("########## ERROR IN SMSSender - Exception : "+ this.getClass());
			logger.error(e);
			e.printStackTrace();
			
			serverResponse = "F";
		}
		return serverResponse;
	}


}

