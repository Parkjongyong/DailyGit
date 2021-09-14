
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
import org.springframework.web.bind.annotation.ResponseStatus;

import com.app.ildong.bat.dao.BatSendBugtDAO;
import com.app.ildong.bdg.service.BdgSupplementService;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.JsonData;
import com.app.ildong.common.model.mvc.BaseController;
import com.app.ildong.common.service.CommonSelectService;
import com.app.ildong.common.util.PropertiesUtil;
import com.app.ildong.common.util.StringUtil;
import com.ildong.CO.BGT_ERP.IFCO008_BGT_SOBindingStub;
import com.ildong.CO.BGT_ERP.IFCO008_BGT_SOServiceLocator;
import com.ildong.CO.BGT_ERP.IFCO008_BGT_S_DTITEM;
import com.ildong.CO.BGT_ERP.IFCO008_BGT_S_DT_response;
import com.ildong.CO.BGT_ERP.IFCO014_BGT_SOBindingStub;
import com.ildong.CO.BGT_ERP.IFCO014_BGT_SOServiceLocator;
import com.ildong.CO.BGT_ERP.IFCO014_BGT_S_DTITEM;
import com.ildong.CO.BGT_ERP.IFCO014_BGT_S_DT_response;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.http.HttpStatus;
import org.springframework.jdbc.BadSqlGrammarException;
import org.springframework.dao.DataIntegrityViolationException;

