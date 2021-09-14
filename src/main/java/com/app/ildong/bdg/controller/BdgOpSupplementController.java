
package com.app.ildong.bdg.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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

import com.app.ildong.bat.dao.BatSendBugtDAO;
import com.app.ildong.bdg.service.BdgOpSupplementService;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.JsonData;
import com.app.ildong.common.model.mvc.BaseController;
import com.app.ildong.common.service.CommonSelectService;
import com.app.ildong.common.util.StringUtil;
import com.ildong.CO.BGT_ERP.IFCO008_BGT_SOBindingStub;
import com.ildong.CO.BGT_ERP.IFCO008_BGT_SOServiceLocator;
import com.ildong.CO.BGT_ERP.IFCO008_BGT_S_DTITEM;
import com.ildong.CO.BGT_ERP.IFCO008_BGT_S_DT_response;
import com.ildong.CO.BGT_ERP.IFCO014_BGT_SOBindingStub;
import com.ildong.CO.BGT_ERP.IFCO014_BGT_SOServiceLocator;
import com.ildong.CO.BGT_ERP.IFCO014_BGT_S_DTITEM;
import com.ildong.CO.BGT_ERP.IFCO014_BGT_S_DT_response;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.jdbc.BadSqlGrammarException;
import org.springframework.dao.DataIntegrityViolationException;

