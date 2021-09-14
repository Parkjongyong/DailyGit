/**
 * 예산 > 예산관리> 코스트센터 관리
 * @author 박종용
 * @since 2020.10.23
 * 
 * << 개정이력(Modification Information) >>
 *  ------------------------------------------------- 
 *  수정일                    수정자            수정내용
 *  ----------   -------- ---------------------------
 *  2020.10.23   박종용            최초생성
 *  -------------------------------------------------
 */
package com.app.ildong.bdg.controller;

import java.lang.reflect.Field;
import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.app.ildong.bdg.service.BdgCostMgtService;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.JsonData;
import com.app.ildong.common.model.mvc.BaseController;
import com.app.ildong.common.service.CommonSelectService;
import com.app.ildong.common.util.PropertiesUtil;
import com.app.ildong.common.util.StringUtil;
import com.ildong.CO.BGT_ERP.IFCO006_BGT_SOBindingStub;
import com.ildong.CO.BGT_ERP.IFCO006_BGT_SOServiceLocator;
import com.ildong.CO.BGT_ERP.IFCO006_BGT_S_DT;
import com.ildong.CO.BGT_ERP.IFCO006_BGT_S_DT_response;
import com.ildong.CO.BGT_ERP.IFCO006_BGT_S_DT_responseITEM;
import com.ildong.SD.BGT_ERP.IFSD020_BGT_SOBindingStub;
import com.ildong.SD.BGT_ERP.IFSD020_BGT_SOServiceLocator;
import com.ildong.SD.BGT_ERP.IFSD020_BGT_S_DT;
import com.ildong.SD.BGT_ERP.IFSD020_BGT_S_DTHEADER;
import com.ildong.SD.BGT_ERP.IFSD020_BGT_S_DTITEM;
import com.ildong.SD.BGT_ERP.IFSD020_BGT_S_DT_response;
import com.ildong.SD.BGT_ERP.IFSD112_BGT_SOBindingStub;
import com.ildong.SD.BGT_ERP.IFSD112_BGT_SOServiceLocator;
import com.ildong.SD.BGT_ERP.IFSD112_BGT_S_DT;
import com.ildong.SD.BGT_ERP.IFSD112_BGT_S_DT_response;
import com.ildong.SD.BGT_ERP.IFSD112_BGT_S_DT_responseITEM;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.jdbc.BadSqlGrammarException;
import org.springframework.dao.DataIntegrityViolationException;

@Controller
public class BdgCostMgtController extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(BdgCostMgtController.class);
    
    private static final String sysErrMsg = "시스템 오류가 발생하였습니다.";
    
	@Autowired
    private CommonSelectService commonSelectService;
	
    @Autowired 
    private BdgCostMgtService bdgCostMgtService;
    
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/bdg/bdgCostMgt.do")
    public String bdgCostMgt(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
    		model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001","YS024","YS025"}));
			
			// 로긴 사용자 정보를 바탕으로 담당자별 부서권한 코드 콤보 데이터 추출
			model.putAll(commonSelectService.selectUserDeptCodeList("USRDPT"));
			
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
        return "com/bdg/bdgCostMgt";
    }
    
    
    @RequestMapping("/com/bdg/bdgCostMgtPop.do")
    public String bdgCostMgtPop(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
    		model.addAttribute("PARAM", paramMap);
    		model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001","YS024","YS025"}));
    		
			// CASE 2
			paramMap.put("CODE"   , "USRDPT");
			// 회사코드와 사번을 가변적으로 셋팅해서 담당자별 부서권한 코드 콤보 데이터 추출
			//paramMap.put("COMP_CD", "1000");
			//paramMap.put("SABUN"  , "sysadmin");
			model.putAll(commonSelectService.selectUserDeptCodeList2(paramMap));
			
    	} catch (ServiceException e) {
    		e.printStackTrace();
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return "com/bdg/bdgCostMgtPop";
    }
    
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/com/bdg/selectCostMgtList.do")
    @ResponseBody
    public JsonData selectCostMgtList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData  = new JsonData();

        try {

            List<Map<String,Object>> dataList  = bdgCostMgtService.selectCostMgtList(paramMap);
            jsonData.setStatus("SUCC");
            jsonData.setRows(dataList);
            
        } catch (Exception e) {
            logger.error("코스트센터 조회 오류", e);
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        return jsonData;
    }
    
    @RequestMapping(value = "/com/bdg/selectCostMgtListPop.do")
    @ResponseBody
    public JsonData selectCostMgtListPop(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData  = new JsonData();

        try {

            List<Map<String,Object>> dataList  = bdgCostMgtService.selectCostMgtListPop(paramMap);
            jsonData.setStatus("SUCC");
            jsonData.setRows(dataList);
            
        } catch (Exception e) {
            logger.error("부서견본신청 조회 오류", e);
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        return jsonData;
    }    
    
    
    @RequestMapping(value = "/com/bdg/saveCostMgt.do")
    @ResponseBody
    public JsonData saveCostMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws ServiceException, Exception {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		Map<String,Object> responseMap = bdgCostMgtService.saveCostMgt(paramMap);
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
    
    @RequestMapping(value = "/com/bdg/deleteCostMgt.do")
    @ResponseBody
    public JsonData deleteCostMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		// 삭제  로직 수행
    		Map<String,Object> responseMap = bdgCostMgtService.deleteCostMgt(paramMap);
    		
    		System.out.println("SUCC_YN::" + responseMap.get("SUCC_YN").toString());
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
    
}
