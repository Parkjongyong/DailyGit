package com.app.ildong.inf.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.app.ildong.common.crypt.DigestUtil;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.JsonData;
import com.app.ildong.common.model.mvc.BaseController;
import com.app.ildong.common.service.CommonSelectService;
import com.app.ildong.common.service.MessageSendService;
import com.app.ildong.inf.service.InfJoinMgmtService;

@Controller
public class InfJoinMgmtController extends BaseController {
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private InfJoinMgmtService InfJoinMgmtService;
    
    /**
     * init
     * "/" Path에 대해서 ID/PW 찾기 화면으로 이동
     * @param userAgent
     * @param device
     * @param model
     * @return String
     * @throws Exception 
     */ 
    @RequestMapping("/findPwInfo.do")
    public String InfFindUserInfo(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model)  throws Exception  {
		model.addAttribute("PARAM_NAME","ID/비밀번호 찾기");
    	model.addAttribute("PARAM", paramMap);

    	return "findPwInfo";
    }
    
   	/**
     * 패스워드찾기
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/findUserPw.do")
	@ResponseBody
	public JsonData findUserPw(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
		try {
			//회원 PW 찾기
			Map<String,Object> findPwMap = InfJoinMgmtService.selectFindUserPw(paramMap);
			jsonData.setStatus("SUCC");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.setErrMsg(e.getMessage());
		}

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
		return jsonData;
	}
}
