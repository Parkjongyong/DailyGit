
package com.app.ildong.wrh.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.jdbc.BadSqlGrammarException;
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
import com.app.ildong.common.service.FileManageService;
import com.app.ildong.sys.service.SysExcelFormService;
import com.app.ildong.wrh.service.WrhSerialRegisterService;
import com.app.ildong.common.util.FileUtil;
import com.app.ildong.common.util.StringUtil;


@Controller
public class WrhSerialRegisterController extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(WrhSerialRegisterController.class);
    
    private static final String sysErrMsg = "시스템 오류가 발생하였습니다.";
    
	@Autowired
    private CommonSelectService commonSelectService;
	
    @Autowired 
    private WrhSerialRegisterService wrhSerialRegister;

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
    @RequestMapping("/com/wrh/wrhSerialRegister.do")
    public String wrhSerialRegisterV(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
    		Map<String, Object> dataInfo = sysExcelFormService.selectExcelForm(paramMap);
            if(!"".equals(StringUtil.nvl(dataInfo.get("ATTACHMENT"), "")) ){
                paramMap.put("APP_SEQ", StringUtil.nvl(dataInfo.get("ATTACHMENT"), ""));
                paramMap.put("ATTACH_SEQ", StringUtil.nvl(dataInfo.get("ATTACH_SEQ"), ""));
                List<Map<String, Object>> uploadedFiles = fileManageService.selectUploadedFileList(paramMap);
                
                model.addAttribute("fileList", FileUtil.convertForFileView(uploadedFiles));
            }

            model.addAttribute("dataInfo",    dataInfo);		
    		
			model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001", "IG002"}));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
        return "com/wrh/wrhSerialRegister";
    }
    
    @RequestMapping("/com/wrh/wrhDateTimeSearchPop.do")
    public String wrhDateTimeSearchPop(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
    		model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001", "IG002"}));
    	} catch (ServiceException e) {
    		e.printStackTrace();
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return "com/wrh/wrhDateTimeSearchPop";
    }
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/com/wrh/selectWrhSerialRegisterList.do")
    @ResponseBody
    public JsonData selectWrhSerialRegisterList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();

        try {

            List<Map<String,Object>> dataList = wrhSerialRegister.selectWrhSerialRegisterList(paramMap);
            
            if (null!=dataList && 0<dataList.size()) {
                Integer totalCnt = Integer.valueOf( ((Map<String,Object>)dataList.get(0)).get("TOT_CNT").toString() );
                
                paramMap.put("APPEND_PAGE","APPEND_PAGE");
                jsonData.setPageRows(paramMap, dataList, totalCnt);
            } else {
                jsonData.setPageRows(paramMap, null, 0);
            }

            jsonData.setStatus("SUCC");
            jsonData.setRows(dataList);
            
        } catch (Exception e) {
            logger.error("입고품목별일련번호등록 조회 오류", e);
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        return jsonData;
    }
    
    @RequestMapping(value = "/com/wrh/selectDateTime.do")
    @ResponseBody
    public JsonData selectDateTime(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	
    	try {
    		
    		List<Map<String,Object>> dataList = wrhSerialRegister.selectDateTime(paramMap);
    		jsonData.setStatus("SUCC");
    		jsonData.setRows(dataList);
    		
    	} catch (Exception e) {
    		logger.error("시간 조회 오류", e);
    	}
    	
    	if( logger.isDebugEnabled()) {
    		logger.debug("jsonData = " + jsonData);
    	}
    	return jsonData;
    }
    
    
    @RequestMapping(value = "/com/wrh/saveSerialRegister.do")
    @ResponseBody
    public JsonData saveSerialRegister(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws ServiceException, Exception {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		Map<String,Object> responseMap = wrhSerialRegister.saveSerialRegister(paramMap);
    		
    		if ("N".equals(responseMap.get("SUCC_YN"))) {
    			jsonData.setStatus("FAIL");
    			jsonData.addFields("result", responseMap);
    			jsonData.setErrMsg(responseMap.get("ERR_MSG").toString());
    		} else {
        		jsonData.setStatus("SUCC");
        		jsonData.addFields("result", responseMap);
    		}
    		
    	} catch (ServiceException se) {
    		se.printStackTrace();
    		jsonData.setStatus("FAIL");
    		jsonData.setErrMsg(se.getMessage());
    	} catch (Exception e) {
        	e.printStackTrace();
        	jsonData.setStatus("FAIL");
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
    
    @RequestMapping(value = "/com/wrh/deleteSerialRegister.do")
    @ResponseBody
    public JsonData deleteSerialRegister(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		// 삭제로직 수행
    		Map<String,Object> responseMap = wrhSerialRegister.deleteSerialRegister(paramMap);
    		
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
    	

		if( logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
    	
    	return jsonData;
    }
    
    
}
