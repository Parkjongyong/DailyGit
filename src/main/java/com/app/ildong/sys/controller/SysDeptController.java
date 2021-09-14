/**
 * 부서 조회 컨트롤러
 * @author 길용덕
 * @since 2020.07.08
 * 
 * << 개정이력(Modification Information) >>
 *  ------------------------------------------------- 
 *  수정일                    수정자            수정내용
 *  ----------   -------- ---------------------------
 *  2020.07.08   길용덕            최초생성
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
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.JsonData;
import com.app.ildong.common.model.mvc.BaseController;
import com.app.ildong.common.service.CommonSelectService;
import com.app.ildong.sys.service.SysDeptService;


@Controller
public class SysDeptController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(SysDeptController.class);
	
    @Autowired 
    private SysDeptService deptService;
    
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
    @RequestMapping("/com/sys/deptList.do")
	public String deptList(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
    		model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001"}));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "com/sys/sysDeptList";
	}

	/**
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/com/sys/selectDeptList.do")
	@ResponseBody
	public JsonData selectDeptList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();

		try {
			List<Map<String, Object>> menuList = deptService.selectDeptList(paramMap);
			jsonData.setRows(menuList);
			
		} catch (Exception e) {
			logger.error("com/sys/selectDeptList.do 오류 발생", e);
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
    @RequestMapping("/com/sys/InterfaceDept.do")
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
