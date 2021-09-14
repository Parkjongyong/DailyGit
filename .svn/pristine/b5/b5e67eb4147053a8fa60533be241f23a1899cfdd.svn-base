/**
 * 유형자산투자계획 조회/저장/생성/승인요청/반려/SAP전송 컨트롤러
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
import org.springframework.web.bind.annotation.ResponseStatus;

import com.app.ildong.bdg.service.BdgTangAssetMgtService;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.JsonData;
import com.app.ildong.common.model.mvc.BaseController;
import com.app.ildong.common.service.CommonSelectService;
import com.app.ildong.common.util.PropertiesUtil;
import com.app.ildong.common.util.StringUtil;
import com.ildong.CO.BGT_ERP.IFCO003_BGT_SOBindingStub;
import com.ildong.CO.BGT_ERP.IFCO003_BGT_SOServiceLocator;
import com.ildong.CO.BGT_ERP.IFCO003_BGT_S_DTITEM;
import com.ildong.CO.BGT_ERP.IFCO003_BGT_S_DT_response;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.http.HttpStatus;
import org.springframework.jdbc.BadSqlGrammarException;
import org.springframework.dao.DataIntegrityViolationException;

@Controller
public class BdgTangAssetMgtController extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(BdgTangAssetMgtController.class);
    
    private static final String sysErrMsg = "시스템 오류가 발생하였습니다.";
    
	@Autowired
    private CommonSelectService commonSelectService;
	
    @Autowired 
    private BdgTangAssetMgtService bdgTangAssetMgtService;
    
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/bdg/bdgTangAssetMgt.do")
    public String bdgTangAssetMgt(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
    		model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001", "YS001", "YS002", "YS003", "YS004", "E102", "YS039"}));
			model.putAll(commonSelectService.selectCompList());
			model.putAll(commonSelectService.selectCostList());    		
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
        return "com/bdg/bdgTangAssetMgt";
    }
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/bdg/bdgTangAssetMgtM.do")
    public String bdgTangAssetMgtM(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
    		model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001", "YS001", "YS002", "YS003", "YS004", "E102"}));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
        return "com/bdg/bdgTangAssetMgtM";
    }    
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/com/bdg/selectTangAssetMgtHeadList.do")
    @ResponseBody
    public JsonData selectTangAssetMgtHeadList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData  = new JsonData();
        JsonData jsonData2 = new JsonData();

        try {

            List<Map<String,Object>> dataList  = bdgTangAssetMgtService.selectTangAssetMgtHeadList(paramMap);
            List<Map<String,Object>> totalList = bdgTangAssetMgtService.selectTangAssetTotalList(paramMap);
            jsonData.setStatus("SUCC");
            jsonData.setRows(dataList);
            jsonData2.setStatus("SUCC");
            jsonData2.setRows(totalList);
            jsonData.addFields("result", jsonData2);
            
        } catch (Exception e) {
            logger.error("유형자산투자계획 헤더/합계 조회 오류", e);
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        return jsonData;
    }
    

    
    @RequestMapping(value = "/com/bdg/saveTangAssetMgt.do")
    @ResponseBody
    public JsonData saveTangAssetMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws ServiceException, Exception {
    	JsonData jsonData = new JsonData();
    	try {
    		checkEndData(paramMap);
    		Map<String,Object> responseMap = bdgTangAssetMgtService.saveTangAssetMgt(paramMap);
    		
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
    
    @RequestMapping(value = "/com/bdg/updateTangAssetMgtStatus.do")
    @ResponseBody
    public JsonData updateTangAssetMgtStatus(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		checkEndData(paramMap);
    		// 반려  로직 수행
    		Map<String,Object> responseMap = bdgTangAssetMgtService.updateTangAssetMgtStatus(paramMap);
    		
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
    
    @RequestMapping(value = "/com/bdg/rejectTangAssetMgtStatus.do")
    @ResponseBody
    public JsonData rejectTangAssetMgtStatus(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		checkEndData(paramMap);
    		// 반려  로직 수행
    		Map<String,Object> responseMap = bdgTangAssetMgtService.rejectTangAssetMgtStatus(paramMap);
    		
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
    
    @RequestMapping(value = "/com/bdg/apprTangAssetMgt.do")
    @ResponseBody
    public JsonData apprTangAssetMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		checkEndData(paramMap);
    		// 승인요청 전 상태 체크
    		Map<String,Object> statusMap = bdgTangAssetMgtService.selectStatusHeader(paramMap);
    		String status = StringUtil.isNullToString(statusMap.get("STATUS"));
    		
    		// 작성중 상태인경우만 승인 요청가능(회수 절차로 인해 작성중으로 변경하여 재상신 가능!!)
    		if ("1".equals(status)) {
    			Map<String,Object> resultMap = bdgTangAssetMgtService.apprTangAssetMgt(paramMap);
    			List<Map<String,Object>> dataList = bdgTangAssetMgtService.selectApprList(paramMap);
    			
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
    	
    	
    	if( logger.isDebugEnabled()) {
    		logger.debug("jsonData = " + jsonData);
    	}
    	
    	return jsonData;
    }    
    
    @RequestMapping(value = "/com/bdg/deleteTangAssetData.do")
    @ResponseBody
    public JsonData deleteTangAssetData(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		checkEndData(paramMap);
    		// 예산실적생성
    		Map<String,Object> responseMap = bdgTangAssetMgtService.deleteTangAssetData(paramMap);
    		
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
    
    @RequestMapping(value = "/com/bdg/sendSapTangAssetData.do")
    @ResponseBody
    public JsonData sendSapTangAssetData(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		checkEndData(paramMap);
    		
    		List<Map<String, Object>> sendInvestList = bdgTangAssetMgtService.selectSendAssetData(paramMap);
        	//Map<String, Object> sendItemMap        = (Map<String, Object>) paramMap.get("ITEM_LIST");
        	//List<Map<String, Object>> sendInvestList = (List<Map<String, Object>>) sendItemMap.get("CHECK_LIST");
        	
			String ifFlag = "";
			String ifMgs  = "";
    		
            if (sendInvestList.size() > 0) {
				// 1. SOAP 통신으로 공급업체  정보 추출 
				IFCO003_BGT_S_DTITEM[] sendInvestRow = new IFCO003_BGT_S_DTITEM[sendInvestList.size()];
				
				int rowCnt = 0;
	           	for (Map<String, Object> sendInvestMap : sendInvestList) {
	           		
	           		IFCO003_BGT_S_DTITEM sendInvest = new IFCO003_BGT_S_DTITEM();
	           		
	                sendInvest.setBUKRS(StringUtil.isNullToString(sendInvestMap.get("BUKRS")));
	                sendInvest.setZINVNR(StringUtil.isNullToString(sendInvestMap.get("ZINVNR")));
	                sendInvest.setGJAHR(StringUtil.isNullToString(sendInvestMap.get("GJAHR")));
	                sendInvest.setKTEXT(StringUtil.isNullToString(sendInvestMap.get("KTEXT")));
	                sendInvest.setKOSTV(StringUtil.isNullToString(sendInvestMap.get("KOSTV")));
	                sendInvest.setANLKL(StringUtil.isNullToString(sendInvestMap.get("ANLKL")));
	                sendInvest.setAKTIV(StringUtil.isNullToString(sendInvestMap.get("AKTIV")));
	                sendInvest.setWKG001(StringUtil.isNullToString(sendInvestMap.get("WKG001")));
	                sendInvest.setWKG002(StringUtil.isNullToString(sendInvestMap.get("WKG002")));
	                sendInvest.setWKG003(StringUtil.isNullToString(sendInvestMap.get("WKG003")));
	                sendInvest.setWKG004(StringUtil.isNullToString(sendInvestMap.get("WKG004")));
	                sendInvest.setWKG005(StringUtil.isNullToString(sendInvestMap.get("WKG005")));
	                sendInvest.setWKG006(StringUtil.isNullToString(sendInvestMap.get("WKG006")));
	                sendInvest.setWKG007(StringUtil.isNullToString(sendInvestMap.get("WKG007")));
	                sendInvest.setWKG008(StringUtil.isNullToString(sendInvestMap.get("WKG008")));
	                sendInvest.setWKG009(StringUtil.isNullToString(sendInvestMap.get("WKG009")));
	                sendInvest.setWKG010(StringUtil.isNullToString(sendInvestMap.get("WKG010")));
	                sendInvest.setWKG011(StringUtil.isNullToString(sendInvestMap.get("WKG011")));
	                sendInvest.setWKG012(StringUtil.isNullToString(sendInvestMap.get("WKG012")));
	                sendInvest.setDEL(StringUtil.isNullToString(sendInvestMap.get("DEL")));
	                
	                sendInvestRow[rowCnt] = sendInvest;
	                rowCnt++;
	           	}
	           	
				// 1. SOAP 통신으로 공급업체  정보 추출 
	            IFCO003_BGT_SOServiceLocator sl = new IFCO003_BGT_SOServiceLocator();
	            IFCO003_BGT_SOBindingStub bs    = (IFCO003_BGT_SOBindingStub)sl.getHTTP_Port();
	            IFCO003_BGT_S_DT_response res   = new IFCO003_BGT_S_DT_response();
	        	
	        	// USER ID/PW 셋팅
	           	String sapId= PropertiesUtil.getProperty("sap.id");
	           	String sapPw= PropertiesUtil.getProperty("sap.pw");
	           	bs.setUsername(sapId);
	           	bs.setPassword(sapPw);
	        	
	        	res = bs.IFCO003_BGT_SO(sendInvestRow);
	           	ifFlag = StringUtil.isNullToString(res.getIF_FLAG());
	           	ifMgs  = StringUtil.isNullToString(res.getIF_MSG());
	           	
	           	// 성공유무 확인
	           	if ("S".equals(ifFlag)) {
	           		
	           		// 전송유무 값  UPDATE
	           		bdgTangAssetMgtService.sendSapTangAssetData(paramMap);
	           		
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
    @RequestMapping("/com/bdg/bdgTangAssetMgtEps.do")
    @ResponseBody
    public JsonData bdgTangAssetMgtEps(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
			if (!"".equals(paramMap.get("EPS_DOC_NO")) && null != paramMap.get("EPS_DOC_NO")) {
				bdgTangAssetMgtService.saveEpsHistory(paramMap);
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
	@RequestMapping("/com/bdg/bdgTangAssetMgtPop.do")
	public String bdgTangAssetMgtPop(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		try {
			model.addAttribute("PARAM", paramMap);
    		model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001", "YS001", "YS002", "YS003", "YS004", "E102"}));
			model.putAll(commonSelectService.selectCompListPop(paramMap));
			model.putAll(commonSelectService.selectCostListPop(paramMap));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "com/bdg/bdgTangAssetMgtPop";
	}


    /**
     * @function 전자결재 시스템에서 팝업 활성화 후 데이터 조회
     */      
    @RequestMapping(value = "/com/bdg/selectTangAssetMgtHeadListPop.do")
    @ResponseBody
    public JsonData selectTangAssetMgtHeadListPop(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData  = new JsonData();
        JsonData jsonData2 = new JsonData();

        try {

            List<Map<String,Object>> dataList  = bdgTangAssetMgtService.selectTangAssetMgtHeadListPop(paramMap);
            List<Map<String,Object>> totalList = bdgTangAssetMgtService.selectTangAssetTotalList(paramMap);
            Map<String,Object> epsInfoMap = bdgTangAssetMgtService.selectEpsInfoData(paramMap);
            jsonData.setStatus("SUCC");
            jsonData.setRows(dataList);
            jsonData2.setStatus("SUCC");
            jsonData2.setRows(totalList);
            jsonData.addFields("result", jsonData2);
            jsonData.addFields("epsInfo", epsInfoMap);
            
        } catch (Exception e) {
            logger.error("유형자산투자계획 헤더/합계 조회 오류", e);
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
    @RequestMapping(value = "/com/bdg/selectTangAssetDetailList.do")
    @ResponseBody
    public JsonData selectTangAssetDetailList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();

        try {

            List<Map<String,Object>> dataList = bdgTangAssetMgtService.selectTangAssetDetailList(paramMap);
            
            jsonData.setStatus("SUCC");
            jsonData.setRows(dataList);
            
            jsonData.addFields("result", paramMap);
            
        } catch (Exception e) {
            logger.error("유형자산투자계획 상세 조회 오류", e);
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        return jsonData;
    }    
    
}
