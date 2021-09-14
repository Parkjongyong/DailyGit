package com.app.ildong.sys.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.ObjectUtils;
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
import com.app.ildong.common.pagenation.PaginationInfo;
import com.app.ildong.common.service.CommonSelectService;
import com.app.ildong.common.service.FileManageService;
import com.app.ildong.common.session.UserSessionUtil;
import com.app.ildong.common.util.FileUtil;
import com.app.ildong.common.util.PageUtil;
import com.app.ildong.common.util.StringUtil;
import com.app.ildong.sys.service.SysBoardService;

@Controller
public class SysBoardController extends BaseController {
    protected final Log logger = LogFactory.getLog(getClass());

    @Autowired
    private SysBoardService sysBoardService;
    
    @Autowired
    private CommonSelectService commonSelectService;
    
    @Autowired
    private FileManageService fileManageService;
    
    @RequestMapping("/com/sys/sysBoardTemp.do")
    public String sysBoardTemp(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, Model model) {
        
        return "com/sys/sysBoardTemp";
    }
    
    @RequestMapping("/com/sys/sysInFaqListPop.do")
    public String sysInFaqListPop(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, Model model) {
    	return "com/sys/sysInFaqListPop";
    }
    
    @RequestMapping("/com/sys/sysInDataListPop.do")
    public String sysInDataListPop(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, Model model) {
    	
    	return "com/sys/sysInDataListPop";
    }
    
    @RequestMapping("/com/sys/sysBoardList.do")
    public String sysBoardList(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, Model model) throws Exception {
        String url = "com/sys/sysBoardList";
        
        paramMap.put("COMP_CD", getCompCd());
        
        Map<String,Object> userinfo  = UserSessionUtil.getUserSession(this.getRequest());
        List<String> getRoleList = (List<String>)userinfo.get("ROLE_LIST");
        if(paramMap.get("BOARD_ID") == null || paramMap.get("BOARD_ID").equals("")) {
            if(getRoleList.indexOf(commonSelectService.selectRoleUserList("ROLE_BBS")) != -1) {
                paramMap.put("BOARD_ID", "001");
            } else {
                paramMap.put("BOARD_ID", "101");
            }
        }
        if(paramMap.get("mode") == null || paramMap.get("mode").equals("")) {
            if(getRoleList.indexOf(commonSelectService.selectRoleUserList("ROLE_BBS")) != -1) {
                paramMap.put("mode", "innerBoard");
            } else {
                paramMap.put("mode", "outterBoard");
            }
        }
        if(paramMap.get("selectBox") == null || paramMap.get("selectBox").equals("")) {
            paramMap.put("selectBox", "01");
        }
        
        model.addAttribute("boardInfo", sysBoardService.selectBoardInfo(paramMap));
        model.addAttribute("boardInfoAll", sysBoardService.selectBoardInfoAll(paramMap));
        model.addAttribute("data", paramMap);

        return url;
    }
    
