/**
 * 시스템관리 > 패스워드 변경 컨트롤러
 * @author 박종용
 * @since 2020.06.22
 *
 * << 개정이력(Modification Information) >>
 *  -------------------------------------------------
 *  수정일                    수정자            수정내용
 *  ----------   -------- ---------------------------
 *  2020.06.22   박종용            최초생성
 *  -------------------------------------------------
 */
package com.app.ildong.sys.controller;

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

import com.app.ildong.common.crypt.DigestUtil;
import com.app.ildong.common.model.JsonData;
import com.app.ildong.common.model.mvc.BaseController;
import com.app.ildong.common.service.CommonSelectService;
import com.app.ildong.sys.service.JCoProcessService;
import com.app.ildong.sys.service.SysPwChangeService;

@Controller
public class SysPwChangeController extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(SysPwChangeController.class);
    
    @Autowired
    private CommonSelectService commonSelectService;
    
    @Autowired
    private JCoProcessService jCoProcessService;
    
    @Autowired
    private SysPwChangeService SysPwChangeService;
    
	@Autowired
    private static DigestUtil digestUtil;

    /**
     * 패스워드 변경 화면
     */
    @RequestMapping("/com/sys/sysPwChange.do")
    public String sysCodeMgmtList(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
        model.addAttribute("paramMap", paramMap);
        return "com/sys/sysPwChangePopup";
    }
    
    
	/**
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
    @RequestMapping("/com/sys/savePw.do")
	@ResponseBody
	public JsonData savePw(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();

		try {
			String beforePw            = (String) paramMap.get("BEFORE_PW");
			beforePw                   = digestUtil.digest(beforePw, (String) paramMap.get("USER_ID"));
			Map<String, Object> chkMap = SysPwChangeService.checkPw(paramMap);
			String chkPw               = (String) chkMap.get("PWD");
			
			logger.debug("beforePw : "+beforePw);
			logger.debug("chkPw :" + chkPw);
			
			if(!beforePw.equals(chkPw) == true) {
				jsonData.setErrMsg("현재 비밀번호가 일치하지 않습니다.");
	            return jsonData;
			}
			
			String encryptedPwd = digestUtil.digest((String) paramMap.get("AFTER_PW"), (String) paramMap.get("USER_ID"));
			paramMap.put("AFTER_PW", encryptedPwd);
			
			Map<String, Object> responseMap = SysPwChangeService.updatePw(paramMap);
			
			jsonData.setStatus("SUCC");
            jsonData.addFields("RESULT", "S");
			
		} catch (Exception e) {
		    logger.error("com/sys/savePw.do 중 오류 발생", e);
			jsonData.setErrMsg(e.getMessage());
		}

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
		return jsonData;
	}

}
