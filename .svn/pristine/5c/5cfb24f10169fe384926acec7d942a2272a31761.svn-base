
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

import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.JsonData;
import com.app.ildong.common.model.mvc.BaseController;
import com.app.ildong.common.service.CommonSelectService;
import com.app.ildong.common.session.UserSessionUtil;
import com.app.ildong.common.util.PropertiesUtil;
import com.app.ildong.common.util.StringUtil;
import com.app.ildong.sys.service.SysUserService;
import com.ecbank.framework.exception.BizException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.jdbc.BadSqlGrammarException;
import org.springframework.dao.DataIntegrityViolationException;

@Controller
public class SysUserController extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(SysUserController.class);
    
    private static final String sysErrMsg = "시스템 오류가 발생하였습니다.";
    
    @Autowired 
    private SysUserService userService;
    
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
    @RequestMapping("/com/sys/userList.do")
    public String userList(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
    	try {
			model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001"}));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
        return "com/sys/sysUserList";
    }

    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/com/sys/selectUserList.do")
    @ResponseBody
    public JsonData selectUserList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();

        try {

            List<Map<String,Object>> dataList = userService.selectUserList(paramMap);
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
            logger.error("사용자 관리 조회 오류", e);
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        return jsonData;
    }
    
    /*
     * 사용자 전환
     */
    
    @RequestMapping(value = "/com/sys/changeVendorUser.do")
    @ResponseBody
    public JsonData changeVendorUser(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) throws ServiceException, Exception {
        JsonData jsonData = new JsonData();

        try {
            Map<String,Object> userInfo = userService.selectUserLoginInfo(paramMap);
            
            if(userInfo != null){
                UserSessionUtil.setUserSession(request, userInfo);
                jsonData.setStatus("SUCC");
            }
            
        } catch (ServiceException se) {
            logger.error("사용자 전환 오류 오류", se);
            jsonData.setErrMsg(se.getMessage());
        } catch (Exception e) {
            logger.error("사용자 전환 오류 오류", e);
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

        if (logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        return jsonData;
    }
    
    /**
     * 사용자 검색 팝업으로 이동
     * @param userAgent
     * @param device
     * @param model
     * @return String
     */
    @RequestMapping("/com/sys/sysUserSearchPop.do")
    public String sysUserSearchPop(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, Model model) {
        
        model.addAllAttributes(paramMap);
        return "com/sys/sysUserSearchPop";
    }
    
    /**
     * 담당자 검색 팝업으로 이동
     * @param userAgent
     * @param device
     * @param model
     * @return String
     */
    @RequestMapping("/com/sys/sysPerUserSearchPop.do")
    public String sysPurUserSearchPop(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, Model model) {
        
        model.addAllAttributes(paramMap);
        return "com/sys/sysPerUserSearchPop";
    }
    
    /**
     * 사용자 정보 검색
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/sys/selectUsersList.do")
    @ResponseBody
    public JsonData selectUsersList(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, Model model) {
        
        JsonData jsonData = new JsonData();
        
        try {
//          paramMap.put("startRow" , getStartRow(paramMap));
//          paramMap.put("endRow"   , getEndRow(paramMap));
            
            List<Map<String,Object>> dataList = userService.selectUsersList(paramMap);
            
            jsonData.setPageRows(paramMap, dataList, 0);
            
            
//          if (null!=dataList && 0<dataList.size()) {
//              Integer totalCnt = Integer.valueOf( ((Map<String,Object>)dataList.get(0)).get("TOT_CNT").toString() ); 
//              jsonData.setPageRows(paramMap, dataList, totalCnt);
//              //jsonData.setPageRows(paramMap, dataList, 0);
//          } else {
//              jsonData.setPageRows(paramMap, null, 0);
//          }
            
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
     * 사용자 정보 검색
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/sys/selectPerUsersList.do")
    @ResponseBody
    public JsonData selectPerUsersList(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, Model model) {
        
        JsonData jsonData = new JsonData();
        
        try {
            
            List<Map<String,Object>> dataList = userService.selectPerUsersList(paramMap);
            jsonData.setPageRows(paramMap, dataList, 0);
            
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
     * 전자결재정보 조회 팝업
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/sys/sysUserAppViewPopup.do")
    public String sysUserAppViewPopup(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();
        
        try {
            //연계정보
            model.put("url",    PropertiesUtil.getProperty("appr.service.url"));
            model.put("apprId", StringUtil.nvl(paramMap.get("apprId"), ""));
        
        } catch (BizException se) {
            logger.error("전자결재정보 조회 팝업 화면 이동오류", se);
            jsonData.setErrMsg(se.getMessage());
        } catch (Exception e) {
            logger.error("전자결재정보 조회 팝업 화면 이동오류", e);
            jsonData.setErrMsg(sysErrMsg);
        }
        return "com/sys/sysUserAppViewPopup";
    }

    /**
     * 비밀번호 초기화
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/sys/saveInitPw.do")
    @ResponseBody
    public JsonData saveInitPw(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) throws ServiceException, Exception {
    	JsonData jsonData = new JsonData();
    	try {
    		
    		Map<String,Object> responseMap = userService.saveInitPw(paramMap);
    		
    		jsonData.setStatus("SUCC");
    		jsonData.addFields("result", responseMap);
    	
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
    
    
    /**
     * batch call
     * 배치 실행 
     * @param device
     * @param model
     * @return String
     */    
    @RequestMapping("/com/sys/InterfaceUser.do")
    @ResponseBody
    public JsonData callUserBatch(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
    	try {
    		
			//스케쥴러 직접 실행
			JobKey jobKey = new JobKey("MAKE_USER_DATA");
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
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     * @throws javax.xml.rpc.ServiceException 
     */
    @RequestMapping(value = "/com/sys/callEai.do")
    @ResponseBody
    public JsonData callEai(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) throws javax.xml.rpc.ServiceException {
        JsonData jsonData = new JsonData();

        try {
        	
//        	IFMM033_BGT_S_DTHEADER dtHeader = new IFMM033_BGT_S_DTHEADER();
//        	IFMM033_BGT_S_DT dt = new IFMM033_BGT_S_DT();
//        	String flag = "";
//        	String msg  = "";
//        	dtHeader.setI_LIFNR("");
//        	dtHeader.setI_UDATE_FR("20200630");
//        	dtHeader.setI_UDATE_TO("20200702");
//        	dtHeader.setI_UTIME_FR("000000");
//        	dtHeader.setI_UTIME_TO("235959");
//        	
//        	// HEADER 정보 셋팅
//        	dt.setHEADER(dtHeader);
//        	
//        	IFMM033_BGT_SOServiceLocator afs = new IFMM033_BGT_SOServiceLocator();
//        	IFMM033_BGT_SOBindingStub af = (IFMM033_BGT_SOBindingStub)afs.getHTTP_Port();
//        	IFMM033_BGT_S_DT_response res = new IFMM033_BGT_S_DT_response();
//        	
//        	// USER ID/PW 셋팅
//        	af.setUsername("podev1");
//           	af.setPassword("init1234!"); 
//           	
//           	res = af.IFMM033_BGT_SO(dt);
//           	
//           	IFMM033_BGT_S_DT_responseVEND_HEAD[] vendDtRow         = res.getVEND_HEAD();
//           	IFMM033_BGT_S_DT_responseVEND_PURCHORG[] purchorgDtRow = res.getVEND_PURCHORG();
//       		
//           	// RESPONSE 정보 확인
//           	flag = res.getRETRURN().getIF_FLAG();
//           	msg = res.getRETRURN().getIF_MSG();
//           	
//           	List<Map<String, Object>> vendList         = new ArrayList<Map<String, Object>>();
//           	List<Map<String, Object>> vendPurchorgList = new ArrayList<Map<String, Object>>();
//           	
//           	for (IFMM033_BGT_S_DT_responseVEND_HEAD vendDt : vendDtRow) {
//           		Map<String, Object> vendMap = new HashMap<String,Object>();
//                for (Field field : vendDt.getClass().getDeclaredFields()) {
//                    field.setAccessible(true);
//    				vendMap.put(field.getName(), field.get(vendDt));
//                }           		
//           		vendList.add(vendMap);
//           	}
//           	
//           	for (IFMM033_BGT_S_DT_responseVEND_PURCHORG purchorgDt : purchorgDtRow) {
//           		Map<String, Object> purchorgMap = new HashMap<String,Object>();
//                for (Field field : purchorgDt.getClass().getDeclaredFields()) {
//                    field.setAccessible(true);
//    				purchorgMap.put(field.getName(), field.get(purchorgDt));
//                }           		
//                vendPurchorgList.add(purchorgMap);
//           	}           	
//
//           	jsonData.addFields("vendList", vendList);
//           	jsonData.addFields("purchorgList", vendPurchorgList);
//           	
            jsonData.setStatus("SUCC");           	
        	
//       	} catch (RemoteException e) {
//       		// TODO Auto-generated catch block
//       		e.printStackTrace();
//       		jsonData.setStatus("Fail");
//       		logger.error("원격 메소드 호출 오류", e);
       	} catch (Exception e) {
       		// TODO Auto-generated catch block
       		e.printStackTrace();
       		jsonData.setStatus("Fail");
       		logger.error("오류", e);
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        return jsonData;
    }
    
}