@Controller
public class BdgSupplementController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(BdgSupplementController.class);

	private static final String sysErrMsg = "시스템 오류가 발생하였습니다.";

	@Autowired
	private CommonSelectService commonSelectService;

	@Autowired
	private BdgSupplementService bdgSupplementService;

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
	@RequestMapping("/com/bdg/bdgSupplement.do")
	public String bdgSupplement(@RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		try {
			model.putAll(commonSelectService.selectCodeList(new String[] { "SYS001", "YS001", "YS009", "YS039"}));
			model.putAll(commonSelectService.selectCompList());
			model.putAll(commonSelectService.selectCostList());
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "com/bdg/bdgSupplement";
	}

	@RequestMapping("/com/bdg/bdgSupplementM.do")
	public String bdgSupplementM(@RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		try {
			model.putAll(commonSelectService.selectCodeList(new String[] { "SYS001", "YS001", "YS009" }));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "com/bdg/bdgSupplementM";
	}
	
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/bdg/bdgSupplementDetail.do")
    public String bdgbdgSupplementDetail(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
    		model.putAll(commonSelectService.selectCodeList(new String[]{"YS036", "YS037", "YS038"}));
			model.addAttribute("PARAM", paramMap);
    	} catch (ServiceException e) {
    		e.printStackTrace();
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return "com/bdg/bdgSupplementDetail";
    } 	

	/**
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/com/bdg/selectSupplement.do")
	@ResponseBody
	public JsonData selectSupplementHeader(@RequestBody Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		JsonData jsonData = new JsonData();

		try {

			List<Map<String, Object>> dataList = bdgSupplementService.selectSupplement(paramMap);
			jsonData.setStatus("SUCC");
			jsonData.setRows(dataList);

		} catch (Exception e) {
			logger.error("추가예산신청 조회 오류", e);
		}

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
		return jsonData;
	}
	
	@RequestMapping(value = "/com/bdg/selectSupplementDetail.do")
	@ResponseBody
	public JsonData selectSupplementDetail(@RequestBody Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		JsonData jsonData = new JsonData();

		try {

			List<Map<String, Object>> dataList = bdgSupplementService.selectSupplementDetail(paramMap);
			jsonData.setStatus("SUCC");
			jsonData.setRows(dataList);

		} catch (Exception e) {
			logger.error("추가예산신청 상세 조회 오류", e);
		}

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
		return jsonData;
	}	

	@RequestMapping(value = "/com/bdg/saveSupplement.do")
	@ResponseBody
	public JsonData saveSupplement(@RequestBody Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		JsonData jsonData = new JsonData();
		try {
			Map<String, Object> responseMap = bdgSupplementService.saveSupplement(paramMap);

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

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}

		return jsonData;
	}
	
	@RequestMapping(value = "/com/bdg/saveSupplementDetail.do")
	@ResponseBody
	public JsonData saveSupplementDetail(@RequestBody Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		JsonData jsonData = new JsonData();
		try {
			Map<String, Object> responseMap = bdgSupplementService.saveSupplementDetail(paramMap);

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

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}

		return jsonData;
	}	

	@RequestMapping(value = "/com/bdg/delSupplement.do")
	@ResponseBody
	public JsonData delSupplement(@RequestBody Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		JsonData jsonData = new JsonData();
		try {

			Map<String, Object> responseMap = bdgSupplementService.delSupplement(paramMap);

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

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}

		return jsonData;
	}
	
	@RequestMapping(value = "/com/bdg/delSupplementDetail.do")
	@ResponseBody
	public JsonData delSupplementDetail(@RequestBody Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		JsonData jsonData = new JsonData();
		try {

			Map<String, Object> responseMap = bdgSupplementService.delSupplementDetail(paramMap);

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

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}

		return jsonData;
	}	

	@RequestMapping(value = "/com/bdg/apprSupplement.do")
	@ResponseBody
	public JsonData apprSupplement(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();
		try {
			
    		int apprCnt = bdgSupplementService.selectApprStatus(paramMap);

    		if(apprCnt > 0) {
        		jsonData.setStatus("FAIL");
        		jsonData.setErrMsg("해당일에 승인요청한 데이터가 존재합니다. 확인 후 작업하세요.");
        		jsonData.addFields("result", paramMap);
        		throw new Exception("해당일에 승인요청한 데이터가 존재합니다. 확인 후 작업하세요.");
    		}
    		
    		// 승인요청 전 상태 체크
    		Map<String,Object> statusMap = bdgSupplementService.selectStatusHeader(paramMap);
    		String status = StringUtil.isNullToString(statusMap.get("STATUS"));
    		
    		// 작성중 상태인경우만 승인 요청가능(회수 절차로 인해 작성중으로 변경하여 재상신 가능!!)
    		if ("1".equals(status)) {
    			Map<String,Object> resultMap = bdgSupplementService.apprSupplement(paramMap);
    			List<Map<String,Object>> dataList = bdgSupplementService.selectApprList(resultMap);
    			
        		jsonData.setStatus("SUCC");
        		jsonData.addFields("result", resultMap);
        		jsonData.addFields("apprList", dataList);
        		
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
	@RequestMapping(value = "/com/bdg/selectSupplementAmt.do")
	@ResponseBody
	public JsonData selectSupplementAmt(@RequestBody Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		JsonData jsonData = new JsonData();

		try {

			List<Map<String, Object>> dataList = bdgSupplementService.selectSupplementAmt(paramMap);
			jsonData.setStatus("SUCC");
			jsonData.setRows(dataList);

		} catch (Exception e) {
			logger.error("추가예산신청 조회 오류", e);
		}

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
		return jsonData;
	}

    @RequestMapping(value = "/com/bdg/returnSupplement.do")
    @ResponseBody
    public JsonData returnModifyMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		Map<String,Object> responseMap = bdgSupplementService.returnSupplement(paramMap);
    		
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

    
    @RequestMapping(value = "/com/bdg/sendSupplement.do")
    @ResponseBody
    public JsonData sendSupplement(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		
            Map<String,Object> returnParam = new HashMap<>();
            Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
            List<Map<String, Object>> updList = (List<Map<String, Object>>)dataMap.get("UPDATED");
            
            
            for (Map<String, Object> data : updList) {
                paramMap.put("COMP_CD", data.get("COMP_CD").toString());
                paramMap.put("CCTR_CD", data.get("CCTR_CD").toString());
                paramMap.put("ACCOUNT_NO", data.get("ACCOUNT_NO").toString());
                
        		List<Map<String,Object>> dataList1 = new ArrayList<Map<String, Object>>();
        		List<Map<String,Object>> dataList2 = new ArrayList<Map<String, Object>>();
    			dataList1 = batSendBugtDAO.selectSendSupplementList(paramMap);
    			//dataList2 = batSendBugtDAO.selectSendSupplementMgmtList(paramMap);
    			returnParam.put("IFCO008", dataList1);
    			//returnParam.put("IFCO014", dataList2);			

    			String ifFlag = "";
    			String ifMgs  = "";

                if (!returnParam.isEmpty()) {
    	            List<Map<String,Object>> sendIFCO008List = (List<Map<String, Object>>) returnParam.get("IFCO008");
    	            //List<Map<String,Object>> sendIFCO014List = (List<Map<String, Object>>) returnParam.get("IFCO014");
    	            
    	            if (sendIFCO008List.size() > 0) {
    					// 1. SOAP 통신으로 승인셰산정보  정보 송신 
    					IFCO008_BGT_S_DTITEM[] sendBugtRow = new IFCO008_BGT_S_DTITEM[sendIFCO008List.size()];
    					
    					int rowCnt = 0;
    		           	for (Map<String, Object> sendBugtMap : sendIFCO008List) {
    		           		IFCO008_BGT_S_DTITEM sendBugt = new IFCO008_BGT_S_DTITEM();
    		           		
    		                sendBugt.setBUKRS(StringUtil.isNullToString(sendBugtMap.get("BUKRS")));
    		                sendBugt.setZBUDCA(StringUtil.isNullToString(sendBugtMap.get("ZBUDCA")));
    		                sendBugt.setZSERIA(StringUtil.isNullToString(sendBugtMap.get("ZSERIA")));
    		                sendBugt.setZOTYPE(StringUtil.isNullToString(sendBugtMap.get("ZOTYPE")));
    		                sendBugt.setAKOSTL(StringUtil.isNullToString(sendBugtMap.get("AKOSTL")));
    		                sendBugt.setBKOSTL(StringUtil.isNullToString(sendBugtMap.get("BKOSTL")));
    		                sendBugt.setAUFNR(StringUtil.isNullToString(sendBugtMap.get("AUFNR")));
    		                sendBugt.setKSTAR(StringUtil.isNullToString(sendBugtMap.get("KSTAR")));
    		                sendBugt.setGJAHR(StringUtil.isNullToString(sendBugtMap.get("GJAHR")));
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
    		           		bdgSupplementService.updateSupplementSap(paramMap);
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
    	            
//    	            if (sendIFCO014List.size() > 0) {
//    					// 2. SOAP 통신으로 유통품목별 상세  정보 전송 
//    					IFCO014_BGT_S_DTITEM[] sendBugtRow = new IFCO014_BGT_S_DTITEM[sendIFCO014List.size()];
//    					
//    					int rowCnt = 0;
//    		           	for (Map<String, Object> sendBugtMap : sendIFCO014List) {
//    		           		IFCO014_BGT_S_DTITEM sendBugt = new IFCO014_BGT_S_DTITEM();
//    		           		
//    		                sendBugt.setBUKRS(StringUtil.isNullToString(sendBugtMap.get("BUKRS")));
//    		                sendBugt.setZBUDCA(StringUtil.isNullToString(sendBugtMap.get("ZBUDCA")));
//    		                sendBugt.setZSERIA(StringUtil.isNullToString(sendBugtMap.get("ZSERIA")));
//    		                sendBugt.setKOSTL(StringUtil.isNullToString(sendBugtMap.get("KOSTL")));
//    		                sendBugt.setVTWEG(StringUtil.isNullToString(sendBugtMap.get("VTWEG")));
//    		                sendBugt.setZLEVEL(StringUtil.isNullToString(sendBugtMap.get("ZLEVEL")));
//    		                sendBugt.setZPRODH(StringUtil.isNullToString(sendBugtMap.get("ZPRODH")));
//    		                sendBugt.setKSTAR(StringUtil.isNullToString(sendBugtMap.get("KSTAR")));
//    		                sendBugt.setGJAHR(StringUtil.isNullToString(sendBugtMap.get("GJAHR")));
//    		                sendBugt.setZSATYP(StringUtil.isNullToString(sendBugtMap.get("ZSATYP")));
//    		                sendBugt.setWKG001(StringUtil.isNullToString(sendBugtMap.get("WKG001")));
//    		                sendBugt.setWKG002(StringUtil.isNullToString(sendBugtMap.get("WKG002")));
//    		                sendBugt.setWKG003(StringUtil.isNullToString(sendBugtMap.get("WKG003")));
//    		                sendBugt.setWKG004(StringUtil.isNullToString(sendBugtMap.get("WKG004")));
//    		                sendBugt.setWKG005(StringUtil.isNullToString(sendBugtMap.get("WKG005")));
//    		                sendBugt.setWKG006(StringUtil.isNullToString(sendBugtMap.get("WKG006")));
//    		                sendBugt.setWKG007(StringUtil.isNullToString(sendBugtMap.get("WKG007")));
//    		                sendBugt.setWKG008(StringUtil.isNullToString(sendBugtMap.get("WKG008")));
//    		                sendBugt.setWKG009(StringUtil.isNullToString(sendBugtMap.get("WKG009")));
//    		                sendBugt.setWKG010(StringUtil.isNullToString(sendBugtMap.get("WKG010")));
//    		                sendBugt.setWKG011(StringUtil.isNullToString(sendBugtMap.get("WKG011")));
//    		                sendBugt.setWKG012(StringUtil.isNullToString(sendBugtMap.get("WKG012")));
//    		                
//    		                sendBugtRow[rowCnt] = sendBugt;
//    		                rowCnt++;
//    		           	}
//    		           	
//    					// 1. SOAP 통신으로 공급업체  정보 추출 
//    		            IFCO014_BGT_SOServiceLocator sl = new IFCO014_BGT_SOServiceLocator();
//    		            IFCO014_BGT_SOBindingStub bs    = (IFCO014_BGT_SOBindingStub)sl.getHTTP_Port();
//    		            IFCO014_BGT_S_DT_response res   = new IFCO014_BGT_S_DT_response();
//    		        	
//    		        	// USER ID/PW 셋팅
//    		        	// USER ID/PW 셋팅
//    		           	String sapId= PropertiesUtil.getProperty("sap.id");
//    		           	String sapPw= PropertiesUtil.getProperty("sap.pw");
//		           	bs.setUsername(sapId);
//		           	bs.setPassword(sapPw); 
//    		        	
//    		        	res = bs.IFCO014_BGT_SO(sendBugtRow);
//    		           	ifFlag = StringUtil.isNullToString(res.getIF_FLAG());
//    		           	ifMgs  = StringUtil.isNullToString(res.getIF_MSG());
    		           	
//    		           	// 성공유무 확인
//    		           	if ("S".equals(ifFlag)) {
//    		           		bdgSupplementService.updateSupplementSap(paramMap);
//    		           	} else if ("E".equals(ifFlag)) {
//    		           		jsonData.setStatus("FAIL");
//    		           		jsonData.setErrMsg(ifMgs);
//    		           	}
//    	            } else {
//    	        		jsonData.setStatus("FAIL");
//    	        		jsonData.setErrMsg("SAP 전송할 데이터가 존재하지 않습니다.");
//    	            }
//    	            
//    	    		jsonData.setStatus("SUCC");
//    	    		jsonData.addFields("result", paramMap);
    	            
                }                
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
     * @function 전자결재 시스템에서 승인과정 UPDATE 정보 전송
     */    
    @RequestMapping("/com/bdg/bdgSupplementEps.do")
    @ResponseBody
    public JsonData bdgSupplementEps(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
			if (!"".equals(paramMap.get("EPS_DOC_NO")) && null != paramMap.get("EPS_DOC_NO")) {
				bdgSupplementService.saveEpsHistory(paramMap);
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
	@RequestMapping("/com/bdg/bdgSupplementPop.do")
	public String bdgSupplementPop(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		try {
			model.addAttribute("PARAM", paramMap);
			model.putAll(commonSelectService.selectCodeList(new String[] { "SYS001", "YS001", "YS009" }));
			model.putAll(commonSelectService.selectCompListPop(paramMap));
			model.putAll(commonSelectService.selectCostListPop(paramMap));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "com/bdg/bdgSupplementPop";
	}

    /**
     * @function 전자결재 시스템에서 팝업 활성화 후 데이터 조회
     */   
	@RequestMapping(value = "/com/bdg/selectSupplementPop.do")
	@ResponseBody
	public JsonData selectSupplementPop(@RequestBody Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		JsonData jsonData = new JsonData();

		try {

			List<Map<String, Object>> dataList = bdgSupplementService.selectSupplementPop(paramMap);
			Map<String,Object> epsInfoMap = bdgSupplementService.selectEpsInfoData(paramMap);
			jsonData.setStatus("SUCC");
			jsonData.setRows(dataList);
			jsonData.addFields("epsInfo", epsInfoMap);

		} catch (Exception e) {
			logger.error("추가예산신청 조회 오류", e);
		}

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
		return jsonData;
	}

}
