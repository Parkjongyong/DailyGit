package com.app.ildong.common.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.ObjectUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ecbank.framework.exception.BizException;
import com.app.ildong.common.dao.MessageSendDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.mail.MailSender;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.common.sms.SMSSender;
import com.app.ildong.common.util.DateUtil;
import com.app.ildong.common.util.MailUtils;
import com.app.ildong.common.util.PropertiesUtil;
import com.app.ildong.common.util.StringUtil;
import com.app.ildong.cmn.dao.CmnMsgDAO;

@Service("MessageSendService")
public class MessageSendService extends BaseService {

	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private MessageSendDAO msgSendDAO;
	
	@Autowired
	private CmnMsgDAO msgDAO;
	
	/**
	 * 메일전송 프로세스
	 * @param paramMap
	 * @return
	 * @throws BizException
	 * @throws Exception
	 */
	public Map<String, Object> sendMailMessage(Map<String, Object> paramMap) throws ServiceException, Exception {
		
		Map<String, Object> resMap		= new HashMap<String, Object>();
		Map<String, Object> mailSmsInfo = new HashMap<String, Object>();
		
		String mailId = (String) ObjectUtils.defaultIfNull(paramMap.get("MAIL_ID"), "");
		
		//MAIL_ID가 있을 경우에만 수행.
		if(StringUtils.isNotEmpty(mailId))
		{
			mailSmsInfo = msgSendDAO.selectMailSmsInfo(paramMap);
			
			if(mailSmsInfo != null)
			{
				String senderEmail = (String) ObjectUtils.defaultIfNull(paramMap.get("SENDER_EMAIL"), "");
				
				if("".equals(senderEmail))
				{
					senderEmail = (String) ObjectUtils.defaultIfNull(mailSmsInfo.get("SENDER_EMAIL"), "");
				}
				
				String receiverEmail = (String) ObjectUtils.defaultIfNull(paramMap.get("RECEIVER_EMAIL"), "");
				
				//개발일 경우 Test Receiver한테 전달.
				if(!PropertiesUtil.isRealMode())
				{
					receiverEmail = (String)ObjectUtils.defaultIfNull(mailSmsInfo.get("TEST_RECEIVER_EMAIL"), "");
				}
				
				String mailSubject  = (String)ObjectUtils.defaultIfNull(paramMap.get("SUBJECT"), ObjectUtils.defaultIfNull(mailSmsInfo.get("SUBJECT"), ""));
				String mailContent = "";
				
				String serverUrl    = PropertiesUtil.getProperty("HTTP.SERVER.URL"); 
				String serverUrlIn  = PropertiesUtil.getProperty("HTTP.SERVER.URL.IN"); 
				String serverUrlOut = PropertiesUtil.getProperty("HTTP.SERVER.URL.OUT");
				try {
					String serverName = getServerName();
					serverUrl = serverName;
					serverUrlIn = serverName;
				}catch(Exception e) {
					
				}

				Map<String, Object> paramData = new HashMap<String, Object>();
				paramData.putAll(paramMap);
				paramData.put("URL_IN",		serverUrlIn);
				paramData.put("URL_OUT",	serverUrlOut);
				
				mailContent = MailUtils.getMailContents(serverUrl, mailSmsInfo, paramData);
				
				if(StringUtils.isNotEmpty(receiverEmail))
				{
					Map<String, Object> mailParam = new HashMap<String, Object>();
					
					mailParam.put("SENDER_EMAIL",	senderEmail);
					mailParam.put("RECEIVER_EMAIL",	receiverEmail);
					mailParam.put("SUBJECT",		mailSubject);
					mailParam.put("CONTENT",		mailContent);
					try {
						resMap = this.sendMail(mailParam);
					}catch(Exception e) {
						logger.equals(e.getMessage());
					}
					
					if(resMap != null)
					{
						Map<String, Object> logParam = new HashMap<String, Object>();
						logParam.put("COMP_CD",		getCompCd());
						logParam.put("MAIL_ID",		mailId);
						logParam.put("MSG_TYPE",	"MAIL");
						logParam.put("MSG_KEY",		"MAIL");
						logParam.put("FROM_ID",		senderEmail);
						logParam.put("TO_ID",		receiverEmail);
						logParam.put("SUBJECT",		mailSubject);
						logParam.put("CONTENT",		mailContent);
						
						if("S".equals(resMap.get("RESULT")))
						{
							//메일전송 로그 기록(성공)
							logParam.put("RESULT", "S");
							msgDAO.insertMsgLogInfo(logParam);
						}
						else
						{
							//메일전송 로그 기록(실패)
							logParam.put("RESULT", "E");
							msgDAO.insertMsgLogInfo(logParam);
						}
					}
				}
				else
				{
					//발송전 오류 발견 시 로그기록.(받는사람이 없을 경우)
					Map<String, Object> logParam = new HashMap<String, Object>();
					logParam.put("COMP_CD", 	getCompCd());
					logParam.put("MAIL_ID",		mailId);
					logParam.put("MSG_TYPE",	"MAIL");
					logParam.put("MSG_KEY",		"MAIL");
					logParam.put("FROM_ID",		senderEmail);
					logParam.put("TO_ID",		receiverEmail);
					logParam.put("SUBJECT",		mailSubject);
					
					if(PropertiesUtil.isRealMode())
					{
						logParam.put("CONTENT",	mailContent);
					}
					else
					{
						logParam.put("CONTENT",	"MAIL SEND ERROR : receiverEmail is NULL");
					}
					logParam.put("RESULT", "E");
					
					msgDAO.insertMsgLogInfo(logParam);
				}
			}else {
				throw new BizException ("MAIL ID 관련 정보가 존재하지 않습니다.");
			}
		}
		
		return resMap;
	}
	
