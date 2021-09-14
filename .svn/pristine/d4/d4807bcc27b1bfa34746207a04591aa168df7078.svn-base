/**
 * 경영예산등록_실행예산
 * @author 박종용
 * @since 2020.08.24
 * 
 * << 개정이력(Modification Information) >>
 *  ------------------------------------------------- 
 *  수정일                    수정자            수정내용
 *  ----------   -------- ---------------------------
 *  2020.08.12   박종용            최초생성
 *  -------------------------------------------------
 */
package com.app.ildong.bdg.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.app.ildong.bat.dao.BatSendBugtDAO;
import com.app.ildong.bdg.service.BdgOpExecBugtMgtService;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.JsonData;
import com.app.ildong.common.model.mvc.BaseController;
import com.app.ildong.common.service.CommonSelectService;
import com.app.ildong.common.util.StringUtil;
import com.app.ildong.sys.service.SysCmmLogMgmtService;
import com.ildong.CO.BGT_ERP.IFCO008_BGT_SOBindingStub;
import com.ildong.CO.BGT_ERP.IFCO008_BGT_SOServiceLocator;
import com.ildong.CO.BGT_ERP.IFCO008_BGT_S_DTITEM;
import com.ildong.CO.BGT_ERP.IFCO008_BGT_S_DT_response;
import com.ildong.CO.BGT_ERP.IFCO014_BGT_SOBindingStub;
import com.ildong.CO.BGT_ERP.IFCO014_BGT_SOServiceLocator;
import com.ildong.CO.BGT_ERP.IFCO014_BGT_S_DTITEM;
import com.ildong.CO.BGT_ERP.IFCO014_BGT_S_DT_response;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.jdbc.BadSqlGrammarException;
import org.springframework.dao.DataIntegrityViolationException;

@Controller
public class BdgOpExecBugtMgtController extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(BdgOpExecBugtMgtController.class);
    
    private static final String sysErrMsg = "시스템 오류가 발생하였습니다.";
    
	@Autowired
    private CommonSelectService commonSelectService;
	
    @Autowired 
    private BdgOpExecBugtMgtService bdgOpExecBugtMgtService;
    
    @Autowired
    private SysCmmLogMgmtService sysCmmLogMgmtService;    
    
    @Autowired
    private SchedulerFactoryBean schedulerFactoryBean;    
    
	@Autowired
	private BatSendBugtDAO batSendBugtDAO;
	
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/bdg/bdgOpExecBugtMgt.do")
    public String bdgOpExecBugtMgt(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
			model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001","YS001","YS006","YS007","YS008"}));
			model.putAll(commonSelectService.selectOpAccountCodeList("SYSACC"));
			model.putAll(commonSelectService.selectCompList());
			model.putAll(commonSelectService.selectCostList());
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
        return "com/bdg/bdgOpExecBugtMgt";
    }
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/bdg/bdgOpExecBugtMgtM.do")
    public String bdgOpExecBugtMgtM(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
			model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001","YS001","YS006","YS007","YS008"}));
			model.putAll(commonSelectService.selectOpAccountCodeList("SYSACC"));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
        return "com/bdg/bdgOpExecBugtMgtM";
    }    
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/com/bdg/selectOpExec.do")
    @ResponseBody
    public JsonData selectExecBugtMgtHeadList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();

        try {

            List<Map<String,Object>> dataList = bdgOpExecBugtMgtService.selectOpExec(paramMap);
            jsonData.setStatus("SUCC");
            jsonData.setRows(dataList);
            
        } catch (Exception e) {
            logger.error("경영예산등록_실행예산 조회 오류", e);
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        return jsonData;
    }
    
    
    @RequestMapping(value = "/com/bdg/saveOpExec.do")
    @ResponseBody
    public JsonData saveExecBugtMgtDetail(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws ServiceException, Exception {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		Map<String,Object> responseMap = bdgOpExecBugtMgtService.saveOpExec(paramMap);
    		
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
    
    @RequestMapping(value = "/com/bdg/deleteOpExec.do")
    @ResponseBody
    public JsonData deleteOpExec(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws ServiceException, Exception {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		Map<String,Object> responseMap = bdgOpExecBugtMgtService.deleteOpExec(paramMap);
    		
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
    
    @RequestMapping(value = "/com/bdg/createOpExecBugtMgt.do")
    @ResponseBody
    public JsonData createOpExecBugtMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		// 예산실적생성
    		Map<String,Object> responseMap = bdgOpExecBugtMgtService.createOpExecBugtMgt(paramMap);
    		
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
    
    @RequestMapping(value = "/com/bdg/confirmOpExec.do")
    @ResponseBody
    public JsonData confirmOpExec(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws ServiceException, Exception {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		Map<String,Object> responseMap = bdgOpExecBugtMgtService.confirmOpExec(paramMap);
    		
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
    
    @RequestMapping(value = "/com/bdg/confirmCancelOpExec.do")
    @ResponseBody
    public JsonData confirmCancelOpExec(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws ServiceException, Exception {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		Map<String,Object> responseMap = bdgOpExecBugtMgtService.confirmCancelOpExec(paramMap);
    		
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
    
    @RequestMapping(value = "/com/bdg/sendOpExec.do")
    @ResponseBody
    public JsonData sendOpExec(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws ServiceException, Exception {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		Map<String,Object> responseMap = bdgOpExecBugtMgtService.sendOpExec(paramMap);
    		
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
    
    @RequestMapping(value = "/com/bdg/sendCancelOpExec.do")
    @ResponseBody
    public JsonData fnSendCancel(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws ServiceException, Exception {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		Map<String,Object> responseMap = bdgOpExecBugtMgtService.sendCancelOpExec(paramMap);
    		
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
    
}
