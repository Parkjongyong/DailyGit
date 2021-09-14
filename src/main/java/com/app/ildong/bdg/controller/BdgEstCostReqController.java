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

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.http.HttpStatus;
import org.springframework.jdbc.BadSqlGrammarException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.app.ildong.bdg.service.BdgEstCostReqService;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.JsonData;
import com.app.ildong.common.model.mvc.BaseController;
import com.app.ildong.common.service.CommonSelectService;
import com.app.ildong.common.util.PropertiesUtil;
import com.app.ildong.common.util.StringUtil;
import com.ildong.CO.BGT_ERP.IFCO011_BGT_SOBindingStub;
import com.ildong.CO.BGT_ERP.IFCO011_BGT_SOServiceLocator;
import com.ildong.CO.BGT_ERP.IFCO011_BGT_S_DTITEM;
import com.ildong.CO.BGT_ERP.IFCO011_BGT_S_DT_response;

@Controller
public class BdgEstCostReqController extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(BdgEstCostReqController.class);
    
    private static final String sysErrMsg = "시스템 오류가 발생하였습니다.";
    
	@Autowired
    private CommonSelectService commonSelectService;
	
    @Autowired 
    private BdgEstCostReqService bdgEstCostReqService;
    
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/bdg/bdgEstCostReq.do")
    public String bdgEstCostReq(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
    		model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001","YS024", "YS001"}));
    		model.putAll(commonSelectService.selectRequestItemList(paramMap));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
        return "com/bdg/bdgEstCostReq";
    }
    
    
    @RequestMapping("/com/bdg/bdgEstCostDetail.do")
    public String bdgEstCostReqPop(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
    		model.addAttribute("PARAM", paramMap);
    		model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001","YS024","YS030"}));
    		model.putAll(commonSelectService.selectRequestItemList(paramMap));
			
    	} catch (ServiceException e) {
    		e.printStackTrace();
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return "com/bdg/bdgEstCostDetail";
    }
    
    @RequestMapping("/com/bdg/bdgEstCostDetailResult.do")
    public String bdgEstCostDetailSap(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
    		model.addAttribute("PARAM", paramMap);
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return "com/bdg/bdgEstCostDetailResult";
    }
    
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/com/bdg/selectEstCostReqList.do")
    @ResponseBody
    public JsonData selectEstCostReqList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData  = new JsonData();

        try {

            List<Map<String,Object>> dataList  = bdgEstCostReqService.selectEstCostReqList(paramMap);
            jsonData.setStatus("SUCC");
            jsonData.setRows(dataList);
            
        } catch (Exception e) {
            logger.error("견적원가 조회 오류", e);
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        return jsonData;
    }
    
    
    @RequestMapping(value = "/com/bdg/saveEstCostReq.do")
    @ResponseBody
    public JsonData saveEstCostReq(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws ServiceException, Exception {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		Map<String,Object> responseMap = bdgEstCostReqService.saveEstCostReq(paramMap);
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
    
    @RequestMapping(value = "/com/bdg/deleteEstCostReq.do")
    @ResponseBody
    public JsonData deleteEstCostReq(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		// 삭제  로직 수행
    		Map<String,Object> responseMap = bdgEstCostReqService.deleteEstCostReq(paramMap);
    		
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

    
    @RequestMapping(value = "/com/bdg/selectEstCostReqDetail.do")
    @ResponseBody
    public JsonData selectEstCostReqDetail(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData  = new JsonData();

        try {

            List<Map<String,Object>> dataList  = bdgEstCostReqService.selectEstCostReqDetail(paramMap);
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
    
    @RequestMapping(value = "/com/bdg/deleteEstCostDetail.do")
    @ResponseBody
    public JsonData deleteEstCostDetail(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		// 삭제  로직 수행
    		Map<String,Object> responseMap = bdgEstCostReqService.deleteEstCostDetail(paramMap);
    		
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
    
    
    @RequestMapping(value = "/com/bdg/apprEstCost.do")
    @ResponseBody
    public JsonData apprEstCost(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		
			Map<String,Object> resultMap = bdgEstCostReqService.apprEstCost(paramMap);
			
    		jsonData.setStatus("SUCC");
    		jsonData.addFields("result", resultMap);
        		
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
    
    /**
     * @function 전자결재 시스템에서 승인과정 UPDATE 정보 전송
     */    
    @RequestMapping("/com/bdg/bdgEstCostReqEps.do")
    @ResponseStatus(value = HttpStatus.OK)
    public JsonData bdgEstCostEps(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	
    	JsonData jsonData = new JsonData();
    	
    	try {
			if (!"".equals(paramMap.get("EPS_DOC_NO")) && null != paramMap.get("EPS_DOC_NO")) {
				
				// 결재완료인 경우  SAP전송
				if ("COMPLETE".equals(paramMap.get("appstatus").toString())) {
					
					bdgEstCostReqService.updateEstCostReqStatus6All(paramMap);	
					// SAP전송 대상 추출
					List<Map<String,Object>> dataList  = bdgEstCostReqService.selectSendEstCostReqList(paramMap);
					
					String ifFlag = "";
					String ifMgs  = "";
					int errCnt = 0;
					
					for (Map<String, Object> data: dataList) {
						// 1. SOAP 통신으로 견적원가의뢰  정보 송신 
						IFCO011_BGT_S_DTITEM item = new IFCO011_BGT_S_DTITEM();
						IFCO011_BGT_S_DTITEM[] items = new IFCO011_BGT_S_DTITEM[1]; 
						item.setBUKRS(StringUtil.isNullToString(data.get("BUKRS")));
						item.setZCONO(StringUtil.isNullToString(data.get("ZCONO")));
						item.setZSEQ(StringUtil.isNullToString(data.get("ZSEQ")));
						item.setBMODEL(StringUtil.isNullToString(data.get("BMODEL")));
						item.setZCONO_TXT(StringUtil.isNullToString(data.get("ZCONO_TXT")));
						items[0] = item;
						
						IFCO011_BGT_SOServiceLocator sl = new IFCO011_BGT_SOServiceLocator();
						IFCO011_BGT_SOBindingStub bs    = (IFCO011_BGT_SOBindingStub)sl.getHTTP_Port();
			        	
			        	// USER ID/PW 셋팅
			        	// USER ID/PW 셋팅
			           	String sapId= PropertiesUtil.getProperty("sap.id");
			           	String sapPw= PropertiesUtil.getProperty("sap.pw");
			           	bs.setUsername(sapId);
			           	bs.setPassword(sapPw);
			           	
			           	IFCO011_BGT_S_DT_response res   = new IFCO011_BGT_S_DT_response();
			        	res = bs.IFCO011_BGT_SO(items);
			        	
			           	ifFlag = StringUtil.isNullToString(res.getIF_FLAG());
			           	ifMgs  = StringUtil.isNullToString(res.getIF_MSG());
			           	
			           	// 성공한 경우 상태코드 업데이트
			           	if (!"S".equals(ifFlag)) {
			           		errCnt++;
			           		data.put("REMARK", ifMgs);
							// 상태 기록 남기기
			           		bdgEstCostReqService.updateEstCostReqStatus6(data);			           		
			           	} else {
			           		bdgEstCostReqService.updatSendFlag(data);
			           	}
					}
					
					// 에러없이 전체 성공해야지 상태변경 처리
					if (errCnt == 0) {
		           		// 상태 기록 남기기
						bdgEstCostReqService.saveEpsHistory(paramMap);						
					}
				} else {
					bdgEstCostReqService.saveEpsHistory(paramMap);
				}
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
    @RequestMapping("/com/bdg/bdgEstCostReqPop.do")
    public String bdgEstCostEpsPop(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
    		model.addAttribute("PARAM", paramMap);
    		model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001","YS024"}));
    		model.putAll(commonSelectService.selectRequestItemList(paramMap));
    	} catch (ServiceException e) {
    		e.printStackTrace();
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return "com/bdg/bdgEstCostReqPop";
    }

    /**
     * @function 전자결재 시스템에서 팝업 활성화 후 데이터 조회
     */      
	@RequestMapping(value = "/com/bdg/selectEstCostReqListPop.do")
	@ResponseBody
	public JsonData selectEstCostReqListPop(@RequestBody Map<String, Object> paramMap, HttpServletRequest request,ModelMap model) {
		JsonData jsonData = new JsonData();

		try {

			List<Map<String, Object>> dataList = bdgEstCostReqService.selectEstCostReqListPop(paramMap);
			jsonData.setStatus("SUCC");
			jsonData.setRows(dataList);

		} catch (Exception e) {
			logger.error("견적원가 조회 오류", e);
		}

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
		return jsonData;
	}    

    @RequestMapping(value = "/com/bdg/selectEstCostCnt.do")
    @ResponseBody
    public JsonData selectEstCostCnt(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData  = new JsonData();

        try {

            Map<String,Object> cntMap  = bdgEstCostReqService.selectEstCostCnt(paramMap);
            jsonData.addFields("CNT", cntMap.get("CNT"));
            jsonData.setStatus("SUCC");
            
        } catch (Exception e) {
            logger.error("견적원가의뢰 RESULT 조회 오류", e);
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        return jsonData;
    }
	
    @RequestMapping(value = "/com/bdg/selectEstCostReqDetailResult.do")
    @ResponseBody
    public JsonData selectEstCostReqDetailResult(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData  = new JsonData();

        try {
            List<Map<String,Object>> dataList  = bdgEstCostReqService.selectEstCostReqDetailResult(paramMap);
            jsonData.setStatus("SUCC");
            jsonData.setRows(dataList);
            
        } catch (Exception e) {
            logger.error("견적내용 조회 오류", e);
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        return jsonData;
    }
    
}