	/**
	 * 메일 전송.
	 * @param paramMap
	 * @return
	 * @throws BizException
	 * @throws Exception
	 */
	public Map<String, Object> sendMail(Map<String, Object> paramMap) throws ServiceException, Exception
	{
		Map<String, Object> resMap	= new HashMap<String, Object>();
		
		final String emailPattern	= "[0-9a-zA-Z.\\-_]+@[0-9a-zA-Z.\\-_]+";
		final String sendOnlyFalse	= "<div style='visibility: hidden; padding-left: 7px; text-align: left; font-size: 9pt; color: #d79364;'>이 메일은 발신전용으로 회신되지 않습니다.</div>";
		final String sendOnlyTrue	= "<div style='padding-left: 7px; text-align: left; font-size: 9pt; color: #d79364;'>이 메일은 발신전용으로 회신되지 않습니다.</div>";
		
		String senderEmail	= (String) ObjectUtils.defaultIfNull(paramMap.get("SENDER_EMAIL"), "");
		String receiverEmail= (String) ObjectUtils.defaultIfNull(paramMap.get("RECEIVER_EMAIL"), "");
		String ccEmail      = (String) ObjectUtils.defaultIfNull(paramMap.get("CC_EMAIL"), "");
		String subject		= (String) ObjectUtils.defaultIfNull(paramMap.get("SUBJECT"), "");
		String content		= (String) ObjectUtils.defaultIfNull(paramMap.get("CONTENT"), "");
		
		if(StringUtils.isEmpty(senderEmail) == true)
		{
			senderEmail = "";
		}
		
		if(StringUtils.isEmpty(receiverEmail) == true)
		{
			throw new ServiceException(getMessage("EBCMN0001", new Object[] {"받는사람Email 주소", receiverEmail}));
		}
		else
		{
	        String[] tokens = receiverEmail.split(",");
	        for (int ii = 0; ii < tokens.length; ii++) {
				if(tokens[ii].matches(emailPattern) == false)
				{
					throw new ServiceException(getMessage("EBCMN0001", new Object[] {"받는사람Email 주소", receiverEmail}));
				}

	        }	        

		}
		
		if(StringUtils.isEmpty(subject) == true)
		{
			throw new ServiceException(getMessage("EBCMN0001", new Object[] {"메일제목", subject}));
		}
		
		if(StringUtils.isEmpty(content) == true)
		{
			throw new ServiceException(getMessage("EBCMN0001", new Object[] {"메일내용", content}));
		}
		
		if(senderEmail.endsWith("parucnc.com") == true)
		{
			content = content.replaceAll(sendOnlyFalse, sendOnlyTrue);
		}
		//운영일 경우
		if(PropertiesUtil.isRealMode())
		{
			//전송 로직 추가
			this._sendEmail(senderEmail, receiverEmail, subject, content, ccEmail);
		}
		else if (PropertiesUtil.isDevMode()) {
			//전송 로직 추가
			this._sendEmail(senderEmail, receiverEmail, subject, content, ccEmail);
		}
		else
		{	//전송 로직 추가
			this._sendEmail(senderEmail, receiverEmail, subject, content, ccEmail);
		}
		resMap.put("RESULT", "S");
		
		return resMap;
	}
	
