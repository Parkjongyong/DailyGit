/**
 * 코스트 조회 컨트롤러
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
package com.app.ildong.cmn.controller;

import java.util.ArrayList;
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
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.app.ildong.cmn.service.CmnCctrService;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.JsonData;
import com.app.ildong.common.model.mvc.BaseController;
import com.app.ildong.common.service.CommonSelectService;
import com.app.ildong.common.util.StringUtil;


@Controller
public class CmnCctrController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(CmnCctrController.class);
	
    @Autowired 
    private CmnCctrService cctrService;
    
	@Autowired
    private CommonSelectService commonSelectService;
	
    @Autowired
    private SchedulerFactoryBean schedulerFactoryBean;	
	
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/cmn/cctrList.do")
	public String cctrList(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
    		model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001"}));
    		model.addAttribute("PARAM", paramMap);
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "com/cmn/cmnCctrList";
	}
    
	/**
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/com/cmn/selectCctrList.do")
	@ResponseBody
	public JsonData selectCctrList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();

		try {
			
			List<Map<String, Object>> cctrList     = new ArrayList<Map<String, Object>>();
			
			String compGubn = StringUtil.isNullToString(paramMap.get("TB_COMP_GUBN"));
			// 부서견본에서 일동제약인 경우
			if ("A".equals(compGubn)) {
				cctrList = cctrService.selectCctrListA(paramMap);
			// 부서견본에서 일동제약이 아닌경우
			} else if ("B".equals(compGubn)) {
				cctrList = cctrService.selectCctrListB(paramMap);
			// 일반 예산관리에서 사용하는 코스트 센터 조회
			} else {
				cctrList = cctrService.selectCctrList(paramMap);
			}
			jsonData.setRows(cctrList);
			
		} catch (Exception e) {
			logger.error("com/cmn/selectCctrList.do 오류 발생", e);
			jsonData.setErrMsg(e.getMessage());
		}

		if (logger.isDebugEnabled()) {
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
    @RequestMapping("/com/sys/InterfaceCctr.do")
    @ResponseBody
    public JsonData callBatch(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		
			//스케쥴러 직접 실행
			JobKey jobKey = new JobKey("MAKE_DEPT_DATA");
			Scheduler scheduler = schedulerFactoryBean.getScheduler();
			scheduler.triggerJob(jobKey);
        	
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
}
