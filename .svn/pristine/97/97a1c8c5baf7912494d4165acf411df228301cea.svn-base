
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
import com.app.ildong.wrh.service.WrhStockStatusService;

@Controller
public class WrhStockStatusController extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(WrhStockStatusController.class);
    
    private static final String sysErrMsg = "시스템 오류가 발생하였습니다.";
    
	@Autowired
    private CommonSelectService commonSelectService;
	
    @Autowired 
    private WrhStockStatusService wrhStockStatusService;
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/wrh/wrhStockStatus.do")
    public String wrhStockStatus(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
			model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001","IG001"}));
			model.putAll(commonSelectService.selectPlandCodeList("SYSPLT"));
			model.putAll(commonSelectService.selectStorageCodeList("SYSSTR"));			
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
        return "com/wrh/wrhStockStatus";
    }
    
    @RequestMapping("/com/wrh/wrhStockStatusV.do")
    public String wrhStockStatusV(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
			model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001","IG001"}));
			model.putAll(commonSelectService.selectPlandCodeList("SYSPLT"));
			model.putAll(commonSelectService.selectStorageCodeList("SYSSTR"));			
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
        return "com/wrh/wrhStockStatusV";
    }    
    
    @RequestMapping("/com/wrh/wrhStockStatusDetail.do")
    public String wrhOrderStatusDetail(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	model.addAttribute("PARAM", paramMap);
        return "com/wrh/wrhStockStatusDetail";
    }
    
    @RequestMapping("/com/wrh/wrhStockStatusDetailV.do")
    public String wrhOrderStatusDetailV(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	model.addAttribute("PARAM", paramMap);
        return "com/wrh/wrhStockStatusDetailV";
    }    

    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/com/wrh/selectWrhStockStatusList.do")
    @ResponseBody
    public JsonData selectWrhStockStatusList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();

        try {

            List<Map<String,Object>> dataList = wrhStockStatusService.selectStockStatusList(paramMap);
            if (null!=dataList && 0 <dataList.size()) {
                Integer totalCnt = Integer.valueOf( ((Map<String,Object>)dataList.get(0)).get("TOT_CNT").toString() );
                Map<String,Object> totMap = wrhStockStatusService.selectTotalGrAmt(paramMap);
                paramMap.put("APPEND_PAGE","APPEND_PAGE");
                jsonData.addFields("result", totMap);
                jsonData.setPageRows(paramMap, dataList, totalCnt);
            } else {
                jsonData.setPageRows(paramMap, null, 0);
            }
            jsonData.setStatus("SUCC");
            
        } catch (Exception e) {
        	jsonData.setStatus("FAIL");
            logger.error("입고정보 조회 오류", e);
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        return jsonData;
    }
    
   
    
}