	/**
	 * SMS 전송 프로세스
	 * @param paramMap
	 * @return
	 * @throws BizException
	 * @throws Exception
	 */
	public Map<String, Object> sendSmsMessage(Map<String, Object> paramMap) throws ServiceException, Exception {
		
		Map<String, Object> resMap		= new HashMap<String, Object>();
		Map<String, Object> mailSmsInfo = new HashMap<String, Object>();
		
		String mailId = (String) ObjectUtils.defaultIfNull(paramMap.get("MAIL_ID"), "");
		
		//MAIL_ID가 있을 경우에만 수행.
		if(StringUtils.isNotEmpty(mailId))
		{
			mailSmsInfo = msgSendDAO.selectMailSmsInfo(paramMap);
			
			if(mailSmsInfo != null)
			{
				String senderPhoneNumber	= (String) ObjectUtils.defaultIfNull(paramMap.get("SENDER_PHONE_NUMBER"), "");
				
				String receiverPhoneNumber	= (String) ObjectUtils.defaultIfNull(paramMap.get("RECEIVER_PHONE_NUMBER"), "");
				
				String subJect				= (String) ObjectUtils.defaultIfNull(paramMap.get("SUBJECT"), "");
				
				//개발일 경우 Test Receiver한테 전달.
				if(!PropertiesUtil.isRealMode())
				{
					receiverPhoneNumber = (String)ObjectUtils.defaultIfNull(mailSmsInfo.get("TEST_RECEIVER_PHONE"), "");
				}
			
				Map<String, Object> paramData = new HashMap<String, Object>();
				paramData.putAll(paramMap);
				String smsMessage	 = MailUtils.getSmsMessage(mailSmsInfo, paramData);
				String smsMessageLog = smsMessage;
				
				if(StringUtils.isEmpty(subJect))
				{
					subJect	=	(String)ObjectUtils.defaultIfNull(mailSmsInfo.get("SUBJECT"), "");
				}
				
				if(StringUtils.isEmpty(senderPhoneNumber))
				{
					senderPhoneNumber = (String) ObjectUtils.defaultIfNull(mailSmsInfo.get("SENDER_PHONE"), "");
				}
				
				if(StringUtils.isNotEmpty(receiverPhoneNumber))
				{
					Map<String, Object> smsParam = new HashMap<String, Object>();
					
					smsParam.put("SENDER_PHONE_NUMBER"	,	senderPhoneNumber);
					smsParam.put("RECEIVER_PHONE_NUMBER",	receiverPhoneNumber);
					
					//메시지가 제대로 생성된 경우
					if(smsMessage != null && !"".equals(smsMessage))
					{
						//String cutMessage = StringUtil.strCutKorByte(smsMessage, 80);
						
						/*while(cutMessage.length() > 0)
						{
							smsParam.put("CONTENT", cutMessage);
							//SMS전송
							resMap = this.sendSms(smsParam);
							smsMessage = smsMessage.substring(cutMessage.length());
							cutMessage = StringUtil.strCutKorByte(smsMessage, 80);
						}*/
						smsParam.put("CONTENT", smsMessage.replaceAll(System.getProperty("line.separator"), ""));
						resMap = this.sendSms(smsParam);
					}
					
					if(resMap != null)
					{
						String result = resMap.get("RESULT").toString();
						Map<String, Object> logParam = new HashMap<String, Object>();
						logParam.put("COMP_CD",		getCompCd());
						logParam.put("MAIL_ID",		mailId);
						logParam.put("MSG_TYPE",	"SMS");
						logParam.put("MSG_KEY",		"SMS");
						logParam.put("FROM_ID",		senderPhoneNumber);
						logParam.put("TO_ID",		receiverPhoneNumber);
						logParam.put("CONTENT",		smsMessageLog);
						logParam.put("SUBJECT",		subJect);
						
						if("S".equals(result))
						{
							//SMS전송 로그 기록(성공)
							logParam.put("RESULT", "S");
							msgDAO.insertMsgLogInfo(logParam);
						}
						else
						{
							//SMS전송 로그 기록(실패)
							logParam.put("RESULT", "E");
							msgDAO.insertMsgLogInfo(logParam);
						}
					}
				}
				else
				{
					//발송전 오류 발견 시 로그기록.(받는사람이 없을 경우)
					Map<String, Object> logParam = new HashMap<String, Object>();
					logParam.put("COMP_CD",		getCompCd());
					logParam.put("MAIL_ID",		mailId);
					logParam.put("MSG_TYPE",	"SMS");
					logParam.put("MSG_KEY",		"SMS");
					logParam.put("FROM_ID",		senderPhoneNumber);
					logParam.put("TO_ID",		receiverPhoneNumber);
					logParam.put("SUBJECT",		subJect);
					if(PropertiesUtil.isRealMode())
					{
						logParam.put("CONTENT",	smsMessageLog);
					}
					else
					{
						logParam.put("CONTENT",	"SMS SEND ERROR : receiverPhoneNumber is NULL");
					}
					logParam.put("RESULT", "E");
					
					msgDAO.insertMsgLogInfo(logParam);
				}
			}
		}
		return resMap;
	}
	