    @RequestMapping("/com/sys/selectSysBoardListFaq.do")
    @ResponseBody
    public JsonData selectSysBoardListFaq(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();
        
        try {
            Map<String,Object> userinfo  = UserSessionUtil.getUserSession(this.getRequest());
            List<String> getRoleList = (List<String>)userinfo.get("ROLE_LIST");
            
            paramMap.put("userId",  getUserId());
            paramMap.put("COMP_CD", getCompCd());
            paramMap.put("startRow", getStartRow(paramMap));
            paramMap.put("pageSize", getPageSize(paramMap));  //또는 paramMap.put("pageSize, paramMap.get("row"));
            
            if(paramMap.get("BOARD_ID") == null || paramMap.get("BOARD_ID").equals("")) {
                if(getRoleList.indexOf(commonSelectService.selectRoleUserList("ROLE_BBS")) != -1) {
                    paramMap.put("BOARD_ID", "001");
                } else {
                    paramMap.put("BOARD_ID", "101");
                }
            }
            
            Integer totalCnt = ObjectUtils.defaultIfNull( sysBoardService.selectBoardListCountFaq(paramMap), new Integer(0));
            List<Map<String,Object>> dataList = null;
            if (0 != totalCnt) dataList = sysBoardService.selectBoardListFaq(paramMap);
            jsonData.setPageRows(paramMap, dataList, totalCnt);

        } catch (Exception e) {
            logger.error("FAQ 목록 조회 오류", e);
            jsonData.setErrMsg("FAQ 목록 조회중 오류가 발생했습니다.");
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        
        return jsonData;
    }
    
    
    @RequestMapping("/com/sys/sysInBoardList.do")
    public String sysInBoardList(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, Model model) throws Exception {
        return "com/sys/sysInBoardList";
    }
    
    @RequestMapping("/com/sys/sysOutBoardList.do")
    public String sysOutBoardList(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, Model model) throws Exception {
        return "com/sys/sysOutBoardList";
    }
    
    @RequestMapping("/com/sys/sysOutBoardAcpyList.do")
    public String sysOutBoardAcpyList(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, Model model) throws Exception {
        return "com/sys/sysOutBoardAcpyList";
    }
    
    @RequestMapping("/com/sys/sysOutBoardNoticeList.do")
    public String sysOutBoardNoticeList(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, Model model) throws Exception {
        return "com/sys/sysOutBoardNoticeList";
    }
    
    @RequestMapping("/com/sys/sysOutBoardDataList.do")
    public String sysOutBoardDataList(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, Model model) throws Exception {
        return "com/sys/sysOutBoardDataList";
    }
    
    @RequestMapping("/com/sys/sysOutBoardFaqList.do")
    public String sysOutBoardFaqList(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, Model model) throws Exception {
        return "com/sys/sysOutBoardFaqList";
    }
    
    @RequestMapping("/com/sys/sysOutBoardPolicyList.do")
    public String sysOutBoardPolicyList(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, Model model) throws Exception {
        return "com/sys/sysOutBoardPolicyList";
    }
    
    @RequestMapping(value = "/com/sys/sysOutBoardDetail.do")
    public String sysOutBoardDetail(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws Exception {
        
    	sysBoardService.updateBoardHit(paramMap);
        Map<String, Object> dataInfo = sysBoardService.selectBoard(paramMap);
        Map<String, Object> subDataInfo = sysBoardService.selectSubBoard(paramMap); 
        
        if(!"".equals(StringUtil.nvl(dataInfo.get("ATTACHMENT"), "")) ){
            paramMap.put("APP_SEQ", StringUtil.nvl(dataInfo.get("ATTACHMENT"), ""));
            List<Map<String, Object>> uploadedFiles = fileManageService.selectUploadedFileList(paramMap);
            
            model.addAttribute("fileList", FileUtil.convertForFileView(uploadedFiles));
        }
        
        model.addAttribute("boardInfo", sysBoardService.selectBoardInfo(paramMap));
        model.addAttribute("dataInfo",    dataInfo);
        model.addAttribute("subDataInfo", subDataInfo);
        
        model.addAttribute("srchGrp",  StringUtil.nvl(paramMap.get("srchGrp"), ""));
        model.addAttribute("srchTxt",  StringUtil.nvl(paramMap.get("srchTxt"), ""));
        model.addAttribute("BOARD_ID", StringUtil.nvl(paramMap.get("BOARD_ID"), ""));
        model.addAttribute("page",     StringUtil.nvl(paramMap.get("page"), "1"));
        model.addAttribute("BTN_YN",   paramMap.get("BTN_YN"));
        
        return "com/sys/sysOutBoardDetail";
    }
    
    @RequestMapping(value = "/com/sys/sysOutBoardWritePop.do")
    public String sysOutBoardWritePop(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws Exception {
        
        model.addAttribute("boardInfo", sysBoardService.selectBoardInfo(paramMap));
        model.addAttribute("BOARD_ID", StringUtil.nvl(paramMap.get("BOARD_ID"), ""));
        
        model.putAll(commonSelectService.selectCodeList(new String[]{"ADM002"}));
        model.putAll(commonSelectService.selectCodeList(new String[]{"ADM003"}));
        
        return "com/sys/sysOutBoardWritePop";
    }
    
    @RequestMapping(value = "/com/sys/sysOutBoardEditPop.do")
    public String sysOutBoardEditPop(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws Exception {
        
        Map<String, Object> dataInfo = sysBoardService.selectBoard(paramMap);
        
        if(!"".equals(StringUtil.nvl(dataInfo.get("ATTACHMENT"), "")) ){
            paramMap.put("APP_SEQ", StringUtil.nvl(dataInfo.get("ATTACHMENT"), ""));
            List<Map<String, Object>> uploadedFiles = fileManageService.selectUploadedFileList(paramMap);
            
            model.addAttribute("fileList", FileUtil.convertForFileView(uploadedFiles));
        }
        
        model.addAttribute("boardInfo", sysBoardService.selectBoardInfo(paramMap));
        model.addAttribute("BOARD_ID",  StringUtil.nvl(paramMap.get("BOARD_ID"), ""));
        model.addAttribute("dataInfo",  dataInfo);
        model.addAttribute("page",     StringUtil.nvl(paramMap.get("page"), "1"));
        model.putAll(commonSelectService.selectCodeList(new String[]{"ADM002"}));
        model.putAll(commonSelectService.selectCodeList(new String[]{"ADM003"}));
        
        return "com/sys/sysOutBoardEditPop";
    }
    
    @RequestMapping("/com/sys/selectSysOutBoardNoticeList.do")
    @ResponseBody
    public JsonData selectSysOutBoardNoticeList(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();
        
        try {
            Map<String,Object> userinfo  = UserSessionUtil.getUserSession(this.getRequest());
            List<String> getRoleList = (List<String>)userinfo.get("ROLE_LIST");
            
            paramMap.put("userId",  getUserId());
            
            List<Map<String,Object>> dataList = sysBoardService.selectSysOutBoardList(paramMap);

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
            
            jsonData.addFields("pagingTag", PageUtil.renderPagination(paginationInfo, "fnSearchNotice"));

        } catch (Exception e) {
            logger.error("게시물 목록 조회 오류", e);
            jsonData.setErrMsg("게시물 목록 조회중 오류가 발생했습니다.");
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        
        return jsonData;
    }
    
    @RequestMapping("/com/sys/selectSysOutBoardDataList.do")
    @ResponseBody
    public JsonData selectSysOutBoardDataList(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();
        
        try {
//            Map<String,Object> userinfo  = UserSessionUtil.getUserSession(this.getRequest());
//            List<String> getRoleList = (List<String>)userinfo.get("ROLE_LIST");
//            
//            paramMap.put("userId",  getUserId());
            
            List<Map<String,Object>> dataList = sysBoardService.selectSysOutBoardList(paramMap);

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
            
            jsonData.addFields("pagingTag", PageUtil.renderPagination(paginationInfo, "fnSearchData"));

        } catch (Exception e) {
            logger.error("게시물 목록 조회 오류", e);
            jsonData.setErrMsg("게시물 목록 조회중 오류가 발생했습니다.");
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        
        return jsonData;
    }
    
    @RequestMapping("/com/sys/selectSysOutBoardFaqList.do")
    @ResponseBody
    public JsonData selectSysOutBoardFaqList(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();
        try {
            //Map<String,Object> userinfo  = UserSessionUtil.getUserSession(this.getRequest());
            //List<String> getRoleList = (List<String>)userinfo.get("ROLE_LIST");
            
            //paramMap.put("userId",  getUserId());
            
            List<Map<String,Object>> dataList = sysBoardService.selectSysOutBoardList(paramMap);

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
            
            jsonData.addFields("pagingTag", PageUtil.renderPagination(paginationInfo, "fnSearchFaq"));

        } catch (Exception e) {
            logger.error("게시물 목록 조회 오류", e);
            jsonData.setErrMsg("게시물 목록 조회중 오류가 발생했습니다.");
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        
        return jsonData;
    }
    
    @RequestMapping("/com/sys/selectSysOutBoardPolicyList.do")
    @ResponseBody
    public JsonData selectSysOutBoardPolicyList(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();
        
        try {
            Map<String,Object> userinfo  = UserSessionUtil.getUserSession(this.getRequest());
            List<String> getRoleList = (List<String>)userinfo.get("ROLE_LIST");
            
            paramMap.put("userId",  getUserId());
            
            List<Map<String,Object>> dataList = sysBoardService.selectSysOutBoardList(paramMap);

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
            
            jsonData.addFields("pagingTag", PageUtil.renderPagination(paginationInfo, "searchPolicy"));

        } catch (Exception e) {
            logger.error("게시물 목록 조회 오류", e);
            jsonData.setErrMsg("게시물 목록 조회중 오류가 발생했습니다.");
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        
        return jsonData;
    }
    
    @RequestMapping("/com/sys/selectSysOutBoardNewsList.do")
    @ResponseBody
    public JsonData selectSysOutBoardNewsList(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();
        
        try {
            Map<String,Object> userinfo  = UserSessionUtil.getUserSession(this.getRequest());
            List<String> getRoleList = (List<String>)userinfo.get("ROLE_LIST");
            
            paramMap.put("userId",  getUserId());
            
            List<Map<String,Object>> dataList = sysBoardService.selectSysOutBoardList(paramMap);

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
            
            jsonData.addFields("pagingTag", PageUtil.renderPagination(paginationInfo, "searchNews"));

        } catch (Exception e) {
            logger.error("게시물 목록 조회 오류", e);
            jsonData.setErrMsg("게시물 목록 조회중 오류가 발생했습니다.");
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        
        return jsonData;
    }
    
    @RequestMapping("/com/sys/selectSysOutBoardVosList.do")
    @ResponseBody
    public JsonData selectSysOutBoardVosList(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();
        
        try {
            Map<String,Object> userinfo  = UserSessionUtil.getUserSession(this.getRequest());
            List<String> getRoleList = (List<String>)userinfo.get("ROLE_LIST");
            
            paramMap.put("userId",  getUserId());
            
            List<Map<String,Object>> dataList = sysBoardService.selectSysOutVosBoardList(paramMap);

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
            
            jsonData.addFields("pagingTag", PageUtil.renderPagination(paginationInfo, "searchVos"));

        } catch (Exception e) {
            logger.error("게시물 목록 조회 오류", e);
            jsonData.setErrMsg("게시물 목록 조회중 오류가 발생했습니다.");
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        
        return jsonData;
    }
    
    @RequestMapping("/com/sys/selectSysBoardList.do")
    @ResponseBody
    public JsonData selectSysBoardList(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();
        
        try {
            Map<String,Object> userinfo  = UserSessionUtil.getUserSession(this.getRequest());
            List<String> getRoleList = (List<String>)userinfo.get("ROLE_LIST");
            
            paramMap.put("userId",  getUserId());
            paramMap.put("COMP_CD", getCompCd());
            paramMap.put("startRow", getStartRow(paramMap));
            paramMap.put("pageSize", getPageSize(paramMap));  //또는 paramMap.put("pageSize, paramMap.get("row"));
            
            if(paramMap.get("BOARD_ID") == null || paramMap.get("BOARD_ID").equals("")) {
                if(getRoleList.indexOf(commonSelectService.selectRoleUserList("ROLE_BBS")) != -1) {
                    paramMap.put("BOARD_ID", "001");
                } else {
                    paramMap.put("BOARD_ID", "101");
                }
            }
            
            Integer totalCnt = ObjectUtils.defaultIfNull( sysBoardService.selectBoardListCount(paramMap), new Integer(0));
            List<Map<String,Object>> dataList = null;
            if (0 != totalCnt) dataList = sysBoardService.selectBoardList(paramMap);
            jsonData.setPageRows(paramMap, dataList, totalCnt);

        } catch (Exception e) {
            logger.error("게시물 목록 조회 오류", e);
            jsonData.setErrMsg("게시물 목록 조회중 오류가 발생했습니다.");
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        
        return jsonData;
    }
    
    @RequestMapping("/com/sys/sysBoardView.do")
    public String sysBoardView(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws Exception {
        try {
            //필요공통코드 목록
            model.putAll(commonSelectService.selectCodeList(new String[]{"ADM002"}));
        
            paramMap.put("COMP_CD", getCompCd());
        
            sysBoardService.updateBoardHit(paramMap);
            
            model.addAttribute("boardInfo", sysBoardService.selectBoardInfo(paramMap));
            model.addAttribute("boardInfoAll", sysBoardService.selectBoardInfoAll(paramMap));
            model.addAttribute("data", paramMap);
            model.addAttribute("boardView", sysBoardService.selectBoard(paramMap));
        }catch(Exception e) {
            logger.error("게시물 내용상세 팝업 오류", e);
        }
        return "com/sys/sysBoardView";
    }
    
    @RequestMapping("/com/sys/sysBoardWrite.do")
    public String sysBoardWrite(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws Exception {
        
        //필요공통코드 목록
        model.putAll(commonSelectService.selectCodeList(new String[]{"ADM002"}));
        
        paramMap.put("COMP_CD", getCompCd());
        
        model.addAttribute("boardInfo", sysBoardService.selectBoardInfo(paramMap));
        model.addAttribute("boardInfoAll", sysBoardService.selectBoardInfoAll(paramMap));
        model.addAttribute("data", paramMap);
        
        return "com/sys/sysBoardWrite";
    }
    
    @RequestMapping("/com/sys/deleteBoard.do")
    @ResponseBody
    public JsonData deleteBoard(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();
        int result = 0;
        String resultCd = "";
        
        try {
            
            result = sysBoardService.deleteBoard(paramMap);
            
            if(result > 0) {
                resultCd = "S";
            } else {
                resultCd = "E";
            }
            jsonData.addFields("resultCd", resultCd);

        } catch (Exception e) {
            logger.error("게시물 삭제 조회 오류", e);
            jsonData.setErrMsg("게시물 삭제중 오류가 발생했습니다.");
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        
        return jsonData;
    }
    
    @RequestMapping("/com/sys/insertBoard.do")
    @ResponseBody
    public JsonData insertBoardSave(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();
        int result = 0;
        String resultCd = "";
        
        try {
            paramMap.put("userId", getUserId());
            paramMap.put("userName", getUserNm());
            paramMap.put("deptCode", getDeptCd());
            paramMap.put("deptName", getDeptNm());
            paramMap.put("regIp", getUserIp());
            paramMap.put("modIp", getUserIp());
            
            logger.debug(paramMap);
            
            result = sysBoardService.insertBoard(paramMap); 
            
            if(result > 0) {
                resultCd = "S";
            } else {
                resultCd = "E";
            }
            jsonData.addFields("resultCd", resultCd);

        } catch (Exception e) {
            logger.error("게시물 저장 오류", e);
            jsonData.setErrMsg("게시물 저장중 오류가 발생했습니다.");
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        
        return jsonData;
    }
    
    
    @RequestMapping("/com/sys/sysBoardModify.do")
    public String sysBoardModify(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws Exception {
        try {
            //필요공통코드 목록
            model.putAll(commonSelectService.selectCodeList(new String[]{"ADM002"}));
                    
            paramMap.put("COMP_CD", getCompCd());
            
            model.addAttribute("boardInfo", sysBoardService.selectBoardInfo(paramMap));
            model.addAttribute("boardInfoAll", sysBoardService.selectBoardInfoAll(paramMap));
            model.addAttribute("data", paramMap);
            
            model.addAttribute("boardView", sysBoardService.selectBoard(paramMap));
        }catch(Exception e) {
            logger.error("게시물 수정 팝업 오류", e);
        }
        return "com/sys/sysBoardModify";
    }
    
    
    @RequestMapping("/com/sys/modifyBoard.do")
    @ResponseBody
    public JsonData modifyBoardSave(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();
        int result = 0;
        String resultCd = "";
        
        try {
            paramMap.put("compCode", getCompCd());
            paramMap.put("userId", getUserId());
            paramMap.put("userName", getUserNm());
            paramMap.put("deptCode", getDeptCd());
            paramMap.put("deptName", getDeptNm());
            paramMap.put("regIp", getUserIp());
            paramMap.put("modIp", getUserIp());
            
            result = sysBoardService.updateBoard(paramMap);
            
            if(result > 0) {
                resultCd = "S";
            } else {
                resultCd = "E";
            }
            jsonData.addFields("resultCd", resultCd);

        } catch (Exception e) {
            logger.error("게시물 수정 오류", e);
            jsonData.setErrMsg("게시물 수정중 오류가 발생했습니다.");
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        
        return jsonData;
    }
    
    @RequestMapping("/com/sys/insertReply.do")
    @ResponseBody
    public JsonData insertReply(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();
        int result = 0;
        String resultCd = "";
        
        try {
            paramMap.put("compCode", getCompCd());
            paramMap.put("regId", getUserId());
            paramMap.put("regName", getUserNm());
            paramMap.put("regIp", getUserIp());
            paramMap.put("deptCode", getDeptCd());
            paramMap.put("deptName", getDeptNm());
            
            
            logger.debug(paramMap);
            
            result = sysBoardService.insertReply(paramMap);
            
            if(result > 0) {
                resultCd = "S";
            } else {
                resultCd = "E";
            }
            jsonData.addFields("resultCd", resultCd);

        } catch (Exception e) {
            logger.error("게시물 답변 오류", e);
            jsonData.setErrMsg("게시물 답변저장중 오류가 발생했습니다.");
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        
        return jsonData;
    }
    
    
    
    @RequestMapping("/com/sys/modifyReply.do")
    @ResponseBody
    public JsonData modifyReply(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();
        int result = 0;
        String resultCd = "";
        
        try {
            paramMap.put("COMP_CD", getCompCd());
            
            result = sysBoardService.updateReply(paramMap);
            
            if(result > 0) {
                resultCd = "S";
            } else {
                resultCd = "E";
            }
            jsonData.addFields("resultCd", resultCd);

        } catch (Exception e) {
            logger.error("게시물 답변 수정 오류", e);
            jsonData.setErrMsg("게시물 답변수정중 오류가 발생했습니다.");
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        
        return jsonData;
    }
    
    
    
    @RequestMapping("/com/sys/deleteReply.do")
    @ResponseBody
    public JsonData deleteReply(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();
        int result = 0;
        String resultCd = "";
        
        try {
            paramMap.put("COMP_CD", getCompCd());
            
            logger.debug(paramMap);
            
            result = sysBoardService.deleteReply(paramMap);
            
            if(result > 0) {
                resultCd = "S";
            } else {
                resultCd = "E";
            }
            jsonData.addFields("resultCd", resultCd);

        } catch (Exception e) {
            logger.error("게시물 답변 삭제 오류", e);
            jsonData.setErrMsg("게시물 답변삭제중 오류가 발생했습니다.");
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        
        return jsonData;
    }
    
    
    
    @RequestMapping("/com/sys/selectFaqGrp.do")
    @ResponseBody
    public JsonData selectFaqGrp(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
        JsonData jsonData = new JsonData();
        
        try {
            paramMap.put("COMP_CD", getCompCd());
            
            List<Map<String,Object>> dataList = sysBoardService.selectFaqGrp(paramMap);
            

            if (null!=dataList && 0<dataList.size()) {
                jsonData.setPageRows(paramMap, dataList, 0);
            } else {
                jsonData.setPageRows(paramMap, null, 0);
            }

        } catch (Exception e) {
            logger.error("FAQ 그룹 조회 오류", e);
            jsonData.setErrMsg("FAQ 그룹 조회중 오류가 발생했습니다.");
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        
        return jsonData;
    }
    
    
    @RequestMapping("/com/sys/sysAccessLogList.do")
    public String sysAccessLogList(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, Model model) {
        
        return "com/sys/sysAccessLogList";
    }
    
    
    @RequestMapping("/com/sys/selectSysAccessLogList.do")
    @ResponseBody
    public JsonData selectSysAccessLogList(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
     
    	JsonData jsonData = new JsonData();
        
        try { 
            
            List<Map<String,Object>> dataList = sysBoardService.selectAccessLogList(paramMap);

            if (null!=dataList && 0<dataList.size()) {
                Integer totalCnt = Integer.valueOf( ((Map<String,Object>)dataList.get(0)).get("TOT_CNT").toString() );
                
                paramMap.put("APPEND_PAGE","APPEND_PAGE");
                jsonData.setPageRows(paramMap, dataList, totalCnt);
            } else {
                jsonData.setPageRows(paramMap, null, 0);
            }

        } catch (Exception e) {
            logger.error("로그 조회 오류", e);
            jsonData.setErrMsg("로그 조회중 오류가 발생했습니다.");
        }
        
        if( logger.isDebugEnabled()) {
            logger.debug("jsonData = " + jsonData);
        }
        
        return jsonData;
    }
}
