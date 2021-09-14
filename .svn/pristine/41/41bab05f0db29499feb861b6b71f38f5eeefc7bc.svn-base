
package com.app.ildong.bdg.controller;

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

import com.app.ildong.bdg.service.BdgPromDetailService;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.JsonData;
import com.app.ildong.common.model.mvc.BaseController;
import com.app.ildong.common.service.CommonSelectService;
import com.app.ildong.common.service.FileManageService;
import com.app.ildong.common.util.FileUtil;
import com.app.ildong.common.util.StringUtil;
import com.app.ildong.sys.service.SysExcelFormService;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.jdbc.BadSqlGrammarException;
import org.springframework.dao.DataIntegrityViolationException;

@Controller
public class BdgPromDetailController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(BdgPromDetailController.class);

	private static final String sysErrMsg = "시스템 오류가 발생하였습니다.";

	@Autowired
	private CommonSelectService commonSelectService;

	@Autowired
	private BdgPromDetailService bdgPromDetailService;
	
	@Autowired
	private SysExcelFormService sysExcelFormService;

    @Autowired
    private FileManageService fileManageService;
    
	/**
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/com/bdg/bdgPromDetail.do")
	public String bdgPromDetail(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		try {
			model.putAll(commonSelectService.selectCodeList(new String[] { "SYS001", "YS012", "YS008" }));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "com/bdg/bdgPromDetail";
	}

	/**
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/com/bdg/bdgPromDetailExcel.do")
	public String bdgPromDetailExcel(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model)  throws Exception {
		paramMap.put("G_MENU_CD", "BDG145");
		Map<String, Object> dataInfo = sysExcelFormService.selectExcelForm(paramMap);
        if(!"".equals(StringUtil.nvl(dataInfo.get("ATTACHMENT"), "")) ){
            paramMap.put("APP_SEQ", StringUtil.nvl(dataInfo.get("ATTACHMENT"), ""));
            paramMap.put("ATTACH_SEQ", StringUtil.nvl(dataInfo.get("ATTACH_SEQ"), ""));
            List<Map<String, Object>> uploadedFiles = fileManageService.selectUploadedFileList(paramMap);
            
            model.addAttribute("fileList", FileUtil.convertForFileView(uploadedFiles));
        }
        
        model.addAttribute("dataInfo",    dataInfo);		
		model.addAttribute("PARAM", paramMap);
		model.putAll(commonSelectService.selectCodeList(new String[] { "SYS001", "YS012", "YS008" }));
		
		return "com/bdg/bdgPromDetailExcel";
	}
	

	/**
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/com/bdg/selectPromDetail.do")
	@ResponseBody
	public JsonData selectPromDetail(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();

		try {

			List<Map<String, Object>> dataList = bdgPromDetailService.selectPromDetail(paramMap);
			jsonData.setStatus("SUCC");
			jsonData.setRows(dataList);

		} catch (Exception e) {
			logger.error("홍보 디테일관리 조회 오류", e);
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
	@RequestMapping(value = "/com/bdg/selectPromDetailExcel.do")
	@ResponseBody
	public JsonData selectPromDetailExcel(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();
		
		try {
			
			List<Map<String, Object>> dataList = bdgPromDetailService.selectPromDetailExcel(paramMap);
			jsonData.setStatus("SUCC");
			jsonData.setRows(dataList);
			
		} catch (Exception e) {
			logger.error("홍보 디테일관리 조회 오류", e);
		}
		
		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
		return jsonData;
	}
	
	@RequestMapping(value = "/com/bdg/savePromDetail.do")
	@ResponseBody
	public JsonData saveSupplement(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();
		try {
			Map<String, Object> responseMap = bdgPromDetailService.savePromDetail(paramMap);

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

	@RequestMapping(value = "/com/bdg/savePromDetailExcel.do")
	@ResponseBody
	public JsonData savePromDetailExcel(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();
		try {
			Map<String, Object> responseMap = bdgPromDetailService.savePromDetailExcel(paramMap);
			
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
	
	@RequestMapping(value = "/com/bdg/savePromDetailUpload.do")
	@ResponseBody
	public JsonData savePromDetailUpload(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();
		try {
			Map<String, Object> responseMap = bdgPromDetailService.savePromDetailUpload(paramMap);
			
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
	
	@RequestMapping(value = "/com/bdg/delPromDetail.do")
	@ResponseBody
	public JsonData delSupplement(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();
		try {

			Map<String, Object> responseMap = bdgPromDetailService.delPromDetail(paramMap);

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

    @RequestMapping(value = "/com/bdg/receptionPromDetail.do")
    @ResponseBody
    public JsonData receptionPromDetail(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	
    	try {
    		Map<String,Object> responseMap = bdgPromDetailService.receptionPromDetail(paramMap);
    		jsonData.setStatus("SUCC");
    		jsonData.addFields("result", responseMap);
    		
    	} catch (ServiceException se) {
    		se.printStackTrace();
    		jsonData.setErrMsg(se.getMessage());
    	} catch (Exception e) {
    		System.out.println("saveBasicMgt Exception in");
        	e.printStackTrace();
        	System.out.println("saveBasicMgt Exception e.getMessage()::" + e.getMessage());
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
    	

		if( logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
    	
    	return jsonData;
    }
}
