package com.app.ildong.wrh.controller;

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

import com.app.ildong.wrh.service.WrhVendorInfoService;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.JsonData;
import com.app.ildong.common.model.mvc.BaseController;
import com.app.ildong.common.service.CommonSelectService;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.jdbc.BadSqlGrammarException;
import org.springframework.dao.DataIntegrityViolationException;

@Controller
public class WrhVendorInfoController extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(WrhVendorInfoController.class);
    
    private static final String sysErrMsg = "시스템 오류가 발생하였습니다.";
    
    @Autowired 
    private WrhVendorInfoService wrhVendorInfoService;
    
	@Autowired
    private CommonSelectService commonSelectService;	    
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/wrh/wrhVendorInfoPop.do")
    public String wrhVendorInfoPop(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	
    	try {
        	model.addAttribute("PARAM", paramMap);
        	model.putAll(commonSelectService.selectCodeList(new String[]{"IG003", "E102"}));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}    	
        return "com/wrh/wrhVendorInfoPop";
    }
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/wrh/wrhVendorMgmtV.do")
    public String wrhVendorMgmtV(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	
    	try {
    		paramMap.put("VENDOR_CD", getVendCode());
    		Map<String,Object> responseMap = wrhVendorInfoService.selectVendorInfo(paramMap);
        	model.addAttribute("PARAM", responseMap);
        	model.putAll(commonSelectService.selectCodeList(new String[]{"IG003", "E102"}));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}    	
        return "com/wrh/wrhVendorMgmtV";
    }    

    @RequestMapping("/com/wrh/selectVendorPurchOrgList.do")
    @ResponseBody
	public JsonData selectVendorPurchOrgList(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	
    	try {
    		
            List<Map<String,Object>> dataList = wrhVendorInfoService.selectVendorPurchOrgList(paramMap);
            jsonData.setStatus("SUCC");
            jsonData.setRows(dataList);
            
        } catch (Exception e) {
            e.printStackTrace();
            jsonData.setErrMsg(e.getMessage());
        }

		if( logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
        return jsonData;
    }
    
    @RequestMapping("/com/wrh/selectVendorUserList.do")
    @ResponseBody
	public JsonData selectVendorUserList(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	
    	try {
            List<Map<String,Object>> dataList = wrhVendorInfoService.selectVendorUserList(paramMap);
            jsonData.setStatus("SUCC");
            jsonData.setRows(dataList);
    		
        } catch (Exception e) {
            e.printStackTrace();
            jsonData.setErrMsg(e.getMessage());
        }

		if( logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
        return jsonData;
    }
    
    @RequestMapping(value = "/com/wrh/saveVendorUser.do")
    @ResponseBody
    public JsonData saveVendorUser(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		Map<String,Object> responseMap = wrhVendorInfoService.saveVendorUser(paramMap);
    		
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
    
    @RequestMapping(value = "/com/wrh/deleteVendorUser.do")
    @ResponseBody
    public JsonData deleteVendorUser(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		Map<String,Object> responseMap = wrhVendorInfoService.deleteVendorUser(paramMap);
    		
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
