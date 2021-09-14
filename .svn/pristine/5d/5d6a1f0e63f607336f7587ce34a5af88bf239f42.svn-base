/**
 * 메뉴 조회/등록/삭제 컨트롤러
 * @author 길용덕
 * @since 2020.06.17
 * 
 * << 개정이력(Modification Information) >>
 *  ------------------------------------------------- 
 *  수정일                    수정자            수정내용
 *  ----------   -------- ---------------------------
 *  2020.06.17   길용덕            최초생성
 *  -------------------------------------------------
 */
package com.app.ildong.sys.controller;

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
import com.app.ildong.sys.service.SysMenuService;
import com.ecbank.framework.exception.BizException;


@Controller
public class SysMenuController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(SysMenuController.class);
	
    @Autowired 
    private SysMenuService menuService;
    
	@Autowired
    private CommonSelectService commonSelectService;

    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/sys/menuList.do")
	public String menuList(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
    		model.putAll(commonSelectService.selectCodeList(new String[]{"ID001"}));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "com/sys/sysMenuList";
	}

	/**
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/com/sys/selectMenuList.do")
	@ResponseBody
	public JsonData selectMenuList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();

		try {
			List<Map<String, Object>> menuList = menuService.selectMenuList(paramMap);
			jsonData.setRows(menuList);
			
		} catch (Exception e) {
			logger.error("com/sys/selectMenuList.do 오류 발생", e);
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
	@RequestMapping(value = "/com/sys/selectMenuMngList.do")
	@ResponseBody
	public JsonData selectMenuMngList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	
    	try {
    		logger.debug("==================================  selectMenuMngList  start ===========================================");

    		paramMap.put("startRow"	, getStartRow(paramMap));
    		paramMap.put("pageSize"	, getPageSize(paramMap));  //또는 paramMap.put("pageSize, paramMap.get("row"));
		    
		    List<Map<String, Object>> dataList = menuService.selectMenuList(paramMap);
            jsonData.setRows(dataList);

        } catch (Exception e) {
            logger.error("com/sys/selectMenuMngList.do 오류 발생", e);
            jsonData.setErrMsg(e.getMessage());
        }

		if( logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
    	return jsonData;
	}
	
	@RequestMapping(value = "/com/sys/selectMenuDetailList.do")
	@ResponseBody
	public JsonData selectMenuDetailList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();

		try {
			List<Map<String, Object>> detailList = menuService.selectMenuDetailList(paramMap);
			
			jsonData.setStatus("SUCC");
			jsonData.addFields("detailList", detailList);
			
		} catch (Exception e) {
		    logger.error("com/sys/selectMenuDetailList.do 오류 발생", e);
			jsonData.setErrMsg(e.getMessage());
		}

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
		return jsonData;
	}
	
	@RequestMapping(value = "/com/sys/updateMenu.do")
	@ResponseBody
	public JsonData updateMenu(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();

		try {
			Map<String, Object> responseMap = menuService.updateMenu(paramMap);
			
			jsonData.setStatus("SUCC");
			jsonData.addFields("result", responseMap);
			
		} catch (Exception e) {
		    logger.error("com/sys/updateMenu.do 오류 발생", e);
			jsonData.setErrMsg(e.getMessage());
		}

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
		return jsonData;
	}
	
	@RequestMapping(value = "/com/sys/deleteMenu.do")
	@ResponseBody
	public JsonData deleteMenu(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();

		try {
			Map<String, Object> responseMap = menuService.deleteMenu(paramMap);
			
			jsonData.setStatus("SUCC");
			jsonData.addFields("result", responseMap);
			
		} catch (BizException be) {
		    logger.error("com/sys/deleteMenu.do 오류 발생", be);
			jsonData.setErrMsg(messageSourceAccessor.getMessage(be.getExceptionCode()));
		} catch (Exception e) {
		    logger.error("com/sys/deleteMenu.do 오류 발생", e);
			jsonData.setErrMsg(messageSourceAccessor.getMessage("sys.exception.occur"));
		}

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
		return jsonData;
	}
}
