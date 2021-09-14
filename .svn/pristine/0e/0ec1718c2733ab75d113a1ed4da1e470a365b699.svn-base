package com.app.ildong.cmn.controller;

import java.util.List;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.mail.MailSender;
import com.app.ildong.common.model.JsonData;
import com.app.ildong.common.model.mvc.BaseController;
import com.app.ildong.common.sms.SMSSender;
import com.app.ildong.common.util.DateUtil;
import com.app.ildong.cmn.service.CmnMsgService;

@Controller
public class CmnMsgController extends BaseController {
	protected final Log logger = LogFactory.getLog(getClass());
	
    @Autowired 
    private CmnMsgService msgService;
    
    /**
     * SMS/MAIL 문구 화면으로 이동
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
	@RequestMapping("/com/cmn/msgList.do")
	public String msgList(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		try {
			
			model.addAttribute("PARAM", paramMap);
			model.put("TASK_GUBUN_LIST" ,	msgService.selectTaskList(paramMap));
			model.put("RECEIVER_NM_LIST" ,	msgService.selectReceiverNameList(paramMap));
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "com/cmn/cmnMsgList";
	}

    /**
     * SMS/MAIL 문구 조회
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
	@RequestMapping(value = "/com/cmn/selectMsgList.do")
	@ResponseBody
	public JsonData selectMsgList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();

		try {
			paramMap.put("startRow"	, getStartRow(paramMap));
			paramMap.put("pageSize"	, getPageSize(paramMap));
			List<Map<String,Object>> msgList = msgService.selectMsgList(paramMap);

			if (null!=msgList && 0<msgList.size())
			{
				Integer totalCnt = Integer.valueOf( ((Map<String,Object>)msgList.get(0)).get("TOT_CNT").toString() ); 
				jsonData.setPageRows(paramMap, msgList, totalCnt);
			}
			else
			{
				jsonData.setPageRows(paramMap, null, 0);
			}

		} catch (Exception e) {
			e.printStackTrace();
			jsonData.setErrMsg(e.getMessage());
		}

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
		return jsonData;
	}
	
	/**
	 * SMS/MAIL 상세화면으로 이동
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/com/cmn/msgDetailPopup.do")
	public String msgDetailPopup(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, Model model) {
		model.addAttribute("PARAM", paramMap);
		return "com/cmn/cmnMsgDetailPopup";
	}
	
	/**
	 * SMS/MAIL 상세정보 수정
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/com/cmn/updateMsgDetail.do")
	@ResponseBody
	public JsonData updateMsgDetail(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();

		try {
			Map<String, Object> responseMap = msgService.updateMsgDetail(paramMap);
			
			jsonData.setStatus("SUCC");
			jsonData.addFields("result", responseMap);
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.setErrMsg(e.getMessage());
		}

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
		return jsonData;
	}
	
	/**
	 * SMS/MAIL 삭제 처리
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/com/cmn/deleteMsgInfo.do")
	@ResponseBody
	public JsonData deleteMsgInfo(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();

		try {
			Map<String, Object> responseMap = msgService.deleteMsgInfo(paramMap);
			
			jsonData.setStatus("SUCC");
			jsonData.addFields("result", responseMap);
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.setErrMsg(e.getMessage());
		}

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
		return jsonData;
	}
	
	/**
	 * SMS/MAIL 최신 전송 정보 조회
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/com/cmn/msgLogInfoPopup.do")
	public String msgLogInfoPopup(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		model.addAttribute("PARAM", paramMap);
		Map<String, Object> responseMap = null;
		try {
			List<Map<String,Object>> msgLogList = msgService.selectMsgLogInfo(paramMap);
			if(msgLogList.size() > 0)
			{
				responseMap = msgLogList.get(0);	
			}
			
			model.put("RESULT_INFO", responseMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "com/cmn/cmnMsgLogInfoPopup";
	}
	
	/**
	 * SMS/MAIL 로그 관리 화면으로 이동
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/com/cmn/msgLogList.do")
	public String msgLogList(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		try {
			model.put("PARAM_DATE_FROM"	, DateUtil.getDateString());
			model.put("PARAM_DATE_TO"	, DateUtil.getDateString());
			
			model.put("MAIL_ID_LIST"	, msgService.selectMailIdList(paramMap));
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "com/cmn/cmnMsgLogList";
	}
	
	
	/**
	 * SMS/MAIL 로그화면 조회
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/com/cmn/selectMsgLogList.do")
	@ResponseBody
	public JsonData selectMsgLogList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();

		try {
			paramMap.put("startRow"	, getStartRow(paramMap));
			paramMap.put("pageSize"	, getPageSize(paramMap));
			
			List<Map<String,Object>> msgLogList = msgService.selectMsgLogList(paramMap);

			if (null!=msgLogList && 0<msgLogList.size())
			{
				Integer totalCnt = Integer.valueOf( ((Map<String,Object>)msgLogList.get(0)).get("TOT_CNT").toString() ); 
				jsonData.setPageRows(paramMap, msgLogList, totalCnt);
			}
			else
			{
				jsonData.setPageRows(paramMap, null, 0);
			}

		} catch (Exception e) {
			e.printStackTrace();
			jsonData.setErrMsg(e.getMessage());
		}

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
		return jsonData;
	}
	
	/**
	 * SMS/MAIL 로그 상세보기 팝업 이동.
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/com/cmn/msgLogDetailPopup.do")
	public String msgLogDetailPopup(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		Map<String, Object> responseMap = null;
		try {
			List<Map<String,Object>> msgLogDetailList = msgService.selectMsgLogDetailInfo(paramMap);
			
			if(msgLogDetailList.size() > 0)
			{
				responseMap = msgLogDetailList.get(0);	
			}
			
			model.put("DETAIL_INFO"	, responseMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "com/cmn/cmnMsgLogDetailPopup";
	}
	
	@RequestMapping(value = "/com/cmn/mailResend.do")
	@ResponseBody
	public JsonData mailResend(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();

		try {
			Map<String, Object> responseMap = msgService.mailResend(paramMap);
			
			jsonData.setStatus("SUCC");
			jsonData.addFields("result", responseMap);
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.setErrMsg(e.getMessage());
		}

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
		return jsonData;
	}
	
	
	@RequestMapping(value = "/com/cmn/mailTest.do")
	@ResponseBody
	public JsonData mailTest(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();

        String result = null;
        MailSender service = new MailSender();

        try {
        	String senderEmail = "parucnc@PARUCNC.COM";
        	String receiverEmail = (String)paramMap.get("RCV_EMAIL");
        	String subject = "[TEST] 메일테스트 " + DateUtil.getFormatHanString(DateUtil.getCurrentDateTimeAsString(), "YYYYMMDDHHMISS");
        	String contents = (String)paramMap.get("CONTENTS");
        	
            result = service.sendMail(senderEmail, receiverEmail, subject, contents);

        } catch (Exception e) {
        	e.printStackTrace();
        }
        
		return jsonData;
	}
	

	@RequestMapping(value = "/com/cmn/smsTest.do")
	@ResponseBody
	public JsonData smsTest(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();

        SMSSender service = new SMSSender();
        
        try {
        	String senderPhoneNumber 	= "0212341234";
        	String receiverPhoneNumber 	= (String)paramMap.get("RCV_SMS");
        	String contents 			= (String)paramMap.get("CONTENTS");
        	service.sendSms("6", receiverPhoneNumber, senderPhoneNumber, contents);
        } catch (Exception e) {
        	e.printStackTrace();
        }
        
		return jsonData;
	}
	

	
}
