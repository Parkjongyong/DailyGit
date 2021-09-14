
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
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.jdbc.BadSqlGrammarException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.app.ildong.bdg.service.BdgSupRegService;
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
import com.ildong.FI.BGT_ERP.IFFI015_BGT_SOBindingStub;
import com.ildong.FI.BGT_ERP.IFFI015_BGT_SOServiceLocator;
import com.ildong.FI.BGT_ERP.IFFI015_BGT_S_DT;
import com.ildong.FI.BGT_ERP.IFFI015_BGT_S_DT_response;
import com.ildong.FI.BGT_ERP.IFFI015_BGT_S_DT_responseOUT_BANK;
import com.ildong.FI.BGT_ERP.IFFI015_BGT_S_DT_responseOUT_HEAD;
import com.ildong.FI.BGT_ERP.IFFI057_BGT_SOBindingStub;
import com.ildong.FI.BGT_ERP.IFFI057_BGT_SOServiceLocator;
import com.ildong.FI.BGT_ERP.IFFI057_BGT_S_DTIT_VEND;
import com.ildong.FI.BGT_ERP.IFFI057_BGT_S_DT_responseRETURN;

@Controller
public class BdgSupRegController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(BdgSupRegController.class);

	private static final String sysErrMsg = "시스템 오류가 발생하였습니다.";

	@Autowired
	private CommonSelectService commonSelectService;

	@Autowired
	private BdgSupRegService bdgSupRegService;

	/**
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/com/bdg/bdgSupReg.do")
	public String bdgSupReg(@RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		try {
			model.putAll(commonSelectService.selectCodeList(new String[] { "SYS001", "YS013", "YS017", "YS018", "YS019", "YS020" , "YS022", "YS023"}));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "com/bdg/bdgSupReg";
	}

	@RequestMapping("/com/bdg/bdgSupRegM.do")
	public String bdgSupRegM(@RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		try {
			model.putAll(commonSelectService.selectCodeList(new String[] { "SYS001", "YS013", "YS017", "YS018", "YS019", "YS020" , "YS022", "YS023"}));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "com/bdg/bdgSupRegM";
	}

	/**
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/com/bdg/selectSupReg.do")
	@ResponseBody
	public JsonData selectSupReg(@RequestBody Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		JsonData jsonData = new JsonData();

		try {

			List<Map<String, Object>> dataList = bdgSupRegService.selectSupReg(paramMap);
			jsonData.setStatus("SUCC");
			jsonData.setRows(dataList);

		} catch (Exception e) {
			logger.error("대외경조신청 조회 오류", e);
		}

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
		return jsonData;
	}
	
	@RequestMapping(value = "/com/bdg/selectPobusiNo.do")
	@ResponseBody
	public JsonData selectPobusiNo(@RequestBody Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		JsonData jsonData = new JsonData();
		try {
			
			Map<String,Object> checkParam = bdgSupRegService.selectCheckSupReg(paramMap);
			
			if ("0".equals(StringUtil.isNullToString(checkParam.get("CNT")))) {
				// 1. SOAP 통신으로 공급업체  정보 추출 
				//IFFI015_BGT_S_DTIN_REQUEST headInfo = new IFFI015_BGT_S_DTIN_REQUEST();
				IFFI015_BGT_S_DT dt = new IFFI015_BGT_S_DT();
		    	
		    	// 회사코드
		        System.out.println("회사코드::" + paramMap.get("SB_COMP_CD").toString());
		        System.out.println("사업자번호::" + paramMap.get("POBUSI_NO").toString());
		        
		        dt.setBUKRS(paramMap.get("SB_COMP_CD").toString());
		        dt.setSTCD2(paramMap.get("POBUSI_NO").toString());
		        IFFI015_BGT_SOServiceLocator afs = new IFFI015_BGT_SOServiceLocator();
		        IFFI015_BGT_SOBindingStub af = (IFFI015_BGT_SOBindingStub)afs.getHTTP_Port();
		        IFFI015_BGT_S_DT_response res = new IFFI015_BGT_S_DT_response();
		    	
		    	// USER ID/PW 셋팅
	        	// USER ID/PW 셋팅
	           	String sapId= PropertiesUtil.getProperty("sap.id");
	           	String sapPw= PropertiesUtil.getProperty("sap.pw");
	           	af.setUsername(sapId);
	           	af.setPassword(sapPw);
	           	
	           	//af.setUsername("if_po");
	           	//af.setPassword("init1234!"); 	           	
		       	
		       	res = af.IFFI015_BGT_SO(dt);
		       	
		       	int headLen = 0;
		   		if (null != res.getOUT_HEAD()) {
		   			headLen = res.getOUT_HEAD().length;
		   		}
		   		
		   		System.out.println("headLen::" + headLen);
		   		
		   		IFFI015_BGT_S_DT_responseOUT_HEAD[] headRow = new IFFI015_BGT_S_DT_responseOUT_HEAD[headLen];
		       	List<Map<String, Object>> headList         = new ArrayList<Map<String, Object>>();
		       	
		   		if (headLen > 0) {
		   			headRow = res.getOUT_HEAD();
		   			
		           	for (IFFI015_BGT_S_DT_responseOUT_HEAD headData : headRow) {
		           		Map<String, Object> headMap = new HashMap<String,Object>();
		                for (Field field : headData.getClass().getDeclaredFields()) {
		                    field.setAccessible(true);
		                    headMap.put(field.getName(), field.get(headData));
		                    System.out.println("HEAD[" + field.getName() + "-" + field.get(headData) + "]");
		                }           		
		                jsonData.addFields("headMap", headMap);
		           	}
		   		}
		   		
			} else {
				jsonData.setStatus("FAIL");
				jsonData.setErrMsg("기등록된 공급업체가 존재합니다. 확인 후 작업하세요.");				
			}
		
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.setStatus("FAIL");
			jsonData.setErrMsg(e.getMessage());
		}

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
		return jsonData;
	}
	
    @RequestMapping(value = "/com/bdg/sendSapSupReg.do")
    @ResponseBody
    public JsonData sendSapSupReg(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		
            Map<String,Object> returnParam = new HashMap<>();
            
    		Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
            List<Map<String, Object>> updList = (List<Map<String, Object>>)dataMap.get("CHECK_LIST");
            
            if (null != updList && 0 < updList.size()) {
                for (Map<String, Object> updData: updList) {
                	
                	Map<String,Object> sendParam = bdgSupRegService.selectSendSapSupReg(updData);
                	
        			// 1. SOAP 통신으로 공급업체  정보 추출 
        			IFFI057_BGT_S_DTIT_VEND[] dataRow   = new IFFI057_BGT_S_DTIT_VEND[1];
        			IFFI057_BGT_S_DTIT_VEND data = new IFFI057_BGT_S_DTIT_VEND();
        			
    				data.setLIFNR(StringUtil.isNullToString(sendParam.get("LIFNR")));
    				data.setRLTYP(StringUtil.isNullToString(sendParam.get("RLTYP")));
    				data.setTYPE(StringUtil.isNullToString(sendParam.get("TYPE")));
    				data.setBUKRS(StringUtil.isNullToString(sendParam.get("BUKRS")));
    				data.setNAME1(StringUtil.isNullToString(sendParam.get("NAME1")));
    				data.setEKORG(StringUtil.isNullToString(sendParam.get("EKORG")));
    				data.setKTOKK(StringUtil.isNullToString(sendParam.get("KTOKK")));
    				data.setNAME1(StringUtil.isNullToString(sendParam.get("NAME1")));
    				data.setNAME2(StringUtil.isNullToString(sendParam.get("NAME2")));
    				data.setSORTL(StringUtil.isNullToString(sendParam.get("SORTL")));
    				data.setPSTLZ(StringUtil.isNullToString(sendParam.get("PSTLZ")));
    				data.setSTRAS(StringUtil.isNullToString(sendParam.get("STRAS")));
    				data.setORT01(StringUtil.isNullToString(sendParam.get("ORT01")));
    				data.setLAND1(StringUtil.isNullToString("KR"));
    				data.setREGIO(StringUtil.isNullToString(sendParam.get("REGIO")));
    				data.setSPRAS(StringUtil.isNullToString("KO"));
    				data.setTELF1(StringUtil.isNullToString(sendParam.get("TELF1")));
    				data.setTELFX(StringUtil.isNullToString(sendParam.get("TELFX")));
    				data.setSMTP_ADDR(StringUtil.isNullToString(sendParam.get("SMTP_ADDR")));
    				data.setBPKIND(StringUtil.isNullToString(sendParam.get("BPKIND")));
    				data.setVBUND(StringUtil.isNullToString(""));
    				data.setDATAB(StringUtil.isNullToString(sendParam.get("DATAB")));
    				data.setTAXTYPE(StringUtil.isNullToString(sendParam.get("TAXTYPE")));
    				data.setSTCD1(StringUtil.isNullToString(sendParam.get("STCD1")));
    				System.out.println("STCD2 ::" + StringUtil.isNullToString(sendParam.get("STCD2")));
    				data.setSTCD2(StringUtil.isNullToString(sendParam.get("STCD2")));
    				data.setREPRESN(StringUtil.isNullToString(sendParam.get("REPRESN")));
    				data.setGESTYPN(StringUtil.isNullToString(sendParam.get("GESTYPN")));
    				data.setINDTYPN(StringUtil.isNullToString(sendParam.get("INDTYPN")));
    				data.setAKONT(StringUtil.isNullToString(sendParam.get("AKONT")));
    				data.setZUAWA(StringUtil.isNullToString("100"));
    				data.setZTERM(StringUtil.isNullToString(sendParam.get("ZTERM")));
    				data.setREPRF(StringUtil.isNullToString("X"));
    				data.setZWELS(StringUtil.isNullToString(sendParam.get("ZWELS")));
    				data.setEIKTO(StringUtil.isNullToString(sendParam.get("EIKTO")));
    				data.setZSABE(StringUtil.isNullToString(sendParam.get("ZSABE")));
    				data.setTLFNS(StringUtil.isNullToString(sendParam.get("TLFNS")));
    				data.setTLFXS(StringUtil.isNullToString(sendParam.get("TLFXS")));
    				data.setINTAD(StringUtil.isNullToString(sendParam.get("INTAD")));
    				data.setWAERS(StringUtil.isNullToString(sendParam.get("WAERS"))); 
    				
    				dataRow[0] = data;
    	            
    	            IFFI057_BGT_SOServiceLocator sl = new IFFI057_BGT_SOServiceLocator();
    	            IFFI057_BGT_SOBindingStub bs    = (IFFI057_BGT_SOBindingStub)sl.getHTTP_Port();
    	        	
		        	// USER ID/PW 셋팅
		           	String sapId= PropertiesUtil.getProperty("sap.id");
		           	String sapPw= PropertiesUtil.getProperty("sap.pw");
    	        	// USER ID/PW 셋팅
    	        	bs.setUsername(sapId);
    	        	bs.setPassword(sapPw); 
    	        	
    	        	IFFI057_BGT_S_DT_responseRETURN[] res = bs.IFFI057_BGT_SO(dataRow);
    	        	
    	        	String IF_FLAG  = "";
    	        	String IF_MSG   = "";
    	        	String IF_LIFNR = "";
    	        	
    	        	int failCnt = 0;
    	        	// 리턴 개수별로 확인
    	        	for (int i=0; i < res.length; i++) {
    	        		IF_FLAG  = StringUtil.isNullToString(res[i].getIF_FLAG());
    	        		IF_MSG   = StringUtil.isNullToString(res[i].getIF_MSG());
    	        		IF_LIFNR = StringUtil.isNullToString(res[i].getLIFNR());
    	        		System.out.println("-------------------------------------");
    	        		System.out.println("R IF_FLAG::" + IF_FLAG);
    	        		System.out.println("R IF_MSG::" + IF_MSG);
    	        		System.out.println("R IF_LIFNR::" + IF_LIFNR);
    	        		
        	        	if (!"S".equals(IF_FLAG)) {
        	        		failCnt++;
        	        	} else {
        	        		updData.put("VENDOR_CD", IF_LIFNR);
        	        	}
    	        	}
    	        	
    	        	// 모두 성공한 경우에만 재전송
    	        	if (failCnt == 0) {
    	        		Map<String, Object> responseMap = bdgSupRegService.updateStatusSupReg(updData);
    	        	} else {
    	        		jsonData.setStatus("FAIL");
    	        		jsonData.setErrMsg(IF_MSG);
    	        		break;
    	        	}
                }
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
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/com/bdg/selectSupRegM.do")
	@ResponseBody
	public JsonData selectSupRegM(@RequestBody Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		JsonData jsonData = new JsonData();
		
		try {
			
			List<Map<String, Object>> dataList = bdgSupRegService.selectSupRegM(paramMap);
			jsonData.setStatus("SUCC");
			jsonData.setRows(dataList);
			
		} catch (Exception e) {
			logger.error("대외경조관리 조회 오류", e);
		}
		
		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
		return jsonData;
	}
	
	@RequestMapping(value = "/com/bdg/saveSupReg.do")
	@ResponseBody
	public JsonData saveSupReg(@RequestBody Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		JsonData jsonData = new JsonData();
		try {
			Map<String, Object> responseMap = bdgSupRegService.saveSupReg(paramMap);

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

	@RequestMapping(value = "/com/bdg/applySupReg.do")
	@ResponseBody
	public JsonData applySupReg(@RequestBody Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		JsonData jsonData = new JsonData();
		try {

			Map<String, Object> responseMap = bdgSupRegService.applySupReg(paramMap);

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
	
	@RequestMapping(value = "/com/bdg/applyCancelSupReg.do")
	@ResponseBody
	public JsonData applyCancelSupReg(@RequestBody Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		JsonData jsonData = new JsonData();
		try {
			
			Map<String, Object> responseMap = bdgSupRegService.applyCancelSupReg(paramMap);
			
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

	@RequestMapping(value = "/com/bdg/returnSupReg.do")
	@ResponseBody
	public JsonData returnSupReg(@RequestBody Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		JsonData jsonData = new JsonData();
		try {
			Map<String, Object> responseMap = bdgSupRegService.returnSupReg(paramMap);

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

	
	@RequestMapping(value = "/com/bdg/delSupReg.do")
	@ResponseBody
	public JsonData delSupReg(@RequestBody Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		JsonData jsonData = new JsonData();
		try {

			Map<String, Object> responseMap = bdgSupRegService.delSupReg(paramMap);

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

}
