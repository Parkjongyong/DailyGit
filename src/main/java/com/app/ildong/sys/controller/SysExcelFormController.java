/**
 * 부서 조회 컨트롤러
 * @author 길용덕
 * @since 2020.07.08
 * 
 * << 개정이력(Modification Information) >>
 *  ------------------------------------------------- 
 *  수정일                    수정자            수정내용
 *  ----------   -------- ---------------------------
 *  2020.07.08   길용덕            최초생성
 *  -------------------------------------------------
 */
package com.app.ildong.sys.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.JsonData;
import com.app.ildong.common.model.mvc.BaseController;
import com.app.ildong.common.service.CommonSelectService;
import com.app.ildong.sys.service.SysExcelFormService;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.jdbc.BadSqlGrammarException;
import org.springframework.dao.DataIntegrityViolationException;


@Controller
public class SysExcelFormController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(SysExcelFormController.class);
	
    @Autowired 
    private SysExcelFormService excelFormService;
    
	@Autowired
    private CommonSelectService commonSelectService;
	
    @Autowired
    private SchedulerFactoryBean schedulerFactoryBean;	
	
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/sys/sysExcelForm.do")
	public String excelFormList(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
    		model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001"}));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "com/sys/sysExcelForm";
	}

	/**
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/com/sys/selectExcelFormList.do")
	@ResponseBody
	public JsonData selectExcelFormList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();

		try {
			List<Map<String, Object>> menuList = excelFormService.selectExcelFormList(paramMap);
			jsonData.setRows(menuList);
			
		} catch (Exception e) {
			logger.error("com/sys/selectExcelFormList.do 오류 발생", e);
			jsonData.setErrMsg(e.getMessage());
		}

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
		return jsonData;
	}
	
	@RequestMapping(value = "/com/sys/saveExcelForm.do")
	@ResponseBody
	public JsonData saveSupplement(@RequestBody Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		JsonData jsonData = new JsonData();
		try {
			Map<String, Object> responseMap = excelFormService.saveExcelForm(paramMap);

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
