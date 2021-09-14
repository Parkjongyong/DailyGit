/**
 * APM예산이관신청 조회/저장/삭제/확정/재작성요청/SAP전송
 * @author 길용덕
 * @since 2020.08.28
 * 
 * << 개정이력(Modification Information) >>
 *  ------------------------------------------------- 
 *  수정일                    수정자            수정내용
 *  ----------   -------- ---------------------------
 *  2020.08.28   길용덕            최초생성
 *  -------------------------------------------------
 */
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
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.app.ildong.bdg.service.BdgApmTransMgtService;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.JsonData;
import com.app.ildong.common.model.mvc.BaseController;
import com.app.ildong.common.service.CommonSelectService;
import com.app.ildong.common.util.PropertiesUtil;
import com.app.ildong.common.util.StringUtil;
import com.ildong.CO.BGT_ERP.IFCO014_BGT_SOBindingStub;
import com.ildong.CO.BGT_ERP.IFCO014_BGT_SOServiceLocator;
import com.ildong.CO.BGT_ERP.IFCO014_BGT_S_DTITEM;
import com.ildong.CO.BGT_ERP.IFCO014_BGT_S_DT_response;
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
public class BdgApmTransMgtController extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(BdgApmTransMgtController.class);
    
    private static final String sysErrMsg = "시스템 오류가 발생하였습니다.";
    
	@Autowired
    private CommonSelectService commonSelectService;
	
    @Autowired 
    private BdgApmTransMgtService bdgApmTransMgtService;
    
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/bdg/bdgApmTransMgt.do")
    public String bdgApmTransMgt(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
			model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001","YS011","YS012","E102"}));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
        return "com/bdg/bdgApmTransMgt";
    }
    
    @RequestMapping("/com/bdg/bdgApmTransMgtM.do")
    public String bdgApmTransMgtM(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
    		model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001","YS011","YS012","E102"}));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
        return "com/bdg/bdgApmTransMgtM";
    } 
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/com/bdg/selectApmTransMgtHeadList.do")
    @ResponseBody
    public JsonData selectApmTransMgtHeadList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData  = new JsonData();

        try {

            List<Map<String,Object>> dataList  = bdgApmTransMgtService.selectApmTransMgtHeadList(paramMap);
            jsonData.setStatus("SUCC");
            jsonData.setRows(dataList);
            
        } catch (Exception e) {
            logger.error("APM예산이관신청/관리 조회 오류", e);
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        return jsonData;
    }
    
    @RequestMapping(value = "/com/bdg/selectApmTransMgtDetailList.do")
    @ResponseBody
    public JsonData selectApmTransMgtDetailList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData  = new JsonData();

        try {

            List<Map<String,Object>> dataList  = bdgApmTransMgtService.selectApmTransMgtDetailList(paramMap);
            jsonData.setStatus("SUCC");
            jsonData.setRows(dataList);
            
        } catch (Exception e) {
            logger.error("APM예산이관신청/관리 상세조회 오류", e);
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        return jsonData;
    }
    
    @RequestMapping(value = "/com/bdg/saveApmTransMgt.do")
    @ResponseBody
    public JsonData saveApmTransMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws ServiceException, Exception {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		Map<String,Object> responseMap = bdgApmTransMgtService.saveApmTransMgt(paramMap);
    		
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
    
    @RequestMapping(value = "/com/bdg/deleteApmTransMgt.do")
    @ResponseBody
    public JsonData deleteApmTransMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		// 삭제  로직 수행
    		Map<String,Object> responseMap = bdgApmTransMgtService.deleteApmTransMgt(paramMap);
    		
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
    
    @RequestMapping(value = "/com/bdg/apprApmTransMgt.do")
    @ResponseBody
    public JsonData apprApmTransMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		// 승인요청 전 상태 체크
    		Map<String,Object> statusMap = bdgApmTransMgtService.selectStatusHeader(paramMap);
    		String status = StringUtil.isNullToString(statusMap.get("STATUS"));
    		
    		// 작성중 상태인경우만 승인 요청가능(회수 절차로 인해 작성중으로 변경하여 재상신 가능!!)
    		if ("1".equals(status)) {
    			Map<String,Object> resultMap = bdgApmTransMgtService.apprApmBasicMgt(paramMap);
    			
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
    
    @RequestMapping(value = "/com/bdg/returnApmTransMgt.do")
    @ResponseBody
    public JsonData returnApmTransMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws ServiceException, Exception {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		Map<String,Object> resultMap1 = bdgApmTransMgtService.saveApmTransMgt(paramMap);
    		
    		if (!"Y".equals(resultMap1.get("SUCC_YN").toString())) {
        		jsonData.setStatus("FAIL");
        		jsonData.setErrMsg(resultMap1.get("ERR_MSG").toString());
        		jsonData.addFields("result", resultMap1);
    		} else {
        		// 재작성확정  로직 수행
        		Map<String,Object> resultMap2 = bdgApmTransMgtService.updatApmTransMgtStatus(paramMap);    		
        		
        		if (!"Y".equals(resultMap2.get("SUCC_YN").toString())) {
            		jsonData.setStatus("FAIL");
            		jsonData.setErrMsg(resultMap2.get("ERR_MSG").toString());
            		jsonData.addFields("result", resultMap2);
        		} else {
            		jsonData.setStatus("SUCC");
            		jsonData.addFields("result", resultMap2);
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
    
    
    @RequestMapping(value = "/com/bdg/rejectApmTransMgt.do")
    @ResponseBody
    public JsonData rejectApmTransMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		Map<String,Object> statusMap = bdgApmTransMgtService.selectStatusCnt(paramMap);
    		String cnt = StringUtil.isNullToString(statusMap.get("CNT"));
    		Map<String,Object> responseMap = new HashMap<>();
    		
    		if ("0".equals(cnt)) {
    			responseMap = bdgApmTransMgtService.rejectApmTransMgt(paramMap);
        		jsonData.setStatus("SUCC");
        		jsonData.addFields("result", responseMap);
    		} else {
        		jsonData.setStatus("FAIL");
        		jsonData.setErrMsg("SAP에 전송된 데이터는 반려처리 불가합니다.");
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
    
    
    @RequestMapping(value = "/com/bdg/updatApmTransMgtStatus.do")
    @ResponseBody
    public JsonData updatApmTransMgtStatus(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		// 확정/재작성요청  로직 수행
    		Map<String,Object> responseMap = bdgApmTransMgtService.updatApmTransMgtStatus(paramMap);
    		
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
    
    @RequestMapping(value = "/com/bdg/sendApmTransMgt.do")
    @ResponseBody
    public JsonData sendApmTransMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		// 전송 데이터 추출
    		paramMap.put("CRE_USER" , getUserId());
    		List<Map<String,Object>> dataList  = bdgApmTransMgtService.selectSendApmTransData(paramMap);
			String ifFlag = "";
			String ifMgs  = "";
    		// SAP전송 시작
            if (!dataList.isEmpty()) {
	            
	            if (dataList.size() > 0) {
					// 1. SOAP 통신으로 승인셰산정보  정보 송신 
	            	IFFI019_BGT_S_DTIN_APM[] sendBugtRow = new IFFI019_BGT_S_DTIN_APM[dataList.size()];
					
					int rowCnt = 0;
		           	for (Map<String, Object> sendBugtMap : dataList) {
		           		IFFI019_BGT_S_DTIN_APM sendBugt = new IFFI019_BGT_S_DTIN_APM();
		           		
		                sendBugt.setBUKRS(StringUtil.isNullToString(sendBugtMap.get("BUKRS")));
		                sendBugt.setZMONTH(StringUtil.isNullToString(sendBugtMap.get("ZMONTH")));
		                sendBugt.setLEGACYNO(StringUtil.isNullToString(sendBugtMap.get("LEGACYNO")));
		                sendBugt.setZBUGTYPE(StringUtil.isNullToString(sendBugtMap.get("ZBUGTYPE")));
		                sendBugt.setZTNR(StringUtil.isNullToString(sendBugtMap.get("ZTNR")));
		                sendBugt.setZUPIND(StringUtil.isNullToString(sendBugtMap.get("ZUPIND")));
		                sendBugt.setZCHANN(StringUtil.isNullToString(sendBugtMap.get("ZCHANN")));
		                sendBugt.setKOSTL(StringUtil.isNullToString(sendBugtMap.get("KOSTL")));
		                sendBugt.setLIFNR(StringUtil.isNullToString(sendBugtMap.get("LIFNR")));
		                sendBugt.setZAPMBUGAMT(StringUtil.isNullToString(sendBugtMap.get("ZAPMBUGAMT")));
		                sendBugt.setZTRDATE(StringUtil.isNullToString(sendBugtMap.get("ZTRDATE")));
		                sendBugt.setZTFSENDAMT(StringUtil.isNullToString(sendBugtMap.get("ZTFSENDAMT")));
		                sendBugt.setZTFRECVAMT(StringUtil.isNullToString(sendBugtMap.get("ZTFRECVAMT")));
		                sendBugt.setZLIFNR(StringUtil.isNullToString(sendBugtMap.get("ZLIFNR")));
		                sendBugt.setZCRDATE(StringUtil.isNullToString(sendBugtMap.get("ZCRDATE")));
		                
		                sendBugtRow[rowCnt] = sendBugt;
		                rowCnt++;
		           	}
		           	
					// 1. SOAP 통신으로 공급업체  정보 추출 
		           	IFFI019_BGT_SOServiceLocator sl = new IFFI019_BGT_SOServiceLocator();
		           	IFFI019_BGT_SOBindingStub bs    = (IFFI019_BGT_SOBindingStub)sl.getHTTP_Port();
		           	IFFI019_BGT_S_DT_response res   = new IFFI019_BGT_S_DT_response();
		        	
		        	// USER ID/PW 셋팅
		           	String sapId= PropertiesUtil.getProperty("sap.id");
		           	String sapPw= PropertiesUtil.getProperty("sap.pw");
		           	bs.setUsername(sapId);
		           	bs.setPassword(sapPw);
		        	
		        	res = bs.IFFI019_BGT_SO(sendBugtRow);
		           	ifFlag = StringUtil.isNullToString(res.getIF_FLAG());
		           	ifMgs  = StringUtil.isNullToString(res.getIF_MSG());
		           	
		           	// 성공유무 확인
		           	if ("S".equals(ifFlag)) {
		           		// 상태코드 업데이트
		        		// 확정/확정취소  로직 수행
		           		paramMap.put("ITEM_LIST", dataList);
		        		Map<String,Object> responseMap = bdgApmTransMgtService.updatApmTransMgtStatus2(paramMap);
		        		
		        		if ("N".equals(responseMap.get("SUCC_YN"))) {
		        			throw new Exception(responseMap.get("ERR_MSG").toString()); 
		        		}
		           	} else if ("E".equals(ifFlag)) {
                		throw new Exception(ifMgs);  
		           	}
		           	
		    		jsonData.setStatus("SUCC");
		    		jsonData.addFields("result", paramMap);
		    		
	            } else {
	        		jsonData.setStatus("FAIL");
	        		jsonData.setErrMsg("SAP전송할 데이터가 존재하지 않습니다.");
	        		jsonData.addFields("result", paramMap);
	            }
	    		
            } else {
        		jsonData.setStatus("FAIL");
        		jsonData.setErrMsg("SAP전송할 데이터가 존재하지 않습니다.");
        		jsonData.addFields("result", paramMap);
            }
    		
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

    @RequestMapping(value = "/com/bdg/selectApmTransBalAmt.do")
    @ResponseBody
    public JsonData selectApmTransBalAmt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws ServiceException, Exception {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		// 1. SOAP 통신으로 공급업체  정보 추출 
    		IFFI054_BGT_S_DTIN_REQUEST headInfo = new IFFI054_BGT_S_DTIN_REQUEST();
    		IFFI054_BGT_S_DT dt = new IFFI054_BGT_S_DT();
        	String ifFlag = "";
        	String ifMgs  = "";
        	// 회사코드
        	headInfo.setBUKRS(paramMap.get("COMP_CD").toString());
            System.out.println("회사코드::" + paramMap.get("COMP_CD").toString());
            //회계연도
            headInfo.setZMONTH(paramMap.get("CRTN_YYMM").toString().replace("-", ""));
            System.out.println("회계연도::" + paramMap.get("CRTN_YYMM").toString().replace("-", ""));
            //부문
            headInfo.setZCHANN(paramMap.get("CHC_ETC_GBN").toString().substring(0, 1));
            System.out.println("부문::" + paramMap.get("CHC_ETC_GBN").toString().substring(0, 1));
            //사원코드
            headInfo.setLIFNR(paramMap.get("SEND_SABUN").toString());
            System.out.println("사원코드::" + paramMap.get("SEND_SABUN").toString());
            
            dt.setIN_REQUEST(headInfo);
            IFFI054_BGT_SOServiceLocator afs = new IFFI054_BGT_SOServiceLocator();
            IFFI054_BGT_SOBindingStub af = (IFFI054_BGT_SOBindingStub)afs.getHTTP_Port();
            IFFI054_BGT_S_DT_response res = new IFFI054_BGT_S_DT_response();
        	
        	// USER ID/PW 셋팅
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
//           	List<Map<String, Object>> apmIfList         = new ArrayList<Map<String, Object>>();
       		Map<String, Object> apmIfMap = new HashMap<String,Object>();
           	
       		if (apmIfLen > 0) {
       			apmIfRow = res.getOUT_APM();
       			
	           	for (IFFI054_BGT_S_DT_responseOUT_APM apmIf : apmIfRow) {
	                for (Field field : apmIf.getClass().getDeclaredFields()) {
	                    field.setAccessible(true);
	                    // 금액 음수 체크
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
//	                apmIfList.add(apmIfMap);
	           	}
       		}
       		
    		jsonData.setStatus("SUCC");
    		jsonData.addFields("result", apmIfMap);	
    		
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
    @RequestMapping("/com/bdg/bdgApmTransMgtEps.do")
    @ResponseStatus(value = HttpStatus.OK)
    public JsonData bdgApmTransMgtEps(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	
    	JsonData jsonData = new JsonData();
    	
    	try {
			if (!"".equals(paramMap.get("EPS_DOC_NO")) && null != paramMap.get("EPS_DOC_NO")) {
				bdgApmTransMgtService.saveEpsHistory(paramMap);
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
    @RequestMapping("/com/bdg/bdgApmTransMgtPop.do")
    public String bdgApmTransMgtPop(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
    		model.addAttribute("PARAM", paramMap);
    		model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001","YS011","YS012","E102"}));
    	} catch (ServiceException e) {
    		e.printStackTrace();
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return "com/bdg/bdgApmTransMgtPop";
    }

    /**
     * @function 전자결재 시스템에서 팝업 활성화 후 데이터 조회
     */      
	@RequestMapping(value = "/com/bdg/selectApmTransMgtPop.do")
	@ResponseBody
	public JsonData selectApmTransMgtPop(@RequestBody Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		JsonData jsonData = new JsonData();

		try {

			List<Map<String, Object>> dataList = bdgApmTransMgtService.selectApmTransMgtPop(paramMap);
			jsonData.setStatus("SUCC");
			jsonData.setRows(dataList);

		} catch (Exception e) {
			logger.error("APM예산 조회 오류", e);
		}

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
		return jsonData;
	}    
}
