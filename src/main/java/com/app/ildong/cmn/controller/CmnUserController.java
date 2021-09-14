
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

import com.app.ildong.cmn.service.CmnUserService;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.JsonData;
import com.app.ildong.common.model.mvc.BaseController;
import com.app.ildong.common.service.CommonSelectService;

@Controller
public class CmnUserController extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(CmnUserController.class);
    
    private static final String sysErrMsg = "시스템 오류가 발생하였습니다.";
    
    @Autowired 
    private CmnUserService userService;
    
	@Autowired
    private CommonSelectService commonSelectService;    
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/cmn/userList.do")
    public String userList(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, Model model) {
    	model.addAttribute("PARAM", paramMap);
        return "com/cmn/cmnUserSearchPop";
    }
    
    @RequestMapping("/com/cmn/userList2.do")
    public String userList2(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	
    	try {
			model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001"}));
			model.addAttribute("PARAM", paramMap);
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
    	
        return "com/cmn/cmnUserSearchPop2";
    }    

    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/com/cmn/selectUserList.do")
    @ResponseBody
    public JsonData selectUserList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();

        try {

            List<Map<String,Object>> dataList = userService.selectUserList(paramMap);
            jsonData.setStatus("SUCC");
            jsonData.setRows(dataList);
            
        } catch (Exception e) {
            logger.error("사용자 관리 조회 오류", e);
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        return jsonData;
    }
    
}
