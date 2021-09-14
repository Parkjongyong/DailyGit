/**
 * 알림팝업 조회/등록/수정 컨트롤러
 * @author 길용덕
 * @since 2020.06.17
 * 
 * << 개정이력(Modification Information) >>
 *  ------------------------------------------------- 
 *  수정일                    수정자            수정내용
 *  ----------   -------- ---------------------------
 *  2020.06.18   길용덕            최초생성
 *  -------------------------------------------------
 */
package com.app.ildong.sys.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
import com.app.ildong.common.pagenation.PaginationInfo;
import com.app.ildong.common.service.CommonSelectService;
import com.app.ildong.common.service.FileManageService;
import com.app.ildong.common.util.FileUtil;
import com.app.ildong.common.util.PageUtil;
import com.app.ildong.common.util.StringUtil;
import com.app.ildong.sys.service.SysBoardService;
import com.app.ildong.sys.service.SysPopupMgmtService;

@Controller
public class SysPopupMgmtController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(SysPopupMgmtController.class);

	@Autowired
	private SysBoardService sysBoardService;
	
	@Autowired
    private SysPopupMgmtService sysPopupMgmtService;
	
	@Autowired
	private CommonSelectService commonSelectService;
	
	@Autowired
    private FileManageService fileManageService;
	
	@RequestMapping("/com/sys/sysBoardViewPop.do")
	public String sysBoardView(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws Exception {
		
		//필요공통코드 목록
		model.putAll(commonSelectService.selectCodeList(new String[]{"ADM002"}));
		
		paramMap.put("COMP_CD", getCompCd());
		
		sysBoardService.updateBoardHit(paramMap);
		
		model.addAttribute("boardInfo", sysBoardService.selectBoardInfo(paramMap));
		model.addAttribute("boardInfoAll", sysBoardService.selectBoardInfoAll(paramMap));
    	model.addAttribute("data", paramMap);
    	model.addAttribute("boardView", sysBoardService.selectBoard(paramMap));
    	
		return "com/sys/sysBoardViewPop";
	}
	
	@RequestMapping("/com/sys/sysBoardListPop.do")
	public String sysBoardList(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws Exception {
		String url = "com/sys/sysBoardListPop";
		
		paramMap.put("COMP_CD", getCompCd());
		
		Map<String, Object> boardInfo = sysBoardService.selectBoardInfo(paramMap);
		
		if("FAQ".equals(boardInfo.get("BOARD_TYPE"))) {
			//필요공통코드 목록
			model.putAll(commonSelectService.selectCodeList(new String[]{"ADM003"}));
			url = "com/sys/sysBoardListPopFaq";
		}
		
		model.addAttribute("boardInfo", boardInfo);
		model.addAttribute("boardInfoAll", sysBoardService.selectBoardInfoAll(paramMap));
    	model.addAttribute("data", paramMap);

		return url;
	}
	
	@RequestMapping("/com/sys/sysPopupMgmt.do")
    public String sysPopupMgmt(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, Model model) {
        
        return "com/sys/sysPopupMgmt";
    }
    
    @RequestMapping("/com/sys/selectSysPopupMgmtList.do")
    @ResponseBody
    public JsonData selectSysPopupMgmtList(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();
        
        try {

            List<Map<String,Object>> dataList = sysPopupMgmtService.selectSysPopupMgmtList(paramMap);
            if (null!=dataList && 0<dataList.size()) {
                Integer totalCnt = Integer.valueOf( ((Map<String,Object>)dataList.get(0)).get("TOT_CNT").toString() ); 
                jsonData.setPageRows(paramMap, dataList, totalCnt);
            } else {
                jsonData.setPageRows(paramMap, null, 0);
            }
            
        } catch (Exception e) {
            logger.error("팝업관리 조회 오류", e);
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        
        return jsonData;
    }
    
    @RequestMapping("/com/sys/sysPopupMgmtWrite.do")
    public String sysPopupMgmtWrite(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, Model model) {
        return "com/sys/sysPopupMgmtWrite";
    }
    
    
    @RequestMapping("/com/sys/insertPopupMgmt.do")
    @ResponseBody
    public JsonData insertPopupMgmt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();
        int result = 0;
        String resultCd = "";
        
        try {
            result = sysPopupMgmtService.insertPopupMgmt(paramMap);
            
            if(result > 0) {
                resultCd = "S";
            } else {
                resultCd = "E";
            }
            jsonData.addFields("resultCd", resultCd);

        } catch (Exception e) {
            logger.error("팝업관리 새 팝업 작성 저장 오류", e);
            jsonData.setErrMsg(e.getMessage());
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        
        return jsonData;
    }
    
    
    @RequestMapping("/com/sys/modifyPopupMgmt.do")
    @ResponseBody
    public JsonData modifyPopupMgmt(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();
        int result = 0;
        String resultCd = "";
        
        try {
            
            result = sysPopupMgmtService.updatePopupMgmt(paramMap);
            
            if(result > 0) {
                resultCd = "S";
            } else {
                resultCd = "E";
            }
            jsonData.addFields("resultCd", resultCd);

        } catch (Exception e) {
            logger.error("팝업관리 새 팝업 작성 수정 오류", e);
            jsonData.setErrMsg(e.getMessage());
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        
        return jsonData;
    }
    
    @RequestMapping("/com/sys/sysPopupMgmtModify.do")
    public String sysPopupMgmtModify(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, Model model) {
        
        model.addAttribute("popupView", sysPopupMgmtService.selectPopupMgmt(paramMap));
        
        return "com/sys/sysPopupMgmtModify";
    }
    
    @RequestMapping("/com/sys/sysPopupMgmtView.do")
    public String sysPopupMgmtView(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, Model model) {
        
        model.addAttribute("popupView", sysPopupMgmtService.selectPopupMgmt(paramMap));
        
        return "com/sys/sysPopupMgmtView";
    }
    
    
    @RequestMapping("/com/sys/selectSysPopupMgmtListMain.do")
    @ResponseBody
    public JsonData selectSysPopupMgmtListMain(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();
        
        try {
            logger.debug("=============================================================================");
            List<Map<String,Object>> dataList = sysPopupMgmtService.selectSysPopupMgmtListMain(paramMap);

            if (null!=dataList && 0<dataList.size()) {
                jsonData.setPageRows(paramMap, dataList, 0);
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
    
    @RequestMapping("/com/sys/selectPopupMgmtMain.do")
    public String selectPopupMgmtMain(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, Model model) {
        
        model.addAttribute("popupView", sysPopupMgmtService.selectPopupMgmtMain(paramMap));
        
        return "com/sys/sysPopupMgmtView";
    }
    
    @RequestMapping("/com/sys/sysBoardListPopup.do")
    public String sysBoardListPopup(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) throws Exception {

        // 공지사항
        JsonData jsonData = new JsonData();
        /*
         * BP 공지사항
         */
        List<Map<String, Object>> dataList = sysBoardService.selectNoticeList(paramMap);

        if (null != dataList && 0 < dataList.size()) {
            Integer totalCnt = Integer.valueOf(((Map<String, Object>) dataList.get(0)).get("TOT_CNT").toString());
            jsonData.setPageRows(paramMap, dataList, totalCnt);

            model.addAttribute("TOT_CNT", totalCnt);
            model.addAttribute("page", jsonData.getPage());
        } else {
            jsonData.setPageRows(paramMap, null, 0);

            model.addAttribute("TOT_CNT", "0");
            model.addAttribute("page", jsonData.getPage());
        }

        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(jsonData.getPage());
        paginationInfo.setRecordCountPerPage(jsonData.getPageUnit());
        paginationInfo.setPageSize(jsonData.getPageSize());
        paginationInfo.setTotalRecordCount(jsonData.getRecords());
        /*
         * BP 공지사항
         */
        model.addAttribute("dataList", dataList);
        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("boardInfo", sysBoardService.selectBoardInfo(paramMap));

        model.addAttribute("srchGrp", StringUtil.nvl(paramMap.get("srchGrp"), ""));
        model.addAttribute("srchTxt", StringUtil.nvl(paramMap.get("srchTxt"), ""));

        return "com/sys/sysBoardListPopup";
    }
    
    @RequestMapping(value = "/com/sys/sysBoardDetailPopup.do")
    public String sysBoardDetailPopup(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws Exception {
        
    	sysBoardService.updateBoardHit(paramMap);
        Map<String, Object> noticeInfo = sysBoardService.selectBoard(paramMap);
        Map<String, Object> subNoticeInfo = sysBoardService.selectSubNotice(paramMap); 
        
        if(!"".equals(StringUtil.nvl(noticeInfo.get("ATTACHMENT"), "")) ){
            paramMap.put("APP_SEQ", StringUtil.nvl(noticeInfo.get("ATTACHMENT"), ""));
            List<Map<String, Object>> uploadedFiles = fileManageService.selectUploadedFileList(paramMap);
            
            model.addAttribute("fileList", FileUtil.convertForFileView(uploadedFiles));
        }
        
        model.addAttribute("page",  StringUtil.nvl(paramMap.get("page"),  "1"));
        model.addAttribute("noticeInfo",    noticeInfo);
        model.addAttribute("subNoticeInfo", subNoticeInfo);
        model.addAttribute("boardInfo", sysBoardService.selectBoardInfo(paramMap));
        
        model.addAttribute("srchGrp",  StringUtil.nvl(paramMap.get("srchGrp"), ""));
        model.addAttribute("srchTxt",  StringUtil.nvl(paramMap.get("srchTxt"), ""));
        model.addAttribute("BOARD_ID", StringUtil.nvl(paramMap.get("BOARD_ID"), ""));
        
        return "com/sys/sysBoardDetailPopup";
    }
    
    @RequestMapping("/com/sys/selectcoNoticeList.do")
    @ResponseBody
    public JsonData selectcoNoticeList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();

        try {
            
            List<Map<String,Object>> dataList = sysBoardService.selectNoticeList(paramMap);

            if (null != dataList && 0 < dataList.size()) {
                Integer totalCnt = Integer.valueOf(((Map<String, Object>) dataList.get(0)).get("TOT_CNT").toString());
                jsonData.setPageRows(paramMap, dataList, totalCnt);
            } else {
                jsonData.setPageRows(paramMap, null, 0);
            }
            
            PaginationInfo paginationInfo = new PaginationInfo();
            paginationInfo.setCurrentPageNo(jsonData.getPage()) ;
            paginationInfo.setRecordCountPerPage(jsonData.getPageUnit());
            paginationInfo.setPageSize(jsonData.getPageSize());
            paginationInfo.setTotalRecordCount(jsonData.getRecords());
            
            jsonData.addFields("pagingTag", PageUtil.renderPagination(paginationInfo, "linkPage"));

        } catch (Exception e) {
            e.printStackTrace();
            jsonData.setErrMsg(e.getMessage());
        }

        if (logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }

        return jsonData;
    }
}
