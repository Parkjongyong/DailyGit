
package com.app.ildong.cmn.controller;

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

import com.app.ildong.cmn.service.CmnCustomerService;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.JsonData;
import com.app.ildong.common.model.mvc.BaseController;
import com.app.ildong.common.service.CommonSelectService;

@Controller
public class CmnCustomerController extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(CmnCustomerController.class);
    
    private static final String sysErrMsg = "시스템 오류가 발생하였습니다.";
    
    @Autowired 
    private CmnCustomerService cmnCustomerService;
    
	@Autowired
    private CommonSelectService commonSelectService;    
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/cmn/customerList.do")
    public String customerList(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	
    	try {
    		model.addAttribute("PARAM", paramMap);
			model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001"}));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
        return "com/cmn/cmnCustomerSearchPop";
    }
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/com/cmn/selectCustomerList.do")
    @ResponseBody
    public JsonData selectCustomerList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();

        try {

            List<Map<String,Object>> dataList = cmnCustomerService.selectCustomerList(paramMap);
            if (null!=dataList && 0<dataList.size()) {
                Integer totalCnt = Integer.valueOf( ((Map<String,Object>)dataList.get(0)).get("TOT_CNT").toString() );
                
                paramMap.put("APPEND_PAGE","APPEND_PAGE");
                jsonData.setPageRows(paramMap, dataList, totalCnt);
            } else {
                jsonData.setPageRows(paramMap, null, 0);
            }
            
        } catch (Exception e) {
            logger.error("거래처 정보 조회 오류", e);
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        return jsonData;
    }
    
}
