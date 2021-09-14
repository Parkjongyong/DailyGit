package com.app.ildong.common.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ecbank.framework.exception.BizException;
import com.app.ildong.common.model.JsonData;
import com.app.ildong.common.model.mvc.BaseController;
import com.app.ildong.sys.service.JCoProcessService;

/**
 * JCO 로그 관련 controller
 * @author SLP00419
 *
 */
@Controller
public class JcoController extends BaseController {
	
	private static final Logger logger = LoggerFactory.getLogger(JcoController.class);
	
	@Autowired
	private JCoProcessService jCoProcessService;
	
	private static final String sysErrMsg = "시스템 오류가 발생하였습니다.";
	
	/**
	 * JCO 결과로그 조회 팝업
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/com/cmn/cmnJcoReturnLogPopup.do")
	public String cmnJcoReturnLogPopup(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
		return "com/cmn/cmnJcoReturnLogPopup";
	}
	
	/**
	 * JCO 결과로그 조회
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/com/cmn/selectJcoReturnLogList.do")
	@ResponseBody
	public JsonData selectJcoReturnLogList(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();
		
		try {
			List<Map<String,Object>> dataList = jCoProcessService.selectJcoReturnLogList(paramMap);
			jsonData.setPageRows(paramMap, dataList, dataList!=null?dataList.size():0);
			
		} catch (BizException se) {
			logger.error(" JCO 결과로그 조회 오류", se);
			jsonData.setErrMsg(se.getMessage());
		} catch (Exception e) {
			logger.error(" JCO 결과로그 조회 오류", e);
			jsonData.setErrMsg(sysErrMsg);
		}
		
		logger.debug("jsonData: {}", jsonData);
			
		return jsonData;
	}
}
