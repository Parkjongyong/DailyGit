
package com.app.ildong.bdg.controller;

import java.lang.reflect.Field;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.app.ildong.bat.dao.BatSendBugtDAO;
import com.app.ildong.bat.service.BatDepreAccountInterfaceService;
import com.app.ildong.bdg.service.BdgModifyMgtService;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.JsonData;
import com.app.ildong.common.model.mvc.BaseController;
import com.app.ildong.common.service.CommonSelectService;
import com.app.ildong.common.util.PropertiesUtil;
import com.app.ildong.common.util.StringUtil;
import com.ildong.CO.BGT_ERP.IFCO007_BGT_SOBindingStub;
import com.ildong.CO.BGT_ERP.IFCO007_BGT_SOServiceLocator;
import com.ildong.CO.BGT_ERP.IFCO007_BGT_S_DT;
import com.ildong.CO.BGT_ERP.IFCO007_BGT_S_DT_response;
import com.ildong.CO.BGT_ERP.IFCO007_BGT_S_DT_responseITEM;
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
public class BdgModifyMgtController extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(BdgModifyMgtController.class);
    
    private static final String sysErrMsg = "시스템 오류가 발생하였습니다.";
    
	@Autowired
    private CommonSelectService commonSelectService;
	
    @Autowired 
    private BdgModifyMgtService bdgModifyMgtService;
    
    @Autowired
    private SchedulerFactoryBean schedulerFactoryBean;	    
    
	@Autowired
	private BatSendBugtDAO batSendBugtDAO;
	
	@Autowired
	private BatDepreAccountInterfaceService batDepreAccountInterfaceService;	
	
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/bdg/bdgModifyMgt.do")
    public String bdgModifyMgt(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
			model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001","YS001","YS009", "YS039"}));
			model.putAll(commonSelectService.selectCompList());
			model.putAll(commonSelectService.selectCostList());
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
        return "com/bdg/bdgModifyMgt";
    }

    @RequestMapping("/com/bdg/bdgModifyMgtM.do")
    public String bdgModifyMgtM(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
    		model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001","YS001","YS009"}));
    	} catch (ServiceException e) {
    		e.printStackTrace();
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return "com/bdg/bdgModifyMgtM";
    }
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/com/bdg/selectModifyMgtHeader.do")
    @ResponseBody
    public JsonData selectModifyMgtHeader(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();

        try {

            List<Map<String,Object>> dataList = bdgModifyMgtService.selectModifyMgtHeader(paramMap);
            jsonData.setStatus("SUCC");
            jsonData.setRows(dataList);
            
        } catch (Exception e) {
            logger.error("수정예산신청 조회 오류", e);
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        return jsonData;
    }
    
    @RequestMapping(value = "/com/bdg/saveModifyMgt.do")
    @ResponseBody
    public JsonData saveModifyMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		checkEndData(paramMap);
    		Map<String,Object> responseMap = bdgModifyMgtService.saveModifyMgt(paramMap);
    		
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
    
    @RequestMapping(value = "/com/bdg/delModifyH.do")
    @ResponseBody
    public JsonData delModifyH(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		checkEndData(paramMap);
    		Map<String,Object> responseMap = bdgModifyMgtService.delModifyH(paramMap);
    		
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
    
    @RequestMapping(value = "/com/bdg/delModifyMgt.do")
    @ResponseBody
    public JsonData delModifyMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		checkEndData(paramMap);
    		Map<String,Object> responseMap = bdgModifyMgtService.delModifyMgt(paramMap);
    		
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
    
    @RequestMapping(value = "/com/bdg/apprModifyMgt.do")
    @ResponseBody
    public JsonData apprModifyMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		checkEndData(paramMap);
    		// 승인요청 전 상태 체크
    		Map<String,Object> statusMap = bdgModifyMgtService.selectStatusHeader(paramMap);
    		String status = StringUtil.isNullToString(statusMap.get("STATUS"));
    		
    		// 작성중 상태인경우만 승인 요청가능(회수 절차로 인해 작성중으로 변경하여 재상신 가능!!)
    		if ("1".equals(status)) {
    			Map<String,Object> resultMap = bdgModifyMgtService.apprModifyMgt(paramMap);
    			
        		jsonData.setStatus("SUCC");
        		jsonData.addFields("result", resultMap);
        		
    		} else if ("".equals(status)) {
        		jsonData.setStatus("FAIL");
        		jsonData.setErrMsg("승인요청할 데이터가 존재하지 않습니다. 확인 후 작업하세요.");
        		jsonData.addFields("result", paramMap);
    		} else {
        		jsonData.setStatus("FAIL");
        		jsonData.setErrMsg("승인요청은 작성중 상태에서만 가능합니다.");
        		jsonData.addFields("result", paramMap);
    		}
    		
    	} catch (ServiceException se) {
    		se.printStackTrace();
    		jsonData.setErrMsg(se.getMessage());
    	} catch (Exception e) {
    		e.printStackTrace();
    		jsonData.setErrMsg(e.getMessage());
    	}
    	
    	
    	if( logger.isDebugEnabled()) {
    		logger.debug("jsonData = " + jsonData);
    	}
    	
    	return jsonData;
    }

    @RequestMapping(value = "/com/bdg/returnModifyMgt.do")
    @ResponseBody
    public JsonData returnModifyMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		checkEndData(paramMap);
    		Map<String,Object> responseMap = bdgModifyMgtService.returnModifyMgt(paramMap);
    		
    		jsonData.setStatus("SUCC");
    		jsonData.addFields("result", responseMap);
    		
    	} catch (ServiceException se) {
    		se.printStackTrace();
    		jsonData.setErrMsg(se.getMessage());
    	} catch (Exception e) {
    		e.printStackTrace();
    		jsonData.setErrMsg(e.getMessage());
    	}
    	
    	
    	if( logger.isDebugEnabled()) {
    		logger.debug("jsonData = " + jsonData);
    	}
    	
    	return jsonData;
    }

    @RequestMapping(value = "/com/bdg/saveModifyHeader.do")
    @ResponseBody
    public JsonData saveModifyHeader(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		checkEndData(paramMap);
    		Map<String,Object> responseMap = bdgModifyMgtService.saveModifyHeader(paramMap);
    		
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
    

    @RequestMapping(value = "/com/bdg/createModifyMgt.do")
    @ResponseBody
    public JsonData createModifyMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		checkEndData(paramMap);
    		Map<String,Object> responseMap = bdgModifyMgtService.createModifyMgt(paramMap);
    		
    		jsonData.setStatus("SUCC");
    		jsonData.addFields("result", responseMap);
    		
    	} catch (ServiceException se) {
    		se.printStackTrace();
    		jsonData.setErrMsg(se.getMessage());
    	} catch (Exception e) {
    		e.printStackTrace();
    		jsonData.setErrMsg(e.getMessage());
    	}
    	
    	
    	if( logger.isDebugEnabled()) {
    		logger.debug("jsonData = " + jsonData);
    	}
    	
    	return jsonData;
    }
    
    @RequestMapping(value = "/com/bdg/receiveModifyHrBugt.do")
    @ResponseBody
    public JsonData receiveModifyHrBugt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		// 마간기한 체크 로직
    		checkEndData(paramMap);
    		Map<String,Object> responseMap = bdgModifyMgtService.ReceiveHrBugt(paramMap);
    		
    		jsonData.setStatus("SUCC");
    		jsonData.addFields("result", responseMap);
    		
    	} catch (ServiceException se) {
    		se.printStackTrace();
    		jsonData.setErrMsg(se.getMessage());
    	} catch (Exception e) {
    		System.out.println("saveBasicMgt Exception in");
        	e.printStackTrace();
        	System.out.println("saveBasicMgt Exception e.getMessage()::" + e.getMessage());
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
     * @function 감가상각비 수신
     */     
    @RequestMapping(value = "/com/bdg/receiveDpreModify.do")
    @ResponseBody
    public JsonData receiveDpreModify(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		// 마간기한 체크 로직
    		checkEndData(paramMap);
    		
            Calendar cal = Calendar.getInstance();
            cal.setTime(new Date());
            DateFormat uDate = new SimpleDateFormat("yyyyMMdd");
            DateFormat uTime = new SimpleDateFormat("HHmm00");    		
    		
            paramMap.put("TRANSACTION_NO", uDate.format(cal.getTime()) + uTime.format(cal.getTime()));
            
			IFCO007_BGT_S_DT dt = new IFCO007_BGT_S_DT();
        	dt.setI_BUKRS(paramMap.get("SB_COMP_CD").toString());
            System.out.println("회사코드::" + paramMap.get("SB_COMP_CD").toString());
            dt.setI_GJAHR(paramMap.get("TB_CRTN_YY").toString());
            System.out.println("회계연도::" + paramMap.get("TB_CRTN_YY").toString());
            dt.setI_VERSN("B00");
            
        	IFCO007_BGT_SOServiceLocator afs = new IFCO007_BGT_SOServiceLocator();
        	IFCO007_BGT_SOBindingStub af = (IFCO007_BGT_SOBindingStub)afs.getHTTP_Port();
        	IFCO007_BGT_S_DT_response res = new IFCO007_BGT_S_DT_response();
        	
        	// USER ID/PW 셋팅
        	// USER ID/PW 셋팅
           	String sapId= PropertiesUtil.getProperty("sap.id");
           	String sapPw= PropertiesUtil.getProperty("sap.pw");
           	af.setUsername(sapId);
           	af.setPassword(sapPw); 
           	
           	res = af.IFCO007_BGT_SO(dt);
           	
           	String flag = StringUtil.isNullToString(res.getIF_FLAG());
           	String msg  = StringUtil.isNullToString(res.getIF_MSG());
           	
           	int depreAccountLen = 0;
       		if (null != res.getITEM()) {
       			depreAccountLen = res.getITEM().length;
       		}
       		
       		IFCO007_BGT_S_DT_responseITEM[] depreAccountRow = new IFCO007_BGT_S_DT_responseITEM[depreAccountLen];
           	List<Map<String, Object>> depreAccountList      = new ArrayList<Map<String, Object>>();
           	
       		if (depreAccountLen > 0) {
       			depreAccountRow = res.getITEM();
       			
	           	for (IFCO007_BGT_S_DT_responseITEM depreAccount : depreAccountRow) {
	           		Map<String, Object> depreAccountMap = new HashMap<String,Object>();
	                for (Field field : depreAccount.getClass().getDeclaredFields()) {
	                    field.setAccessible(true);
	                    depreAccountMap.put(field.getName(), field.get(depreAccount));
	                    System.out.println("[" + field.getName() + "-" + field.get(depreAccount) + "]");
	                }           		
	                depreAccountList.add(depreAccountMap);
	           	}
	           	
	           	
	           	paramMap.put("VERSION", "B00");
				// 전송된 감가상각비 IF 정보를 테이블에 반영 
	           	batDepreAccountInterfaceService.makeDepreAccountData(paramMap, depreAccountList);
       		}           	
    		
    		jsonData.setStatus("SUCC");
    		jsonData.addFields("result", paramMap);
    		
    	} catch (ServiceException se) {
    		se.printStackTrace();
    		jsonData.setErrMsg(se.getMessage());
    	} catch (Exception e) {
    		System.out.println("receiveDpreModify Exception in");
        	e.printStackTrace();
        	System.out.println("receiveDpreModify Exception e.getMessage()::" + e.getMessage());
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
    
    @RequestMapping(value = "/com/bdg/saveModifyMaster.do")
    @ResponseBody
    public JsonData saveBasicMaster(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		checkEndData(paramMap);
            Map<String,Object> returnParam = new HashMap<>();
            
    		List<Map<String,Object>> dataList1 = new ArrayList<Map<String, Object>>();
    		List<Map<String,Object>> dataList2 = new ArrayList<Map<String, Object>>();
			dataList1 = batSendBugtDAO.selectSendModifyBugtList(paramMap);
			dataList2 = batSendBugtDAO.selectSendBugtModifyBasicMgmtList(paramMap);
			returnParam.put("IFCO008", dataList1);
			returnParam.put("IFCO014", dataList2);			

			String ifFlag = "";
			String ifMgs  = "";

            if (!returnParam.isEmpty()) {
	            List<Map<String,Object>> sendIFCO008List = (List<Map<String, Object>>) returnParam.get("IFCO008");
	            List<Map<String,Object>> sendIFCO014List = (List<Map<String, Object>>) returnParam.get("IFCO014");
	            
	            if (sendIFCO008List.size() > 0) {
					// 1. SOAP 통신으로 승인셰산정보  정보 송신 
					IFCO008_BGT_S_DTITEM[] sendBugtRow = new IFCO008_BGT_S_DTITEM[sendIFCO008List.size()];
					
					int rowCnt = 0;
		           	for (Map<String, Object> sendBugtMap : sendIFCO008List) {
		           		IFCO008_BGT_S_DTITEM sendBugt = new IFCO008_BGT_S_DTITEM();
		           		
		                sendBugt.setBUKRS(StringUtil.isNullToString(sendBugtMap.get("BUKRS")));
		                sendBugt.setZBUDCA(StringUtil.isNullToString(sendBugtMap.get("ZBUDCA")));
		                sendBugt.setZSERIA(StringUtil.isNullToString("00"));
		                sendBugt.setZOTYPE(StringUtil.isNullToString(sendBugtMap.get("ZOTYPE")));
		                sendBugt.setAKOSTL(StringUtil.isNullToString(sendBugtMap.get("AKOSTL")));
		                sendBugt.setBKOSTL(StringUtil.isNullToString(sendBugtMap.get("BKOSTL")));
		                sendBugt.setAUFNR(StringUtil.isNullToString(sendBugtMap.get("AUFNR")));
		                sendBugt.setKSTAR(StringUtil.isNullToString(sendBugtMap.get("KSTAR")));
		                sendBugt.setGJAHR(StringUtil.isNullToString(sendBugtMap.get("GJAHR")));
		                sendBugt.setZDATE(StringUtil.isNullToString(sendBugtMap.get("ZDATE")));
		                sendBugt.setZSALES(StringUtil.isNullToString(sendBugtMap.get("ZSALES")));
		                sendBugt.setZSATYP(StringUtil.isNullToString(sendBugtMap.get("ZSATYP")));
		                sendBugt.setWKG001(StringUtil.isNullToString(sendBugtMap.get("WKG001")));
		                sendBugt.setWKG002(StringUtil.isNullToString(sendBugtMap.get("WKG002")));
		                sendBugt.setWKG003(StringUtil.isNullToString(sendBugtMap.get("WKG003")));
		                sendBugt.setWKG004(StringUtil.isNullToString(sendBugtMap.get("WKG004")));
		                sendBugt.setWKG005(StringUtil.isNullToString(sendBugtMap.get("WKG005")));
		                sendBugt.setWKG006(StringUtil.isNullToString(sendBugtMap.get("WKG006")));
		                sendBugt.setWKG007(StringUtil.isNullToString(sendBugtMap.get("WKG007")));
		                sendBugt.setWKG008(StringUtil.isNullToString(sendBugtMap.get("WKG008")));
		                sendBugt.setWKG009(StringUtil.isNullToString(sendBugtMap.get("WKG009")));
		                sendBugt.setWKG010(StringUtil.isNullToString(sendBugtMap.get("WKG010")));
		                sendBugt.setWKG011(StringUtil.isNullToString(sendBugtMap.get("WKG011")));
		                sendBugt.setWKG012(StringUtil.isNullToString(sendBugtMap.get("WKG012")));
		                
		                sendBugtRow[rowCnt] = sendBugt;
		                rowCnt++;
		           	}
		           	
					// 1. SOAP 통신으로 공급업체  정보 추출 
		            IFCO008_BGT_SOServiceLocator sl = new IFCO008_BGT_SOServiceLocator();
		            IFCO008_BGT_SOBindingStub bs    = (IFCO008_BGT_SOBindingStub)sl.getHTTP_Port();
		            IFCO008_BGT_S_DT_response res   = new IFCO008_BGT_S_DT_response();
		        	
		        	// USER ID/PW 셋팅
		        	// USER ID/PW 셋팅
		           	String sapId= PropertiesUtil.getProperty("sap.id");
		           	String sapPw= PropertiesUtil.getProperty("sap.pw");
		           	bs.setUsername(sapId);
		           	bs.setPassword(sapPw);
		        	
		        	res = bs.IFCO008_BGT_SO(sendBugtRow);
		           	ifFlag = StringUtil.isNullToString(res.getIF_FLAG());
		           	ifMgs  = StringUtil.isNullToString(res.getIF_MSG());
		           	
		           	// 성공유무 확인
		           	if ("S".equals(ifFlag)) {
		           		bdgModifyMgtService.saveModifyMaster(paramMap);
		           	} else if ("E".equals(ifFlag)) {
		           		jsonData.setStatus("FAIL");
		           		jsonData.setErrMsg(ifMgs);
		           	}
	            } else {
	        		jsonData.setStatus("FAIL");
	        		jsonData.setErrMsg("SAP 전송할 데이터가 존재하지 않습니다.");
	            }
		           	
	    		jsonData.setStatus("SUCC");
	    		jsonData.addFields("result", paramMap);
	            
	            if (sendIFCO014List.size() > 0) {
					// 2. SOAP 통신으로 유통품목별 상세  정보 전송 
					IFCO014_BGT_S_DTITEM[] sendBugtRow = new IFCO014_BGT_S_DTITEM[sendIFCO014List.size()];
					
					int rowCnt = 0;
		           	for (Map<String, Object> sendBugtMap : sendIFCO014List) {
		           		IFCO014_BGT_S_DTITEM sendBugt = new IFCO014_BGT_S_DTITEM();
		           		
		                sendBugt.setBUKRS(StringUtil.isNullToString(sendBugtMap.get("BUKRS")));
		                sendBugt.setZBUDCA(StringUtil.isNullToString(sendBugtMap.get("ZBUDCA")));
		                sendBugt.setZSERIA(StringUtil.isNullToString("00"));
		                sendBugt.setKOSTL(StringUtil.isNullToString(sendBugtMap.get("KOSTL")));
		                sendBugt.setVTWEG(StringUtil.isNullToString(sendBugtMap.get("VTWEG")));
		                sendBugt.setZLEVEL(StringUtil.isNullToString(sendBugtMap.get("ZLEVEL")));
		                sendBugt.setZPRODH(StringUtil.isNullToString(sendBugtMap.get("ZPRODH")));
		                sendBugt.setKSTAR(StringUtil.isNullToString(sendBugtMap.get("KSTAR")));
		                sendBugt.setGJAHR(StringUtil.isNullToString(sendBugtMap.get("GJAHR")));
		                sendBugt.setZSATYP(StringUtil.isNullToString(sendBugtMap.get("ZSATYP")));
		                sendBugt.setWKG001(StringUtil.isNullToString(sendBugtMap.get("WKG001")));
		                sendBugt.setWKG002(StringUtil.isNullToString(sendBugtMap.get("WKG002")));
		                sendBugt.setWKG003(StringUtil.isNullToString(sendBugtMap.get("WKG003")));
		                sendBugt.setWKG004(StringUtil.isNullToString(sendBugtMap.get("WKG004")));
		                sendBugt.setWKG005(StringUtil.isNullToString(sendBugtMap.get("WKG005")));
		                sendBugt.setWKG006(StringUtil.isNullToString(sendBugtMap.get("WKG006")));
		                sendBugt.setWKG007(StringUtil.isNullToString(sendBugtMap.get("WKG007")));
		                sendBugt.setWKG008(StringUtil.isNullToString(sendBugtMap.get("WKG008")));
		                sendBugt.setWKG009(StringUtil.isNullToString(sendBugtMap.get("WKG009")));
		                sendBugt.setWKG010(StringUtil.isNullToString(sendBugtMap.get("WKG010")));
		                sendBugt.setWKG011(StringUtil.isNullToString(sendBugtMap.get("WKG011")));
		                sendBugt.setWKG012(StringUtil.isNullToString(sendBugtMap.get("WKG012")));
		                
		                sendBugtRow[rowCnt] = sendBugt;
		                rowCnt++;
		           	}
		           	
					// 1. SOAP 통신으로 공급업체  정보 추출 
		            IFCO014_BGT_SOServiceLocator sl = new IFCO014_BGT_SOServiceLocator();
		            IFCO014_BGT_SOBindingStub bs    = (IFCO014_BGT_SOBindingStub)sl.getHTTP_Port();
		            IFCO014_BGT_S_DT_response res   = new IFCO014_BGT_S_DT_response();
		        	
		        	// USER ID/PW 셋팅
		        	// USER ID/PW 셋팅
		           	String sapId= PropertiesUtil.getProperty("sap.id");
		           	String sapPw= PropertiesUtil.getProperty("sap.pw");
		           	bs.setUsername(sapId);
		           	bs.setPassword(sapPw);
		        	
		        	res = bs.IFCO014_BGT_SO(sendBugtRow);
		           	ifFlag = StringUtil.isNullToString(res.getIF_FLAG());
		           	ifMgs  = StringUtil.isNullToString(res.getIF_MSG());
		           	
		           	// 성공유무 확인
		           	if ("S".equals(ifFlag)) {
		           		bdgModifyMgtService.saveModifyMaster(paramMap);
		           	} else if ("E".equals(ifFlag)) {
		           		jsonData.setStatus("FAIL");
		           		jsonData.setErrMsg(ifMgs);
		           	}
	            } else {
	        		jsonData.setStatus("FAIL");
	        		jsonData.setErrMsg("SAP 전송할 데이터가 존재하지 않습니다.");
	            }
	            
	    		jsonData.setStatus("SUCC");
	    		jsonData.addFields("result", paramMap);
	            
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

    /**
     * @function 전자결재 시스템에서 승인과정 UPDATE 정보 전송
     */ 
    @RequestMapping("/com/bdg/bdgModifyMgtEps.do")
    @ResponseBody
    public JsonData bdgModifyMgtEps(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
			if (!"".equals(paramMap.get("EPS_DOC_NO")) && null != paramMap.get("EPS_DOC_NO")) {
				bdgModifyMgtService.saveEpsHistory(paramMap);
			}
			
			jsonData.setStatus("SUCCESS");
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

    /**
     * @function 전자결재 시스템에서 팝업 링크 접속
     */    
    @RequestMapping("/com/bdg/bdgModifyMgtPop.do")
    public String bdgModifyMgtPop(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
    		model.addAttribute("PARAM", paramMap);
    		model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001","YS001","YS009"}));
			model.putAll(commonSelectService.selectCompListPop(paramMap));
			model.putAll(commonSelectService.selectCostListPop(paramMap));
    	} catch (ServiceException e) {
    		e.printStackTrace();
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return "com/bdg/bdgModifyMgtPop";
    }

    /**
     * @function 전자결재 시스템에서 팝업 활성화 후 데이터 조회
     */    
    @RequestMapping(value = "/com/bdg/selectModifyMgtHeaderPop.do")
    @ResponseBody
    public JsonData selectModifyMgtHeaderPop(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();

        try {

            List<Map<String,Object>> dataList = bdgModifyMgtService.selectModifyMgtHeaderPop(paramMap);
            Map<String,Object> epsInfoMap = bdgModifyMgtService.selectEpsInfoData(paramMap);
            jsonData.setStatus("SUCC");
            jsonData.setRows(dataList);
            jsonData.addFields("result", epsInfoMap);
        } catch (Exception e) {
            logger.error("수정예산신청 조회 오류", e);
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        return jsonData;
    }
    
    @RequestMapping(value = "/com/bdg/selectModifyMgtDetail.do")
    @ResponseBody
    public JsonData selectModifyMgtDetail(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	
    	try {
    		
    		List<Map<String,Object>> dataList = bdgModifyMgtService.selectModifyMgtDetail(paramMap);
    		Map<String,Object> stausMap       = bdgModifyMgtService.selectStatusHeader2(paramMap);
    		jsonData.setStatus("SUCC");
    		jsonData.setRows(dataList);
    		jsonData.addFields("STATUS"      , stausMap.get("STATUS"));
    		jsonData.addFields("PROCESS_TYPE", stausMap.get("PROCESS_TYPE"));
    		
    	} catch (Exception e) {
    		logger.error("수정예산신청 조회 오류", e);
    	}
    	
    	if( logger.isDebugEnabled()) {
    		logger.debug("jsonData = " + jsonData);
    	}
    	return jsonData;
    }    

}
