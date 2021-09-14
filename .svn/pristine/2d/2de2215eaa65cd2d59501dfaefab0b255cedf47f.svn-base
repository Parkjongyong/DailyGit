
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

import com.app.ildong.cmn.service.CmnPlantStorageService;
import com.app.ildong.common.model.JsonData;
import com.app.ildong.common.model.mvc.BaseController;

@Controller
public class CmnPlantStorageController extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(CmnPlantStorageController.class);
    
    private static final String sysErrMsg = "시스템 오류가 발생하였습니다.";
    
    @Autowired 
    private CmnPlantStorageService cmnPlantStorageService;
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/cmn/plantStorageList.do")
    public String userList(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, Model model) {
    	model.addAttribute("PARAM", paramMap);
        return "com/cmn/cmnPlantStorageSearchPop";
    }

    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/com/cmn/selectPlantStorageList.do")
    @ResponseBody
    public JsonData selectPlantStorageList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();

        try {

            List<Map<String,Object>> dataList = cmnPlantStorageService.selectPlantStorageList(paramMap);
            jsonData.setStatus("SUCC");
            jsonData.setRows(dataList);
            
        } catch (Exception e) {
            logger.error("창고 조회 오류", e);
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        return jsonData;
    }
    
}
