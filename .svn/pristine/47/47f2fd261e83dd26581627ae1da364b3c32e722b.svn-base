
package com.app.ildong.wrh.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
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

import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.JsonData;
import com.app.ildong.common.model.mvc.BaseController;
import com.app.ildong.common.service.CommonSelectService;
import com.app.ildong.common.util.PropertiesUtil;
import com.app.ildong.common.util.StringUtil;
import com.app.ildong.wrh.service.WrhOrderStatusService;
import com.ildong.MM.BGT_ERP.IFMM036_BGT_SOBindingStub;
import com.ildong.MM.BGT_ERP.IFMM036_BGT_SOServiceLocator;
import com.ildong.MM.BGT_ERP.IFMM036_BGT_S_DTIT_HEAD;
import com.ildong.MM.BGT_ERP.IFMM036_BGT_S_DT_response;

@Controller
public class WrhOrderStatusController extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(WrhOrderStatusController.class);
    
    private static final String sysErrMsg = "시스템 오류가 발생하였습니다.";
    
	@Autowired
    private CommonSelectService commonSelectService;
	
    @Autowired 
    private WrhOrderStatusService wrhOrderStatusService;
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/wrh/wrhOrderStatus.do")
    public String wrhOrderStatus(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
			model.putAll(commonSelectService.selectCodeList(new String[]{"IG004","IG005","SYS001","IG001"}));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
        return "com/wrh/wrhOrderStatus";
    }
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/wrh/wrhOrderStatusV.do")
    public String wrhOrderStatusV(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
			model.putAll(commonSelectService.selectCodeList(new String[]{"IG004","IG005","SYS001","IG001"}));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
        return "com/wrh/wrhOrderStatusV";
    }    

    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/wrh/wrhOrderStatusDetail.do")
    public String wrhOrderStatusDetail(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
    		model.putAll(commonSelectService.selectCodeList(new String[]{"IG004","IG005","SYS001","IG001"}));
			model.addAttribute("PARAM", paramMap);
    	} catch (ServiceException e) {
    		e.printStackTrace();
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return "com/wrh/wrhOrderStatusDetail";
    }
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/wrh/wrhOrderStatusDetailV.do")
    public String wrhOrderStatusDetailV(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
    		model.putAll(commonSelectService.selectCodeList(new String[]{"IG004","IG005","SYS001","IG001"}));
			model.addAttribute("PARAM", paramMap);
    	} catch (ServiceException e) {
    		e.printStackTrace();
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return "com/wrh/wrhOrderStatusDetailV";
    }    
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/wrh/wrhOrderStatusDetailOne.do")
    public String wrhOrderStatusDetailOne(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws Exception {
    	model.addAttribute("PARAM", paramMap);
    	return "com/wrh/wrhOrderStatusDetailOne";
    }
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/com/wrh/selectWrhOrderStatusList.do")
    @ResponseBody
    public JsonData selectWrhOrderStatusList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();

        try {

            List<Map<String,Object>> dataList = wrhOrderStatusService.selectOrderStatusList(paramMap);
            if (null!=dataList && 0<dataList.size()) {
                Integer totalCnt = Integer.valueOf( ((Map<String,Object>)dataList.get(0)).get("TOT_CNT").toString() );
                
                paramMap.put("APPEND_PAGE","APPEND_PAGE");
                jsonData.setPageRows(paramMap, dataList, totalCnt);
            } else {
                jsonData.setPageRows(paramMap, null, 0);
            }
            
        } catch (Exception e) {
            logger.error("발주 현황 조회 오류", e);
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
    @RequestMapping(value = "/com/wrh/selectWrhOrderStatusDetail.do")
    @ResponseBody
    public JsonData selectWrhOrderStatusDetail(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	
    	try {
    		List<Map<String,Object>> dataList = wrhOrderStatusService.selectOrderStatusDetail(paramMap);
    		jsonData.setStatus("SUCC");
    		
    		if(dataList.size() > 0) {
        		jsonData.addFields("H_SUM_AMT", dataList.get(0).get("H_SUM_AMT"));
    		}
    		
    		jsonData.setRows(dataList);
    		
    	} catch (Exception e) {
    		logger.error("발주현황 상세 조회 오류", e);
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
    @RequestMapping(value = "/com/wrh/selectWrhOrderStatusDetailOne.do")
    @ResponseBody
    public JsonData selectWrhOrderStatusDetailOne(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	
    	try {
    		List<Map<String,Object>> dataList = wrhOrderStatusService.selectOrderStatusDetailOne(paramMap);
    		jsonData.setStatus("SUCC");
    		
    		if(dataList.size() > 0) {
    			jsonData.addFields("SUM_AMT", dataList.get(0).get("SUM_AMT"));
    		}
    		
    		jsonData.setRows(dataList);
    		
    	} catch (Exception e) {
    		logger.error("발주품목상세 조회 오류", e);
    	}
    	
    	if( logger.isDebugEnabled()) {
    		logger.debug("jsonData = " + jsonData);
    	}
    	return jsonData;
    }
    
    @RequestMapping(value = "/com/wrh/wrhOrderStatusDetailConfirm.do")
    @ResponseBody
    public JsonData wrhOrderStatusDetailConfirm(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		paramMap.put("MOD_USER", getUserId());
    		Map<String, Object> responseMap = wrhOrderStatusService.wrhOrderStatusDetailConfirm(paramMap);
    		System.out.println("SUCC_YN::" + responseMap.get("SUCC_YN").toString());
    		if ("Y".equals(responseMap.get("SUCC_YN").toString())) {
    			jsonData.setStatus("SUCC");
    			
    	        Map<String, Object> dataMap       = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	        List<Map<String, Object>> delList = (List<Map<String, Object>>)dataMap.get("ALLDATA");
    			
    			// 발주확인 EAI 전송
    			IFMM036_BGT_S_DTIT_HEAD[] inheadRow = new IFMM036_BGT_S_DTIT_HEAD[delList.size()];
    			IFMM036_BGT_S_DTIT_HEAD inhead = new IFMM036_BGT_S_DTIT_HEAD();
    			
            	String flag = "";
            	String msg  = "";
            	
	            Calendar cal = Calendar.getInstance();
	            cal.setTime(new Date());
	            DateFormat uDate = new SimpleDateFormat("yyyyMMdd");
	            
	            int rowIndex = 0;
                for (Map<String, Object> data: delList) {
                	
                	// 초기화
                	inhead = new IFMM036_BGT_S_DTIT_HEAD();
                	
    	            inhead.setBUKRS(StringUtil.isNullToString(data.get("COMP_CD")));
    	            inhead.setEBELN(StringUtil.isNullToString(data.get("PO_NUMBER")));
    	            inhead.setEBELP(StringUtil.isNullToString(data.get("PO_SEQ")));
    	            inhead.setLABNR(uDate.format(cal.getTime()));
    	            inhead.setZEDATE(StringUtil.isNullToString(data.get("RQ_DATE")));
    	            inhead.setZSREASON(StringUtil.isNullToString(data.get("REMARK")));
    	            
    	            System.out.println("COMP_CD ------------------>" +  StringUtil.isNullToString(data.get("COMP_CD"))); 
    	            System.out.println("PO_NUMBER ------------------>" +  StringUtil.isNullToString(data.get("PO_NUMBER")));
    	            System.out.println("PO_SEQ ------------------>" +  StringUtil.isNullToString(data.get("PO_SEQ")));
    	            System.out.println("RQ_DATE ------------------>" +  StringUtil.isNullToString(data.get("RQ_DATE")));
    	            System.out.println("REMARK ------------------>" +  StringUtil.isNullToString(data.get("REMARK")));
    	            
    	            inheadRow[rowIndex] = inhead;
    	            rowIndex++;
                }
            	
            	IFMM036_BGT_SOServiceLocator afs = new IFMM036_BGT_SOServiceLocator();
            	IFMM036_BGT_SOBindingStub af = (IFMM036_BGT_SOBindingStub)afs.getHTTP_Port();
            	IFMM036_BGT_S_DT_response res = new IFMM036_BGT_S_DT_response();
            	
	        	// USER ID/PW 셋팅
	           	String sapId= PropertiesUtil.getProperty("sap.id");
	           	String sapPw= PropertiesUtil.getProperty("sap.pw");
	           	af.setUsername(sapId);
	           	af.setPassword(sapPw);
               	
               	res = af.IFMM036_BGT_SO(inheadRow);
               	
               	// RESPONSE 정보 확인
               	flag = res.getIF_FLAG();
               	msg = res.getIF_MSG();

               	System.out.println("flag ------------------>" +  flag);
               	if (!"S".equals(flag)) {
               		int result2 = wrhOrderStatusService.wrhOrderStatusDetailConfirmCancel(paramMap);
               		jsonData.setStatus("FAIL");
               		jsonData.setErrMsg("발주확인 실패했습니다.");
               	} else {
               		jsonData.setStatus("SUCC"); 
               	}
    			
    		} else {
    			jsonData.setStatus("FAIL");
    			jsonData.setErrMsg("발주확인 실패했습니다.");
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

    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/wrh/wrhOrderStatusD.do")
    public String wrhOrderStatusD(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
			model.putAll(commonSelectService.selectCodeList(new String[]{"IG004","IG005","SYS001","IG001"}));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
        return "com/wrh/wrhOrderStatusD";
    }
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/wrh/wrhOrderStatusDV.do")
    public String wrhOrderStatusDV(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
			model.putAll(commonSelectService.selectCodeList(new String[]{"IG004","IG005","SYS001","IG001"}));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
        return "com/wrh/wrhOrderStatusDV";
    }    
    
}
