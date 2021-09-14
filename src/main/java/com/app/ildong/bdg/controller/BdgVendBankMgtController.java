/**
 * 공급업체계좌 조회/저장/삭제/승인요청
 * @author 길용덕
 * @since 2020.09.16
 * 
 * << 개정이력(Modification Information) >>
 *  ------------------------------------------------- 
 *  수정일                    수정자            수정내용
 *  ----------   -------- ---------------------------
 *  2020.09.16   길용덕            최초생성
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

import com.app.ildong.bdg.service.BdgVendBankMgtService;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.JsonData;
import com.app.ildong.common.model.mvc.BaseController;
import com.app.ildong.common.service.CommonSelectService;
import com.app.ildong.common.util.PropertiesUtil;
import com.app.ildong.common.util.StringUtil;
import com.ildong.FI.BGT_ERP.IFFI015_BGT_SOBindingStub;
import com.ildong.FI.BGT_ERP.IFFI015_BGT_SOServiceLocator;
import com.ildong.FI.BGT_ERP.IFFI015_BGT_S_DT;
import com.ildong.FI.BGT_ERP.IFFI015_BGT_S_DT_response;
import com.ildong.FI.BGT_ERP.IFFI015_BGT_S_DT_responseOUT_BANK;
import com.ildong.FI.BGT_ERP.IFFI015_BGT_S_DT_responseOUT_HEAD;
import com.ildong.FI.BGT_ERP.IFFI016_BGT_SOBindingStub;
import com.ildong.FI.BGT_ERP.IFFI016_BGT_SOServiceLocator;
import com.ildong.FI.BGT_ERP.IFFI016_BGT_S_DTIN_BANK;
import com.ildong.FI.BGT_ERP.IFFI016_BGT_S_DT_response;

@Controller
public class BdgVendBankMgtController extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(BdgVendBankMgtController.class);
    
    private static final String sysErrMsg = "시스템 오류가 발생하였습니다.";
    
	@Autowired
    private CommonSelectService commonSelectService;
	
    @Autowired 
    private BdgVendBankMgtService bdgVendBankMgtService;
    
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/bdg/bdgVendBankMgt.do")
    public String bdgVendBankMgt(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
			model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001","YS026","YS027","YS019","YS033","YS040"}));
			
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
        return "com/bdg/bdgVendBankMgt";
    }
    
	@RequestMapping(value = "/com/bdg/selectPobusiNo2.do")
	@ResponseBody
	public JsonData selectPobusiNo2(@RequestBody Map<String, Object> paramMap, HttpServletRequest request,
			ModelMap model) {
		JsonData jsonData = new JsonData();
		try {
			
			Map<String,Object> checkParam = bdgVendBankMgtService.selectCheckVendBankMgt(paramMap);
			
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
	           	
	           	//af.setUsername("if_po");
	           	//af.setPassword("init1234!"); 
	           	af.setUsername(sapId);
	           	af.setPassword(sapPw);
		       	
		       	res = af.IFFI015_BGT_SO(dt);
		       	
		       	
		       	int headLen = 0;
		       	int bankLen = 0;
		   		if (null != res.getOUT_HEAD()) {
		   			headLen = res.getOUT_HEAD().length;
		   		}
		   		
		   		if (null != res.getOUT_BANK()) {
		   			bankLen = res.getOUT_BANK().length;
		   		}	   		
		   		
		   		System.out.println("headLen::" + headLen);
		   		System.out.println("bankLen::" + bankLen);
		   		
		   		IFFI015_BGT_S_DT_responseOUT_HEAD[] headRow = new IFFI015_BGT_S_DT_responseOUT_HEAD[headLen];
		       	List<Map<String, Object>> headList         = new ArrayList<Map<String, Object>>();
		       	
		       	IFFI015_BGT_S_DT_responseOUT_BANK[] bankRow = new IFFI015_BGT_S_DT_responseOUT_BANK[bankLen];
		       	List<Map<String, Object>> bankList         = new ArrayList<Map<String, Object>>();	       	
		       	
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
		   		
		   		if (bankLen > 0) {
		   			bankRow = res.getOUT_BANK();
		   			
		           	for (IFFI015_BGT_S_DT_responseOUT_BANK bankData : bankRow) {
		           		Map<String, Object> bankMap = new HashMap<String,Object>();
		                for (Field field : bankData.getClass().getDeclaredFields()) {
		                    field.setAccessible(true);
		                    bankMap.put(field.getName(), field.get(bankData));
		                    System.out.println("BANK[" + field.getName() + "-" + field.get(bankData) + "]");
		                }           		
		                bankList.add(bankMap);
		           	}
		           	jsonData.addFields("bankList", bankList);
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
  
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/com/bdg/selectVendBankMgtHeadList.do")
    @ResponseBody
    public JsonData selectVendBankMgtHeadList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData  = new JsonData();

        try {

            List<Map<String,Object>> dataList  = bdgVendBankMgtService.selectVendBankMgtHeadList(paramMap);
            jsonData.setStatus("SUCC");
            jsonData.setRows(dataList);
            
        } catch (Exception e) {
            logger.error("공급업체계좌 HEADER 조회 오류", e);
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        return jsonData;
    }
    
    @RequestMapping(value = "/com/bdg/selectVendBankMgtDetailList.do")
    @ResponseBody
    public JsonData selectVendBankMgtDetailList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData  = new JsonData();

        try {

            List<Map<String,Object>> dataList  = bdgVendBankMgtService.selectVendBankMgtDetailList(paramMap);
            jsonData.setStatus("SUCC");
            jsonData.setRows(dataList);
            
        } catch (Exception e) {
            logger.error("공급업체계좌 DETAIL 조회 오류", e);
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        return jsonData;
    }
    
    /**
     * @function 전자결재 시스템에서 승인과정 UPDATE 정보 전송
     */     
    @RequestMapping("/com/bdg/bdgVendBankMgtEps.do")
    @ResponseBody
    public JsonData bdgVendBankMgtEps(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	
    	try {
			if (!"".equals(paramMap.get("EPS_DOC_NO")) && null != paramMap.get("EPS_DOC_NO")) {
				
				// 결재완료인 경우  SAP전송
				if ("COMPLETE".equals(paramMap.get("appstatus").toString())) {
					// 실패가 발생할 경우를 대비해서 선행처리(전송이 성공적으로 처리되면 후속 처리함)
					bdgVendBankMgtService.updatVendBankMgtStatus6(paramMap);
					// SAP전송 대상 추출
					List<Map<String,Object>> dataList  = bdgVendBankMgtService.selectSendVendBankData(paramMap);
					
					String ifFlag = "";
					String ifMgs  = "";
					
					IFFI016_BGT_S_DTIN_BANK[] bankList = new IFFI016_BGT_S_DTIN_BANK[dataList.size()];
					int setDataCnt = 0;
					for (Map<String, Object> data: dataList) {
						
						// 1. SOAP 통신으로 공급업체  정보 추출 
						
						IFFI016_BGT_S_DTIN_BANK bankData = new IFFI016_BGT_S_DTIN_BANK();
						System.out.println("PARTNER ::" + StringUtil.isNullToString(data.get("PARTNER")));
						bankData.setPARTNER(StringUtil.isNullToString(data.get("PARTNER")));
						bankData.setBKVID(StringUtil.isNullToString(data.get("BKVID")));
						bankData.setBANKS(StringUtil.isNullToString(data.get("BANKS")));
						bankData.setBANKL(StringUtil.isNullToString(data.get("BANKL")));
						bankData.setBANKN(StringUtil.isNullToString(data.get("BANKN")));
						bankData.setBKREF(StringUtil.isNullToString(data.get("BKREF")));
						bankData.setKOINH(StringUtil.isNullToString(data.get("KOINH")));
						
						bankList[setDataCnt] = bankData;
						setDataCnt++;

					}
					
					IFFI016_BGT_SOServiceLocator sl = new IFFI016_BGT_SOServiceLocator();
					IFFI016_BGT_SOBindingStub bs    = (IFFI016_BGT_SOBindingStub)sl.getHTTP_Port();					
					
		        	// USER ID/PW 셋팅
		           	String sapId= PropertiesUtil.getProperty("sap.id");
		           	String sapPw= PropertiesUtil.getProperty("sap.pw");
		           	bs.setUsername(sapId);
		           	bs.setPassword(sapPw);
    	        	//bs.setUsername("if_po");
    	        	//bs.setPassword("init1234!");		           	
		           	
		        	IFFI016_BGT_S_DT_response res   = new IFFI016_BGT_S_DT_response();
		        	res = bs.IFFI016_BGT_SO(bankList);
		        	
		           	ifFlag = StringUtil.isNullToString(res.getIF_FLAG());
		           	ifMgs  = StringUtil.isNullToString(res.getIF_MSG());
		           	
		           	// 성공한 경우 상태코드 업데이트
		           	if ("S".equals(ifFlag)) {
						// 상태 기록 남기기
						bdgVendBankMgtService.saveEpsHistory(paramMap);
		           		bdgVendBankMgtService.updatSendFlag(paramMap);
		           	}
				} else {
					bdgVendBankMgtService.saveEpsHistory(paramMap);
				}
			}
	        
			jsonData.setStatus("SUCCESS");
    	} catch (RemoteException e) {
    		e.printStackTrace();
    		jsonData.setStatus("FAIL");
    		jsonData.setErrMsg(e.getMessage());
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
    @RequestMapping("/com/bdg/bdgVendBankMgtPop.do")
    public String bdgBasicMgtPop(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
    		model.addAttribute("PARAM", paramMap);
    		model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001","YS026","YS027","YS019","YS033"}));
    		
    	} catch (ServiceException e) {
    		e.printStackTrace();
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return "com/bdg/bdgVendBankMgtPop";
    }    

    /**
     * @function 전자결재 시스템에서 팝업 활성화 후 데이터 조회
     */ 
    @RequestMapping(value = "/com/bdg/selectVendBankMgtHeadListPop.do")
    @ResponseBody
    public JsonData selectVendBankMgtHeadListPop(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData  = new JsonData();

        try {

            List<Map<String,Object>> dataList  = bdgVendBankMgtService.selectVendBankMgtHeadListPop(paramMap);
            jsonData.setStatus("SUCC");
            jsonData.setRows(dataList);
            
        } catch (Exception e) {
            logger.error("공급업체계좌 HEADER 조회 오류", e);
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        return jsonData;
    }
    
    /**
     * @function 전자결재 시스템에서 팝업 활성화 후 데이터 조회
     */    
    @RequestMapping(value = "/com/bdg/selectVendBankMgtDetailListPop.do")
    @ResponseBody
    public JsonData selectVendBankMgtDetailListPop(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData  = new JsonData();

        try {

            List<Map<String,Object>> dataList  = bdgVendBankMgtService.selectVendBankMgtDetailListPop(paramMap);
            jsonData.setStatus("SUCC");
            jsonData.setRows(dataList);
            
        } catch (Exception e) {
            logger.error("공급업체계좌 DETAIL 조회 오류", e);
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        return jsonData;
    }    
    
       
    @RequestMapping(value = "/com/bdg/saveVendBankMgt.do")
    @ResponseBody
    public JsonData saveVendBankHeadMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws ServiceException, Exception {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		Map<String,Object> responseMap = bdgVendBankMgtService.saveVendBankMgt(paramMap);
    		
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
    
    @RequestMapping(value = "/com/bdg/deleteVendBankMgt.do")
    @ResponseBody
    public JsonData deleteVendBankMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		// 삭제  로직 수행
    		Map<String,Object> responseMap = bdgVendBankMgtService.deleteVendBankMgt(paramMap);
    		
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
    
    @RequestMapping(value = "/com/bdg/deleteVendBankDetailMgt.do")
    @ResponseBody
    public JsonData deleteVendBankDetailMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		// 삭제  로직 수행
    		Map<String,Object> responseMap = bdgVendBankMgtService.deleteVendBankDetailMgt(paramMap);
    		
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
    
    
    @RequestMapping(value = "/com/bdg/apprVendBankMgt.do")
    @ResponseBody
    public JsonData apprVendBankMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		Map<String,Object> apprMap = bdgVendBankMgtService.updatDeptSampleMgtStatus(paramMap);
    		
    		List<Map<String,Object>> dataList  = bdgVendBankMgtService.selectApprVendBankList(apprMap);
    		
    		jsonData.setStatus("SUCC");
    		jsonData.addFields("result", apprMap);
    		jsonData.addFields("epsList", dataList);
    		
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
    
}
