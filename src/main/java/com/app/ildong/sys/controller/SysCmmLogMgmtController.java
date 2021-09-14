/**
 * 시스템관리 > 배치 관리 컨트롤러
 * @author 박종용
 * @since 2020.06.22
 *
 * << 개정이력(Modification Information) >>
 *  -------------------------------------------------
 *  수정일                    수정자            수정내용
 *  ----------   -------- ---------------------------
 *  2020.06.22   박종용            최초생성
 *  -------------------------------------------------
 */
package com.app.ildong.sys.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.app.ildong.common.model.JsonData;
import com.app.ildong.common.model.mvc.BaseController;
import com.app.ildong.common.service.CommonSelectService;
import com.app.ildong.common.util.StringUtil;
import com.app.ildong.sys.service.JCoProcessService;
import com.app.ildong.sys.service.SysCmmLogMgmtService;

@Controller
public class SysCmmLogMgmtController extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(SysCmmLogMgmtController.class);
    
    @Autowired
    private SchedulerFactoryBean schedulerFactoryBean;    
    
    @Autowired
    private CommonSelectService commonSelectService;
    
    @Autowired
    private JCoProcessService jCoProcessService;
    
    @Autowired
    private SysCmmLogMgmtService sysCmmLogMgmtService;
    
    /**
     * RFC 로그관리화면 전환
     */
    @RequestMapping("/com/sys/sysRfcLogMgmtView.do")
    public String sysCodeMgmtList(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
        model.addAttribute("paramMap", paramMap);
        return "com/sys/sysRfcLogMgmtView";
    }
    
    /**
     * 알림 로그관리화면 전환
     */
    @RequestMapping("/com/sys/sysAlarmLogMgmtView.do")
    public String sysAlarmLogMgmtView(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
        model.addAttribute("paramMap", paramMap);
        return "com/sys/sysAlarmLogMgmtView";
    }
    
    /**
     * 배치 관리화면 전환
     */
    @RequestMapping("/com/sys/sysBatchLogMgmtView.do")
    public String sysBatchLogMgmtView(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
        model.addAttribute("paramMap", paramMap);
        return "com/sys/sysBatchLogMgmtView";
    }
    
    /**
     * 배치 관리화면 전환
     */
    @RequestMapping("/com/sys/sysBatchLogMgmtDetailPop.do")
    public String sysBatchLogMgmtDetailPop(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
        model.addAttribute("paramMap", paramMap);
        return "com/sys/sysBatchLogMgmtDetailPop";
    }
    
    
    /**
     * init
     * RFC 로그 리스트 조회 
     * @param userAgent
     * @param device
     * @param model
     * @return String
     */
    @RequestMapping("/com/sys/selectRfcLogMgmtList.do")
    @ResponseBody
    public JsonData selectRfcLogMgmtList(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
        
        JsonData jsonData = new JsonData();
        
        try {
            
            List<Map<String,Object>> dataList = sysCmmLogMgmtService.selectRfcLogMgmtList(paramMap);
            
            if (null!=dataList && 0<dataList.size()) {
                Integer totalCnt = Integer.valueOf( ((Map<String,Object>)dataList.get(0)).get("TOT_CNT").toString() ); 
                //APPEND 페이지추가 모드
                paramMap.put("APPEND_PAGE","APPEND_PAGE");
                jsonData.setPageRows(paramMap, dataList, totalCnt);
            } else {
                jsonData.setPageRows(paramMap, null, 0);
            }

        } catch (Exception e) {
            e.printStackTrace();
            jsonData.setErrMsg(e.getMessage());
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        
        return jsonData;
    }
    
    @RequestMapping("/com/sys/sysRfcLogMgmtDetailPop.do")
    public String sysRfcLogMgmtDetailPop(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws Exception {
        
        Map<String,Object> rfcLogInfo = sysCmmLogMgmtService.selectRfcLogMgmtDetail(paramMap);
        
        model.addAttribute("rfcLogInfo", rfcLogInfo);   // Log 정보
        
        return "com/sys/sysRfcLogMgmtDetailPop";
    }
    
    /**
     * init
     * 알람 로그 리스트 조회 
     * @param userAgent
     * @param device
     * @param model
     * @return String
     */
    @RequestMapping("/com/sys/selectAlarmLogMgmtList.do")
    @ResponseBody
    public JsonData selectAlarmLogMgmtList(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
        
        JsonData jsonData = new JsonData();
        
        try {
            
            List<Map<String,Object>> dataList = sysCmmLogMgmtService.selectAlarmLogMgmtList(paramMap);
            
            if (null!=dataList && 0<dataList.size()) {
                Integer totalCnt = Integer.valueOf( ((Map<String,Object>)dataList.get(0)).get("TOT_CNT").toString() ); 
                //APPEND 페이지추가 모드
                paramMap.put("APPEND_PAGE","APPEND_PAGE");
                jsonData.setPageRows(paramMap, dataList, totalCnt);
            } else {
                jsonData.setPageRows(paramMap, null, 0);
            }

        } catch (Exception e) {
            e.printStackTrace();
            jsonData.setErrMsg(e.getMessage());
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        
        return jsonData;
    }
    
    @RequestMapping("/com/sys/sysAlarmLogMgmtDetailPop.do")
    public String sysAlarmLogMgmtDetailPop(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, Model model) throws Exception {
        
        Map<String,Object> alarmLogInfo = sysCmmLogMgmtService.selectAlarmLogMgmtDetail(paramMap);
        
        model.addAttribute("alarmLogInfo", alarmLogInfo);   // Log 정보
        
        return "com/sys/sysAlarmLogMgmtDetailPop";
    }
    
    
    /**
     * init
     * 배치관리 리스트 조회 
     * @param device
     * @param model
     * @return String
     */
    @RequestMapping("/com/sys/selectBatchLogMgmtList.do")
    @ResponseBody
    public JsonData selectBatchLogMgmtList(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
        
        JsonData jsonData = new JsonData();
        
        try {
            
            List<Map<String,Object>> dataList = sysCmmLogMgmtService.selectBatchLogMgmtList(paramMap);
            
            if (null!=dataList && 0<dataList.size()) {
                Integer totalCnt = Integer.valueOf( ((Map<String,Object>)dataList.get(0)).get("TOT_CNT").toString() ); 
                //APPEND 페이지추가 모드
                jsonData.setPageRows(paramMap, dataList, totalCnt);
            } else {
                jsonData.setPageRows(paramMap, null, 0);
            }

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
     * batch call
     * 배치 실행 
     * @param device
     * @param model
     * @return String
     */    
    @RequestMapping("/com/sys/sysCallBatch.do")
    @ResponseBody
    public JsonData callBatch(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		
        	Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
        	List<Map<String, Object>> updList = (List<Map<String, Object>>)dataMap.get("UPDATED");
        	
            if (null != updList && 0 < updList.size()) {
                for (Map<String, Object> data: updList) {
                	
                	// 화면에서 입력 받은 값을  UPDATE!
                	sysCmmLogMgmtService.updateBatchMaster(data);
        			//스케쥴러 직접 실행
        			JobKey jobKey = new JobKey(data.get("BATCH_ID").toString());
        			Scheduler scheduler = schedulerFactoryBean.getScheduler();
        			
        			scheduler.triggerJob(jobKey);
                }
            }      
        	
			jsonData.setStatus("SUCC");
    	
    	} catch (SchedulerException se) {
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
     * init
     * 배치관리 리스트 조회 
     * @param device
     * @param model
     * @return String
     */
    @RequestMapping("/com/sys/selectBatchLogMgmtDetailList.do")
    @ResponseBody
    public JsonData selectBatchLogMgmtDetailList(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
        
        JsonData jsonData = new JsonData();
        
        try {
            
            List<Map<String,Object>> dataList = sysCmmLogMgmtService.selectBatchLogMgmtDetailList(paramMap);
            
            if (null!=dataList && 0<dataList.size()) {
                Integer totalCnt = Integer.valueOf( ((Map<String,Object>)dataList.get(0)).get("TOT_CNT").toString() ); 
                //APPEND 페이지추가 모드
                paramMap.put("APPEND_PAGE","APPEND_PAGE");
                jsonData.setPageRows(paramMap, dataList, totalCnt);
            } else {
                jsonData.setPageRows(paramMap, null, 0);
            }

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
     * 배치 관리 오류 상세보기 화면 전환
     */
    @RequestMapping("/com/sys/sysBatchLogMgmtErrPop.do")
    public String sysBatchLogMgmtErrorPop(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws Exception {
        Map<String,Object> batchLogInfo = sysCmmLogMgmtService.selectBatchLogMgmtErrDetail(paramMap);
        
        model.addAttribute("batchLogInfo", batchLogInfo);   // Log 정보
        return "com/sys/sysBatchLogMgmtErrPop";
    }
    
    
    /**
     * JCO 재전송Y
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/com/sys/returnJcoInfo.do")
    @ResponseBody
    public JsonData returnJcoInfo(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();
        try {
                
            Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("JCO_PARAMS");
            
            if(!StringUtil.isEmpty( dataMap )){
                Map<String,Object> result = jCoProcessService.processJCoExecute(dataMap);
                
                String resultCd = (String)result.get("JCO_RESULT_CD");
                String resultMsg = (String)result.get("JCO_RESULT_MSG");
                
                if(!"".equals(resultCd)) {
                    jsonData.setStatus("SUCC");
                    jsonData.addFields("result", resultCd);
                }else{
                    jsonData.setStatus("FAIL");
                    jsonData.addFields("result", resultCd);
                    jsonData.setErrMsg(resultMsg);
                }
            }

        } catch (Exception e) {
            logger.error("SAP RFC 재 전송 중 오류", e);
            jsonData.setErrMsg(e.getMessage());
        }

        if (logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        return jsonData;
    }
}
