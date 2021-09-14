
package com.app.ildong.wrh.controller;

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
import com.app.ildong.wrh.service.WrhVendorScheduledService;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.jdbc.BadSqlGrammarException;
import org.springframework.dao.DataIntegrityViolationException;

@Controller
public class WrhVendorScheduledController extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(WrhVendorScheduledController.class);
    
    private static final String sysErrMsg = "시스템 오류가 발생하였습니다.";
    
	@Autowired
    private CommonSelectService commonSelectService;
	
    @Autowired 
    private WrhVendorScheduledService wrhVendorScheduledService;
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/wrh/wrhVendorScheduled.do")
    public String wrhVendorScheduled(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
			model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001","IG007","E102","IG001"}));
			model.put("CODELIST_IG", commonSelectService.setCommMap(new String[]{"IG007","ALL","ATTR01"}));
			model.putAll(commonSelectService.selectPlandCodeList("SYSPLT"));
			model.putAll(commonSelectService.selectStorageCodeList("SYSSTR"));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
        return "com/wrh/wrhVendorScheduled";
    }

    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/com/wrh/selectVendorScheduled.do")
    @ResponseBody
    public JsonData selectWhrVendorScheduledList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();
        try {
            List<Map<String,Object>> dataList = wrhVendorScheduledService.selectVendorScheduled(paramMap);
            jsonData.setStatus("SUCC");
            jsonData.setRows(dataList);
            
        } catch (Exception e) {
            logger.error("입고예정일 관리 조회 오류", e);
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        return jsonData;
    }
    
}
