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

import com.app.ildong.cmn.service.CmnMenuService;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.JsonData;
import com.app.ildong.common.model.mvc.BaseController;
import com.app.ildong.common.service.CommonSelectService;
import com.ecbank.framework.exception.BizException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.jdbc.BadSqlGrammarException;
import org.springframework.dao.DataIntegrityViolationException;


@Controller
public class CmnMenuController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(CmnMenuController.class);
	
    @Autowired 
    private CmnMenuService menuService;
    
	@Autowired
    private CommonSelectService commonSelectService;

    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/cmn/menuList.do")
	public String menuList(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
    		model.putAll(commonSelectService.selectCodeList(new String[]{"ID001"}));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "com/cmn/cmnMenuList";
	}

	/**
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/com/cmn/selectMenuList.do")
	@ResponseBody
	public JsonData selectMenuList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();

		try {
			List<Map<String, Object>> menuList = menuService.selectMenuList(paramMap);
			jsonData.setRows(menuList);
			
		} catch (Exception e) {
			logger.error("com/cmn/selectMenuList.do ?????? ??????", e);
			jsonData.setErrMsg(e.getMessage());
		}

		if (logger.isDebugEnabled()) {
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
	@RequestMapping(value = "/com/cmn/selectMenuMngList.do")
	@ResponseBody
	public JsonData selectMenuMngList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	
    	try {
    		logger.debug("==================================  selectMenuMngList  start ===========================================");

    		paramMap.put("startRow"	, getStartRow(paramMap));
    		paramMap.put("pageSize"	, getPageSize(paramMap));  //?????? paramMap.put("pageSize, paramMap.get("row"));
		    
		    List<Map<String, Object>> dataList = menuService.selectMenuList(paramMap);
		    
            if (null!=dataList && 0<dataList.size()) {
                Integer totalCnt = Integer.valueOf( ((Map<String,Object>)dataList.get(0)).get("TOT_CNT").toString() ); 
                //APPEND ??????????????? ??????
                jsonData.setPageRows(paramMap, dataList, totalCnt);
            } else {
                jsonData.setPageRows(paramMap, null, 0);
            }
            
        } catch (Exception e) {
            logger.error("com/cmn/selectMenuMngList.do ?????? ??????", e);
            jsonData.setErrMsg(e.getMessage());
        }

		if( logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
    	return jsonData;
	}
	
	@RequestMapping(value = "/com/cmn/selectMenuDetailList.do")
	@ResponseBody
	public JsonData selectMenuDetailList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();

		try {
			List<Map<String, Object>> detailList = menuService.selectMenuDetailList(paramMap);
			
			jsonData.setStatus("SUCC");
			jsonData.addFields("detailList", detailList);
			
		} catch (Exception e) {
		    logger.error("com/cmn/selectMenuDetailList.do ?????? ??????", e);
			jsonData.setErrMsg(e.getMessage());
		}

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
		return jsonData;
	}
	
	@RequestMapping(value = "/com/cmn/updateMenu.do")
	@ResponseBody
	public JsonData updateMenu(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();

		try {
			Map<String, Object> responseMap = menuService.updateMenu(paramMap);
			
			jsonData.setStatus("SUCC");
			jsonData.addFields("result", responseMap);
			
		} catch (Exception e) {
		    logger.error("com/cmn/updateMenu.do ?????? ??????", e);
        	if (e instanceof DuplicateKeyException) {
        		jsonData.setErrMsg("????????? ???????????? ???????????????. ?????? ??? ???????????????.");
        	} else if (e instanceof BadSqlGrammarException) {
        		jsonData.setErrMsg("DB ????????? ??????????????????. ??????????????? ?????? ????????? ????????????.");
        	} else if (e instanceof DataIntegrityViolationException) {
        		jsonData.setErrMsg("DB ????????? ??????????????????. ??????????????? ?????? ????????? ????????????.");
        	} else {
        		jsonData.setErrMsg(e.getMessage());
        	}
		}

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
		return jsonData;
	}
	
	@RequestMapping(value = "/com/cmn/deleteMenu.do")
	@ResponseBody
	public JsonData deleteMenu(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();

		try {
			Map<String, Object> responseMap = menuService.deleteMenu(paramMap);
			
			jsonData.setStatus("SUCC");
			jsonData.addFields("result", responseMap);
			
		} catch (BizException be) {
		    logger.error("com/cmn/deleteMenu.do ?????? ??????", be);
		    jsonData.setErrMsg(be.getExceptionCode());
		} catch (Exception e) {
		    logger.error("com/cmn/deleteMenu.do ?????? ??????", e);
        	if (e instanceof DuplicateKeyException) {
        		jsonData.setErrMsg("????????? ???????????? ???????????????. ?????? ??? ???????????????.");
        	} else if (e instanceof BadSqlGrammarException) {
        		jsonData.setErrMsg("DB ????????? ??????????????????. ??????????????? ?????? ????????? ????????????.");
        	} else if (e instanceof DataIntegrityViolationException) {
        		jsonData.setErrMsg("DB ????????? ??????????????????. ??????????????? ?????? ????????? ????????????.");
        	} else {
        		jsonData.setErrMsg(e.getMessage());
        	}

		}

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
		return jsonData;
	}
}
