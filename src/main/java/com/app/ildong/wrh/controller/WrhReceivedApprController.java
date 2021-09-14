
package com.app.ildong.wrh.controller;

import java.text.DecimalFormat;
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
import com.app.ildong.common.mail.MailSender;
import com.app.ildong.common.model.JsonData;
import com.app.ildong.common.model.mvc.BaseController;
import com.app.ildong.common.service.CommonSelectService;
import com.app.ildong.common.util.DateUtil;
import com.app.ildong.common.util.PropertiesUtil;
import com.app.ildong.wrh.service.WrhReceivedApprService;
import com.app.ildong.wrh.service.WrhStockDueDateRegistService;

@Controller
public class WrhReceivedApprController extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(WrhReceivedApprController.class);
    
    private static final String sysErrMsg = "시스템 오류가 발생하였습니다.";
    
	@Autowired
    private CommonSelectService commonSelectService;
	
    @Autowired 
    private WrhReceivedApprService wrhReceivedApprService;
    
    @Autowired 
    private WrhStockDueDateRegistService wrhStockDueDateRegistService;
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/wrh/wrhReceivedAppr.do")
    public String wrhReceivedAppr(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
			model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001","IG007","E102"}));
			model.put("CODELIST_IG", commonSelectService.setCommMap(new String[]{"IG007","ALL","ATTR01"}));
			model.putAll(commonSelectService.selectPlandCodeList("SYSPLT"));
			model.putAll(commonSelectService.selectStorageCodeList("SYSSTR"));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
        return "com/wrh/wrhReceivedAppr";
    }

    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/com/wrh/selectReceivedAppr.do")
    @ResponseBody
    public JsonData selectWhrReceivedApprList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();

        try {

            List<Map<String,Object>> dataList = wrhReceivedApprService.selectReceivedAppr(paramMap);
            if (null!=dataList && 0<dataList.size()) {
                Integer totalCnt = Integer.valueOf( ((Map<String,Object>)dataList.get(0)).get("TOT_CNT").toString() );
                
                paramMap.put("APPEND_PAGE","APPEND_PAGE");
                jsonData.setPageRows(paramMap, dataList, totalCnt);
            } else {
                jsonData.setPageRows(paramMap, null, 0);
            }
            jsonData.setStatus("SUCC");
            jsonData.setRows(dataList);
            
        } catch (Exception e) {
            logger.error("입고승인 조회 오류", e);
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        return jsonData;
    }
    
    @RequestMapping(value = "/com/wrh/apprReceived.do")
    @ResponseBody
    public JsonData apprReceived(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		Map<String,Object> responseMap = wrhReceivedApprService.apprReceived(paramMap);
    		
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

    @RequestMapping(value = "/com/wrh/returnReceivedAppr.do")
    @ResponseBody
    public JsonData returnReceivedAppr(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		Map<String,Object> responseMap = wrhReceivedApprService.returnReceived(paramMap);
    		
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

    @RequestMapping(value = "/com/wrh/apprReceivedDetail.do")
    @ResponseBody
    public JsonData apprReceivedDetail(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		Map<String,Object> responseMap = wrhReceivedApprService.apprReceivedDetail(paramMap);
    		
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
    
    @RequestMapping(value = "/com/wrh/returnReceivedApprDetail.do")
    @ResponseBody
    public JsonData returnReceivedApprDetail(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		Map<String,Object> responseMap = wrhReceivedApprService.returnReceivedApprDetail(paramMap);
    		
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
    

	@RequestMapping(value = "/com/wrh/sendMail.do")
	@ResponseBody
	public JsonData sendMail(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData    = new JsonData();
		DecimalFormat df     = new DecimalFormat("###,###");
        String result        = null;
        String receiverEmail = null;
        String subject       = null;
        MailSender service   = new MailSender();
        
        if (PropertiesUtil.isRealMode()) {
            if("DETAIL".equals(paramMap.get("GUBN"))) {
                
    	        try {
    	        	String senderEmail = (String)paramMap.get("EMAIL_ID");
    	        	List<Map<String,Object>> receiverList = wrhStockDueDateRegistService.selectWhrStockDueDateReceiverList(paramMap);
    	        	
    	            for (Map<String, Object> receiverData: receiverList) {
    	            	receiverEmail = (String)receiverData.get("RECEIVER_EMAIL");
    	            	if("AC".equals((String)paramMap.get("STAT"))) {
    	            		subject = "제목 : [일동제약] 입고예정정보 승인변경내역_" + DateUtil.getFormatHanString(DateUtil.getCurrentDateTimeAsString(), "YYYYMMDD");
    	            	} else {
    	            		subject = "제목 : [일동제약] 입고예정정보 승인처리내역_" + DateUtil.getFormatHanString(DateUtil.getCurrentDateTimeAsString(), "YYYYMMDD");	
    	            	}
    		        	
    		        	// 메일에 출력할 텍스트
    		            StringBuffer sb = new StringBuffer();
    		    	 	sb.append("<!DOCTYPE html>");
    		    	 	sb.append( "<html lang='ko'>");
    		    	 	sb.append( "<head>");
    		    	 	sb.append( "<meta charset='UTF-8'>");
    		    	 	sb.append( "<meta http-equiv='Content-Type' content='text/html; charset=utf-8'/>");
    		    	 	sb.append( "</head>");
    		    	 	sb.append( "<table align='center' border='0' cellspacing='0' cellpadding='0' style='width:798px; margin:13px auto;'>");
    		    	 	sb.append( "<tr>");
    		    	 	sb.append( "<td><img src='https://srm.ildong.com/resources/images/common/mailform_ft_logo.png' align='left'></td>");
    		    	 	sb.append( "</tr>");
    		    	 	sb.append( "</table>");
    		    		
    		    	 	sb.append( "<table align='center' border='0' cellspacing='0' cellpadding='0' style='width:798px; border:1px solid #dfdfe3; border-top:3px solid #444;'>");
    		    	 	sb.append( "<tr>");
    		    	 	sb.append( "<td><img src='https://srm.ildong.com/resources/images/common/mailform_top.jpg' width='798' height='89' style='border-bottom:1px solid #dfdfe3;'></td>");
    		    	 	sb.append( "</tr>");
    		    	 	
    		    	 	sb.append( "<tr>");
    		    	 	sb.append( "<td style='width:798px; padding:40px 0 0 0;'>");
    		    	 	sb.append( "<table border='0' cellspacing='0' cellpadding='0' width='700' align='center' style='margin:0 49px 0 49px'>");
    		    	 	sb.append( "<tr>");
    		    	 	sb.append( "<td  style='font-family:NotoSans, Malgun Gothic,돋움, Dotum, sans-serif; font-size:24px; color:#222; padding-bottom:10px; letter-spacing:-1px; font-weight:900;'>");
    		    	 	sb.append(subject);
    		    	 	sb.append( "<p style='height:4px; padding:30px 0 0 0; margin:0'><div style='width:40px; height:4px; background-color:#429db0'></div></p>");
    		    	 	sb.append( "</td>");
    		    	 	sb.append( "</tr>");
    		    	 	sb.append( "</table>");
    		    	 	sb.append( "<table border='0' cellspacing='0' cellpadding='0' width='700' align='center' style='margin:0 49px 0 49px'>");
    		    	 	sb.append( "<tbody>");
    		    	 	sb.append( "<tr>");
    		    	 	sb.append( "<td style='font-family:NotoSans, Malgun Gothic,돋움, Dotum, sans-serif; font-size:14px; color:#444; line-height:22px;'>");
    		    	 	
    		    	 	
    		            sb.append("<h5>※ 요청하신 입고예정정보가 <span  style='color: red;'>"+(String)paramMap.get("STATUS_NM")+"</span> 되었습니다.</h5>\n");
    		            sb.append("<h5>▶ 업체명 :&nbsp;" + (String)paramMap.get("VENDOR_NM")+"</h5>\n");
    		            sb.append("<h5>▶ 문서번호 :&nbsp;" + (String)paramMap.get("DOC_NO")+"</h5>\n");
    		            sb.append("<h5>▶ 입고예정일시 :&nbsp;" + (String)paramMap.get("GR_DATE_TIME")+"</h5>\n");
    		            sb.append("<h5>▶ 납품처 :&nbsp;" + (String)paramMap.get("FULL_LOCATION")+"</h5>\n");
    		            sb.append("<h5>▶ 납품내역 </h5>");

    		            sb.append( "<table style='width:100%;table-layout:fixed;border-top:2px solid #2d5ab5;border-right:1px solid #e0e0e0;'>");
    		            sb.append( "<colgroup>");
    		            sb.append( "<col style='width:100px'>");
    		            sb.append( "<col style='width:50px'>");
    		            sb.append( "<col style='width:100px'>");
    		            sb.append( "<col style='width:250px'>");
    		            sb.append( "<col style='width:50px'>");
    		            sb.append( "<col style='width:100px'>");
    		            sb.append( "</colgroup>");
    		            sb.append( "<tbody>");
    		            sb.append( "<tr>");
    		            sb.append( "<th style='text-align:center; height:25px; padding:5px 8px; border-left:1px solid #e0e0e0; border-bottom:1px solid #e0e0e0; background-color:#f1f2f6'>발주번호</th>");
    		            sb.append( "<th style='text-align:center; height:25px; padding:5px 8px; border-left:1px solid #e0e0e0; border-bottom:1px solid #e0e0e0; background-color:#f1f2f6'>항번</th>");
    		            sb.append( "<th style='text-align:center; height:25px; padding:5px 8px; border-left:1px solid #e0e0e0; border-bottom:1px solid #e0e0e0; background-color:#f1f2f6'>자재코드</th>");
    		            sb.append( "<th style='text-align:center; height:25px; padding:5px 8px; border-left:1px solid #e0e0e0; border-bottom:1px solid #e0e0e0; background-color:#f1f2f6'>자재내역</th>");
    		            sb.append( "<th style='text-align:center; height:25px; padding:5px 8px; border-left:1px solid #e0e0e0; border-bottom:1px solid #e0e0e0; background-color:#f1f2f6'>로트번호</th>");
    		            sb.append( "<th style='text-align:center; height:25px; padding:5px 8px; border-left:1px solid #e0e0e0; border-bottom:1px solid #e0e0e0; background-color:#f1f2f6'>납품수량</th>");
    		            sb.append( "</tr>");
    		            
    		            List<Map<String,Object>> detailList = wrhStockDueDateRegistService.selectWhrStockDueDateRegistDetailList(paramMap);
    		            
    		            for (Map<String, Object> detailData: detailList) {
    		                sb.append( "<tr>");
    		                sb.append( "<td style='height:25px;padding:5px 8px;border-left:1px solid #e0e0e0;border-bottom:1px solid #e0e0e0;color:#666;text-align:center;'>" + detailData.get("PO_NUMBER") + "</td>");
    		                sb.append( "<td style='height:25px;padding:5px 8px;border-left:1px solid #e0e0e0;border-bottom:1px solid #e0e0e0;color:#666;text-align:center;'>" + detailData.get("PO_SEQ") + "</td>");
    		                sb.append( "<td style='height:25px;padding:5px 8px;border-left:1px solid #e0e0e0;border-bottom:1px solid #e0e0e0;color:#666;text-align:center;'>" + detailData.get("MAT_NUMBER") + "</td>");
    		                sb.append( "<td style='height:25px;padding:5px 8px;border-left:1px solid #e0e0e0;border-bottom:1px solid #e0e0e0;color:#666;text-align:left;'>" + detailData.get("MAT_DESC") + "</td>");
    		                sb.append( "<td style='height:25px;padding:5px 8px;border-left:1px solid #e0e0e0;border-bottom:1px solid #e0e0e0;color:#666;text-align:right;'>" + detailData.get("MAKER_LOT_NO") + "</td>");
    		                sb.append( "<td style='height:25px;padding:5px 8px;border-left:1px solid #e0e0e0;border-bottom:1px solid #e0e0e0;color:#666;text-align:right;'>" + df.format(detailData.get("ITEM_QTY")) + "</td>");
    		                sb.append( "</tr>");
    		            	
    		            }
    		            sb.append( "</td>");
    		            sb.append( "</tr>");	            
    		            sb.append( "<tr>");
    		            sb.append( "<td height='20'></td>");
    		            sb.append( "</tr>");
    		            sb.append( "<tr>");
    		            sb.append( "<td>");
    		            sb.append( "</table>");
    		            sb.append( "<table align='center' style='margin:0 auto;'>");
    		            sb.append( "<tbody>");
    		            sb.append( "<tr>");
    		            sb.append( "<td style='width:236px; height:38px; text-align:center; background-color:#429db0;'>");
    		            sb.append( "<a href='https://srm.ildong.com' style='font-size:14px; color:#fff; text-decoration:none; font-family:NotoSans, Malgun Gothic,돋움, Dotum, sans-serif; font-weight:600;'>전사시스템 바로가기</a>");
    		            sb.append( "</td>");
    		            sb.append( "</tr>");
    		            sb.append( "<tr>");			
    		            sb.append( "<td style='height:20px;'></td>");			
    		            sb.append( "</tr>");			
    		            sb.append( "</tbody>");			
    		            sb.append( "</table>");			
    		            sb.append( "</td>");			
    		            sb.append( "</tr>");			
    		            sb.append( "</table>");			
    		            sb.append( "<table border='0' cellspacing='0' cellpadding='0' width='700' style='margin:30px 49px 0 49px; padding:20px 35px; text-align:center; border-top:1px solid #b4b4b4'>");
    		            sb.append( "<tr>");
    		            sb.append( "<td style='font-size:12px; color:#888; font-family:'NotoSans', 'Malgun Gothic','돋움', 'Dotum', sans-serif;'>");
    		            sb.append( "COPYRIGHT ⓒ ILDONG PHARMACEUTICAL CO.,LTD. ALL RIGHTS RESERVED.");
    		            sb.append( "</td>");
    		            sb.append( "</tr>");
    		            sb.append( "</table>");
    		            sb.append( "</td>");
    		            sb.append( "</tr>");
    		            sb.append( "</tbody>");
    		            sb.append( "</table>");
    		            sb.append( "</body>");
    		            sb.append( "</html>");
    		            String contents = sb.toString();
    		            
    		            result = service.sendMail(senderEmail, receiverEmail, subject, contents);
    	            }
    	        	
    	        } catch (Exception e) {
    	        	e.printStackTrace();
    	        }
        			        	
            } else {
                Map<String, Object> dataMap        = (Map<String, Object>) paramMap.get("ITEM_LIST");
                List<Map<String, Object>> headList = (List<Map<String, Object>>)dataMap.get("UPDATED");
                
                for (Map<String, Object> headData: headList) {
        	        try {
        	        	String senderEmail = (String)paramMap.get("EMAIL_ID");
        	        	paramMap.put("DOC_NO", headData.get("DOC_NO"));
        	            paramMap.put("TB_DOC_NO", headData.get("DOC_NO"));
        	        	List<Map<String,Object>> receiverList = wrhStockDueDateRegistService.selectWhrStockDueDateReceiverList(paramMap);
        	        	
        	            for (Map<String, Object> receiverData: receiverList) {
        	            	receiverEmail = (String)receiverData.get("RECEIVER_EMAIL");
        	            	if("AC".equals((String)paramMap.get("STAT"))) {
        	            		subject = "제목 : [일동제약] 입고예정정보 승인변경내역_" + DateUtil.getFormatHanString(DateUtil.getCurrentDateTimeAsString(), "YYYYMMDD");
        	            	} else {
        	            		subject = "제목 : [일동제약] 입고예정정보 승인처리내역_" + DateUtil.getFormatHanString(DateUtil.getCurrentDateTimeAsString(), "YYYYMMDD");	
        	            	}
        		        	
        		        	// 메일에 출력할 텍스트
        		            StringBuffer sb = new StringBuffer();
        		    	 	sb.append("<!DOCTYPE html>");
        		    	 	sb.append( "<html lang='ko'>");
        		    	 	sb.append( "<head>");
        		    	 	sb.append( "<meta charset='UTF-8'>");
        		    	 	sb.append( "<meta http-equiv='Content-Type' content='text/html; charset=utf-8'/>");
        		    	 	sb.append( "</head>");
        		    	 	sb.append( "<table align='center' border='0' cellspacing='0' cellpadding='0' style='width:798px; margin:13px auto;'>");
        		    	 	sb.append( "<tr>");
        		    	 	sb.append( "<td><img src='https://srm.ildong.com/resources/images/common/mailform_ft_logo.png' align='left'></td>");
        		    	 	sb.append( "</tr>");
        		    	 	sb.append( "</table>");
        		    		
        		    	 	sb.append( "<table align='center' border='0' cellspacing='0' cellpadding='0' style='width:798px; border:1px solid #dfdfe3; border-top:3px solid #444;'>");
        		    	 	sb.append( "<tr>");
        		    	 	sb.append( "<td><img src='https://srm.ildong.com/resources/images/common/mailform_top.jpg' width='798' height='89' style='border-bottom:1px solid #dfdfe3;'></td>");
        		    	 	sb.append( "</tr>");
        		    	 	
        		    	 	sb.append( "<tr>");
        		    	 	sb.append( "<td style='width:798px; padding:40px 0 0 0;'>");
        		    	 	sb.append( "<table border='0' cellspacing='0' cellpadding='0' width='700' align='center' style='margin:0 49px 0 49px'>");
        		    	 	sb.append( "<tr>");
        		    	 	sb.append( "<td  style='font-family:NotoSans, Malgun Gothic,돋움, Dotum, sans-serif; font-size:24px; color:#222; padding-bottom:10px; letter-spacing:-1px; font-weight:900;'>");
        		    	 	sb.append(subject);
        		    	 	sb.append( "<p style='height:4px; padding:30px 0 0 0; margin:0'><div style='width:40px; height:4px; background-color:#429db0'></div></p>");
        		    	 	sb.append( "</td>");
        		    	 	sb.append( "</tr>");
        		    	 	sb.append( "</table>");
        		    	 	sb.append( "<table border='0' cellspacing='0' cellpadding='0' width='700' align='center' style='margin:0 49px 0 49px'>");
        		    	 	sb.append( "<tbody>");
        		    	 	sb.append( "<tr>");
        		    	 	sb.append( "<td style='font-family:NotoSans, Malgun Gothic,돋움, Dotum, sans-serif; font-size:14px; color:#444; line-height:22px;'>");
        		    	 	
        		    	 	
        		            sb.append("<h5>※ 요청하신 입고예정정보가 <span  style='color: red;'>"+(String)paramMap.get("STATUS_NM")+"</span> 되었습니다.</h5>\n");
        		            sb.append("<h5>▶ 업체명 :&nbsp;" + (String)headData.get("VENDOR_NM")+"</h5>\n");
        		            sb.append("<h5>▶ 문서번호 :&nbsp;" + (String)headData.get("DOC_NO")+"</h5>\n");
        		            sb.append("<h5>▶ 입고예정일시 :&nbsp;" + (String)headData.get("GR_DATE_TIME")+"</h5>\n");
        		            sb.append("<h5>▶ 납품처 :&nbsp;" + (String)headData.get("FULL_LOCATION")+"</h5>\n");
        		            sb.append("<h5>▶ 납품내역 </h5>");

        		            sb.append( "<table style='width:100%;table-layout:fixed;border-top:2px solid #2d5ab5;border-right:1px solid #e0e0e0;'>");
        		            sb.append( "<colgroup>");
        		            sb.append( "<col style='width:100px'>");
        		            sb.append( "<col style='width:50px'>");
        		            sb.append( "<col style='width:100px'>");
        		            sb.append( "<col style='width:250px'>");
        		            sb.append( "<col style='width:50px'>");
        		            sb.append( "<col style='width:100px'>");
        		            sb.append( "</colgroup>");
        		            sb.append( "<tbody>");
        		            sb.append( "<tr>");
        		            sb.append( "<th style='text-align:center; height:25px; padding:5px 8px; border-left:1px solid #e0e0e0; border-bottom:1px solid #e0e0e0; background-color:#f1f2f6'>발주번호</th>");
        		            sb.append( "<th style='text-align:center; height:25px; padding:5px 8px; border-left:1px solid #e0e0e0; border-bottom:1px solid #e0e0e0; background-color:#f1f2f6'>항번</th>");
        		            sb.append( "<th style='text-align:center; height:25px; padding:5px 8px; border-left:1px solid #e0e0e0; border-bottom:1px solid #e0e0e0; background-color:#f1f2f6'>자재코드</th>");
        		            sb.append( "<th style='text-align:center; height:25px; padding:5px 8px; border-left:1px solid #e0e0e0; border-bottom:1px solid #e0e0e0; background-color:#f1f2f6'>자재내역</th>");
        		            sb.append( "<th style='text-align:center; height:25px; padding:5px 8px; border-left:1px solid #e0e0e0; border-bottom:1px solid #e0e0e0; background-color:#f1f2f6'>로트번호</th>");
        		            sb.append( "<th style='text-align:center; height:25px; padding:5px 8px; border-left:1px solid #e0e0e0; border-bottom:1px solid #e0e0e0; background-color:#f1f2f6'>납품수량</th>");
        		            sb.append( "</tr>");
        		            
        		            List<Map<String,Object>> detailList = wrhStockDueDateRegistService.selectWhrStockDueDateRegistDetailList(paramMap);
        		            
        		            for (Map<String, Object> detailData: detailList) {
        		                sb.append( "<tr>");
        		                sb.append( "<td style='height:25px;padding:5px 8px;border-left:1px solid #e0e0e0;border-bottom:1px solid #e0e0e0;color:#666;text-align:center;'>" + detailData.get("PO_NUMBER") + "</td>");
        		                sb.append( "<td style='height:25px;padding:5px 8px;border-left:1px solid #e0e0e0;border-bottom:1px solid #e0e0e0;color:#666;text-align:center;'>" + detailData.get("PO_SEQ") + "</td>");
        		                sb.append( "<td style='height:25px;padding:5px 8px;border-left:1px solid #e0e0e0;border-bottom:1px solid #e0e0e0;color:#666;text-align:center;'>" + detailData.get("MAT_NUMBER") + "</td>");
        		                sb.append( "<td style='height:25px;padding:5px 8px;border-left:1px solid #e0e0e0;border-bottom:1px solid #e0e0e0;color:#666;text-align:left;'>" + detailData.get("MAT_DESC") + "</td>");
        		                sb.append( "<td style='height:25px;padding:5px 8px;border-left:1px solid #e0e0e0;border-bottom:1px solid #e0e0e0;color:#666;text-align:right;'>" + detailData.get("MAKER_LOT_NO") + "</td>");
        		                sb.append( "<td style='height:25px;padding:5px 8px;border-left:1px solid #e0e0e0;border-bottom:1px solid #e0e0e0;color:#666;text-align:right;'>" + df.format(detailData.get("ITEM_QTY")) + "</td>");
        		                sb.append( "</tr>");
        		            	
        		            }
        		            sb.append( "</td>");
        		            sb.append( "</tr>");	            
        		            sb.append( "<tr>");
        		            sb.append( "<td height='20'></td>");
        		            sb.append( "</tr>");
        		            sb.append( "<tr>");
        		            sb.append( "<td>");
        		            sb.append( "</table>");
        		            sb.append( "<table align='center' style='margin:0 auto;'>");
        		            sb.append( "<tbody>");
        		            sb.append( "<tr>");
        		            sb.append( "<td style='width:236px; height:38px; text-align:center; background-color:#429db0;'>");
        		            sb.append( "<a href='https://srm.ildong.com' style='font-size:14px; color:#fff; text-decoration:none; font-family:NotoSans, Malgun Gothic,돋움, Dotum, sans-serif; font-weight:600;'>전사시스템 바로가기</a>");
        		            sb.append( "</td>");
        		            sb.append( "</tr>");
        		            sb.append( "<tr>");			
        		            sb.append( "<td style='height:20px;'></td>");			
        		            sb.append( "</tr>");			
        		            sb.append( "</tbody>");			
        		            sb.append( "</table>");			
        		            sb.append( "</td>");			
        		            sb.append( "</tr>");			
        		            sb.append( "</table>");			
        		            sb.append( "<table border='0' cellspacing='0' cellpadding='0' width='700' style='margin:30px 49px 0 49px; padding:20px 35px; text-align:center; border-top:1px solid #b4b4b4'>");
        		            sb.append( "<tr>");
        		            sb.append( "<td style='font-size:12px; color:#888; font-family:'NotoSans', 'Malgun Gothic','돋움', 'Dotum', sans-serif;'>");
        		            sb.append( "COPYRIGHT ⓒ ILDONG PHARMACEUTICAL CO.,LTD. ALL RIGHTS RESERVED.");
        		            sb.append( "</td>");
        		            sb.append( "</tr>");
        		            sb.append( "</table>");
        		            sb.append( "</td>");
        		            sb.append( "</tr>");
        		            sb.append( "</tbody>");
        		            sb.append( "</table>");
        		            sb.append( "</body>");
        		            sb.append( "</html>");
        		            String contents = sb.toString();
        		            
        		            result = service.sendMail(senderEmail, receiverEmail, subject, contents);
        	            }
        	        	
        	        } catch (Exception e) {
        	        	e.printStackTrace();
        	        }
        			        	
                }        	
            }
            
        	try {
    			Map<String,Object> responseMap = wrhStockDueDateRegistService.insertSmsData(paramMap);
    			jsonData.setStatus("SUCC");
    			jsonData.addFields("result", responseMap);
    	    } catch (Exception e) {
    	    	e.printStackTrace();
    	    	jsonData.setErrMsg(e.getMessage());
    	    }
        	
    		return jsonData;        	
        } else {
			jsonData.setStatus("SUCC");
    		return jsonData;        	
        }
        

	}
    
}
