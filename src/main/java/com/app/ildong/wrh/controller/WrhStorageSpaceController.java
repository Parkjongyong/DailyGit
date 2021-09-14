
package com.app.ildong.wrh.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.JsonData;
import com.app.ildong.common.model.mvc.BaseController;
import com.app.ildong.common.service.CommonSelectService;
import com.app.ildong.wrh.service.WrhStorageSpaceMgmtService;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.jdbc.BadSqlGrammarException;
import org.springframework.dao.DataIntegrityViolationException;

@Controller
public class WrhStorageSpaceController extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(WrhStorageSpaceController.class);
    
    private static final String sysErrMsg = "시스템 오류가 발생하였습니다.";
    
	@Autowired
    private CommonSelectService commonSelectService;
	
    @Autowired 
    private WrhStorageSpaceMgmtService wrhStorageSpaceMgmtService;
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/wrh/wrhStorageSpaceMgmt.do")
    public String wrhStorageSpaceMgmt(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
			model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001", "IG002"}));
			model.putAll(commonSelectService.selectPlandCodeList("SYSPLT"));
			model.putAll(commonSelectService.selectStorageCodeList("SYSSTR"));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
        return "com/wrh/wrhStorageSpaceMgmt";
    }
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/wrh/wrhStorageSpacePop.do")
    public String wrhStorageSpacePop(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	model.addAttribute("PARAM", paramMap);
        return "com/wrh/wrhStorageSpacePop";
    }    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/com/wrh/selectWhrStorageSpaceMgmtList.do")
    @ResponseBody
    public JsonData selectWhrStorageSpaceMgmtList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();
        
        try {
        	paramMap.put("USER_ID", getUserId());
            List<Map<String,Object>> dataList = wrhStorageSpaceMgmtService.selectWhrStorageSpaceMgmtList(paramMap);
            jsonData.setStatus("SUCC");
            jsonData.addFields("storageSpace", dataList);
            
        } catch (Exception e) {
            logger.error("입고예정등록일 조회 오류", e);
        }
        
        if( logger.isDebugEnabled()) {
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
    @RequestMapping(value = "/com/wrh/wrhStorageSpacePopList.do")
    @ResponseBody
    public JsonData wrhStorageSpacePopList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();
        
        try {

            List<Map<String,Object>> dataList = wrhStorageSpaceMgmtService.selectwrhStorageSpacePopList(paramMap);
            jsonData.setStatus("SUCC");
            jsonData.setRows(dataList);
            
        } catch (Exception e) {
            logger.error("입고예정등록일 조회 오류", e);
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        return jsonData;
    } 
    
    @RequestMapping(value = "/com/wrh/saveWhrStorageSpace.do")
    @ResponseBody
    public JsonData saveWhrStorageSpace(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws ServiceException, Exception {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		Map<String,Object> responseMap = wrhStorageSpaceMgmtService.saveWhrStorageSpace(paramMap);

    		jsonData.setStatus("SUCC");
    		jsonData.addFields("result", responseMap);
    		
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

    
    @RequestMapping("/com/wrh/wrhStorageSpaceM.do")
    public String wrhStorageSpaceM(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
			model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001", "IG002"}));
			model.putAll(commonSelectService.selectStorageCompList("ST_COMP"));
			model.putAll(commonSelectService.selectStoragePlantList("ST_PLANT"));
			model.putAll(commonSelectService.selectStorageList("ST_STORAGE"));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
        return "com/wrh/wrhStorageSpaceM";
    }
    

}
