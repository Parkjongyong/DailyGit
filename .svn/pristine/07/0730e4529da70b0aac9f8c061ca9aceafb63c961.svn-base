
package com.app.ildong.bdg.controller;

import java.util.ArrayList;
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
import com.app.ildong.bdg.service.BdgResultService;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.jdbc.BadSqlGrammarException;
import org.springframework.dao.DataIntegrityViolationException;

@Controller
public class BdgResultController extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(BdgResultController.class);
    
    private static final String sysErrMsg = "시스템 오류가 발생하였습니다.";
    
	@Autowired
    private CommonSelectService commonSelectService;
	
    @Autowired 
    private BdgResultService bdgResultService;
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/bdg/bdgResult.do")
    public String bdgResult(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
			model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001","YS034","YS009"}));
			model.putAll(commonSelectService.selectCompList());
			model.putAll(commonSelectService.selectCostList());
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
        return "com/bdg/bdgResult";
    }

    @RequestMapping("/com/bdg/bdgResultM.do")
    public String bdgResultM(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
    		model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001","YS034","YS009"}));
    		model.putAll(commonSelectService.selectCompList());
    		model.putAll(commonSelectService.selectCostList());
    	} catch (ServiceException e) {
    		e.printStackTrace();
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return "com/bdg/bdgResultM";
    }
    
    @RequestMapping("/com/bdg/bdgResultPop.do")
    public String bdgResultPop(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
   		model.addAttribute("PARAM", paramMap);
    	return "com/bdg/bdgResultPop";
    }
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/com/bdg/selectResult.do")
    @ResponseBody
    public JsonData selectWhrBdgResultList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();

        try {
        	
        	List<Map<String, Object>> dataList = new ArrayList<Map<String, Object>>();
        	
        	if("1".equals(paramMap.get("SB_BGD_GUBN"))) {
        		dataList = bdgResultService.selectBasicResult(paramMap);	
        	} else if("2".equals(paramMap.get("SB_BGD_GUBN"))) {
        		dataList = bdgResultService.selectModifyResult(paramMap);	
        	} else if("3".equals(paramMap.get("SB_BGD_GUBN"))) {
        		dataList = bdgResultService.selectExecResult(paramMap);	
        	} else {
        		dataList = bdgResultService.selectSuppleResult(paramMap);	
        	}
        	
            jsonData.setStatus("SUCC");
            jsonData.setRows(dataList);
            
        } catch (Exception e) {
            logger.error("예산실적 조회 오류", e);
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
    @RequestMapping(value = "/com/bdg/selectResultPop.do")
    @ResponseBody
    public JsonData selectResultPop(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	
    	try {
    		
    		List<Map<String, Object>> dataList = bdgResultService.selectResultPop(paramMap);	
    		jsonData.setStatus("SUCC");
    		jsonData.setRows(dataList);
    		
    	} catch (Exception e) {
    		logger.error("예산실적 조회 오류", e);
    	}
    	
    	if( logger.isDebugEnabled()) {
    		logger.debug("jsonData = " + jsonData);
    	}
    	return jsonData;
    }
    
}
