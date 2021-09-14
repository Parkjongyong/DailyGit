package com.app.ildong.cmn.service;

import java.util.HashMap;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.ObjectUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ecbank.framework.exception.BizException;
import com.app.ildong.cmn.dao.CmnMsgDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.JsonData;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.common.service.MessageSendService;


@Service("cmnMsgService")
public class CmnMsgService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private CmnMsgDAO msgDAO;
	
	@Autowired
	private MessageSendService msgService;

	/**
	 * SMS/메일 문구 조회
	 * @param paramMap
	 * @return
	 * @throws Exception 
	 */
	public List<Map<String, Object>> selectMsgList(Map<String, Object> paramMap) throws Exception
	{
		paramMap.put("COMP_CD", getCompCd());
		return msgDAO.selectMsgList(paramMap);
	}
	
	/**
	 * SMS/MAIL 상세정보 수정
	 * @param paramMap
	 * @return
	 * @throws BizException
	 * @throws Exception
	 */
	public Map<String, Object> updateMsgDetail(Map<String, Object> paramMap) throws BizException, Exception
	{
		
		paramMap.put("COMP_CD", getCompCd());
		paramMap.put("UPD_ID" , getUserId());
		
		if(paramMap.get("CONTENTS_AREA") != null)
		{
			String contents = paramMap.get("CONTENTS_AREA").toString();
			contents = contents.trim().replaceAll("\n", "\\\\r\\\\n");
			paramMap.put("CONTENTS_AREA", contents);
		}
		msgDAO.updateMsgDetail(paramMap);
		return paramMap;
	}
	
	/**
	 * SMS/MAIL 삭제 처리
	 * @param paramMap
	 * @return
	 * @throws BizException
	 * @throws Exception
	 */
	public Map<String, Object> deleteMsgInfo(Map<String, Object> paramMap) throws BizException, Exception
	{
		
		paramMap.put("COMP_CD", getCompCd());
		paramMap.put("UPD_ID" , getUserId());
		String[] mailArr ;
		
		if(null != paramMap.get("MAIL_ID_ARR"))
		{
			mailArr = paramMap.get("MAIL_ID_ARR").toString().split(",");
			
			for(String mailId : mailArr)
			{
				paramMap.put("MAIL_ID", mailId);
				msgDAO.deleteMsgInfo(paramMap);
			}
		}
		
		return paramMap;
	}
	
	/**
	 * SMS/MAIL 로그 정보 조회
	 * @param paramMap
	 * @return
	 * @throws BizException
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectMsgLogInfo(Map<String, Object> paramMap) throws BizException, Exception
	{
		
		paramMap.put("COMP_CD", getCompCd());
		
		List<Map<String,Object>> logList = null;
		
		//최근 로그 중 성공한 로그가 있을 경우 성공한 내용 return.
		logList = msgDAO.selectMsgLogInfo(paramMap);
		
		//최근 성공한 로그가 없을 경우 한번 더 조회
		if(logList.size() == 0 && "SMS".equals(paramMap.get("DIV_CD").toString()))
		{
			logList = msgDAO.selectMsgLogInfo2(paramMap);
		}
		
		return logList;
	}
	
	/**
	 * SMS/MAIL 로그 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectMsgLogList(Map<String, Object> paramMap) throws Exception
	{
		paramMap.put("COMP_CD", getCompCd());
		return msgDAO.selectMsgLogList(paramMap);
	}
	
	/**
	 * MAIL ID 리스트 조회(조회조건)
	 * @param paramMap
	 * @return
	 * @throws BizException
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectMailIdList(Map<String, Object> paramMap) throws BizException, Exception
	{
		paramMap.put("COMP_CD", getCompCd());
		return msgDAO.selectMailIdList(paramMap);
	}
	
	/**
	 * SMS/MAIL 상세보기 조회
	 * @param paramMap
	 * @return
	 * @throws BizException
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectMsgLogDetailInfo(Map<String, Object> paramMap) throws BizException, Exception
	{
		paramMap.put("COMP_CD", getCompCd());
		return msgDAO.selectMsgLogDetailInfo(paramMap);
	}
		
	/**
	 * 메일 재전송 처리
	 * @param paramMap
	 * @return
	 * @throws BizException
	 * @throws Exception
	 */
	public Map<String, Object> mailResend(Map<String, Object> paramMap) throws BizException, Exception
	{
		String[] seqArr = null;
		JsonData jsonData = new JsonData();
		int resCnt = 0;
		
		paramMap.put("COMP_CD", getCompCd());
		
		if(paramMap.get("SEQ_ARR") != null)
		{
			seqArr = paramMap.get("SEQ_ARR").toString().split(",");
			
			
			for(String seq : seqArr)
			{
				paramMap.put("SEQ", seq);
				List<Map<String, Object>> mailSmsInfoList = msgDAO.selectMsgLogDetailInfo(paramMap);
				
				if(mailSmsInfoList.size() > 0)
				{
					Map<String, Object> mailSmsInfo = mailSmsInfoList.get(0);
					
					Map<String, Object> mailParam = new HashMap<String, Object>();
					Map<String, Object> logParam  = new HashMap<String, Object>();
					
					mailParam.put("SENDER_EMAIL"	, ObjectUtils.defaultIfNull(mailSmsInfo.get("FROM_ID"),""));
					mailParam.put("RECEIVER_EMAIL"	, ObjectUtils.defaultIfNull(mailSmsInfo.get("TO_ID"),""));
					mailParam.put("SUBJECT"			, ObjectUtils.defaultIfNull(mailSmsInfo.get("SUBJECT"),""));
					mailParam.put("CONTENT"			, ObjectUtils.defaultIfNull(mailSmsInfo.get("CONTENT"),""));
					
					try
					{
						//메일 전송 로직 추가 
						//***********************************************************************************//*
						Map<String, Object> resMap = msgService.sendMail(mailParam);
						
						//***********************************************************************************//*
						//전송결과에 따라 성공 및 실패일 경우 로그 추가.
						logParam.put("COMP_CD", 	getCompCd());
						logParam.put("MAIL_ID", 	ObjectUtils.defaultIfNull(mailSmsInfo.get("MAIL_ID"),""));
						logParam.put("MSG_TYPE",	ObjectUtils.defaultIfNull(mailSmsInfo.get("MSG_TYPE"),""));
						logParam.put("MSG_KEY", 	ObjectUtils.defaultIfNull(mailSmsInfo.get("MSG_KEY"),""));
						logParam.put("FROM_ID",		ObjectUtils.defaultIfNull(mailSmsInfo.get("FROM_ID"),""));
						logParam.put("TO_ID",		ObjectUtils.defaultIfNull(mailSmsInfo.get("TO_ID"),""));
						logParam.put("SUBJECT",		ObjectUtils.defaultIfNull(mailSmsInfo.get("SUBJECT"),""));
						logParam.put("CONTENT",		ObjectUtils.defaultIfNull(mailSmsInfo.get("CONTENT"),""));
						
						if(resMap != null)
						{
							if("S".equals(resMap.get("RESULT").toString()))
							{
								//메일발송 성공시
								logParam.put("RESULT", "S");
							}
							else
							{
								//메일발송 실패시
								logParam.put("RESULT", "F");
							}
							
							resCnt = msgDAO.insertMsgLogInfo(logParam);
						}
						
					}
					catch(ServiceException e)
					{
						e.printStackTrace();
						jsonData.setErrMsg(e.getMessage());
					}
					catch(Exception e)
					{
						//메일발송 오류시
						logParam.put("COMP_CD", 	getCompCd());
						logParam.put("MAIL_ID", 	ObjectUtils.defaultIfNull(mailSmsInfo.get("MAIL_ID"),""));
						logParam.put("MSG_TYPE",	ObjectUtils.defaultIfNull(mailSmsInfo.get("MSG_TYPE"),""));
						logParam.put("MSG_KEY", 	ObjectUtils.defaultIfNull(mailSmsInfo.get("MSG_KEY"),""));
						logParam.put("FROM_ID",		ObjectUtils.defaultIfNull(mailSmsInfo.get("FROM_ID"),""));
						logParam.put("TO_ID",		ObjectUtils.defaultIfNull(mailSmsInfo.get("TO_ID"),""));
						logParam.put("SUBJECT",		ObjectUtils.defaultIfNull(mailSmsInfo.get("SUBJECT"),""));
						logParam.put("CONTENT",		ObjectUtils.defaultIfNull(mailSmsInfo.get("CONTENT"),""));
						logParam.put("RESULT",		"E");
						
						resCnt = msgDAO.insertMsgLogInfo(logParam);
					}
				}
				
			}
		}
		
		return paramMap;
	}
	
	/**
	 * 업무구분 리스트 조회
	 * @param param
	 * @return
	 * @throws BizException
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectTaskList(Map<String, Object> param) throws BizException, Exception
	{
		
		List<Map<String,Object>> searchList = null;
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("COMP_CD", getCompCd());
		
		searchList = msgDAO.selectTaskList(paramMap);
		
		return searchList;
	}
	
	/**
	 * 수신자 리스트
	 * @param param
	 * @return
	 * @throws BizException
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectReceiverNameList(Map<String, Object> param) throws BizException, Exception
	{
		
		List<Map<String,Object>> searchList = null;
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("COMP_CD", getCompCd());
		
		searchList = msgDAO.selectReceiverNameList(paramMap);
		
		return searchList;
	}
	
	
}
