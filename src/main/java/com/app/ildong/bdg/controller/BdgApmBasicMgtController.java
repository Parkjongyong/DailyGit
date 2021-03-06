
package com.app.ildong.bdg.controller;

import java.lang.reflect.Field;
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
import org.springframework.web.bind.annotation.ResponseStatus;

import com.app.ildong.bdg.dao.BdgApmBasicMgtDAO;
import com.app.ildong.bdg.service.BdgApmBasicMgtService;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.JsonData;
import com.app.ildong.common.model.mvc.BaseController;
import com.app.ildong.common.service.CommonSelectService;
import com.app.ildong.common.util.PropertiesUtil;
import com.app.ildong.common.util.StringUtil;
import com.ildong.FI.BGT_ERP.IFFI019_BGT_SOBindingStub;
import com.ildong.FI.BGT_ERP.IFFI019_BGT_SOServiceLocator;
import com.ildong.FI.BGT_ERP.IFFI019_BGT_S_DTIN_APM;
import com.ildong.FI.BGT_ERP.IFFI019_BGT_S_DT_response;
import com.ildong.FI.BGT_ERP.IFFI054_BGT_SOBindingStub;
import com.ildong.FI.BGT_ERP.IFFI054_BGT_SOServiceLocator;
import com.ildong.FI.BGT_ERP.IFFI054_BGT_S_DT;
import com.ildong.FI.BGT_ERP.IFFI054_BGT_S_DTIN_REQUEST;
import com.ildong.FI.BGT_ERP.IFFI054_BGT_S_DT_response;
import com.ildong.FI.BGT_ERP.IFFI054_BGT_S_DT_responseOUT_APM;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.http.HttpStatus;
import org.springframework.jdbc.BadSqlGrammarException;
import org.springframework.dao.DataIntegrityViolationException;

