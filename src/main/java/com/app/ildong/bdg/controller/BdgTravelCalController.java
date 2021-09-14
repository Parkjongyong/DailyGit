
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

import com.app.ildong.bdg.service.BdgTravelCalService;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.JsonData;
import com.app.ildong.common.model.mvc.BaseController;
import com.app.ildong.common.service.CommonSelectService;
import com.app.ildong.common.util.PropertiesUtil;
import com.app.ildong.common.util.StringUtil;
import com.ildong.FI.BGT_ERP.IFFI017_BGT_SOBindingStub;
import com.ildong.FI.BGT_ERP.IFFI017_BGT_SOServiceLocator;
import com.ildong.FI.BGT_ERP.IFFI017_BGT_S_DT;
import com.ildong.FI.BGT_ERP.IFFI017_BGT_S_DTIN_DETAIL;
import com.ildong.FI.BGT_ERP.IFFI017_BGT_S_DTIN_HEAD;
import com.ildong.FI.BGT_ERP.IFFI017_BGT_S_DT_responseRETURN;

@Controller
public class BdgTravelCalController extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(BdgTravelCalController.class);
    
    private static final String sysErrMsg = "시스템 오류가 발생하였습니다.";
    
	@Autowired
    private CommonSelectService commonSelectService;
	
    @Autowired 
    private BdgTravelCalService bdgTravelCalService;
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/bdg/bdgTravelCal.do")
    public String bdgTravelCal(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
    		model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001","YS012"}));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
        return "com/bdg/bdgTravelCal";
    }

    @RequestMapping("/com/bdg/bdgTravelCalDetail.do")
    public String bdgTravelCalDetail(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
    		model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001","YS012"}));
    		model.addAttribute("PARAM", paramMap);
    	} catch (ServiceException e) {
    		e.printStackTrace();
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return "com/bdg/bdgTravelCalDetail";
    }
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/com/bdg/selectTravelCal.do")
    @ResponseBody
    public JsonData selectWhrTravelCalList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();

        try {
            List<Map<String,Object>> dataList = bdgTravelCalService.selectTravelCal(paramMap);
            jsonData.setStatus("SUCC");
            jsonData.setRows(dataList);
        } catch (Exception e) {
            logger.error("영업출장비정산 조회 오류", e);
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
    @RequestMapping(value = "/com/bdg/createPdf.do")
    @ResponseBody
    public JsonData createPdf(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();

        try {
            List<Map<String,Object>> dataList = bdgTravelCalService.createPdf(paramMap);
            jsonData.setStatus("SUCC");
            jsonData.setRows(dataList);
        } catch (Exception e) {
            logger.error("영업출장비정산 명세표출력 조회 오류", e);
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        return jsonData;
    }    
    
    
    @RequestMapping(value = "/com/bdg/selectTravelCalDetail.do")
    @ResponseBody
    public JsonData selectTravelCalDetail(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	
    	try {
    		List<Map<String,Object>> dataList = bdgTravelCalService.selectTravelCalDetail(paramMap);
    		jsonData.setStatus("SUCC");
    		jsonData.setRows(dataList);
    	} catch (Exception e) {
    		logger.error("영업출장비정산세부내역 조회 오류", e);
    	}
    	
    	if( logger.isDebugEnabled()) {
    		logger.debug("jsonData = " + jsonData);
    	}
    	return jsonData;
    }    
    @RequestMapping(value = "/com/bdg/sendTravelCal.do")
    @ResponseBody
    public JsonData sendTravelCal(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws ServiceException, Exception {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		Map<String,Object> returnParam = bdgTravelCalService.selectSendTravelCal(paramMap);
    		
    		paramMap.put("LEGACYNO", returnParam.get("LEGACYNO"));
    		
    		List<Map<String,Object>> sendIFCO017List_01 = (List<Map<String, Object>>) returnParam.get("IFFI017_01");
    		List<Map<String,Object>> sendIFCO017List_02 = (List<Map<String, Object>>) returnParam.get("IFFI017_02");
    		List<Map<String,Object>> sendIFCO017List_03 = (List<Map<String, Object>>) returnParam.get("IFFI017_03");
    		
    		returnParam.put("IFCO017_01", sendIFCO017List_01);
    		returnParam.put("IFCO017_02", sendIFCO017List_02);
    		returnParam.put("IFCO017_03", sendIFCO017List_03);
    		
    		String ifFlag = "";
    		String ifMgs  = "";
    		int seq       = 1;
    		
    		
    		if (!returnParam.isEmpty()) {
    			
				IFFI017_BGT_S_DTIN_HEAD[] sendHeadRow      = new IFFI017_BGT_S_DTIN_HEAD[sendIFCO017List_01.size()];
				IFFI017_BGT_S_DTIN_DETAIL[] sendDetailRow = new IFFI017_BGT_S_DTIN_DETAIL[sendIFCO017List_02.size() + sendIFCO017List_03.size()];

				IFFI017_BGT_S_DT dt = new IFFI017_BGT_S_DT();	
    			
    			if (sendIFCO017List_01.size() > 0) {
    				// 1. SOAP 통신으로 비용전표 처리 정보 송신 
    				
    				int rowCnt = 0;
    				for (Map<String, Object> sendHeadMap : sendIFCO017List_01) {
    					IFFI017_BGT_S_DTIN_HEAD sendHead = new IFFI017_BGT_S_DTIN_HEAD();
    					sendHead.setBUKRS(StringUtil.isNullToString(sendHeadMap.get("BUKRS")));
    					sendHead.setGJAHR(StringUtil.isNullToString(sendHeadMap.get("GJAHR")));
    					sendHead.setLEGACYNO(StringUtil.isNullToString(sendHeadMap.get("LEGACYNO")));
    					sendHead.setZACTYTYPE(StringUtil.isNullToString(sendHeadMap.get("ZACTYTYPE")));
    					//sendHead.setSTGRD(StringUtil.isNullToString("STGRD"));
    					sendHead.setZREBUDAT(StringUtil.isNullToString(sendHeadMap.get("ZREBUDAT")));
    					sendHead.setZREVTXT(StringUtil.isNullToString(sendHeadMap.get("ZREVTXT")));
    					sendHead.setZTRNSFRSEQ(StringUtil.isNullToString(sendHeadMap.get("ZTRNSFRSEQ")));
    					sendHead.setBLDAT(StringUtil.isNullToString(sendHeadMap.get("BLDAT")));
    					sendHead.setBUDAT(StringUtil.isNullToString(sendHeadMap.get("BUDAT")));
    					sendHead.setBLART(StringUtil.isNullToString(sendHeadMap.get("BLART")));
    					sendHead.setWAERS(StringUtil.isNullToString(sendHeadMap.get("WAERS")));
    					sendHead.setZEMPL_CO(StringUtil.isNullToString(sendHeadMap.get("ZEMPL_CO")));
    					sendHead.setZEMPL_DES(StringUtil.isNullToString(sendHeadMap.get("ZEMPL_DES")));
    					sendHead.setZCCTR_CO(StringUtil.isNullToString(sendHeadMap.get("ZCCTR_CO")));
    					sendHead.setZCCTR_DES(StringUtil.isNullToString(sendHeadMap.get("ZCCTR_DES")));
    					sendHead.setXBLNR(StringUtil.isNullToString(sendHeadMap.get("WAERS")) + "/" + StringUtil.isNullToString(sendHeadMap.get("ZEMPL_CO")));
    					sendHeadRow[rowCnt] = sendHead;
    					dt.setIN_HEAD(sendHeadRow);
    					rowCnt++;
    				}
    				
    			} else {
    				jsonData.setStatus("FAIL");
    				jsonData.setErrMsg("SAP 전송 할 데이터가 존재하지 않습니다.");
    			}
    			
    			int rowCnt    = 0;
    			
    			if (sendIFCO017List_02.size() > 0) {
    				// 1. SOAP 통신으로 비용전표 처리 정보 송신 
    				
    				
    				for (Map<String, Object> sendDetailMap : sendIFCO017List_02) {
    					IFFI017_BGT_S_DTIN_DETAIL sendDetail = new IFFI017_BGT_S_DTIN_DETAIL();
    					
    					
    					sendDetail.setBUKRS(StringUtil.isNullToString(sendDetailMap.get("BUKRS")));
    					sendDetail.setGJAHR(StringUtil.isNullToString(sendDetailMap.get("GJAHR")));
    					sendDetail.setLEGACYNO(StringUtil.isNullToString(sendDetailMap.get("LEGACYNO")));
    					sendDetail.setBUZEI(StringUtil.isNullToString(seq));
    					sendDetail.setKOART(StringUtil.isNullToString(sendDetailMap.get("KOART")));
    					sendDetail.setSHKZG(StringUtil.isNullToString(sendDetailMap.get("SHKZG")));
    					sendDetail.setHKONT(StringUtil.isNullToString(sendDetailMap.get("HKONT")));
    					sendDetail.setKUNNR(StringUtil.isNullToString(sendDetailMap.get("KUNNR")));
    					sendDetail.setLIFNR(StringUtil.isNullToString(sendDetailMap.get("LIFNR")));
    					sendDetail.setWRBTR(StringUtil.isNullToString(sendDetailMap.get("WRBTR")));
    					sendDetail.setDMBTR(StringUtil.isNullToString(sendDetailMap.get("DMBTR")));
    					sendDetail.setBUPLA(StringUtil.isNullToString(sendDetailMap.get("BUPLA")));
    					sendDetail.setMWSKZ(StringUtil.isNullToString(sendDetailMap.get("MWSKZ")));
    					sendDetail.setMWSTS(StringUtil.isNullToString(sendDetailMap.get("MWSTS")));
    					sendDetail.setWMWST(StringUtil.isNullToString(sendDetailMap.get("WMWST")));
    					sendDetail.setHWBAS(StringUtil.isNullToString(sendDetailMap.get("HWBAS")));
    					sendDetail.setFWBAS(StringUtil.isNullToString(sendDetailMap.get("FWBAS")));
    					sendDetail.setKOSTL(StringUtil.isNullToString(sendDetailMap.get("KOSTL")));
    					
    					sendDetailRow[rowCnt] = sendDetail;
    					rowCnt++;
    					seq++;
    					
    				}
    				
    			} else {
    				jsonData.setStatus("FAIL");
    				jsonData.setErrMsg("SAP 전송 할 데이터가 존재하지 않습니다.");
    			}
    			
    			if (sendIFCO017List_03.size() > 0) {
    				
    				// 1. SOAP 통신으로 비용전표 처리 정보 송신 
    				
    				for (Map<String, Object> sendDetailMap : sendIFCO017List_03) {
    					IFFI017_BGT_S_DTIN_DETAIL sendDetail = new IFFI017_BGT_S_DTIN_DETAIL();
    					
    					sendDetail.setBUKRS(StringUtil.isNullToString(sendDetailMap.get("BUKRS")));
    					sendDetail.setGJAHR(StringUtil.isNullToString(sendDetailMap.get("GJAHR")));
    					sendDetail.setLEGACYNO(StringUtil.isNullToString(sendDetailMap.get("LEGACYNO")));
    					sendDetail.setBUZEI(StringUtil.isNullToString(seq));
    					sendDetail.setKOART(StringUtil.isNullToString(sendDetailMap.get("KOART")));
    					sendDetail.setSHKZG(StringUtil.isNullToString(sendDetailMap.get("SHKZG")));
    					sendDetail.setHKONT(StringUtil.isNullToString(sendDetailMap.get("HKONT")));
    					sendDetail.setKUNNR(StringUtil.isNullToString(sendDetailMap.get("KUNNR")));
    					sendDetail.setLIFNR(StringUtil.isNullToString(sendDetailMap.get("LIFNR")));
    					sendDetail.setWRBTR(StringUtil.isNullToString(sendDetailMap.get("WRBTR")));
    					sendDetail.setDMBTR(StringUtil.isNullToString(sendDetailMap.get("DMBTR")));
    					sendDetail.setBUPLA(StringUtil.isNullToString(sendDetailMap.get("BUPLA")));
    					sendDetail.setMWSKZ(StringUtil.isNullToString(sendDetailMap.get("MWSKZ")));
    					sendDetail.setMWSTS(StringUtil.isNullToString(sendDetailMap.get("MWSTS")));
    					sendDetail.setWMWST(StringUtil.isNullToString(sendDetailMap.get("WMWST")));
    					sendDetail.setHWBAS(StringUtil.isNullToString(sendDetailMap.get("HWBAS")));
    					sendDetail.setFWBAS(StringUtil.isNullToString(sendDetailMap.get("FWBAS")));
    					sendDetail.setKOSTL(StringUtil.isNullToString(sendDetailMap.get("KOSTL")));
    					
    					sendDetailRow[rowCnt] = sendDetail;
    					rowCnt++;
    					seq++;
    				}
    				
    			} else {
    				jsonData.setStatus("FAIL");
    				jsonData.setErrMsg("SAP 전송 할 데이터가 존재하지 않습니다.");
    			}
    			
    			dt.setIN_DETAIL(sendDetailRow);
				// 1. SOAP 통신으로 공급업체  정보 추출 
				IFFI017_BGT_SOServiceLocator sl     = new IFFI017_BGT_SOServiceLocator();
				IFFI017_BGT_SOBindingStub bs        = (IFFI017_BGT_SOBindingStub)sl.getHTTP_Port();
				
				// USER ID/PW 셋팅
				String sapId= PropertiesUtil.getProperty("sap.id");
				String sapPw= PropertiesUtil.getProperty("sap.pw");
				bs.setUsername(sapId);
				bs.setPassword(sapPw);
				IFFI017_BGT_S_DT_responseRETURN[] res = bs.IFFI017_BGT_SO(dt);
				
				for (int i=0; i < res.length; i++) {
					ifFlag = res[i].getIF_FLAG();
					ifMgs  = res[i].getIF_MSG();
					System.out.println("send ifFlag :" + ifFlag);
					System.out.println("send ifMgs :" + ifMgs);
				}
				
    			jsonData.setStatus("SUCC");
    			jsonData.addFields("result", paramMap);
    			
    		} else {
    			jsonData.setStatus("FAIL");
    			jsonData.setErrMsg("SAP 전송 할 데이터가 존재하지 않습니다.");          	
    		}
			// 성공유무 확인
			if ("S".equals(ifFlag)) {
				bdgTravelCalService.updateSendBusin(paramMap);
			} else if ("E".equals(ifFlag)) {
				jsonData.setStatus("FAIL");
				jsonData.setErrMsg(ifMgs);
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
    
    @RequestMapping(value = "/com/bdg/sendCancelTravelCal.do")
    @ResponseBody
    public JsonData sendCancelTravelCal(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws ServiceException, Exception {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		Map<String,Object> returnParam = bdgTravelCalService.selectSendCancelTravelCal(paramMap);
    		
    		paramMap.put("LEGACYNO", returnParam.get("LEGACYNO"));
    		
    		List<Map<String,Object>> sendIFCO017List_01 = (List<Map<String, Object>>) returnParam.get("IFFI017_01");
    		List<Map<String,Object>> sendIFCO017List_02 = (List<Map<String, Object>>) returnParam.get("IFFI017_02");
    		List<Map<String,Object>> sendIFCO017List_03 = (List<Map<String, Object>>) returnParam.get("IFFI017_03");
    		
    		returnParam.put("IFCO017_01", sendIFCO017List_01);
    		returnParam.put("IFCO017_02", sendIFCO017List_02);
    		returnParam.put("IFCO017_03", sendIFCO017List_03);
    		
    		String ifFlag = "";
    		String ifMgs  = "";
    		int seq       = 1;
    		
    		
    		if (!returnParam.isEmpty()) {
    			
    			IFFI017_BGT_S_DTIN_HEAD[] sendHeadRow      = new IFFI017_BGT_S_DTIN_HEAD[sendIFCO017List_01.size()];
    			IFFI017_BGT_S_DTIN_DETAIL[] sendDetailRow = new IFFI017_BGT_S_DTIN_DETAIL[sendIFCO017List_02.size() + sendIFCO017List_03.size()];
    			
    			IFFI017_BGT_S_DT dt = new IFFI017_BGT_S_DT();	
    			
    			if (sendIFCO017List_01.size() > 0) {
    				// 1. SOAP 통신으로 비용전표 처리 정보 송신 
    				
    				int rowCnt = 0;
    				for (Map<String, Object> sendHeadMap : sendIFCO017List_01) {
    					IFFI017_BGT_S_DTIN_HEAD sendHead = new IFFI017_BGT_S_DTIN_HEAD();
    					sendHead.setBUKRS(StringUtil.isNullToString(sendHeadMap.get("BUKRS")));
    					sendHead.setGJAHR(StringUtil.isNullToString(sendHeadMap.get("GJAHR")));
    					sendHead.setLEGACYNO(StringUtil.isNullToString(sendHeadMap.get("LEGACYNO")));
    					sendHead.setZACTYTYPE(StringUtil.isNullToString(sendHeadMap.get("ZACTYTYPE")));
    					//sendHead.setSTGRD(StringUtil.isNullToString("STGRD"));
    					sendHead.setZREBUDAT(StringUtil.isNullToString(sendHeadMap.get("ZREBUDAT")));
    					sendHead.setZREVTXT(StringUtil.isNullToString(sendHeadMap.get("ZREVTXT")));
    					sendHead.setZTRNSFRSEQ(StringUtil.isNullToString(sendHeadMap.get("ZTRNSFRSEQ")));
    					sendHead.setBLDAT(StringUtil.isNullToString(sendHeadMap.get("BLDAT")));
    					sendHead.setBUDAT(StringUtil.isNullToString(sendHeadMap.get("BUDAT")));
    					sendHead.setBLART(StringUtil.isNullToString(sendHeadMap.get("BLART")));
    					sendHead.setWAERS(StringUtil.isNullToString(sendHeadMap.get("WAERS")));
    					sendHead.setZEMPL_CO(StringUtil.isNullToString(sendHeadMap.get("ZEMPL_CO")));
    					sendHead.setZEMPL_DES(StringUtil.isNullToString(sendHeadMap.get("ZEMPL_DES")));
    					sendHead.setZCCTR_CO(StringUtil.isNullToString(sendHeadMap.get("ZCCTR_CO")));
    					sendHead.setZCCTR_DES(StringUtil.isNullToString(sendHeadMap.get("ZCCTR_DES")));
    					sendHead.setXBLNR(StringUtil.isNullToString(sendHeadMap.get("WAERS")) + "/" + StringUtil.isNullToString(sendHeadMap.get("ZEMPL_CO")));
    					sendHeadRow[rowCnt] = sendHead;
    					dt.setIN_HEAD(sendHeadRow);
    					rowCnt++;
    				}
    				
    			} else {
    				jsonData.setStatus("FAIL");
    				jsonData.setErrMsg("SAP 전송취소 할 데이터가 존재하지 않습니다.");
    			}
    			
    			int rowCnt    = 0;
    			
    			if (sendIFCO017List_02.size() > 0) {
    				// 1. SOAP 통신으로 비용전표 처리 정보 송신 
    				
    				
    				for (Map<String, Object> sendDetailMap : sendIFCO017List_02) {
    					IFFI017_BGT_S_DTIN_DETAIL sendDetail = new IFFI017_BGT_S_DTIN_DETAIL();
    					
    					
    					sendDetail.setBUKRS(StringUtil.isNullToString(sendDetailMap.get("BUKRS")));
    					sendDetail.setGJAHR(StringUtil.isNullToString(sendDetailMap.get("GJAHR")));
    					sendDetail.setLEGACYNO(StringUtil.isNullToString(sendDetailMap.get("LEGACYNO")));
    					sendDetail.setBUZEI(StringUtil.isNullToString(seq));
    					sendDetail.setKOART(StringUtil.isNullToString(sendDetailMap.get("KOART")));
    					sendDetail.setSHKZG(StringUtil.isNullToString(sendDetailMap.get("SHKZG")));
    					sendDetail.setHKONT(StringUtil.isNullToString(sendDetailMap.get("HKONT")));
    					sendDetail.setKUNNR(StringUtil.isNullToString(sendDetailMap.get("KUNNR")));
    					sendDetail.setLIFNR(StringUtil.isNullToString(sendDetailMap.get("LIFNR")));
    					sendDetail.setWRBTR(StringUtil.isNullToString(sendDetailMap.get("WRBTR")));
    					sendDetail.setDMBTR(StringUtil.isNullToString(sendDetailMap.get("DMBTR")));
    					sendDetail.setBUPLA(StringUtil.isNullToString(sendDetailMap.get("BUPLA")));
    					sendDetail.setMWSKZ(StringUtil.isNullToString(sendDetailMap.get("MWSKZ")));
    					sendDetail.setMWSTS(StringUtil.isNullToString(sendDetailMap.get("MWSTS")));
    					sendDetail.setWMWST(StringUtil.isNullToString(sendDetailMap.get("WMWST")));
    					sendDetail.setHWBAS(StringUtil.isNullToString(sendDetailMap.get("HWBAS")));
    					sendDetail.setFWBAS(StringUtil.isNullToString(sendDetailMap.get("FWBAS")));
    					sendDetail.setKOSTL(StringUtil.isNullToString(sendDetailMap.get("KOSTL")));
    					
    					sendDetailRow[rowCnt] = sendDetail;
    					rowCnt++;
    					seq++;
    					
    				}
    				
    			} else {
    				jsonData.setStatus("FAIL");
    				jsonData.setErrMsg("SAP 전송취소 할 데이터가 존재하지 않습니다.");
    			}
    			
    			if (sendIFCO017List_03.size() > 0) {
    				
    				// 1. SOAP 통신으로 비용전표 처리 정보 송신 
    				
    				for (Map<String, Object> sendDetailMap : sendIFCO017List_03) {
    					IFFI017_BGT_S_DTIN_DETAIL sendDetail = new IFFI017_BGT_S_DTIN_DETAIL();
    					
    					sendDetail.setBUKRS(StringUtil.isNullToString(sendDetailMap.get("BUKRS")));
    					sendDetail.setGJAHR(StringUtil.isNullToString(sendDetailMap.get("GJAHR")));
    					sendDetail.setLEGACYNO(StringUtil.isNullToString(sendDetailMap.get("LEGACYNO")));
    					sendDetail.setBUZEI(StringUtil.isNullToString(seq));
    					sendDetail.setKOART(StringUtil.isNullToString(sendDetailMap.get("KOART")));
    					sendDetail.setSHKZG(StringUtil.isNullToString(sendDetailMap.get("SHKZG")));
    					sendDetail.setHKONT(StringUtil.isNullToString(sendDetailMap.get("HKONT")));
    					sendDetail.setKUNNR(StringUtil.isNullToString(sendDetailMap.get("KUNNR")));
    					sendDetail.setLIFNR(StringUtil.isNullToString(sendDetailMap.get("LIFNR")));
    					sendDetail.setWRBTR(StringUtil.isNullToString(sendDetailMap.get("WRBTR")));
    					sendDetail.setDMBTR(StringUtil.isNullToString(sendDetailMap.get("DMBTR")));
    					sendDetail.setBUPLA(StringUtil.isNullToString(sendDetailMap.get("BUPLA")));
    					sendDetail.setMWSKZ(StringUtil.isNullToString(sendDetailMap.get("MWSKZ")));
    					sendDetail.setMWSTS(StringUtil.isNullToString(sendDetailMap.get("MWSTS")));
    					sendDetail.setWMWST(StringUtil.isNullToString(sendDetailMap.get("WMWST")));
    					sendDetail.setHWBAS(StringUtil.isNullToString(sendDetailMap.get("HWBAS")));
    					sendDetail.setFWBAS(StringUtil.isNullToString(sendDetailMap.get("FWBAS")));
    					sendDetail.setKOSTL(StringUtil.isNullToString(sendDetailMap.get("KOSTL")));
    					
    					sendDetailRow[rowCnt] = sendDetail;
    					rowCnt++;
    					seq++;
    				}
    				
    			} else {
    				jsonData.setStatus("FAIL");
    				jsonData.setErrMsg("SAP 전송취소 할 데이터가 존재하지 않습니다.");
    			}
    			
    			dt.setIN_DETAIL(sendDetailRow);
    			// 1. SOAP 통신으로 공급업체  정보 추출 
    			IFFI017_BGT_SOServiceLocator sl     = new IFFI017_BGT_SOServiceLocator();
    			IFFI017_BGT_SOBindingStub bs        = (IFFI017_BGT_SOBindingStub)sl.getHTTP_Port();
    			
    			// USER ID/PW 셋팅
    			String sapId= PropertiesUtil.getProperty("sap.id");
    			String sapPw= PropertiesUtil.getProperty("sap.pw");
    			bs.setUsername(sapId);
    			bs.setPassword(sapPw);
    			IFFI017_BGT_S_DT_responseRETURN[] res = bs.IFFI017_BGT_SO(dt);
    			
    			for (int i=0; i < res.length; i++) {
    				ifFlag = res[i].getIF_FLAG();
    				ifMgs  = res[i].getIF_MSG();
    				System.out.println("sendCancel ifFlag :" + ifFlag);
    				System.out.println("sendCancel ifMgs :" + ifMgs);
    			}
    			
    			jsonData.setStatus("SUCC");
    			jsonData.addFields("result", paramMap);
    			
    		} else {
    			jsonData.setStatus("FAIL");
    			jsonData.setErrMsg("SAP 전송취소 할 데이터가 존재하지 않습니다.");          	
    		}
    		// 성공유무 확인
    		if ("S".equals(ifFlag)) {
    			bdgTravelCalService.updateSendCancelBusin(paramMap);
    		} else if ("E".equals(ifFlag)) {
    			jsonData.setStatus("FAIL");
    			jsonData.setErrMsg(ifMgs);
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
    
}