	/**
	 * SMS 전송
	 * @param paramMap
	 * @return
	 * @throws BizException
	 * @throws Exception
	 */
	public Map<String, Object> sendSms(Map<String, Object> paramMap) throws ServiceException, Exception
	{
		Map<String, Object> resMap	= new HashMap<String, Object>();
		
		String senderPhoneNumber	= (String) ObjectUtils.defaultIfNull(paramMap.get("SENDER_PHONE_NUMBER"), "");
		String receiverPhoneNumber	= (String) ObjectUtils.defaultIfNull(paramMap.get("RECEIVER_PHONE_NUMBER"), "");
		String content				= (String) ObjectUtils.defaultIfNull(paramMap.get("CONTENT"), "");
		
		if(StringUtils.isEmpty(senderPhoneNumber) == true)
		{
			senderPhoneNumber = "";
		}
		else
		{
			if(senderPhoneNumber.contains("-") == true)
			{
				senderPhoneNumber = senderPhoneNumber.replaceAll("-", "");
			}
			
			if(senderPhoneNumber.length() > 11)
			{
				throw new ServiceException(getMessage("EBCMN0001", new Object[] {"보내는사람 전화번호", senderPhoneNumber}));
			}
		}
		
		if(StringUtils.isEmpty(receiverPhoneNumber) == true)
		{
			throw new ServiceException(getMessage("EBCMN0001", new Object[] {"받는사람 전화번호", receiverPhoneNumber}));
		}
		else
		{
			if(receiverPhoneNumber.contains("-") == true)
			{
				receiverPhoneNumber = receiverPhoneNumber.replaceAll("-", "");
			}
			
			if(receiverPhoneNumber.length() > 11)
			{
				throw new ServiceException(getMessage("EBCMN0001", new Object[] {"받는사람 전화번호", receiverPhoneNumber}));
			}
		}
		
		if(StringUtils.isEmpty(content) == true)
		{
			throw new ServiceException(getMessage("EBCMN0001", new Object[] {"메시지", content}));
		}
		
		//운영일 경우
		if(PropertiesUtil.isRealMode())
		{
			//전송 로직 추가
			this._sendSMS(senderPhoneNumber, receiverPhoneNumber, content);
		}
		else if (PropertiesUtil.isDevMode()) {
			this._sendSMS(senderPhoneNumber, receiverPhoneNumber, content);
		}
		else
		{	//전송 로직 추가
//			this._sendSMS(senderPhoneNumber, receiverPhoneNumber, content);
		}
		resMap.put("RESULT", "S");
		
		return resMap;
	}
	
	
    /**
     * 
     * _sendEmail
     * 
     * @param senderEmail
     * @param receiverEmail
     * @param subject
     * @param contents
     * @return String
     * @throws ServiceException 
     */
    private String _sendEmail(String senderEmail, String receiverEmail, String subject, String contents) throws ServiceException {
        return _sendEmail(senderEmail, receiverEmail, subject, contents, null);
    }	
	
