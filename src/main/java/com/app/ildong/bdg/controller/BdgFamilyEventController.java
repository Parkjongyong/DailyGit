
package com.app.ildong.bdg.controller;

import java.lang.reflect.Field;
import java.util.ArrayList;
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

import com.app.ildong.bdg.service.BdgFamilyEventService;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.JsonData;
import com.app.ildong.common.model.mvc.BaseController;
import com.app.ildong.common.service.CommonSelectService;
import com.app.ildong.common.util.StringUtil;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.jdbc.BadSqlGrammarException;
import org.springframework.dao.DataIntegrityViolationException;

@Controller
public class BdgFamilyEventController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(BdgFamilyEventController.class);

	private static final String sysErrMsg = "시스템 오류가 발생하였습니다.";

	@Autowired
	private CommonSelectService commonSelectService;

	@Autowired
	private BdgFamilyEventService bdgFamilyEventService;

	/**
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/com/bdg/bdgFamilyEvent.do")
	public String bdgFamilyEvent(@RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		try {
			model.putAll(commonSelectService.selectCodeList(new String[] { "SYS001", "YS013", "YS014", "YS015", "YS016", "E102" }));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "com/bdg/bdgFamilyEvent";
	}

	@RequestMapping("/com/bdg/bdgFamilyEventM.do")
	public String bdgFamilyEventM(@RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		try {
			model.putAll(commonSelectService.selectCodeList(new String[] { "SYS001", "YS013", "YS014", "YS015", "YS016", "E102" }));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "com/bdg/bdgFamilyEventM";
	}

	/**
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/com/bdg/selectFamilyEvent.do")
	@ResponseBody
	public JsonData selectFamilyEvent(@RequestBody Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		JsonData jsonData = new JsonData();

		try {

			List<Map<String, Object>> dataList = bdgFamilyEventService.selectFamilyEvent(paramMap);
			jsonData.setStatus("SUCC");
			jsonData.setRows(dataList);

		} catch (Exception e) {
			logger.error("대외경조신청 조회 오류", e);
		}

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
		return jsonData;
	}

	/**
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/com/bdg/selectFamilyEventM.do")
	@ResponseBody
	public JsonData selectFamilyEventM(@RequestBody Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		JsonData jsonData = new JsonData();
		
		try {
			
			List<Map<String, Object>> dataList = bdgFamilyEventService.selectFamilyEventM(paramMap);
			jsonData.setStatus("SUCC");
			jsonData.setRows(dataList);
			
		} catch (Exception e) {
			logger.error("대외경조관리 조회 오류", e);
		}
		
		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
		return jsonData;
	}
	
	@RequestMapping(value = "/com/bdg/saveFamilyEvent.do")
	@ResponseBody
	public JsonData saveFamilyEvent(@RequestBody Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		JsonData jsonData = new JsonData();
		try {
			Map<String, Object> responseMap = bdgFamilyEventService.saveFamilyEvent(paramMap);
    		if (!"Y".equals(responseMap.get("SUCC_YN").toString())) {
        		jsonData.setStatus("FAIL");
        		jsonData.setErrMsg(responseMap.get("ERR_MSG").toString());
        		jsonData.addFields("result", responseMap);
    		} else {
        		jsonData.setStatus("SUCC");
        		jsonData.addFields("result", responseMap);
    		} 

		} catch (ServiceException se) {
			se.printStackTrace();
			jsonData.setErrMsg(se.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
        	if (e instanceof DuplicateKeyException) {
        		jsonData.setErrMsg("중복된 데이터가 존재합니다. 확인 후 작업하세요.");
        	} else if (e instanceof BadSqlGrammarException) {
        		jsonData.setErrMsg("DB 오류가 발생했습니다. 관리자에게 문의 하시길 바랍니다.");
        	} else if (e instanceof DataIntegrityViolationException) {
        		jsonData.setErrMsg("DB 오류가 발생했습니다. 관리자에게 문의 하시길 바랍니다.");
        	} else {
        		jsonData.setErrMsg(e.getMessage());
        	}
		}

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}

		return jsonData;
	}

	@RequestMapping(value = "/com/bdg/applyFamilyEvent.do")
	@ResponseBody
	public JsonData applyFamilyEvent(@RequestBody Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		JsonData jsonData = new JsonData();
		try {

			Map<String, Object> responseMap = bdgFamilyEventService.applyFamilyEvent(paramMap);

			jsonData.setStatus("SUCC");
			jsonData.addFields("result", responseMap);

		} catch (ServiceException se) {
			se.printStackTrace();
			jsonData.setErrMsg(se.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.setErrMsg(e.getMessage());
		}

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}

		return jsonData;
	}

	@RequestMapping(value = "/com/bdg/confirmFamilyEvent.do")
	@ResponseBody
	public JsonData confirmFamilyEvent(@RequestBody Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		JsonData jsonData = new JsonData();
		try {
			Map<String, Object> responseMap = bdgFamilyEventService.confirmFamilyEvent(paramMap);

			jsonData.setStatus("SUCC");
			jsonData.addFields("result", responseMap);

		} catch (ServiceException se) {
			se.printStackTrace();
			jsonData.setErrMsg(se.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.setErrMsg(e.getMessage());
		}

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}

		return jsonData;
	}

	
	@RequestMapping(value = "/com/bdg/delFamilyEvent.do")
	@ResponseBody
	public JsonData delFamilyEvent(@RequestBody Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		JsonData jsonData = new JsonData();
		try {

			Map<String, Object> responseMap = bdgFamilyEventService.delFamilyEvent(paramMap);

			jsonData.setStatus("SUCC");
			jsonData.addFields("result", responseMap);

		} catch (ServiceException se) {
			se.printStackTrace();
			jsonData.setErrMsg(se.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
        	if (e instanceof DuplicateKeyException) {
        		jsonData.setErrMsg("중복된 데이터가 존재합니다. 확인 후 작업하세요.");
        	} else if (e instanceof BadSqlGrammarException) {
        		jsonData.setErrMsg("DB 오류가 발생했습니다. 관리자에게 문의 하시길 바랍니다.");
        	} else if (e instanceof DataIntegrityViolationException) {
        		jsonData.setErrMsg("DB 오류가 발생했습니다. 관리자에게 문의 하시길 바랍니다.");
        	} else {
        		jsonData.setErrMsg(e.getMessage());
        	}
		}

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}

		return jsonData;
	}

}
