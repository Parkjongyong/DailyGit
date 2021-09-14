package com.app.ildong.mai.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
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
import com.app.ildong.common.service.LoginAuthService;
import com.app.ildong.common.util.FileUtil;
import com.app.ildong.common.util.PropertiesUtil;
import com.app.ildong.mai.service.MainRoleViewService;
import com.app.ildong.sys.dao.SysMainImageDAO;
import com.app.ildong.sys.service.SysBoardService;
import com.app.ildong.sys.service.SysMainImageService;

@Controller
public class MainRoleViewController extends BaseController {
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private MainRoleViewService mainRoleViewService;
	
	@Autowired
	private SysBoardService sysBoardService;
	
	@Autowired
	private SysMainImageDAO sysMainImageDAO;	
	
	@Autowired
	private LoginAuthService loginAuthService;
	
	@Autowired
    private CommonSelectService commonSelectService;

    @Autowired 
    private SysMainImageService sysMainImageService;
	
	
	@RequestMapping(value = "/main.do")
	public String goMainPage(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws Exception {
		String fowardPage = "";
		String page1 = "main/main";
		String page2 = "main/main2";
		String page3 = "wrhStorageSpaceM";
		
		model.putAll(paramMap);
		
		paramMap.put("USER_ID", getUserId());
		
		//공지사항
		paramMap.put("COMP_CD", getCompCd());
		paramMap.put("status", "1");
		paramMap.put("startRow", "0");
		paramMap.put("pageSize", "5");
		paramMap.put("BOARD_ID", 001);
		
		model.addAttribute("noticeList", sysBoardService.selectBoardList(paramMap));
		
		//자료실
		paramMap.put("pageSize", "5");
		paramMap.put("BOARD_ID", 002);
		model.addAttribute("archiveList", sysBoardService.selectBoardList(paramMap));
		
		model.addAttribute("inImgList", sysMainImageService.selectInImageList(paramMap));
		model.addAttribute("outImgList", sysMainImageService.selectOutImageList(paramMap));
		
		if(getUserRole().contains(PropertiesUtil.getProperty("ROLE_PUR")) || getDeptRole().contains(PropertiesUtil.getProperty("ROLE_PUR"))) {
			paramMap.put("ROLE_PUR", "Y");
		}else {
			paramMap.put("ROLE_PUR", "N");
		}
		
		paramMap.put("MAIN_WORK_TYPE", getSessionAttribute("MAIN_WORK_TYPE"));
		
		List<Map<String, Object>> imageList = sysMainImageDAO.selectMainImageList(paramMap);
		int cnt = 1;
		for (Map<String, Object> imageMap: imageList) {
			paramMap.put("IMAGE_URL" + cnt, imageMap.get("FILE_PATH").toString());
		}
		
		System.out.println("/main.do USER_CLS :" + (String)paramMap.get("USER_CLS"));
		if (getUserCls().equals("B")) {
			fowardPage = page1;
		} else {
			List<Map<String,Object>> noticeInfo = loginAuthService.selectNoticeList(paramMap);
	    	model.addAttribute("noticeInfo", noticeInfo);
	    	List<Map<String,Object>> todoInfo = loginAuthService.selectTodoInfoList(paramMap);
	    	model.addAttribute("oferCnt", todoInfo.get(0).get("OFER_CNT"));
	    	model.addAttribute("oferCompCnt", todoInfo.get(0).get("OFER_COMP_CNT"));
	    	model.addAttribute("cmpnCnt", todoInfo.get(0).get("CMPN_CNT"));
	    	model.addAttribute("G_TOP_MENU_CD", todoInfo.get(0).get("G_TOP_MENU_CD"));
	    	model.addAttribute("G_TOP_MENU_NM", todoInfo.get(0).get("G_TOP_MENU_NM"));
	    	model.addAttribute("G_UP_MENU_CD", todoInfo.get(0).get("G_UP_MENU_CD"));
	    	model.addAttribute("G_MENU_CD", todoInfo.get(0).get("G_MENU_CD"));
	    	
			fowardPage = page2;
		}

		if(request.getHeader("User-Agent").toUpperCase().indexOf("MOBILE") > -1) {
			model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001", "IG002"}));
			model.putAll(commonSelectService.selectStorageCompList("ST_COMP"));
			model.putAll(commonSelectService.selectStoragePlantList("ST_PLANT"));
			model.putAll(commonSelectService.selectStorageList("ST_STORAGE"));

			fowardPage = page3;
		}
		
		return fowardPage;
	}

	@RequestMapping(value = "/siteMapPop.do")
	public String siteMapPop(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws Exception {
		String fowardPage = "com/mai/siteMapPop";
		
		model.putAll(paramMap);
		return fowardPage;
	}
	
	@RequestMapping(value = "/purProcessPop.do")
	public String purProcessPop(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws Exception {
		String fowardPage = "com/mai/purProcessPop";
		
		model.putAll(paramMap);
		return fowardPage;
	}
	
	@RequestMapping(value = "/alarmPop.do")
	public String alarmPop(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws Exception {
		String fowardPage = "com/mai/alarmPop";
		
		model.putAll(paramMap);
		return fowardPage;
	}
	
	@RequestMapping(value = "/taskManagerPop.do")
	public String taskManagerPop(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws Exception {
		String fowardPage = "com/mai/taskManagerPop";
		
		model.putAll(paramMap);
		
		return fowardPage;
	}
	
	
	
	//공지팝업 관리
	@RequestMapping("/com/mai/selectPopupMgmtListMain.do")
	@ResponseBody
	public JsonData selectPopupMgmtListMain(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();
		
		try {
    		logger.debug("=============================================================================");
		    
		    List<Map<String,Object>> dataList = mainRoleViewService.selectPopupMgmtListMain(paramMap);
            
		    logger.debug("paramMap PRESENT_FLAG  : " + paramMap.get("PRESENT_FLAG"));
		    
		    jsonData.setPageRows(paramMap, dataList, 0);
            
        } catch (Exception e) {
            logger.error("메인 팝업 조회 오류", e);
            jsonData.setErrMsg("메인 팝업 조회중 오류가 발생했습니다.");
        }
		
		if( logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
		
		return jsonData;
	}
	
	//공지팝업관리
	@RequestMapping("/com/mai/selectPopupMgmtMain.do")
	public String selectPopupMgmtMain(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, Model model) {
		try {
			model.addAttribute("popupView", mainRoleViewService.selectPopupMgmtMain(paramMap));
		}catch(Exception e) {
			logger.error("메인팝업 조회 오류", e);
		}
		return "com/sys/sysPopupMgmtView";
	}
    
	
	//거래품목/용어설명
	@RequestMapping("/com/mai/viewTradeItemTerm.do")
	public String viewTradeItemTerm(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, Model model) {
		
		model.addAllAttributes(paramMap);
		
		return "com/mai/maiViewTradeItemTerm";
	}
	
	
	//파일 다운로드
	@RequestMapping(value = "/com/mai/fileDownload.do")
	public void fileDownload(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, ModelMap model, HttpServletResponse response) throws Exception{

		String serverFilePath = (String)paramMap.get("FILE_PATH");
		String physicalName = (String)paramMap.get("FILE_NAME");
		String original = (String)paramMap.get("FILE_NAME");

		FileUtil.downloadFile(response, serverFilePath, physicalName, original);
		
	}

}
