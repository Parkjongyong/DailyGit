/**
 * 부서견본신청 조회/저장/삭제/견본가수신/승인요청
 * @author 길용덕
 * @since 2020.09.14
 * 
 * << 개정이력(Modification Information) >>
 *  ------------------------------------------------- 
 *  수정일                    수정자            수정내용
 *  ----------   -------- ---------------------------
 *  2020.09.14   길용덕            최초생성
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
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.app.ildong.bdg.service.BdgDeptSampleMgtService;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.JsonData;
import com.app.ildong.common.model.mvc.BaseController;
import com.app.ildong.common.service.CommonSelectService;
import com.app.ildong.common.util.PropertiesUtil;
import com.app.ildong.common.util.StringUtil;
import com.ildong.CO.BGT_ERP.IFCO006_BGT_SOBindingStub;
import com.ildong.CO.BGT_ERP.IFCO006_BGT_SOServiceLocator;
import com.ildong.CO.BGT_ERP.IFCO006_BGT_S_DT;
import com.ildong.CO.BGT_ERP.IFCO006_BGT_S_DT_response;
import com.ildong.CO.BGT_ERP.IFCO006_BGT_S_DT_responseITEM;
import com.ildong.SD.BGT_ERP.IFSD020_BGT_SOBindingStub;
import com.ildong.SD.BGT_ERP.IFSD020_BGT_SOServiceLocator;
import com.ildong.SD.BGT_ERP.IFSD020_BGT_S_DT;
import com.ildong.SD.BGT_ERP.IFSD020_BGT_S_DTHEADER;
import com.ildong.SD.BGT_ERP.IFSD020_BGT_S_DTITEM;
import com.ildong.SD.BGT_ERP.IFSD020_BGT_S_DT_response;
import com.ildong.SD.BGT_ERP.IFSD112_BGT_SOBindingStub;
import com.ildong.SD.BGT_ERP.IFSD112_BGT_SOServiceLocator;
import com.ildong.SD.BGT_ERP.IFSD112_BGT_S_DT;
import com.ildong.SD.BGT_ERP.IFSD112_BGT_S_DT_response;
import com.ildong.SD.BGT_ERP.IFSD112_BGT_S_DT_responseITEM;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.jdbc.BadSqlGrammarException;
import org.springframework.dao.DataIntegrityViolationException;

@Controller
public class BdgDeptSampleMgtController extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(BdgDeptSampleMgtController.class);
    
    private static final String sysErrMsg = "시스템 오류가 발생하였습니다.";
    
	@Autowired
    private CommonSelectService commonSelectService;
	
    @Autowired 
    private BdgDeptSampleMgtService bdgDeptSampleMgtService;
    
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/bdg/bdgDeptSampleMgt.do")
    public String bdgDeptSampleMgt(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
    		model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001","YS024","YS025"}));
			
			// 로긴 사용자 정보를 바탕으로 담당자별 부서권한 코드 콤보 데이터 추출
			model.putAll(commonSelectService.selectUserDeptCodeList("USRDPT"));
			
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
        return "com/bdg/bdgDeptSampleMgt";
    }
    
    @RequestMapping("/com/bdg/bdgMatSearchPop.do")
    public String bdgMatSearchPop(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
    		model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001"}));
    		model.putAll(commonSelectService.selectPlandCodeList("SYSPLT"));
    		model.addAttribute("PARAM", paramMap);   
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}    	
 	
        return "com/bdg/bdgMatSearchPop";
    }
    
    @RequestMapping("/com/bdg/bdgDeptSampleMgtPop.do")
    public String bdgDeptSampleMgtPop(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
    		model.addAttribute("PARAM", paramMap);
    		model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001","YS024","YS025"}));
    		
			// CASE 2
			paramMap.put("CODE"   , "USRDPT");
			// 회사코드와 사번을 가변적으로 셋팅해서 담당자별 부서권한 코드 콤보 데이터 추출
			//paramMap.put("COMP_CD", "1000");
			paramMap.put("USER_ID", StringUtil.isNullToString(paramMap.get("USER_ID")));
			model.putAll(commonSelectService.selectUserDeptCodeList2(paramMap));
			
    	} catch (ServiceException e) {
    		e.printStackTrace();
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return "com/bdg/bdgDeptSampleMgtPop";
    }
    
    @RequestMapping("/com/bdg/bdgDeptSampleMgtEps.do")
    @ResponseStatus(value = HttpStatus.OK)
    public JsonData bdgDeptSampleMgtEps(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
			if (!"".equals(paramMap.get("EPS_DOC_NO")) && null != paramMap.get("EPS_DOC_NO")) {
				// 결재완료인 경우  SAP전송
				if ("COMPLETE".equals(paramMap.get("appstatus").toString())) {
					bdgDeptSampleMgtService.updatDeptSampleMgtStatus6All(paramMap);
					
					// SAP전송 대상 추출
					List<Map<String,Object>> dataList  = bdgDeptSampleMgtService.selectSendDeptSampleMgtList(paramMap);
					
					String ifFlag = "";
					String ifMgs  = "";
					int errCnt = 0;
					
					for (Map<String, Object> data: dataList) {
						
						// 1. SOAP 통신으로 공급업체  정보 추출 
						IFSD020_BGT_S_DTHEADER inhead = new IFSD020_BGT_S_DTHEADER();
						IFSD020_BGT_S_DTITEM[] items  = new IFSD020_BGT_S_DTITEM[1];
						IFSD020_BGT_S_DTITEM item     = new IFSD020_BGT_S_DTITEM();
						IFSD020_BGT_S_DT dt = new IFSD020_BGT_S_DT();	
						System.out.println("VBEXT::" + data.get("VBEXT").toString());
						inhead.setVBEXT(StringUtil.isNullToString(data.get("VBEXT")));
						inhead.setAUART(StringUtil.isNullToString(data.get("AUART")));
						//inhead.setVKORG(StringUtil.isNullToString(data.get("VKORG")));
						inhead.setVKORG(StringUtil.isNullToString("11000"));
						inhead.setVTWEG(StringUtil.isNullToString(data.get("VTWEG")));
						inhead.setSPART(StringUtil.isNullToString(data.get("SPART")));
						inhead.setKUNZP(StringUtil.isNullToString(data.get("KUNZP")));
						//inhead.setKUNNR(StringUtil.isNullToString(data.get("KUNNR")));
						inhead.setKUNNR(StringUtil.isNullToString("11000"));
						inhead.setKUNWE(StringUtil.isNullToString(data.get("KUNWE")));
						inhead.setKETDT(StringUtil.isNullToString(data.get("KETDT")));
						inhead.setKOSTL(StringUtil.isNullToString(data.get("KOSTL")));
						inhead.setFROMS(StringUtil.isNullToString(data.get("FROMS")));
						inhead.setAPPST(StringUtil.isNullToString(data.get("APPST")));
						inhead.setWAERK("KRW");
						
						
						item.setVBEXT(StringUtil.isNullToString(data.get("VBEXT")));
						item.setPOEXT(StringUtil.isNullToString(data.get("POEXT")));
						item.setMATNR(StringUtil.isNullToString(data.get("MATNR")));
						item.setKWMENG(StringUtil.isNullToString(data.get("KWMENG")));
						item.setKWMENG(StringUtil.isNullToString(data.get("KWMENG")));
						items[0] = item;
						
						dt.setHEADER(inhead);
						dt.setITEM(items);
						
						IFSD020_BGT_SOServiceLocator sl = new IFSD020_BGT_SOServiceLocator();
						IFSD020_BGT_SOBindingStub bs    = (IFSD020_BGT_SOBindingStub)sl.getHTTP_Port();
			        	
			        	// USER ID/PW 셋팅
			        	// USER ID/PW 셋팅
			           	String sapId= PropertiesUtil.getProperty("sap.id");
			           	String sapPw= PropertiesUtil.getProperty("sap.pw");
			           	bs.setUsername(sapId);
			           	bs.setPassword(sapPw);
			        	IFSD020_BGT_S_DT_response res   = new IFSD020_BGT_S_DT_response();
			        	res = bs.IFSD020_BGT_SO(dt);
			        	
			           	ifFlag = StringUtil.isNullToString(res.getIF_FLAG());
			           	ifMgs  = StringUtil.isNullToString(res.getIF_MSG());
			           	
			           	// 성공한 경우 상태코드 업데이트
			           	if (!"S".equals(ifFlag)) {
			           		errCnt++;
			           		data.put("REMARK", ifMgs);
							// 상태 기록 남기기
							bdgDeptSampleMgtService.updatDeptSampleMgtStatus6(data);			           		
			           	} else {
			           		bdgDeptSampleMgtService.updatSendFlag(data);
			           	}
					}
					
					// 에러없이 전체 성공해야지 상태변경 처리
					if (errCnt == 0) {
		           		// 상태 기록 남기기
		           		bdgDeptSampleMgtService.saveEpsHistory(paramMap);						
					}
					
				} else {
					bdgDeptSampleMgtService.saveEpsHistory(paramMap);
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
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/com/bdg/selectDeptSampleMgtList.do")
    @ResponseBody
    public JsonData selectDeptSampleMgtList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData  = new JsonData();

        try {

            List<Map<String,Object>> dataList  = bdgDeptSampleMgtService.selectDeptSampleMgtList(paramMap);
            jsonData.setStatus("SUCC");
            jsonData.setRows(dataList);
            
        } catch (Exception e) {
            logger.error("부서견본신청 조회 오류", e);
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        return jsonData;
    }
    
    @RequestMapping(value = "/com/bdg/selectDeptSampleMgtListPop.do")
    @ResponseBody
    public JsonData selectDeptSampleMgtListPop(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData  = new JsonData();

        try {

            List<Map<String,Object>> dataList  = bdgDeptSampleMgtService.selectDeptSampleMgtListPop(paramMap);
            jsonData.setStatus("SUCC");
            jsonData.setRows(dataList);
            
        } catch (Exception e) {
            logger.error("부서견본신청 조회 오류", e);
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        return jsonData;
    }    
    
    @RequestMapping(value = "/com/bdg/selectMatList.do")
    @ResponseBody
    public JsonData selectMatList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData  = new JsonData();

        try {

            List<Map<String,Object>> dataList  = bdgDeptSampleMgtService.selectMatList(paramMap);
            
            if (null!=dataList && 0<dataList.size()) {
                Integer totalCnt = Integer.valueOf( ((Map<String,Object>)dataList.get(0)).get("TOT_CNT").toString() );
                
                paramMap.put("APPEND_PAGE","APPEND_PAGE");
                jsonData.setPageRows(paramMap, dataList, totalCnt);
            } else {
                jsonData.setPageRows(paramMap, null, 0);
            }
            
        } catch (Exception e) {
            logger.error("부서견본신청 조회 오류", e);
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        return jsonData;
    }    
    
    
    @RequestMapping(value = "/com/bdg/saveDeptSampleMgt.do")
    @ResponseBody
    public JsonData saveDeptSampleMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws ServiceException, Exception {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		Map<String,Object> responseMap = bdgDeptSampleMgtService.saveDeptSampleMgt(paramMap);
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
    
    @RequestMapping(value = "/com/bdg/deleteDeptSampleMgt.do")
    @ResponseBody
    public JsonData deleteDeptSampleMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		// 삭제  로직 수행
    		Map<String,Object> responseMap = bdgDeptSampleMgtService.deleteDeptSampleMgt(paramMap);
    		
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
    
    @RequestMapping(value = "/com/bdg/apprDeptSampleMgt.do")
    @ResponseBody
    public JsonData apprDeptSampleMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		Map<String,Object> saveMap = bdgDeptSampleMgtService.saveDeptSampleMgt(paramMap);
    		
    		if (!"Y".equals(saveMap.get("SUCC_YN").toString())) {
        		jsonData.setStatus("FAIL");
        		jsonData.setErrMsg(saveMap.get("ERR_MSG").toString());
        		jsonData.addFields("result", paramMap);
    		} else {
    			Map<String,Object> apprMap = bdgDeptSampleMgtService.updatDeptSampleMgtStatus(paramMap);
        		jsonData.setStatus("SUCC");
        		jsonData.addFields("result", apprMap);
    		}
    		
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
    
    @RequestMapping(value = "/com/bdg/receptionDeptSampleMgt.do")
    @ResponseBody
    public JsonData receptionDeptSampleMgt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws ServiceException, Exception {
    	JsonData jsonData = new JsonData();
    	try {
    		
        	Map<String, Object> dataMap          = (Map<String, Object>) paramMap.get("ITEM_LIST");
        	List<Map<String, Object>> dataList   = (List<Map<String, Object>>) dataMap.get("CHECK_LIST");
        	List<Map<String, Object>> sampleList = new ArrayList<Map<String, Object>>();
        	List<Map<String, Object>> returnList = new ArrayList<Map<String, Object>>();
    		

        	String ifFlag = "";
        	String ifMgs  = "";
        	
        	for (Map<String, Object> data : dataList) {
        		
        		// 1. SOAP 통신으로 견본가 수신
        		IFSD112_BGT_S_DT item = new IFSD112_BGT_S_DT();        		
        		
            	item.setVKORG("1100");// 회사코드
            	item.setVTWEG("99");// 유통경로
            	item.setSPART("00");//제품군
            	item.setKUNAG("11000");//판매처
            	System.out.println("PLANT_CD ::" + data.get("PLANT_CD").toString());
            	item.setKUNWE(data.get("DELIVERY_LOC").toString());//납품처
            	System.out.println("DELIVERY_LOC ::" + data.get("DELIVERY_LOC").toString());
            	//item.setKUNWE("365679");//납품처
            	item.setKUNZH(data.get("DELIVERY_LOC").toString());//간납처
            	//item.setKUNZH("365679");//간납처
            	item.setPRSDT(data.get("RELEASE_REQ_YMD").toString());//가격결정일
            	System.out.println("ORDER_TYPE ::" + data.get("DELIVERY_LOC").toString());
            	System.out.println("MAT_NUMBER ::" + data.get("MAT_NUMBER").toString());
            	item.setAUART(data.get("ORDER_TYPE").toString());//주문유형
            	//item.setAUART("ZFS1");//주문유형
            	item.setMATNR(data.get("MAT_NUMBER").toString());//자재코드
            	item.setWERKS(data.get("PLANT_CD").toString());//플랜트
            	
            	IFSD112_BGT_SOServiceLocator afs = new IFSD112_BGT_SOServiceLocator();
            	IFSD112_BGT_SOBindingStub af = (IFSD112_BGT_SOBindingStub)afs.getHTTP_Port();
            	IFSD112_BGT_S_DT_response res = new IFSD112_BGT_S_DT_response();            	
            	
	        	// USER ID/PW 셋팅
	           	String sapId= PropertiesUtil.getProperty("sap.id");
	           	String sapPw= PropertiesUtil.getProperty("sap.pw");
	           	af.setUsername(sapId);
	           	af.setPassword(sapPw);
               	
               	res = af.IFSD112_BGT_SO(item);
               	
               	ifFlag = StringUtil.isNullToString(res.getIF_FLAG());
               	ifMgs  = StringUtil.isNullToString(res.getIF_MSG());  
               	
               	int sampleAmtLen = 0;
           		if (null != res.getITEM()) {
           			sampleAmtLen = res.getITEM().length;
           			System.out.println("sampleAmtLen::" + sampleAmtLen);
           		}
           		
           		IFSD112_BGT_S_DT_responseITEM[] sampleAmtRow = new IFSD112_BGT_S_DT_responseITEM[sampleAmtLen];
               	
           		if (sampleAmtLen > 0) {
           			sampleAmtRow = res.getITEM();
           			
    	           	for (IFSD112_BGT_S_DT_responseITEM sampleAmt : sampleAmtRow) {
    	                for (Field field : sampleAmt.getClass().getDeclaredFields()) {
    	                    field.setAccessible(true);
    	                    data.put(field.getName(), field.get(sampleAmt));
    	                    System.out.println("[" + field.getName() + "-" + field.get(sampleAmt) + "]");
    	                }           		
    	           	}
    	           	
    	           	data.put("SAMPLE_AMT", StringUtil.isNullToString(data.get("NETSP")));
    	           	data.put("JAEGO_QTY", StringUtil.isNullToString(data.get("ATPQTY")));
    	           	
    	           	String FCO01 = StringUtil.isNullToString(data.get("FCO01"));
    	    		if ("".equals(FCO01)) {
    	    			FCO01 = "Y";
    	    		}
    	           	data.put("REQ_YN", FCO01);
           		}
           		
        		// 2. SOAP 통신으로 품목재고/예산금액 수신 (단건수신)
           		IFCO006_BGT_S_DT input = new IFCO006_BGT_S_DT();
           		// 코스트 센터는 화면에서 선택한 코스트 센터로 셋팅
           		//Map<String,Object> cctrMap = bdgDeptSampleMgtService.selectCctrCode(paramMap);
           		
           		input.setI_BUKRS("1100");
           		input.setSPMON(data.get("CRTN_YMD").toString().substring(0, 6));
           		System.out.println("data::" + data.get("CRTN_YMD").toString().substring(0, 6));
           		input.setKOSTL(data.get("CCTR_CD").toString());
           		//input.setKOSTL(cctrMap.get("CCTR_CD").toString());
           		System.out.println("CCTR_CD::" + data.get("CCTR_CD").toString());
           		input.setKSTAR(data.get("ACCOUNT_NO").toString());
           		System.out.println("ACCOUNT_NO::" + data.get("ACCOUNT_NO").toString());
           		
           		IFCO006_BGT_SOServiceLocator sl = new IFCO006_BGT_SOServiceLocator();
           		IFCO006_BGT_SOBindingStub bs = (IFCO006_BGT_SOBindingStub)sl.getHTTP_Port();
           		IFCO006_BGT_S_DT_response rs = new IFCO006_BGT_S_DT_response(); 
           		
            	// USER ID/PW 셋팅
               	bs.setUsername(sapId);
               	bs.setPassword(sapPw);
               	
           		rs = bs.IFCO006_BGT_SO(input); 
           		
               	ifFlag = StringUtil.isNullToString(rs.getIF_FLAG());
               	ifMgs  = StringUtil.isNullToString(rs.getIF_MSG());  
               	
               	int accountResultLen = 0;
           		if (null != rs.getITEM()) {
           			accountResultLen = rs.getITEM().length;
           			System.out.println("accountResultLen::" + accountResultLen);
           		}
           		
           		IFCO006_BGT_S_DT_responseITEM[] accountResultRow = new IFCO006_BGT_S_DT_responseITEM[accountResultLen];
           		Map<String,Object> accountMap = new HashMap<>();
           		if (accountResultLen > 0) {
           			accountResultRow = rs.getITEM();
           			
    	           	for (IFCO006_BGT_S_DT_responseITEM accountResult : accountResultRow) {
    	                for (Field field : accountResult.getClass().getDeclaredFields()) {
    	                    field.setAccessible(true);
    	                    accountMap.put(field.getName(), field.get(accountResult));
    	                    System.out.println("[" + field.getName() + "-" + field.get(accountResult) + "]");
    	                }           		
    	           	}
    	           	
    	           	data.put("BUGT_AMT", StringUtil.isNullToString(accountMap.get("ZAMT1")));
    	           	data.put("RESULT_AMT", StringUtil.isNullToString(accountMap.get("ZAMT2")));
           		}           		

           		// 요청 들어온 건수 만큼 데이터를 생성해서 되돌리기
           		sampleList.add(data);
        	}
       		
        	jsonData.addFields("result", sampleList);
        	
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
