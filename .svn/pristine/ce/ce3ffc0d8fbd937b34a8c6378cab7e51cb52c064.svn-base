
package com.app.ildong.wrh.controller;

import java.util.HashMap;
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
import com.app.ildong.wrh.service.WrhStockDueDateRegistService;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.jdbc.BadSqlGrammarException;
import org.springframework.dao.DataIntegrityViolationException;

@Controller
public class WrhStockDueDateRegistController extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(WrhStockDueDateRegistController.class);
    
    private static final String sysErrMsg = "시스템 오류가 발생하였습니다.";
    
	@Autowired
    private CommonSelectService commonSelectService;
	
    @Autowired 
    private WrhStockDueDateRegistService wrhStockDueDateRegistService;
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/wrh/wrhStockDueDateRegistV.do")
    public String wrhStockDueDateRegistV(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
			model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001", "IG002"}));
			model.putAll(commonSelectService.selectPlandCodeList("SYSPLT"));
			model.putAll(commonSelectService.selectStorageCodeList("SYSSTR"));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
        return "com/wrh/wrhStockDueDateRegistV";
    }
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/wrh/wrhStockDueDateRegistDetailV.do")
    public String wrhStockDueDateRegistDetailV(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        model.addAttribute("PARAM", paramMap);
        return "com/wrh/wrhStockDueDateRegistDetailV";
    }
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/wrh/wrhDelyDateSearch.do")
    public String delyDateSearch(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        model.addAttribute("PARAM", paramMap);
        return "com/wrh/wrhDelyDateSearch";
    }     

    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/com/wrh/selectWhrStockDueDateRegistList.do")
    @ResponseBody
    public JsonData selectWhrStockDueDateRegistList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();

        try {

            List<Map<String,Object>> dataList = wrhStockDueDateRegistService.selectWhrStockDueDateRegistList(paramMap);
            jsonData.setStatus("SUCC");
            jsonData.setRows(dataList);
            
        } catch (Exception e) {
            logger.error("입고예정등록일 조회 오류", e);
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        return jsonData;
    }
    
    @RequestMapping(value = "/com/wrh/selectPltQtyList.do")
    @ResponseBody
    public JsonData selectPltQtyList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData  = new JsonData();

        try {

            List<Map<String,Object>> dataList  = wrhStockDueDateRegistService.selectPltQty(paramMap);
            jsonData.setStatus("SUCC");
            jsonData.addFields("pltQtyInfo", dataList);
            
        } catch (Exception e) {
            logger.error("자재마스터 PLT수량 조회 오류", e);
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
    @RequestMapping(value = "/com/wrh/selectWhrStockDueDateRegistDetailList.do")
    @ResponseBody
    public JsonData selectWhrStockDueDateRegistDetailList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();

        try {

            List<Map<String,Object>> dataList = wrhStockDueDateRegistService.selectWhrStockDueDateRegistDetailList(paramMap);
            Map<String,Object> headerInfo = wrhStockDueDateRegistService.selectWhrStockDueDateRegistheaderInfo(paramMap);
            jsonData.setStatus("SUCC");
            jsonData.setRows(dataList);
            jsonData.addFields("headerInfo", headerInfo);
            
        } catch (Exception e) {
            logger.error("입고예정등록일 조회 오류", e);
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        return jsonData;
    }
    
    @RequestMapping(value = "/com/wrh/saveDueDateRegist.do")
    @ResponseBody
    public JsonData saveDueDateRegist(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws ServiceException, Exception {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		Map<String,Object> responseMap = wrhStockDueDateRegistService.saveDueDateRegist(paramMap);
    		
    		if ("N".equals(responseMap.get("SUCC_YN"))) {
    			jsonData.setStatus("FAIL");
    			jsonData.addFields("result", responseMap);
    			jsonData.setErrMsg(responseMap.get("ERR_MSG").toString());
    		} else {
        		jsonData.setStatus("SUCC");
        		jsonData.addFields("result", responseMap);
    		}
    		
    	} catch (ServiceException se) {
    		se.printStackTrace();
    		jsonData.setStatus("FAIL");
    		jsonData.setErrMsg(se.getMessage());
    	} catch (Exception e) {
        	e.printStackTrace();
        	jsonData.setStatus("FAIL");
        	if (e instanceof DuplicateKeyException) {
        		jsonData.setErrMsg("중복된 데이터가 존재합니다. 확인 후 작업하세요.");
        	} else if (e instanceof BadSqlGrammarException) {
        		jsonData.setErrMsg("DB 오류가 발생했습니다. 관리자에게 문의 하시길 바랍니다.");
        	} else if (e instanceof DataIntegrityViolationException) {
        		jsonData.setErrMsg("DB 오류가 발생했습니다. 관리자에게 문의 하시길 바랍니다.");
        	} else {
        		jsonData.setErrMsg(e.getMessage());
        	}
        }
    	

		if( logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
    	
    	return jsonData;
    } 
    
    @RequestMapping(value = "/com/wrh/requestDueDateRegist.do")
    @ResponseBody
    public JsonData requestDueDateRegist(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		// 저장로직 수행
    		Map<String,Object> responseParamMap = wrhStockDueDateRegistService.saveDueDateRegist(paramMap);
    		
    		if ("N".equals(responseParamMap.get("SUCC_YN"))) {
    			jsonData.setStatus("FAIL");
    			jsonData.addFields("result", responseParamMap);
    			jsonData.setErrMsg(responseParamMap.get("ERR_MSG").toString());
    		} else {
        		// 승인 요청 로직 수행
        		Map<String,Object> responseRequestMap = wrhStockDueDateRegistService.requestDueDateRegist(responseParamMap);
        		
        		jsonData.setStatus("SUCC");
        		jsonData.addFields("result", responseRequestMap);
    		}
    	
    	} catch (ServiceException se) {
    		se.printStackTrace();
    		jsonData.setStatus("FAIL");
    		jsonData.setErrMsg(se.getMessage());
    	} catch (Exception e) {
        	e.printStackTrace();
        	jsonData.setStatus("FAIL");
        	if (e instanceof DuplicateKeyException) {
        		jsonData.setErrMsg("중복된 데이터가 존재합니다. 확인 후 작업하세요.");
        	} else if (e instanceof BadSqlGrammarException) {
        		jsonData.setErrMsg("DB 오류가 발생했습니다. 관리자에게 문의 하시길 바랍니다.");
        	} else if (e instanceof DataIntegrityViolationException) {
        		jsonData.setErrMsg("DB 오류가 발생했습니다. 관리자에게 문의 하시길 바랍니다.");
        	} else {
        		jsonData.setErrMsg(e.getMessage());
        	}
        }
    	

		if( logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
    	
    	return jsonData;
    }
    
    @RequestMapping(value = "/com/wrh/cancelDueDateRegist.do")
    @ResponseBody
    public JsonData cancelDueDateRegist(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		// 승인 요청 취소 로직 수행
    		Map<String,Object> statusMap  = wrhStockDueDateRegistService.selectStatusDueDateRegist(paramMap);
    		if (!"2".equals(statusMap.get("DOC_STATUS"))) {
    			jsonData.setStatus("FAIL");
    			jsonData.addFields("result", paramMap);
    		} else {
        		// 승인 요청 취소 로직 수행
        		Map<String,Object> responseMap = wrhStockDueDateRegistService.cancelDueDateRegist(paramMap);
        		
        		jsonData.setStatus("SUCC");
        		jsonData.addFields("result", responseMap);
    		}
    	
    	} catch (ServiceException se) {
    		se.printStackTrace();
    		jsonData.setStatus("FAIL");
    		jsonData.setErrMsg(se.getMessage());
    	} catch (Exception e) {
        	e.printStackTrace();
        	jsonData.setStatus("FAIL");
    		jsonData.setErrMsg(e.getMessage());
        }
    	

		if( logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
    	
    	return jsonData;
    }    
    
    @RequestMapping(value = "/com/wrh/deleteDueDateRegist.do")
    @ResponseBody
    public JsonData deleteDueDateRegist(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		// 삭제로직 수행
    		Map<String,Object> responseMap = wrhStockDueDateRegistService.deleteDueDateRegist(paramMap);
    		
    		jsonData.setStatus("SUCC");
    		jsonData.addFields("result", responseMap);
    	
    	} catch (ServiceException se) {
    		se.printStackTrace();
    		jsonData.setErrMsg(se.getMessage());
    	} catch (Exception e) {
        	e.printStackTrace();
        	if (e instanceof DuplicateKeyException) {
        		jsonData.setErrMsg("중복된 데이터가 존재합니다. 확인 후 작업하세요.");
        	} else if (e instanceof BadSqlGrammarException) {
        		jsonData.setErrMsg("DB 오류가 발생했습니다. 관리자에게 문의 하시길 바랍니다.");
        	} else if (e instanceof DataIntegrityViolationException) {
        		jsonData.setErrMsg("DB 오류가 발생했습니다. 관리자에게 문의 하시길 바랍니다.");
        	} else {
        		jsonData.setErrMsg(e.getMessage());
        	}
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
    @RequestMapping("/com/wrh/wrhStockDueDate.do")
    public String wrhStockDueDate(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        model.addAttribute("PARAM", paramMap);
        return "com/wrh/wrhStockDueDate";
    }
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/com/wrh/selectWhrStockDueDate.do")
    @ResponseBody
    public JsonData selectWhrStockDueDate(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();

        try {

            List<Map<String,Object>> dataList = wrhStockDueDateRegistService.selectWhrStockDueDateRegistDetailList(paramMap);
            jsonData.setStatus("SUCC");
            jsonData.setRows(dataList);
            
        } catch (Exception e) {
            logger.error("입고예정등록일 조회 오류", e);
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        return jsonData;
    }    
    
}