@Controller
public class BdgOpSupplementController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(BdgOpSupplementController.class);

	private static final String sysErrMsg = "시스템 오류가 발생하였습니다.";

	@Autowired
	private CommonSelectService commonSelectService;

	@Autowired
	private BdgOpSupplementService bdgOpSupplementService;

	@Autowired
	private SchedulerFactoryBean schedulerFactoryBean;

	@Autowired
	private BatSendBugtDAO batSendBugtDAO;

	/**
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/com/bdg/bdgOpSupplement.do")
	public String bdgOpSupplement(@RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		try {
			model.putAll(commonSelectService.selectCodeList(new String[] { "SYS001", "YS007", "YS006" }));
			model.putAll(commonSelectService.selectCompList());
			model.putAll(commonSelectService.selectCostList());
			model.putAll(commonSelectService.selectOpAccountCodeList2("SYSACC"));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "com/bdg/bdgOpSupplement";
	}

	@RequestMapping("/com/bdg/bdgOpSupplementM.do")
	public String bdgOpSupplementM(@RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		try {
			model.putAll(commonSelectService.selectCodeList(new String[] { "SYS001", "YS007", "YS006" }));
			model.putAll(commonSelectService.selectOpAccountCodeList2("SYSACC"));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "com/bdg/bdgOpSupplementM";
	}

	/**
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/com/bdg/selectOpSupplement.do")
	@ResponseBody
	public JsonData selectSupplementHeader(@RequestBody Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		JsonData jsonData = new JsonData();

		try {

			List<Map<String, Object>> dataList = bdgOpSupplementService.selectOpSupplement(paramMap);
			jsonData.setStatus("SUCC");
			jsonData.setRows(dataList);

		} catch (Exception e) {
			logger.error("기본예산신청 조회 오류", e);
		}

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
		return jsonData;
	}

	@RequestMapping(value = "/com/bdg/saveOpSupplement.do")
	@ResponseBody
	public JsonData saveSupplement(@RequestBody Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		JsonData jsonData = new JsonData();
		try {
			Map<String, Object> responseMap = bdgOpSupplementService.saveOpSupplement(paramMap);

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

	@RequestMapping(value = "/com/bdg/delOpSupplement.do")
	@ResponseBody
	public JsonData delSupplement(@RequestBody Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		JsonData jsonData = new JsonData();
		try {

			Map<String, Object> responseMap = bdgOpSupplementService.delOpSupplement(paramMap);

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

	@RequestMapping(value = "/com/bdg/confirmOpSupplement.do")
	@ResponseBody
	public JsonData confirmOpSupplement(@RequestBody Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		JsonData jsonData = new JsonData();
		try {
			Map<String, Object> responseMap = bdgOpSupplementService.confirmOpSupplement(paramMap);

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

	@RequestMapping(value = "/com/bdg/confirmCancelOpSupplement.do")
	@ResponseBody
	public JsonData confirmCancelOpSupplement(@RequestBody Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		JsonData jsonData = new JsonData();
		try {
			Map<String, Object> responseMap = bdgOpSupplementService.confirmCancelOpSupplement(paramMap);
			
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
	
	/**
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/com/bdg/selectOpSupplementAmt.do")
	@ResponseBody
	public JsonData selectSupplementAmt(@RequestBody Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		JsonData jsonData = new JsonData();

		try {

			List<Map<String, Object>> dataList = bdgOpSupplementService.selectOpSupplementAmt(paramMap);
			jsonData.setStatus("SUCC");
			jsonData.setRows(dataList);

		} catch (Exception e) {
			logger.error("기본예산신청 조회 오류", e);
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
	@RequestMapping(value = "/com/bdg/selectOpDistribList.do")
	@ResponseBody
	public JsonData selectOpDistribList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		JsonData jsonData = new JsonData();
		
		try {
			
			List<Map<String, Object>> dataList = bdgOpSupplementService.selectOpDistribList(paramMap);
			jsonData.setStatus("SUCC");
			jsonData.setRows(dataList);
			
		} catch (Exception e) {
			logger.error("기본예산신청 조회 오류", e);
		}
		
		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
		return jsonData;
	}

    @RequestMapping(value = "/com/bdg/returnOpSupplement.do")
    @ResponseBody
    public JsonData returnModifyMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		Map<String,Object> responseMap = bdgOpSupplementService.returnOpSupplement(paramMap);
    		
    		jsonData.setStatus("SUCC");
    		jsonData.addFields("result", responseMap);
    		
    	} catch (ServiceException se) {
    		se.printStackTrace();
    		jsonData.setErrMsg(se.getMessage());
    	} catch (Exception e) {
    		e.printStackTrace();
    		jsonData.setErrMsg(e.getMessage());
    	}
    	
    	
    	if( logger.isDebugEnabled()) {
    		logger.debug("jsonData = " + jsonData);
    	}
    	
    	return jsonData;
    }

    @RequestMapping(value = "/com/bdg/sendOpSupplement.do")
    @ResponseBody
    public JsonData sendOpSupplement(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws ServiceException, Exception {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		Map<String,Object> responseMap = bdgOpSupplementService.sendOpSupplement(paramMap);
    		
    		jsonData.setStatus("SUCC");
    		jsonData.addFields("result", responseMap);
    		
    	} catch (ServiceException se) {
    		se.printStackTrace();
    		jsonData.setStatus("FAIL");
    		jsonData.setErrMsg(se.getMessage());
    	} catch (Exception e) {
    		e.printStackTrace();
    		jsonData.setStatus("FAIL");
    		jsonData.setErrMsg(e.getMessage());
    	}
    	
    	
    	if( logger.isDebugEnabled()) {
    		logger.debug("jsonData = " + jsonData);
    	}
    	
    	return jsonData;
    } 
    
    @RequestMapping(value = "/com/bdg/sendCancelOpSupplement.do")
    @ResponseBody
    public JsonData sendCancelOpSupplement(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws ServiceException, Exception {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		Map<String,Object> responseMap = bdgOpSupplementService.sendCancelOpSupplement(paramMap);
    		
    		jsonData.setStatus("SUCC");
    		jsonData.addFields("result", responseMap);
    		
    	} catch (ServiceException se) {
    		se.printStackTrace();
    		jsonData.setStatus("FAIL");
    		jsonData.setErrMsg(se.getMessage());
    	} catch (Exception e) {
    		e.printStackTrace();
    		jsonData.setStatus("FAIL");
    		jsonData.setErrMsg(e.getMessage());
    	}
    	
    	
    	if( logger.isDebugEnabled()) {
    		logger.debug("jsonData = " + jsonData);
    	}
    	
    	return jsonData;
    } 
    
    
}
