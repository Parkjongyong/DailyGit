package com.app.ildong.usr.controller;

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

import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.JsonData;
import com.app.ildong.common.model.mvc.BaseController;
import com.app.ildong.usr.service.UsrUserSearchService;


@Controller
public class UsrUserSearchController extends BaseController {
	protected final Log logger = LogFactory.getLog(getClass());

	@Autowired
	private UsrUserSearchService usrUserSearchService;
	
	@RequestMapping("/com/usr/usrUserSearch.do")
	public String mgtBoardTemp(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, Model model) {
		
		return "com/usr/usrUserSearch";
	}
	
	@RequestMapping("/com/usr/selectUsrUserSearchInList.do")
	@ResponseBody
	public JsonData selectUsrUserSearchInList(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();
		
		try {
    		logger.debug("=============================================================================");
    		
    		
		    List<Map<String,Object>> dataList = usrUserSearchService.selectUsrUserSearchInList(paramMap);

		    if (null!=dataList && 0<dataList.size()) {
		    	jsonData.setPageRows(paramMap, dataList, 0);
            } else {
            	jsonData.setPageRows(paramMap, null, 0);
            }

        } catch (Exception e) {
            e.printStackTrace();
            jsonData.setErrMsg(e.getMessage());
        }

		
		
		if( logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
		
		
		return jsonData;
	}
	
	@RequestMapping("/com/usr/selectUsrUserSearchOutList.do")
	@ResponseBody
	public JsonData selectUsrUserSearchOutList(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();
		
		try {
    		logger.debug("=============================================================================");
    		
    		
		    List<Map<String,Object>> dataList = usrUserSearchService.selectUsrUserSearchOutList(paramMap);

		    if (null!=dataList && 0<dataList.size()) {
		    	jsonData.setPageRows(paramMap, dataList, 0);
            } else {
            	jsonData.setPageRows(paramMap, null, 0);
            }

        } catch (Exception e) {
            e.printStackTrace();
            jsonData.setErrMsg(e.getMessage());
        }

		
		
		if( logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
		
		
		return jsonData;
	}
	
	
	
	
	//외부 유저 비밀번호 초기화(아이디와 동일) 하기
    @RequestMapping("/com/usr/updateAllUserPwd.do")
    @ResponseBody
    public JsonData updateAllUserPwd(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		
    		usrUserSearchService.updateAllUserPwd(paramMap);
    		
    		jsonData.setStatus("SUCC");
    		
    	}catch (Exception e) {
    		e.printStackTrace();
    		jsonData.setErrMsg(e.getMessage());
    	}
    	
    	
    	if( logger.isDebugEnabled()) {
    		logger.debug("jsonData = " + jsonData);
    	}
    	
    	return jsonData;
    }
	
    
    //내부 유저 비밀번호 초기화(아이디와 동일) 하기
    @RequestMapping("/com/usr/updateInAllUserPwd.do")
    @ResponseBody
    public JsonData updateInAllUserPwd(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		
    		usrUserSearchService.updateInAllUserPwd(paramMap);
    		
    		jsonData.setStatus("SUCC");
    		
    	}catch (Exception e) {
    		e.printStackTrace();
    		jsonData.setErrMsg(e.getMessage());
    	}
    	
    	
    	if( logger.isDebugEnabled()) {
    		logger.debug("jsonData = " + jsonData);
    	}
    	
    	return jsonData;
    }
    
	
}