    private String _sendEmail(String senderEmail, String receiverEmail, String subject, String contents, String ccEmail) throws ServiceException {
        String result = null;
        MailSender service = new MailSender();

        try {

            result = service.sendMail(senderEmail, receiverEmail, subject, contents, ccEmail);

        } catch (Exception exception) {
        	throw new ServiceException(getMessage("EBCMN0011"));
        }

        return result;
    }
    
    /**
     * 
     * _sendSMS
     * 
     * @param senderPhoneNumber
     * @param receiverPhoneNumber
     * @param contents
     *            String
     * @throws ServiceException 
     */
    private String _sendSMS(String senderPhoneNumber, String receiverPhoneNumber, String contents) throws ServiceException {
        return _sendSMS(senderPhoneNumber, receiverPhoneNumber, contents, "6") ;
    }

    /**
     * 
     * @param senderPhoneNumber
     * @param receiverPhoneNumber
     * @param contents
     * @param msgType 4:SMS, 6:MMS
     * @return
     * @throws ServiceException
     */
    private String _sendSMS(String senderPhoneNumber, String receiverPhoneNumber, String contents, String msgType) throws ServiceException {

        SMSSender service = new SMSSender();
        
        try {
        	service.sendSms("6", receiverPhoneNumber, senderPhoneNumber, contents);
        } catch (Exception exception) {
        	throw new ServiceException(getMessage("EBCMN0012"));
        }

        return "" ;
    }
	
    
	/**
	 * 메일전송 프로세스 - 배치처리
	 * @param paramMap
	 * @return
	 * @throws BizException
	 * @throws Exception
	 */
	public Map<String, Object> sendMailMessageBatch(Map<String, Object> paramMap) throws ServiceException, Exception {
		
		Map<String, Object> resMap		= new HashMap<String, Object>();
		Map<String, Object> mailSmsInfo = new HashMap<String, Object>();
		
		String mailId = (String) ObjectUtils.defaultIfNull(paramMap.get("MAIL_ID"), "");
		
		//MAIL_ID가 있을 경우에만 수행.
		if(StringUtils.isNotEmpty(mailId))
		{
			mailSmsInfo = msgSendDAO.selectMailSmsInfo(paramMap);
			
			if(mailSmsInfo != null)
			{
				String senderEmail = (String) ObjectUtils.defaultIfNull(paramMap.get("SENDER_EMAIL"), "");
				
				if("".equals(senderEmail))
				{
					senderEmail = (String) ObjectUtils.defaultIfNull(mailSmsInfo.get("SENDER_EMAIL"), "");
				}
				
				String receiverEmail = (String) ObjectUtils.defaultIfNull(paramMap.get("RECEIVER_EMAIL"), "");
				
				//개발일 경우 Test Receiver한테 전달.
				if(!PropertiesUtil.isRealMode())
				{
					receiverEmail = (String)ObjectUtils.defaultIfNull(mailSmsInfo.get("TEST_RECEIVER_EMAIL"), "");
				}
				
				//CC
				String ccEmail = MapUtils.getString(paramMap, "CC_EMAIL", "");
				//개발일 경우 Test cc한테 전달.
				if(!PropertiesUtil.isRealMode()) {
					ccEmail = MapUtils.getString(mailSmsInfo, "TEST_CC_EMAIL", "");
				}
				
				String mailSubject  = (String)ObjectUtils.defaultIfNull(paramMap.get("SUBJECT"), ObjectUtils.defaultIfNull(mailSmsInfo.get("SUBJECT"), ""));
				String mailContent = "";
				
				String serverUrl    = PropertiesUtil.getProperty("HTTP.SERVER.URL"); 
				String serverUrlIn  = PropertiesUtil.getProperty("HTTP.SERVER.URL.IN"); 
				String serverUrlOut = PropertiesUtil.getProperty("HTTP.SERVER.URL.OUT");
				try {
					String serverName = getServerName();
					serverUrl = serverName;
					serverUrlIn = serverName;
				}catch(Exception e) {
					
				}

				Map<String, Object> paramData = new HashMap<String, Object>();
				paramData.putAll(paramMap);
				paramData.put("URL_IN",		serverUrlIn);
				paramData.put("URL_OUT",	serverUrlOut);
				
				mailContent = MailUtils.getMailContents(serverUrl, mailSmsInfo, paramData);
				
				
				//받는사람 메일주소가 없다면 메일배치대상으로 등록하지않고 바로 전송로그 등록
				if(StringUtils.isNotEmpty(receiverEmail))
				{
					
					//메일전송정보
					Map<String, Object> mailParam = new HashMap<String, Object>();
					
					mailParam.put("SENDER_EMAIL",   senderEmail);
					mailParam.put("RECEIVER_EMAIL", receiverEmail);
					mailParam.put("CC_EMAIL",       ccEmail);
					mailParam.put("SUBJECT", mailSubject);
					mailParam.put("CONTENT", mailContent);
					
					//추가정보
					mailParam.put("COMP_CD", getCompCd());
					mailParam.put("MAIL_ID", mailId);
					mailParam.put("MSG_TYPE", "MAIL");
					mailParam.put("REG_ID", getUserId());
					
					
					//메일전송정보를 메일배치대상으로 등록
					msgDAO.insertBatchMailInfo(mailParam);
					
					
				}
				else
				{
					//발송전 오류 발견 시 로그기록.(받는사람이 없을 경우)
					Map<String, Object> logParam = new HashMap<String, Object>();
					logParam.put("COMP_CD", 	getCompCd());
					logParam.put("MAIL_ID",		mailId);
					logParam.put("MSG_TYPE",	"MAIL");
					logParam.put("MSG_KEY",		"MAIL");
					logParam.put("FROM_ID",		senderEmail);
					logParam.put("TO_ID",		receiverEmail);
					logParam.put("SUBJECT",		mailSubject);
					
					if(PropertiesUtil.isRealMode())
					{
						logParam.put("CONTENT",	mailContent);
					}
					else
					{
						logParam.put("CONTENT",	"MAIL SEND ERROR : receiverEmail is NULL");
					}
					logParam.put("RESULT", "E");
					
					msgDAO.insertMsgLogInfo(logParam);
				}
			}
		}
		
		return resMap;
	}