@Controller
public class BdgApmBasicMgtController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(BdgApmBasicMgtController.class);

	private static final String sysErrMsg = "????????? ????????? ?????????????????????.";

	@Autowired
	private CommonSelectService commonSelectService;

	@Autowired
	private BdgApmBasicMgtService bdgApmBasicMgtService;

	@Autowired
	private SchedulerFactoryBean schedulerFactoryBean;

	@Autowired
	private BdgApmBasicMgtDAO bdgApmBasicMgtDAO;

	/**
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/com/bdg/bdgApmBasicMgt.do")
	public String bdgApmBasicMgt(@RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		try {
			model.putAll(commonSelectService.selectCodeList(new String[] { "SYS001", "YS010", "YS012" }));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "com/bdg/bdgApmBasicMgt";
	}

	@RequestMapping("/com/bdg/bdgApmBasicMgtM.do")
	public String bdgApmBasicMgtM(@RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		try {
			model.putAll(commonSelectService.selectCodeList(new String[] { "SYS001", "YS010", "YS012" }));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "com/bdg/bdgApmBasicMgtM";
	}

	/**
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/com/bdg/selectApmBasicMgt.do")
	@ResponseBody
	public JsonData selectApmBasicMgt(@RequestBody Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		JsonData jsonData = new JsonData();

		try {

			List<Map<String, Object>> dataList = bdgApmBasicMgtService.selectApmBasicMgt(paramMap);
			Map<String, Object>       checkMap = bdgApmBasicMgtService.selectCheckStatusApmBasic(paramMap);
			jsonData.setStatus("SUCC");
			jsonData.setRows(dataList);
			jsonData.addFields("check", checkMap);

		} catch (Exception e) {
			logger.error("APM?????? ?????? ??????", e);
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
	@RequestMapping(value = "/com/bdg/selectApmBasicMgtM.do")
	@ResponseBody
	public JsonData selectApmBasicMgtM(@RequestBody Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		JsonData jsonData = new JsonData();
		
		try {
			
			List<Map<String, Object>> dataList = bdgApmBasicMgtService.selectApmBasicMgtM(paramMap);
			jsonData.setStatus("SUCC");
			jsonData.setRows(dataList);
			
		} catch (Exception e) {
			logger.error("APM?????? ?????? ??????", e);
		}
		
		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
		return jsonData;
	}
	
	@RequestMapping(value = "/com/bdg/saveApmBasicMgt.do")
	@ResponseBody
	public JsonData saveSupplement(@RequestBody Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		JsonData jsonData = new JsonData();
		try {
			Map<String, Object> responseMap = bdgApmBasicMgtService.saveApmBasicMgt(paramMap);

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

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}

		return jsonData;
	}

	@RequestMapping(value = "/com/bdg/delApmBasicMgt.do")
	@ResponseBody
	public JsonData delSupplement(@RequestBody Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		JsonData jsonData = new JsonData();
		try {

			Map<String, Object> responseMap = bdgApmBasicMgtService.delApmBasicMgt(paramMap);

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

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}

		return jsonData;
	}

	@RequestMapping(value = "/com/bdg/confirmApmBasicMgt.do")
	@ResponseBody
	public JsonData confirmApmBasicMgt(@RequestBody Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		JsonData jsonData = new JsonData();
		try {
			Map<String, Object> responseMap = bdgApmBasicMgtService.confirmApmBasicMgt(paramMap);

			jsonData.setStatus("SUCC");
			jsonData.addFields("result", responseMap);

		} catch (ServiceException se) {
			se.printStackTrace();
			jsonData.setErrMsg(se.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.setErrMsg(e.getMessage());
		}

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}

		return jsonData;
	}

	@RequestMapping(value = "/com/bdg/confirmCancelApmBasicMgt.do")
	@ResponseBody
	public JsonData confirmCancelApmBasicMgt(@RequestBody Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		JsonData jsonData = new JsonData();
		try {
			Map<String, Object> responseMap = bdgApmBasicMgtService.confirmCancelApmBasicMgt(paramMap);
			
			jsonData.setStatus("SUCC");
			jsonData.addFields("result", responseMap);
			
		} catch (ServiceException se) {
			se.printStackTrace();
			jsonData.setErrMsg(se.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.setErrMsg(e.getMessage());
		}
		
		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
		
		return jsonData;
	}
	
    @RequestMapping(value = "/com/bdg/apprApmBasicMgt.do")
    @ResponseBody
    public JsonData apprApmBasicMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		// ???????????? ??? ?????? ??????
    		Map<String,Object> statusMap = bdgApmBasicMgtService.selectStatusHeader(paramMap);
    		String status = StringUtil.isNullToString(statusMap.get("STATUS"));
    		
    		// ????????? ?????????????????? ?????? ????????????(?????? ????????? ?????? ??????????????? ???????????? ????????? ??????!!)
    		if ("1".equals(status)) {
    			Map<String,Object> resultMap = bdgApmBasicMgtService.apprApmBasicMgt(paramMap);
    			
        		jsonData.setStatus("SUCC");
        		jsonData.addFields("result", resultMap);
        		
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
	
    @RequestMapping(value = "/com/bdg/returnApmBasicMgt.do")
    @ResponseBody
    public JsonData returnModifyMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		Map<String,Object> responseMap = bdgApmBasicMgtService.returnApmBasicMgt(paramMap);
    		
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
    
    @RequestMapping(value = "/com/bdg/rejectApmBasicMgt.do")
    @ResponseBody
    public JsonData rejectApmBasicMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		Map<String,Object> statusMap = bdgApmBasicMgtService.selectStatusCnt(paramMap);
    		String cnt = StringUtil.isNullToString(statusMap.get("CNT"));
    		Map<String,Object> responseMap = new HashMap<>();
    		
    		if ("0".equals(cnt)) {
    			responseMap = bdgApmBasicMgtService.rejectApmBasicMgt(paramMap);
        		jsonData.setStatus("SUCC");
        		jsonData.addFields("result", responseMap);
    		} else {
        		jsonData.setStatus("FAIL");
        		jsonData.setErrMsg("SAP??? ????????? ???????????? ???????????? ???????????????.");
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

    
    @RequestMapping(value = "/com/bdg/sendCancelApmBasicMgt.do")
    @ResponseBody
    public JsonData sendCancelApmBasicMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws ServiceException, Exception {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		Map<String,Object> responseMap = bdgApmBasicMgtService.sendCancelApmBasicMgt(paramMap);
    		
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
    
    @RequestMapping(value = "/com/bdg/ReceiveApmBasicMgt.do")
    @ResponseBody
    public JsonData ReceiveApmBasicMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws ServiceException, Exception {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		// 1. SOAP ???????????? ????????????  ?????? ?????? 
    		IFFI054_BGT_S_DTIN_REQUEST headInfo = new IFFI054_BGT_S_DTIN_REQUEST();
    		IFFI054_BGT_S_DT dt = new IFFI054_BGT_S_DT();
        	String ifFlag = "";
        	String ifMgs  = "";
        	
        	// ????????????
        	headInfo.setBUKRS(paramMap.get("SB_COMP_CD").toString());
            System.out.println("????????????::" + paramMap.get("SB_COMP_CD").toString());
            //????????????
            headInfo.setZMONTH(paramMap.get("CRTN_YYMM").toString().replace("-", ""));
            System.out.println("????????????::" + paramMap.get("CRTN_YYMM").toString().replace("-", ""));
            //??????
            headInfo.setZCHANN(paramMap.get("SB_CHC_ETC_GBN").toString().substring(0, 1));
            System.out.println("??????::" + paramMap.get("SB_CHC_ETC_GBN").toString().substring(0, 1));
            
            dt.setIN_REQUEST(headInfo);
            IFFI054_BGT_SOServiceLocator afs = new IFFI054_BGT_SOServiceLocator();
            IFFI054_BGT_SOBindingStub af = (IFFI054_BGT_SOBindingStub)afs.getHTTP_Port();
            IFFI054_BGT_S_DT_response res = new IFFI054_BGT_S_DT_response();
        	
        	// USER ID/PW ??????
           	String sapId= PropertiesUtil.getProperty("sap.id");
           	String sapPw= PropertiesUtil.getProperty("sap.pw");
           	af.setUsername(sapId);
           	af.setPassword(sapPw);             
           	
           	res = af.IFFI054_BGT_SO(dt);
           	
           	ifFlag = StringUtil.isNullToString(res.getIF_FLAG());
           	ifMgs  = StringUtil.isNullToString(res.getIF_MSG());
           	
           	int apmIfLen = 0;
       		if (null != res.getOUT_APM()) {
       			apmIfLen = res.getOUT_APM().length;
       		}
       		
       		System.out.println("apmIfLen::" + apmIfLen);
       		
       		IFFI054_BGT_S_DT_responseOUT_APM[] apmIfRow = new IFFI054_BGT_S_DT_responseOUT_APM[apmIfLen];
           	List<Map<String, Object>> apmIfList         = new ArrayList<Map<String, Object>>();
           	
       		if (apmIfLen > 0) {
       			apmIfRow = res.getOUT_APM();
       			
	           	for (IFFI054_BGT_S_DT_responseOUT_APM apmIf : apmIfRow) {
	           		Map<String, Object> apmIfMap = new HashMap<String,Object>();
	                for (Field field : apmIf.getClass().getDeclaredFields()) {
	                    field.setAccessible(true);
	                    // ?????? ?????? ??????
	                    if ("ZPREBAL".equals(field.getName()) || "ZCURBAL".equals(field.getName())) {
	                    	String strValue = StringUtil.isNullToString(field.get(apmIf));
	                    	if (strValue.toString().indexOf("-") > -1) {
	                    		apmIfMap.put(field.getName(), "-" + field.get(apmIf).toString().replace("-", ""));
	                    		System.out.println("CASE 3[" + field.getName() + "-" + field.get(apmIf) + "]");
	                    	} else {
	                    		apmIfMap.put(field.getName(), field.get(apmIf));
	                    		System.out.println("CASE 2[" + field.getName() + "-" + field.get(apmIf) + "]");
	                    	}
	                    } else {
	                    	apmIfMap.put(field.getName(), field.get(apmIf));
	                    	System.out.println("CASE 1[" + field.getName() + "-" + field.get(apmIf) + "]");
	                    }
	                    
	                }           		
	                apmIfList.add(apmIfMap);
	           	}
	           	
				// ????????? ???????????? ??????(??????????????????) ????????? ???????????? ?????? 
	           	bdgApmBasicMgtService.makeApmIfData(paramMap, apmIfList);
	           	
	    		jsonData.setStatus("SUCC");
	    		jsonData.addFields("result", paramMap);	           	
       		} else {
        		jsonData.setStatus("FAIL");
        		jsonData.setErrMsg("SAP?????? ????????? ???????????? ???????????? ????????????.");
        		jsonData.addFields("result", paramMap);
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
    
    @RequestMapping(value = "/com/bdg/sendApmBasicMgt.do")
    @ResponseBody
    public JsonData sendApmBasicMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws ServiceException, Exception {
    	JsonData jsonData = new JsonData();
    	try {
    		
            Map<String,Object> returnParam = new HashMap<>();
            
    		List<Map<String,Object>> dataList = bdgApmBasicMgtService.selectSendApmBasicMgt(paramMap);
    		
			returnParam.put("IFFI019", dataList);

			String ifFlag = "";
			String ifMgs  = "";

            if (!returnParam.isEmpty()) {
	            List<Map<String,Object>> sendIFFI019List = (List<Map<String, Object>>) returnParam.get("IFFI019");
	            
	            if (sendIFFI019List.size() > 0) {
					// 1. SOAP ???????????? ??????????????????  ?????? ?????? 
	            	IFFI019_BGT_S_DTIN_APM[] sendApmRow = new IFFI019_BGT_S_DTIN_APM[sendIFFI019List.size()];
					
					int rowCnt = 0;
		           	for (Map<String, Object> sendApmMap : sendIFFI019List) {
		           		IFFI019_BGT_S_DTIN_APM sendApm = new IFFI019_BGT_S_DTIN_APM();
		           		
		           		sendApm.setBUKRS(StringUtil.isNullToString(sendApmMap.get("BUKRS")));
		           		sendApm.setZMONTH(StringUtil.isNullToString(sendApmMap.get("ZMONTH")));
		           		sendApm.setLEGACYNO(StringUtil.isNullToString(sendApmMap.get("LEGACYNO")));
		           		sendApm.setZBUGTYPE(StringUtil.isNullToString(sendApmMap.get("ZBUGTYPE")));
		           		sendApm.setZTNR(StringUtil.isNullToString("")); // ??????????????? ?????????!!!
		           		sendApm.setZUPIND(StringUtil.isNullToString(sendApmMap.get("ZUPIND")));
		           		sendApm.setZCHANN(StringUtil.isNullToString(sendApmMap.get("ZCHANN")));
		           		sendApm.setKOSTL(StringUtil.isNullToString(sendApmMap.get("KOSTL")));
		                sendApm.setLIFNR(StringUtil.isNullToString(sendApmMap.get("LIFNR")));
		                sendApm.setZAPMBUGAMT(StringUtil.isNullToString(sendApmMap.get("ZAPMBUGAMT")));
		                sendApm.setZTRDATE(StringUtil.isNullToString(sendApmMap.get("ZTRDATE")));
		                sendApm.setZTFSENDAMT(StringUtil.isNullToString(sendApmMap.get("ZTFSENDAMT")));
		                sendApm.setZTFRECVAMT(StringUtil.isNullToString(sendApmMap.get("ZTFRECVAMT")));
		                sendApm.setZLIFNR(StringUtil.isNullToString(sendApmMap.get("ZLIFNR")));
		                sendApm.setZCRDATE(StringUtil.isNullToString(sendApmMap.get("ZCRDATE")));
		                
		                sendApmRow[rowCnt] = sendApm;
		                rowCnt++;
		           	}
		           	
					// 1. SOAP ???????????? ????????????  ?????? ?????? 
		           	IFFI019_BGT_SOServiceLocator sl = new IFFI019_BGT_SOServiceLocator();
		           	IFFI019_BGT_SOBindingStub bs    = (IFFI019_BGT_SOBindingStub)sl.getHTTP_Port();
		           	IFFI019_BGT_S_DT_response res   = new IFFI019_BGT_S_DT_response();
		        	
		        	// USER ID/PW ??????
		           	
		           	String sapId= PropertiesUtil.getProperty("sap.id");
		           	String sapPw= PropertiesUtil.getProperty("sap.pw");
		        	bs.setUsername(sapId);
		        	bs.setPassword(sapPw); 
		        	
		        	res = bs.IFFI019_BGT_SO(sendApmRow);
		           	ifFlag = StringUtil.isNullToString(res.getIF_FLAG());
		           	ifMgs  = StringUtil.isNullToString(res.getIF_MSG());
		           	
		           	// ???????????? ??????
		           	if ("S".equals(ifFlag)) {
		           		Map<String,Object> responseMap = bdgApmBasicMgtService.updateApmBasicMgtSap(paramMap, dataList);
		           		
		        		if ("N".equals(responseMap.get("SUCC_YN"))) {
		        			throw new Exception(responseMap.get("ERR_MSG").toString()); 
		        		} else {
				    		jsonData.setStatus("SUCC");
				    		jsonData.addFields("result", paramMap);		
		        		}
           		
		           	} else if ("E".equals(ifFlag)) {
		           		jsonData.setStatus("FAIL");
		           		jsonData.setErrMsg(ifMgs);
		           	}
	            } else {
	        		jsonData.setStatus("FAIL");
	        		jsonData.setErrMsg("SAP ????????? ???????????? ???????????? ????????????.");
	            }
	            
            } else {
        		jsonData.setStatus("FAIL");
        		jsonData.setErrMsg("SAP ????????? ???????????? ???????????? ????????????.");          	
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
    
    /**
     * @function ???????????? ??????????????? ???????????? UPDATE ?????? ??????
     */    
    @RequestMapping("/com/bdg/bdgApmBasicMgtEps.do")
    @ResponseStatus(value = HttpStatus.OK)
    public JsonData bdgBasicMgtEps(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	
    	JsonData jsonData = new JsonData();
    	
    	try {
			if (!"".equals(paramMap.get("EPS_DOC_NO")) && null != paramMap.get("EPS_DOC_NO")) {
				bdgApmBasicMgtService.saveEpsHistory(paramMap);
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
    @RequestMapping("/com/bdg/bdgApmBasicMgtPop.do")
    public String bdgApmBasicMgtPop(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
    		model.addAttribute("PARAM", paramMap);
    		model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001","YS001","YS009"}));
    	} catch (ServiceException e) {
    		e.printStackTrace();
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return "com/bdg/bdgApmBasicMgtPop";
    }

    /**
     * @function ???????????? ??????????????? ?????? ????????? ??? ????????? ??????
     */      
	@RequestMapping(value = "/com/bdg/selectApmBasicMgtPop.do")
	@ResponseBody
	public JsonData selectApmBasicMgtPop(@RequestBody Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		JsonData jsonData = new JsonData();

		try {

			List<Map<String, Object>> dataList = bdgApmBasicMgtService.selectApmBasicMgtPop(paramMap);
			jsonData.setStatus("SUCC");
			jsonData.setRows(dataList);

		} catch (Exception e) {
			logger.error("APM?????? ?????? ??????", e);
		}

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
		return jsonData;
	}


    
}
