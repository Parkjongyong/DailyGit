/**
 * 경영예산계정관리 조회/저장/삭제
 * @author 길용덕
 * @since 2020.08.20
 * 
 * << 개정이력(Modification Information) >>
 *  ------------------------------------------------- 
 *  수정일                    수정자            수정내용
 *  ----------   -------- ---------------------------
 *  2020.08.20   길용덕            최초생성
 *  -------------------------------------------------
 */
package com.app.ildong.bdg.controller;

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

import com.app.ildong.bdg.service.BdgOpBasicMgtService;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.JsonData;
import com.app.ildong.common.model.mvc.BaseController;
import com.app.ildong.common.service.CommonSelectService;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.jdbc.BadSqlGrammarException;
import org.springframework.dao.DataIntegrityViolationException;

@Controller
public class BdgOpBasicMgtController extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(BdgOpBasicMgtController.class);
    
    private static final String sysErrMsg = "시스템 오류가 발생하였습니다.";
    
	@Autowired
    private CommonSelectService commonSelectService;
	
    @Autowired 
    private BdgOpBasicMgtService bdgOpBasicMgtService;
    
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/bdg/bdgOpBasicMgt.do")
    public String bdgBasicMgt(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
			model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001","YS006","YS007","YS008"}));
			model.putAll(commonSelectService.selectOpAccountCodeList("SYSACC"));
			model.putAll(commonSelectService.selectCompList());
			model.putAll(commonSelectService.selectCostList());				
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
        return "com/bdg/bdgOpBasicMgt";
    }
    
    @RequestMapping("/com/bdg/bdgOpBasicMgtM.do")
    public String bdgOpBasicMgtM(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
    		model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001","YS006","YS007","YS008"}));
			model.putAll(commonSelectService.selectOpAccountCodeList("SYSACC"));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
        return "com/bdg/bdgOpBasicMgtM";
    } 
    
    @RequestMapping("/com/bdg/bdgOpBasicMgtExcel.do")
    public String bdgOpBasicMgtExcel(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
    		model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001","YS006","YS007","YS008"}));
    		model.putAll(commonSelectService.selectOpAccountCodeList("SYSACC"));
    		model.putAll(commonSelectService.selectCompList());
    		model.putAll(commonSelectService.selectCostList());
    		model.addAttribute("PARAM", paramMap);
    	} catch (ServiceException e) {
    		e.printStackTrace();
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return "com/bdg/bdgOpBasicMgtExcel";
    } 
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/com/bdg/selectOpBasicMgtList.do")
    @ResponseBody
    public JsonData selectOpBasicMgtList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData  = new JsonData();

        try {

            List<Map<String,Object>> dataList  = bdgOpBasicMgtService.selectOpBasicMgtList(paramMap);
            jsonData.setStatus("SUCC");
            jsonData.setRows(dataList);
            
        } catch (Exception e) {
            logger.error("경영예산등록_기본예산 조회 오류", e);
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        return jsonData;
    }
    
    @RequestMapping(value = "/com/bdg/saveOpBasicMgt.do")
    @ResponseBody
    public JsonData saveOpBasicMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws ServiceException, Exception {
    	JsonData jsonData = new JsonData();
    	try {
    		checkEndData(paramMap);
    		Map<String,Object> responseMap = bdgOpBasicMgtService.saveOpBasicMgt(paramMap);
    		
    		if (!"Y".equals(responseMap.get("SUCC_YN").toString())) {
        		jsonData.setStatus("FAIL");
        		jsonData.setErrMsg(responseMap.get("ERR_MSG").toString());
        		jsonData.addFields("result", responseMap);
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
    
    @RequestMapping(value = "/com/bdg/deleteOpBasicMgt.do")
    @ResponseBody
    public JsonData deleteOpBasicMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		checkEndData(paramMap);
    		// 삭제  로직 수행
    		Map<String,Object> responseMap = bdgOpBasicMgtService.deleteOpBasicMgt(paramMap);
    		
    		if (!"Y".equals(responseMap.get("SUCC_YN").toString())) {
        		jsonData.setStatus("FAIL");
        		jsonData.setErrMsg(responseMap.get("ERR_MSG").toString());
        		jsonData.addFields("result", responseMap);
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
    
    @RequestMapping(value = "/com/bdg/updateOpBasicMgtStatus.do")
    @ResponseBody
    public JsonData updateOpBasicMgtStatus(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		checkEndData(paramMap);
    		// 확정/확정취소  로직 수행
    		Map<String,Object> responseMap = bdgOpBasicMgtService.updateOpBasicMgtStatus(paramMap);
    		
    		if (!"Y".equals(responseMap.get("SUCC_YN").toString())) {
        		jsonData.setStatus("FAIL");
        		jsonData.setErrMsg(responseMap.get("ERR_MSG").toString());
        		jsonData.addFields("result", responseMap);
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
    		jsonData.setErrMsg(e.getMessage());
        }
    	

		if( logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
    	
    	return jsonData;
    }
    
    @RequestMapping(value = "/com/bdg/cancelOpBasicMgt.do")
    @ResponseBody
    public JsonData cancelOpBasicMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		checkEndData(paramMap);
    		// 확정/확정취소  로직 수행
    		Map<String,Object> responseMap = bdgOpBasicMgtService.cancelOpBasicMgt(paramMap);
    		
    		if (!"Y".equals(responseMap.get("SUCC_YN").toString())) {
    			jsonData.setStatus("FAIL");
    			jsonData.setErrMsg(responseMap.get("ERR_MSG").toString());
    			jsonData.addFields("result", responseMap);
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
    		jsonData.setErrMsg(e.getMessage());
    	}
    	
    	
    	if( logger.isDebugEnabled()) {
    		logger.debug("jsonData = " + jsonData);
    	}
    	
    	return jsonData;
    }
    
    @RequestMapping(value = "/com/bdg/sendOpBasicMgt.do")
    @ResponseBody
    public JsonData sendOpBasicMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		checkEndData(paramMap);
    		// 전송  로직 수행
    		Map<String,Object> responseMap = bdgOpBasicMgtService.sendOpBasicMgt(paramMap);
    		
    		if (!"Y".equals(responseMap.get("SUCC_YN").toString())) {
        		jsonData.setStatus("FAIL");
        		jsonData.setErrMsg(responseMap.get("ERR_MSG").toString());
        		jsonData.addFields("result", responseMap);
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
    		jsonData.setErrMsg(e.getMessage());
        }

		if( logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
    	
    	return jsonData;
    }
    
    @RequestMapping(value = "/com/bdg/sendCancelOpBasicMgt.do")
    @ResponseBody
    public JsonData sendCancelOpBasicMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		checkEndData(paramMap);
    		// 전송/전송취소  로직 수행
    		Map<String,Object> responseMap = bdgOpBasicMgtService.sendCancelOpBasicMgt(paramMap);
    		
    		if (!"Y".equals(responseMap.get("SUCC_YN").toString())) {
        		jsonData.setStatus("FAIL");
        		jsonData.setErrMsg(responseMap.get("ERR_MSG").toString());
        		jsonData.addFields("result", responseMap);
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
    		jsonData.setErrMsg(e.getMessage());
        }
    	

		if( logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
    	
    	return jsonData;
    }    

    @RequestMapping(value = "/com/bdg/selectOpBasicMgtCode1.do")
    @ResponseBody
    public JsonData selectOpBasicMgtCode1(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData  = new JsonData();

        try {

            List<Map<String,Object>> dataList  = bdgOpBasicMgtService.selectOpBasicMgtCode1(paramMap);
            jsonData.setStatus("SUCC");
            jsonData.setRows(dataList);
            
        } catch (Exception e) {
            logger.error("경영예산등록_기본예산 조회 오류", e);
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        return jsonData;
    }
    
    @RequestMapping(value = "/com/bdg/selectOpBasicMgtCode2.do")
    @ResponseBody
    public JsonData selectOpBasicMgtCode2(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData  = new JsonData();
    	
    	try {
    		
    		List<Map<String,Object>> dataList  = bdgOpBasicMgtService.selectOpBasicMgtCode2(paramMap);
    		jsonData.setStatus("SUCC");
    		jsonData.setRows(dataList);
    		
    	} catch (Exception e) {
    		logger.error("경영예산등록_기본예산 조회 오류", e);
    	}
    	
    	if( logger.isDebugEnabled()) {
    		logger.debug("jsonData = " + jsonData);
    	}
    	return jsonData;
    }
    
    @RequestMapping(value = "/com/bdg/selectOpBasicMgtCode3.do")
    @ResponseBody
    public JsonData selectOpBasicMgtCode3(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData  = new JsonData();
    	
    	try {
    		
    		List<Map<String,Object>> dataList  = bdgOpBasicMgtService.selectOpBasicMgtCode3(paramMap);
    		jsonData.setStatus("SUCC");
    		jsonData.setRows(dataList);
    		
    	} catch (Exception e) {
    		logger.error("경영예산등록_기본예산 조회 오류", e);
    	}
    	
    	if( logger.isDebugEnabled()) {
    		logger.debug("jsonData = " + jsonData);
    	}
    	return jsonData;
    }
    
    @RequestMapping(value = "/com/bdg/selectOpBasicMgtCode4.do")
    @ResponseBody
    public JsonData selectOpBasicMgtCode4(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData  = new JsonData();
    	
    	try {
    		
    		List<Map<String,Object>> dataList  = bdgOpBasicMgtService.selectOpBasicMgtCode4(paramMap);
    		jsonData.setStatus("SUCC");
    		jsonData.setRows(dataList);
    		
    	} catch (Exception e) {
    		logger.error("경영예산등록_기본예산 조회 오류", e);
    	}
    	
    	if( logger.isDebugEnabled()) {
    		logger.debug("jsonData = " + jsonData);
    	}
    	return jsonData;
    }
    
    @RequestMapping(value = "/com/bdg/selectOpBasicMgtData.do")
    @ResponseBody
    public JsonData selectOpBasicMgtData(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData  = new JsonData();
    	
    	try {
    		
    		List<Map<String,Object>> dataList  = bdgOpBasicMgtService.selectOpBasicMgtData(paramMap);
    		jsonData.setStatus("SUCC");
    		jsonData.setRows(dataList);
    		
    	} catch (Exception e) {
    		logger.error("경영예산등록_기본예산 조회 오류", e);
    	}
    	
    	if( logger.isDebugEnabled()) {
    		logger.debug("jsonData = " + jsonData);
    	}
    	return jsonData;
    }
    
    @RequestMapping(value = "/com/bdg/saveOpBasicMgtExcel.do")
    @ResponseBody
    public JsonData saveOpBasicMgtExcel(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws ServiceException, Exception {
    	JsonData jsonData = new JsonData();
    	try {
    		Map<String,Object> responseMap = bdgOpBasicMgtService.saveOpBasicMgtExcel(paramMap);
    		
    		jsonData.setStatus("SUCC");
    		jsonData.addFields("result", responseMap);
    		
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
    
    @RequestMapping(value = "/com/bdg/selectOpBasicMgtExcel.do")
    @ResponseBody
    public JsonData selectOpBasicMgtExcel(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData  = new JsonData();

        try {

            List<Map<String,Object>> dataList  = bdgOpBasicMgtService.selectOpBasicMgtExcel(paramMap);
            jsonData.setStatus("SUCC");
            jsonData.setRows(dataList);
            
        } catch (Exception e) {
            logger.error("경영예산등록_기본예산 조회 오류", e);
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        return jsonData;
    }    
}
