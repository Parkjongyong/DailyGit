
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
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.jdbc.BadSqlGrammarException;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.app.ildong.bat.dao.BatSendBugtDAO;
import com.app.ildong.bat.service.BatDepreAccountInterfaceService;
import com.app.ildong.bat.service.BatSendBugtInterfaceService;
import com.app.ildong.bdg.service.BdgBasicMgtService;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.JsonData;
import com.app.ildong.common.model.mvc.BaseController;
import com.app.ildong.common.service.CommonSelectService;
import com.app.ildong.common.util.PropertiesUtil;
import com.app.ildong.common.util.StringUtil;
import com.ecbank.framework.exception.BizException;
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

@Controller
public class BdgBasicMgtController extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(BdgBasicMgtController.class);
    
    private static final String sysErrMsg = "????????? ????????? ?????????????????????.";
    
	@Autowired
    private CommonSelectService commonSelectService;
	
    @Autowired 
    private BdgBasicMgtService bdgBasicMgtService;

    @Autowired
    private SchedulerFactoryBean schedulerFactoryBean;
    
	@Autowired
	private BatSendBugtInterfaceService batSendBugtInterfaceService;

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
    @RequestMapping("/com/bdg/bdgBasicMgt.do")
    public String bdgBasicMgt(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
			model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001","YS001","YS009", "YS039"}));
			model.putAll(commonSelectService.selectCompList());
			model.putAll(commonSelectService.selectCostList());
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
        return "com/bdg/bdgBasicMgt";
    }
    
    @RequestMapping("/com/bdg/bdgBasicMgtM.do")
    public String bdgBasicMgtM(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
    		model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001","YS001","YS009"}));
    	} catch (ServiceException e) {
    		e.printStackTrace();
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return "com/bdg/bdgBasicMgtM";
    }
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/com/bdg/selectBasicMgtHeader.do")
    @ResponseBody
    public JsonData selectBasicMgtHeader(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();

        try {

            List<Map<String,Object>> dataList = bdgBasicMgtService.selectBasicMgtHeader(paramMap);
            jsonData.setStatus("SUCC");
            jsonData.setRows(dataList);
            if(dataList.size() > 0) {
                jsonData.addFields("B_RATE", dataList.get(0).get("B_RATE"));
                jsonData.addFields("B_BUDGET", dataList.get(0).get("B_BUDGET"));
            }
            
        } catch (Exception e) {
            logger.error("?????????????????? ?????? ??????", e);
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
    @RequestMapping(value = "/com/bdg/selectBbugdet.do")
    @ResponseBody
    public JsonData selectBbugdet(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	
    	try {
    		
    		List<Map<String,Object>> dataList = bdgBasicMgtService.selectBbugdet(paramMap);
    		Map<String,Object> stausMap       = bdgBasicMgtService.selectStatusHeader2(paramMap);
    		jsonData.setStatus("SUCC");
    		jsonData.setRows(dataList);
    		jsonData.addFields("STATUS", stausMap.get("STATUS"));
    		if(dataList.size() > 0) {
    			jsonData.addFields("B_BUDGET", dataList.get(0).get("B_BUDGET"));
    		}
    		
    	} catch (Exception e) {
    		logger.error("?????????????????? ?????? ??????", e);
    	}
    	
    	if( logger.isDebugEnabled()) {
    		logger.debug("jsonData = " + jsonData);
    	}
    	return jsonData;
    }
    
    @RequestMapping(value = "/com/bdg/selectBasicMgtDetail.do")
    @ResponseBody
    public JsonData selectBasicMgtDetail(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	
    	try {

    		List<Map<String,Object>> dataList = bdgBasicMgtService.selectBasicMgtDetail(paramMap);
    		Map<String,Object> stausMap       = bdgBasicMgtService.selectStatusHeader2(paramMap);
    		jsonData.setStatus("SUCC");
    		jsonData.setRows(dataList);
    		jsonData.addFields("STATUS"      , stausMap.get("STATUS"));
    		jsonData.addFields("PROCESS_TYPE", stausMap.get("PROCESS_TYPE"));    		
    		
    	} catch (Exception e) {
    		logger.error("?????????????????? ?????? ??????", e);
    	}
    	
    	if( logger.isDebugEnabled()) {
    		logger.debug("jsonData = " + jsonData);
    	}
    	return jsonData;
    }
    
    @RequestMapping(value = "/com/bdg/saveBasicMgt.do")
    @ResponseBody
    public JsonData saveBasicMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		// ???????????? ?????? ??????
    		checkEndData(paramMap);
    		Map<String,Object> responseMap = bdgBasicMgtService.saveBasicMgt(paramMap);
    		
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
        		jsonData.setErrMsg("????????? ???????????? ???????????????. ?????? ??? ???????????????.");
        	} else if (e instanceof BadSqlGrammarException) {
        		jsonData.setErrMsg("DB ????????? ??????????????????. ??????????????? ?????? ????????? ????????????.");
        	} else if (e instanceof DataIntegrityViolationException) {
        		jsonData.setErrMsg("DB ????????? ??????????????????. ??????????????? ?????? ????????? ????????????.");
        	} else {
        		jsonData.setErrMsg(e.getMessage());
        	}
        }
    	

		if( logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
    	
    	return jsonData;
    }
    
    @RequestMapping(value = "/com/bdg/delBasicH.do")
    @ResponseBody
    public JsonData delBasicH(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		checkEndData(paramMap);
    		Map<String,Object> responseMap = bdgBasicMgtService.delBasicH(paramMap);
    		
    		jsonData.setStatus("SUCC");
    		jsonData.addFields("result", responseMap);
    		
    	} catch (ServiceException se) {
    		se.printStackTrace();
    		jsonData.setErrMsg(se.getMessage());
    	} catch (Exception e) {
    		e.printStackTrace();
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
    	
    	
    	if( logger.isDebugEnabled()) {
    		logger.debug("jsonData = " + jsonData);
    	}
    	
    	return jsonData;
    }
    
    @RequestMapping(value = "/com/bdg/delBasicMgt.do")
    @ResponseBody
    public JsonData delBasicMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		checkEndData(paramMap);
    		Map<String,Object> responseMap = bdgBasicMgtService.delBasicMgt(paramMap);
    		
    		jsonData.setStatus("SUCC");
    		jsonData.addFields("result", responseMap);
    		
    	} catch (ServiceException se) {
    		se.printStackTrace();
    		jsonData.setErrMsg(se.getMessage());
    	} catch (Exception e) {
    		e.printStackTrace();
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
    	
    	
    	if( logger.isDebugEnabled()) {
    		logger.debug("jsonData = " + jsonData);
    	}
    	
    	return jsonData;
    }
    
    @RequestMapping(value = "/com/bdg/apprBasicMgt.do")
    @ResponseBody
    public JsonData apprBasicMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		checkEndData(paramMap);
    		// ???????????? ??? ?????? ??????
    		Map<String,Object> statusMap = bdgBasicMgtService.selectStatusHeader(paramMap);
    		String status = StringUtil.isNullToString(statusMap.get("STATUS"));
    		
    		// ????????? ?????????????????? ?????? ????????????(?????? ????????? ?????? ??????????????? ???????????? ????????? ??????!!)
    		//if ("1".equals(status) || "2".equals(status)) {
    		if ("1".equals(status)) {
    			Map<String,Object> resultMap  = bdgBasicMgtService.apprBasicMgt(paramMap);
    			Map<String,Object> bugtSumMap = bdgBasicMgtService.selectBugtSumData(paramMap);
        		jsonData.setStatus("SUCC");
        		jsonData.addFields("result", resultMap);
        		jsonData.addFields("sumData", bugtSumMap);
        		
    		} else if ("".equals(status)) {
        		jsonData.setStatus("FAIL");
        		jsonData.setErrMsg("??????????????? ???????????? ???????????? ????????????. ?????? ??? ???????????????.");
        		jsonData.addFields("result", paramMap);
    		} else {
        		jsonData.setStatus("FAIL");
        		jsonData.setErrMsg("??????????????? ????????? ??????????????? ???????????????.");
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

    @RequestMapping(value = "/com/bdg/returnBasicMgt.do")
    @ResponseBody
    public JsonData returnBasicMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		checkEndData(paramMap);
    		Map<String,Object> responseMap = bdgBasicMgtService.returnBasicMgt(paramMap);
    		
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

    
    @RequestMapping(value = "/com/bdg/saveHeader.do")
    @ResponseBody
    public JsonData saveHeader(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		checkEndData(paramMap);
    		Map<String,Object> responseMap = bdgBasicMgtService.saveHeader(paramMap);
    		
    		jsonData.setStatus("SUCC");
    		jsonData.addFields("result", responseMap);
    	
    	} catch (ServiceException se) {
    		se.printStackTrace();
    		jsonData.setErrMsg(se.getMessage());
    	} catch (Exception e) {
        	e.printStackTrace();
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
    	

		if( logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
    	
    	return jsonData;
    }
    
    @RequestMapping(value = "/com/bdg/saveBasicMaster.do")
    @ResponseBody
    public JsonData saveBasicMaster(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		checkEndData(paramMap);
            Map<String,Object> returnParam = new HashMap<>();
            
    		List<Map<String,Object>> dataList1 = new ArrayList<Map<String, Object>>();
    		List<Map<String,Object>> dataList2 = new ArrayList<Map<String, Object>>();
			dataList1 = batSendBugtDAO.selectSendBasicBugtList(paramMap);
			dataList2 = batSendBugtDAO.selectSendBugtBasicMgmtList(paramMap);
			returnParam.put("IFCO008", dataList1);
			returnParam.put("IFCO014", dataList2);

			String ifFlag = "";
			String ifMgs  = "";

//            if (!returnParam.isEmpty()) {
	            List<Map<String,Object>> sendIFCO008List = (List<Map<String, Object>>) returnParam.get("IFCO008");
	            List<Map<String,Object>> sendIFCO014List = (List<Map<String, Object>>) returnParam.get("IFCO014");
	            
	            if (sendIFCO008List.size() > 0) {
					// 1. SOAP ???????????? ??????????????????  ?????? ?????? 
					IFCO008_BGT_S_DTITEM[] sendBugtRow = new IFCO008_BGT_S_DTITEM[sendIFCO008List.size()];
					
					int rowCnt = 0;
		           	for (Map<String, Object> sendBugtMap : sendIFCO008List) {
		           		IFCO008_BGT_S_DTITEM sendBugt = new IFCO008_BGT_S_DTITEM();
		           		
		                sendBugt.setBUKRS(StringUtil.isNullToString(sendBugtMap.get("BUKRS")));
		                sendBugt.setZBUDCA(StringUtil.isNullToString(sendBugtMap.get("ZBUDCA")));
		                //sendBugt.setZSERIA(StringUtil.isNullToString(sendBugtMap.get("ZSERIA")));
		                //???????????? ???????????? ????????? ??????????????? SETTING!!!!
		                sendBugt.setZSERIA(StringUtil.isNullToString(paramMap.get("SB_CHASU")));
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
		           	
					// 1. SOAP ???????????? ????????????  ?????? ?????? 
		            IFCO008_BGT_SOServiceLocator sl = new IFCO008_BGT_SOServiceLocator();
		            IFCO008_BGT_SOBindingStub bs    = (IFCO008_BGT_SOBindingStub)sl.getHTTP_Port();
		            IFCO008_BGT_S_DT_response res   = new IFCO008_BGT_S_DT_response();
		        	
		        	// USER ID/PW ??????
		        	// USER ID/PW ??????
		           	String sapId= PropertiesUtil.getProperty("sap.id");
		           	String sapPw= PropertiesUtil.getProperty("sap.pw");
		           	bs.setUsername(sapId);
		           	bs.setPassword(sapPw);
		        	
		        	res = bs.IFCO008_BGT_SO(sendBugtRow);
		           	ifFlag = StringUtil.isNullToString(res.getIF_FLAG());
		           	ifMgs  = StringUtil.isNullToString(res.getIF_MSG());
		           	
		           	// ???????????? ??????
		           	if ("S".equals(ifFlag)) {
		        		bdgBasicMgtService.saveBasicMaster(paramMap);
		           	} else if ("E".equals(ifFlag)) {
		           		jsonData.setStatus("FAIL");
		           		jsonData.setErrMsg(ifMgs);
		           	}
	            } else {
	        		jsonData.setStatus("FAIL");
	        		jsonData.setErrMsg("SAP ????????? ???????????? ???????????? ????????????.");
	            }
		           	
	    		jsonData.setStatus("SUCC");
	    		jsonData.addFields("result", paramMap);
	            
	            if (sendIFCO014List.size() > 0) {
					// 2. SOAP ???????????? ??????????????? ??????  ?????? ?????? 
					IFCO014_BGT_S_DTITEM[] sendBugtRow = new IFCO014_BGT_S_DTITEM[sendIFCO014List.size()];
					
					int rowCnt = 0;
		           	for (Map<String, Object> sendBugtMap : sendIFCO014List) {
		           		IFCO014_BGT_S_DTITEM sendBugt = new IFCO014_BGT_S_DTITEM();
		           		
		                sendBugt.setBUKRS(StringUtil.isNullToString(sendBugtMap.get("BUKRS")));
		                sendBugt.setZBUDCA(StringUtil.isNullToString(sendBugtMap.get("ZBUDCA")));
		                //sendBugt.setZSERIA(StringUtil.isNullToString(sendBugtMap.get("ZSERIA")));
		                //???????????? ???????????? ????????? ??????????????? SETTING!!!!
		                sendBugt.setZSERIA(StringUtil.isNullToString(paramMap.get("SB_CHASU")));
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
		           	
					// 1. SOAP ???????????? ????????????  ?????? ?????? 
		            IFCO014_BGT_SOServiceLocator sl = new IFCO014_BGT_SOServiceLocator();
		            IFCO014_BGT_SOBindingStub bs    = (IFCO014_BGT_SOBindingStub)sl.getHTTP_Port();
		            IFCO014_BGT_S_DT_response res   = new IFCO014_BGT_S_DT_response();
		        	
		        	// USER ID/PW ??????
		           	String sapId= PropertiesUtil.getProperty("sap.id");
		           	String sapPw= PropertiesUtil.getProperty("sap.pw");
		           	bs.setUsername(sapId);
		           	bs.setPassword(sapPw);
		        	
		        	res = bs.IFCO014_BGT_SO(sendBugtRow);
		           	ifFlag = StringUtil.isNullToString(res.getIF_FLAG());
		           	ifMgs  = StringUtil.isNullToString(res.getIF_MSG());
		           	
		           	// ???????????? ??????
		           	if ("S".equals(ifFlag)) {
		        		bdgBasicMgtService.saveBasicMaster(paramMap);
		           	} else if ("E".equals(ifFlag)) {
		           		jsonData.setStatus("FAIL");
		           		jsonData.setErrMsg(ifMgs);
		           	}
	            } else {
	        		jsonData.setStatus("FAIL");
	        		jsonData.setErrMsg("SAP ????????? ???????????? ???????????? ????????????.");
	            }
	            
	    		jsonData.setStatus("SUCC");
	    		jsonData.addFields("result", paramMap);
	            
//            }
           	
    	} catch (ServiceException se) {
    		se.printStackTrace();
    		jsonData.setStatus("FAIL");
    		jsonData.setErrMsg(se.getMessage());
    	} catch (Exception e) {
        	e.printStackTrace();
        	jsonData.setStatus("FAIL");
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
    	
    	
    	if( logger.isDebugEnabled()) {
    		logger.debug("jsonData = " + jsonData);
    	}
    	
    	return jsonData;
    }
    
    @RequestMapping(value = "/com/bdg/receiveBasicHrBugt.do")
    @ResponseBody
    public JsonData receiveBasicHrBugt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		// ???????????? ?????? ??????
    		checkEndData(paramMap);
    		Map<String,Object> responseMap = bdgBasicMgtService.ReceiveHrBugt(paramMap);
    		
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
        		jsonData.setErrMsg("????????? ???????????? ???????????????. ?????? ??? ???????????????.");
        	} else if (e instanceof BadSqlGrammarException) {
        		jsonData.setErrMsg("DB ????????? ??????????????????. ??????????????? ?????? ????????? ????????????.");
        	} else if (e instanceof DataIntegrityViolationException) {
        		jsonData.setErrMsg("DB ????????? ??????????????????. ??????????????? ?????? ????????? ????????????.");
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
     * @function ??????????????? ??????
     */     
    @RequestMapping(value = "/com/bdg/receiveDpreBasic.do")
    @ResponseBody
    public JsonData receiveDpreBasic(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		// ???????????? ?????? ??????
    		checkEndData(paramMap);
    		
            Calendar cal = Calendar.getInstance();
            cal.setTime(new Date());
            DateFormat uDate = new SimpleDateFormat("yyyyMMdd");
            DateFormat uTime = new SimpleDateFormat("HHmm00");    		
    		
            paramMap.put("TRANSACTION_NO", uDate.format(cal.getTime()) + uTime.format(cal.getTime()));
            
			IFCO007_BGT_S_DT dt = new IFCO007_BGT_S_DT();
        	dt.setI_BUKRS(paramMap.get("SB_COMP_CD").toString());
            System.out.println("????????????::" + paramMap.get("SB_COMP_CD").toString());
            dt.setI_GJAHR(paramMap.get("TB_CRTN_YY").toString());
            System.out.println("????????????::" + paramMap.get("TB_CRTN_YY").toString());
            dt.setI_VERSN("A00");
            
        	IFCO007_BGT_SOServiceLocator afs = new IFCO007_BGT_SOServiceLocator();
        	IFCO007_BGT_SOBindingStub af = (IFCO007_BGT_SOBindingStub)afs.getHTTP_Port();
        	IFCO007_BGT_S_DT_response res = new IFCO007_BGT_S_DT_response();
        	
        	// USER ID/PW ??????
        	// USER ID/PW ??????
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
	           	
	           	
	           	paramMap.put("VERSION", "A00");
				// ????????? ??????????????? IF ????????? ???????????? ?????? 
	           	batDepreAccountInterfaceService.makeDepreAccountData(paramMap, depreAccountList);
       		}           	
    		
    		jsonData.setStatus("SUCC");
    		jsonData.addFields("result", paramMap);
    		
    	} catch (ServiceException se) {
    		se.printStackTrace();
    		jsonData.setErrMsg(se.getMessage());
    	} catch (Exception e) {
    		System.out.println("receiveDpreBasic Exception in");
        	e.printStackTrace();
        	System.out.println("receiveDpreBasic Exception e.getMessage()::" + e.getMessage());
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
    	

		if( logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
    	
    	return jsonData;
    }    
    
    
    

    /**
     * @function ???????????? ??????????????? ???????????? UPDATE ?????? ??????
     */    
    @RequestMapping("/com/bdg/bdgBasicMgtEps.do")
    @ResponseBody
    public JsonData bdgBasicMgtEps(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
			if (!"".equals(paramMap.get("EPS_DOC_NO")) && null != paramMap.get("EPS_DOC_NO")) {
				bdgBasicMgtService.saveEpsHistory(paramMap);
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
     * @function ???????????? ??????????????? ?????? ?????? ??????
     */     
    @RequestMapping("/com/bdg/bdgBasicMgtPop.do")
    public String bdgBasicMgtPop(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
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
    	return "com/bdg/bdgBasicMgtPop";
    }    
 
    /**
     * @function ???????????? ??????????????? ?????? ????????? ??? ????????? ??????
     */
    @RequestMapping(value = "/com/bdg/selectBasicMgtHeaderPop.do")
    @ResponseBody
    public JsonData selectBasicMgtHeaderPop(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();

        try {

            List<Map<String,Object>> dataList = bdgBasicMgtService.selectBasicMgtHeaderPop(paramMap);
            Map<String,Object> epsInfoMap = bdgBasicMgtService.selectEpsInfoData(paramMap);
            jsonData.setStatus("SUCC");
            jsonData.setRows(dataList);
            jsonData.addFields("result", epsInfoMap);
            
        } catch (Exception e) {
            logger.error("?????????????????? ?????? ??????", e);
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        return jsonData;
    }

}
