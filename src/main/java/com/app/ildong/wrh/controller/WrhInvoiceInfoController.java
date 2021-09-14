
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
import com.app.ildong.common.service.CommonSelectService;
import com.app.ildong.wrh.service.WrhInvoiceInfoService;

@Controller
public class WrhInvoiceInfoController extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(WrhInvoiceInfoController.class);
    
    private static final String sysErrMsg = "시스템 오류가 발생하였습니다.";
    
	@Autowired
    private CommonSelectService commonSelectService;
	
    @Autowired 
    private WrhInvoiceInfoService wrhInvoiceInfoService;
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/wrh/wrhInvoiceInfo.do")
    public String wrhInvoiceInfo(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	model.addAttribute("PARAM", paramMap);
        return "com/wrh/wrhInvoiceInfo";
    }

    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/wrh/wrhInvoiceInfoV.do")
    public String wrhInvoiceInfoV(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	model.addAttribute("PARAM", paramMap);
    	return "com/wrh/wrhInvoiceInfoV";
    }
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/wrh/wrhInvoicePdf.do")
    public String wrhInvoicePdf(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	model.addAttribute("PARAM", paramMap);
    	return "com/wrh/wrhInvoicePdf";
    }    
    
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/com/wrh/selectInvoiceInfo.do")
    @ResponseBody
    public JsonData selectWrhInvoiceInfo(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();

        try {

            List<Map<String,Object>> dataList = wrhInvoiceInfoService.selectInvoiceInfo(paramMap);
            jsonData.setStatus("SUCC");
            jsonData.setRows(dataList);

        } catch (Exception e) {
            logger.error("송장마감정보 조회 오류", e);
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
    @RequestMapping("/com/wrh/wrhInvoiceInfoDetail.do")
    public String wrhInvoiceInfoDetail(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	model.addAttribute("PARAM", paramMap);
    	return "com/wrh/wrhInvoiceInfoDetail";
    }
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/com/wrh/selectInvoiceInfoDetail.do")
    @ResponseBody
    public JsonData selectInvoiceInfoDetail(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();

        try {

            List<Map<String,Object>> dataList = wrhInvoiceInfoService.selectInvoiceInfoDetail(paramMap);
            jsonData.setStatus("SUCC");
            jsonData.setRows(dataList);

        } catch (Exception e) {
            logger.error("송장마감정보 조회 오류", e);
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        return jsonData;
    }
        

}
