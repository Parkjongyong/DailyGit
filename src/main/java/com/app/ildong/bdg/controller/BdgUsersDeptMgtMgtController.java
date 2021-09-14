/**
 * 담당자별 관리부서 조회/저장/삭제
 * @author 길용덕
 * @since 2020.09.09
 * 
 * << 개정이력(Modification Information) >>
 *  ------------------------------------------------- 
 *  수정일                    수정자            수정내용
 *  ----------   -------- ---------------------------
 *  2020.09.09   길용덕            최초생성
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

import com.app.ildong.bdg.service.BdgUsersDeptMgtService;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.JsonData;
import com.app.ildong.common.model.mvc.BaseController;
import com.app.ildong.common.service.CommonSelectService;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.jdbc.BadSqlGrammarException;
import org.springframework.dao.DataIntegrityViolationException;

@Controller
public class BdgUsersDeptMgtMgtController extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(BdgUsersDeptMgtMgtController.class);
    
    private static final String sysErrMsg = "시스템 오류가 발생하였습니다.";
    
	@Autowired
    private CommonSelectService commonSelectService;
	
    @Autowired 
    private BdgUsersDeptMgtService bdgUsersDeptMgtService;
    
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/bdg/bdgUsersDeptMgt.do")
    public String bdgUsersDeptMgt(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
			model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001"}));
			
			// CASE 1
			// 로긴 사용자 정보를 바탕으로 담당자별 부서권한 코드 콤보 데이터 추출
			model.putAll(commonSelectService.selectUserDeptCodeList("USRDPT"));
			
			// CASE 2
			paramMap.put("CODE"   , "USRDPT");
			// 회사코드와 사번을 가변적으로 셋팅해서 담당자별 부서권한 코드 콤보 데이터 추출
			//paramMap.put("SABUN"  , paramMap.get("USER_ID"));
			model.putAll(commonSelectService.selectUserDeptCodeList2(paramMap));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
        return "com/bdg/bdgUsersDeptMgt";
    }
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/com/bdg/selectUsersMgtList.do")
    @ResponseBody
    public JsonData selectUsersDeptMgtList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData  = new JsonData();

        try {

            List<Map<String,Object>> dataList  = bdgUsersDeptMgtService.selectUsersMgtList(paramMap);
            jsonData.setStatus("SUCC");
            jsonData.setRows(dataList);
            
        } catch (Exception e) {
            logger.error("담당자별 부서권한 관리 조회 오류", e);
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        return jsonData;
    }
    
    @RequestMapping(value = "/com/bdg/selectDeptMgtList.do")
    @ResponseBody
    public JsonData selectDeptMgtList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData  = new JsonData();
    	
    	try {
    		
    		List<Map<String,Object>> dataList  = bdgUsersDeptMgtService.selectDeptMgtList(paramMap);
    		jsonData.setStatus("SUCC");
    		jsonData.setRows(dataList);
    		
    	} catch (Exception e) {
    		logger.error("담당자별 부서권한 관리 조회 오류", e);
    	}
    	
    	if( logger.isDebugEnabled()) {
    		logger.debug("jsonData = " + jsonData);
    	}
    	return jsonData;
    }
    
    @RequestMapping(value = "/com/bdg/saveUsersMgt.do")
    @ResponseBody
    public JsonData saveUsersDeptMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws ServiceException, Exception {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		Map<String,Object> responseMap = bdgUsersDeptMgtService.insertUsersMgt(paramMap);
    		
    		jsonData.setStatus("SUCC");
    		jsonData.addFields("result", responseMap);
    		
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
    
    @RequestMapping(value = "/com/bdg/deleteUsersMgt.do")
    @ResponseBody
    public JsonData deleteUsersMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		// 삭제  로직 수행
    		Map<String,Object> responseMap = bdgUsersDeptMgtService.deleteUsersMgt(paramMap);
    		
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
    
    @RequestMapping(value = "/com/bdg/saveDeptMgt.do")
    @ResponseBody
    public JsonData saveDeptMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws ServiceException, Exception {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		Map<String,Object> responseMap = bdgUsersDeptMgtService.insertUsersMgt(paramMap);
    		
    		jsonData.setStatus("SUCC");
    		jsonData.addFields("result", responseMap);
    		
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
    
    @RequestMapping(value = "/com/bdg/deleteDeptMgt.do")
    @ResponseBody
    public JsonData deleteDeptMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		// 삭제  로직 수행
    		Map<String,Object> responseMap = bdgUsersDeptMgtService.deleteDeptMgt(paramMap);
    		
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
    
}
