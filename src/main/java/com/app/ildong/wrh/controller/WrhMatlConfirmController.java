
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
import org.springframework.dao.DuplicateKeyException;
import org.springframework.jdbc.BadSqlGrammarException;
import org.springframework.dao.DataIntegrityViolationException;

import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.JsonData;
import com.app.ildong.common.model.mvc.BaseController;
import com.app.ildong.common.service.CommonSelectService;
import com.app.ildong.wrh.service.WrhMatlConfirmService;

@Controller
public class WrhMatlConfirmController extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(WrhMatlConfirmController.class);
    
    private static final String sysErrMsg = "시스템 오류가 발생하였습니다.";
    
	@Autowired
    private CommonSelectService commonSelectService;
	
    @Autowired 
    private WrhMatlConfirmService wrhMatlConfirmService;
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/wrh/wrhMatlConfirm.do")
    public String wrhMatlConfirm(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
			model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001","IG007","E102","IG001"}));
			model.putAll(commonSelectService.selectPlandCodeList("SYSPLT"));
			model.putAll(commonSelectService.selectStorageCodeList("SYSSTR"));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
        return "com/wrh/wrhMatlConfirm";
    }

    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/com/wrh/selectMatlConfirm.do")
    @ResponseBody
    public JsonData selectWhrMatlConfirmList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();

        try {

            List<Map<String,Object>> dataList = wrhMatlConfirmService.selectMatlConfirm(paramMap);
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
            logger.error("중요자재확인 조회 오류", e);
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        return jsonData;
    }
    
    @RequestMapping(value = "/com/wrh/saveMatlConfirm.do")
    @ResponseBody
    public JsonData saveMatlConfirm(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		Map<String,Object> responseMap = wrhMatlConfirmService.saveMatlConfirm(paramMap);
    		
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
