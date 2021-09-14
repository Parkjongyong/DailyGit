
package com.app.ildong.cmn.controller;

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

import com.app.ildong.cmn.service.CmnItemMgmtService;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.JsonData;
import com.app.ildong.common.model.mvc.BaseController;
import com.app.ildong.common.service.CommonSelectService;

@Controller
public class CmnItemMgmtController extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(CmnItemMgmtController.class);
    
    private static final String sysErrMsg = "시스템 오류가 발생하였습니다.";
    
	@Autowired
    private CommonSelectService commonSelectService;
    
    @Autowired 
    private CmnItemMgmtService cmnItemMgmtService;
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/cmn/cmnItemMgmtSearchPop.do")
    public String itemMgmtList(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
			model.putAll(commonSelectService.selectCodeList(new String[]{"YS005"}));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

        return "com/cmn/cmnItemMgmtSearchPop";
    }

    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/com/cmn/selectItemMgmtList.do")
    @ResponseBody
    public JsonData selectItemMgmtList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();

        try {

        	List<Map<String,Object>> dataList = cmnItemMgmtService.selectItemMgmtList(paramMap);
    		
            jsonData.setStatus("SUCC");
            jsonData.setRows(dataList);
    		
        } catch (Exception e) {
            logger.error("품목코드정보 관리 조회 오류", e);
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
    @RequestMapping(value = "/com/cmn/selectPlantItemList.do")
    @ResponseBody
    public JsonData selectPlantItemList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	
    	try {
    		List<Map<String,Object>> dataList = cmnItemMgmtService.selectPlantItemList(paramMap);
    		
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
    		logger.error("품목코드정보 관리 조회 오류", e);
    	}
    	
    	if( logger.isDebugEnabled()) {
    		logger.debug("jsonData = " + jsonData);
    	}
    	return jsonData;
    }
    
}
