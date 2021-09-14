
package com.app.ildong.wrh.controller;

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

import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.JsonData;
import com.app.ildong.common.model.mvc.BaseController;
import com.app.ildong.wrh.service.WrhDeliveryHistoryService;

@Controller
public class WrhDeliveryHistoryController extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(WrhDeliveryHistoryController.class);
    
    private static final String sysErrMsg = "시스템 오류가 발생하였습니다.";
    
    @Autowired 
    private WrhDeliveryHistoryService wrhDeliveryHistoryService;
    

    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/wrh/wrhDeliveryHistory.do")
    public String wrhMatlConfirm(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	model.addAttribute("PARAM", paramMap);
        return "com/wrh/wrhDeliveryHistorySearch";
    }
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/com/wrh/selectDeliveryHistoryList.do")
    @ResponseBody
    public JsonData selectDeliveryHistoryList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();

        try {
            List<Map<String,Object>> dataList = wrhDeliveryHistoryService.selectDeliveryHistoryList(paramMap);
            jsonData.setStatus("SUCC");
            jsonData.setRows(dataList);
            
        } catch (Exception e) {
            logger.error("입고예정일 승인현황 조회 오류", e);
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        return jsonData;
    }
}