	/**
	 * 메일 배치 일괄전송
	 * @param paramMap
	 * @return
	 */
	public Map<String, Object> sendMailBatch(Map<String, Object> paramMap) throws ServiceException, Exception {
		
		Map<String, Object> resMap		= new HashMap<String, Object>();
		
		String procId = DateUtil.getCurrentDateTimeAsString()+StringUtil.getRandomStr(10);
		
		paramMap.put("PROC_ID", procId); //이번에 처리될 배치 고유번호
		paramMap.put("USER_ID", getUserId());
		paramMap.put("COMP_CD", getCompCd());
		
		try {
			
			//메일 전송 대상 조회
			List<Map<String, Object>> mailList = msgDAO.selectMailBatchList(paramMap);
			
			for (Map<String, Object> mailParam : mailList) {
				//메일전송
				try {
					resMap = this.sendMail(mailParam);
				}catch(Exception e) {
					logger.equals(e.getMessage());
					continue;
				}
				//결과처리
				if(resMap != null) {
					Map<String, Object> logParam = new HashMap<String, Object>();
					logParam.put("COMP_CD", getCompCd());
					logParam.put("MAIL_ID", StringUtil.nvlObjectEmpty(mailParam.get("MAIL_ID"), ""));
					logParam.put("MSG_TYPE", "MAIL");
					logParam.put("MSG_KEY", "MAIL");
					logParam.put("FROM_ID", StringUtil.nvlObjectEmpty(mailParam.get("SENDER_EMAIL"), ""));
					logParam.put("TO_ID", StringUtil.nvlObjectEmpty(mailParam.get("RECEIVER_EMAIL"), ""));
					logParam.put("SUBJECT", StringUtil.nvlObjectEmpty(mailParam.get("SUBJECT"), ""));
					logParam.put("CONTENT", StringUtil.nvlObjectEmpty(mailParam.get("CONTENT"), ""));
					
					if("S".equals(resMap.get("RESULT"))) {
						//성공시 발송일시 업데이트
						msgDAO.updateMailSendDate(mailParam);
						
						logParam.put("RESULT", "S");
						msgDAO.insertMsgLogInfo(logParam);
					} else {
						logParam.put("RESULT", "E");
						msgDAO.insertMsgLogInfo(logParam);
					}
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			paramMap.put("RESULT", "F");
			paramMap.put("ERR_MSG", e.getMessage());
		}
		
		paramMap.put("RESULT", "S");
		return paramMap;
	}
}
