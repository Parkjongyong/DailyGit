/**
 * 시스템관리 > 권한 관리 컨트롤러
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

import java.util.ArrayList;

import java.util.HashMap;
import java.util.LinkedHashMap;
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
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.service.CommonSelectService;
import com.app.ildong.sys.service.SysRoleService;

import net.minidev.json.JSONArray;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.jdbc.BadSqlGrammarException;
import org.springframework.dao.DataIntegrityViolationException;

@Controller
public class SysRoleController extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(SysRoleController.class);
	
	@Autowired
    private CommonSelectService commonSelectService;
	
    @Autowired 
    private SysRoleService roleService;
    
    /**
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/sys/roleList.do")
	public String roleList(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
     	try {
			model.putAll(commonSelectService.selectCodeList(new String[]{"ID001"}));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
    	return "com/sys/sysRoleList";

	}

	/**
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/com/sys/selectRoleList.do")
	@ResponseBody
	public JsonData selectMenuList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();

		try {
			    
			List<Map<String, Object>> dataList = roleService.selectRoleList(paramMap);
            
            if (null!=dataList && 0<dataList.size()) {
                Integer totalCnt = Integer.valueOf( ((Map<String,Object>)dataList.get(0)).get("TOT_CNT").toString() ); 
                //APPEND 페이지추가 모드
                jsonData.setPageRows(paramMap, dataList, totalCnt);
            } else {
                jsonData.setPageRows(paramMap, null, 0);
            }

		} catch (Exception e) {
			logger.error("com/sys/selectRoleList.do 중 오류 발생", e);
			jsonData.setErrMsg(e.getMessage());
		}

		if (logger.isDebugEnabled()) {
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
	@RequestMapping("/com/sys/sysRoleMenuPopup.do")
	public String sysRoleMenuPopup(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		model.addAttribute("PARAM", paramMap);
        try {
			model.putAll(commonSelectService.selectCodeList(new String[]{"E102"}));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "com/sys/sysRoleMenuPopup";
	}
	
	/**
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/com/sys/selectRoleDetailList.do")
	@ResponseBody
	public JsonData selectRoleDetailList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();

		try {
			List<Map<String, Object>> detailList = roleService.selectRoleDetailList(paramMap);
			
			jsonData.setStatus("SUCC");
			jsonData.addFields("detailList", detailList);
			
		} catch (Exception e) {
		    logger.error("com/sys/selectRoleDetailList.do 중 오류 발생", e);
			jsonData.setErrMsg(e.getMessage());
		}

		if (logger.isDebugEnabled()) {
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
	@RequestMapping(value = "/com/sys/updateRoleMenuList.do")
	@ResponseBody
	public JsonData updateRoleMenuList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();

		try {
			
			Map<String, Object> responseMap = roleService.updateRoleMenuList(paramMap);
			
			jsonData.setStatus("SUCC");
            jsonData.addFields("RESULT", "S");
			
		} catch (Exception e) {
		    logger.error("com/sys/updateRoleMenuList.do 중 오류 발생", e);
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
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/com/sys/deleteRoleList.do")
	@ResponseBody
	public JsonData deleteRoleList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();

		try {
			
			Map<String, Object> responseMap = roleService.deleteRoleList(paramMap);
			
			jsonData.setStatus("SUCC");
			jsonData.addFields("result", responseMap);
			
		} catch (Exception e) {
		    logger.error("com/sys/deleteRoleList.do 중 오류 발생", e);
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
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/com/sys/updateRoleList.do")
	@ResponseBody
	public JsonData updateRoleList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();

		try {
			
			Map<String, Object> responseMap = roleService.updateRoleList(paramMap);
			
			jsonData.setStatus("SUCC");
			jsonData.addFields("result", responseMap);
			
		} catch (Exception e) {
		    logger.error("com/sys/updateRoleList.do 중 오류 발생", e);
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
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/com/sys/delRoleList.do")
	@ResponseBody
	public JsonData delRoleList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();
		
		try {
			
			Map<String, Object> responseMap = roleService.delRoleList(paramMap);
			
			jsonData.setStatus("SUCC");
			jsonData.addFields("result", responseMap);
			
		} catch (Exception e) {
			logger.error("com/sys/delRoleList.do 중 오류 발생", e);
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
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/com/sys/sysRoleUserPopup.do")
	public String sysRoleUserPopup(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		model.addAttribute("PARAM", paramMap);
        try {
			model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001"}));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "com/sys/sysRoleUserPopup";
	}
	
	@RequestMapping(value = "/com/sys/selectRoleAssignmentUserList.do")
	@ResponseBody
	public JsonData selectRoleAssignmentUserList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();

		try {
			List<Map<String, Object>> assignUserList = roleService.selectRoleAssignmentUserList(paramMap);
			
			jsonData.setStatus("SUCC");
			jsonData.addFields("assignUserList", assignUserList);
			
			jsonData.setRows(assignUserList);
			
		} catch (Exception e) {
		    logger.error("com/sys/selectRoleAssignmentUserList.do 중 오류 발생", e);
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
	
	@RequestMapping(value = "/com/sys/selectRoleUnassignedUserList.do")
	@ResponseBody
	public JsonData selectRoleUnassignedUserList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();

		try {
			List<Map<String, Object>> unassignedUserList = roleService.selectRoleUnassignedUserList(paramMap);
			
			jsonData.setStatus("SUCC");
			jsonData.addFields("unassignedUserList", unassignedUserList);
			
			jsonData.setRows(unassignedUserList);
			
		} catch (Exception e) {
		    logger.error("com/sys/selectRoleUnassignedUserList.do 중 오류 발생", e);
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
	
	@RequestMapping(value = "/com/sys/updateRoleUser.do")
	@ResponseBody
	public JsonData updateRoleUser(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();

		try {
			Map<String, Object> responseMap = roleService.updateRoleUser(paramMap);
			
			jsonData.setStatus("SUCC");
			jsonData.addFields("RESULT", "S");
			
		} catch (Exception e) {
		    logger.error("com/sys/updateRoleUser.do 중 오류 발생", e);
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
	
	@RequestMapping("/com/sys/sysRoleDeptPopup.do")
	public String sysRoleDeptPopup(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		model.addAttribute("PARAM", paramMap);
        try {
			model.putAll(commonSelectService.selectCodeList(new String[]{"SYS001"}));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "com/sys/sysRoleDeptPopup";
	}
	
	@RequestMapping(value = "/com/sys/selectRoleUnassignedDeptList.do")
	@ResponseBody
	public JsonData selectRoleUnassignedDeptList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();

		try {
			List<Map<String, Object>> deptList = roleService.selectRoleUnassignedDeptList(paramMap);
			
            jsonData.setStatus("SUCC");
            jsonData.setRows(deptList);

		} catch (Exception e) {
		    logger.error("com/sys/selectRoleUnassignedDeptList.do 중 오류 발생", e);
			jsonData.setErrMsg(e.getMessage());
		}

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
		return jsonData;
	}
	
	@RequestMapping(value = "/com/sys/selectRoleAssignmentDeptList.do")
	@ResponseBody
	public JsonData selectRoleAssignmentDeptList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();

		try {
		    List<Map<String, Object>> deptList = roleService.selectRoleAssignmentDeptList(paramMap);
            
            jsonData.setStatus("SUCC");
            jsonData.setRows(deptList);
			
		} catch (Exception e) {
		    logger.error("com/sys/selectRoleAssignmentDeptList.do 중 오류 발생", e);
			jsonData.setErrMsg(e.getMessage());
		}

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
		return jsonData;
	}
	
	/**
	 * 권한-부서 설정
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/com/sys/updateRoleDept.do")
	@ResponseBody
	public JsonData updateRoleDept(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();

		try {
			Map<String, Object> responseMap = roleService.updateRoleDept(paramMap);
			
			jsonData.setStatus("SUCC");
			jsonData.addFields("result", responseMap);
			
		} catch (Exception e) {
		    logger.error("com/sys/updateRoleDept.do 중 오류 발생", e);
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
	 * 사용자별 권한 설정 화면으로 이동
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/com/sys/userRolePopup.do")
	public String userRolePopup(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, Model model) {
		model.addAttribute("PARAM", paramMap);
		return "com/sys/sysUserRolePopup";
	}
	
	/**
	 * 비할당 권한 조회
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/com/sys/selectUnassignedRoleList.do")
	@ResponseBody
	public JsonData selectUnassignedRoleList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();

		try {
			paramMap.put("COMP_CD", getCompCd());
			List<Map<String, Object>> unassignedRoleList = roleService.selectUnassignedRoleList(paramMap);
			
			jsonData.setStatus("SUCC");
			jsonData.addFields("unassignedRoleList", unassignedRoleList);
			
			jsonData.setRows(unassignedRoleList);
			
		} catch (Exception e) {
		    logger.error("com/sys/selectUnassignedRoleList.do 중 오류 발생", e);
			jsonData.setErrMsg(e.getMessage());
		}

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
		return jsonData;
	}
	
	
	/**
	 * 사용자별 할당 권한 조회
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/com/sys/selectAssignedRoleList.do")
	@ResponseBody
	public JsonData selectAssignedRoleList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();

		try {
			paramMap.put("COMP_CD", getCompCd());
			List<Map<String, Object>> assignedRoleList = roleService.selectAssignedRoleList(paramMap);
			
			jsonData.setStatus("SUCC");
			jsonData.addFields("assignedRoleList", assignedRoleList);
			
			jsonData.setRows(assignedRoleList);
			
		} catch (Exception e) {
		    logger.error("com/sys/selectAssignedRoleList.do 중 오류 발생", e);
			jsonData.setErrMsg(e.getMessage());
		}

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
		return jsonData;
	}
	
	
	/**
	 * 사용자별 권한 수정
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/com/sys/updateUserRole.do")
	@ResponseBody
	public JsonData updateUserRole(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();

		try {
			Map<String, Object> responseMap = roleService.updateUserRole(paramMap);
			
			jsonData.setStatus("SUCC");
			jsonData.addFields("result", responseMap);
			
		} catch (Exception e) {
		    logger.error("사용자별 권한 수정 중 오류 발생", e);
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
	 * 부서별 권한 설정화면으로 이동
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/com/sys/deptRolePopup.do")
	public String deptRolePopup(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, Model model) {
		model.addAttribute("PARAM", paramMap);
		return "com/sys/sysDeptRolePopup";
	}
	
	/**
	 * 비할당 권한 조회(부서별)
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/com/sys/selectUnassignedDeptRoleList.do")
	@ResponseBody
	public JsonData selectUnassignedDeptRoleList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();

		try {
			List<Map<String, Object>> unassignedDeptRoleList = roleService.selectUnassignedDeptRoleList(paramMap);
			
			jsonData.setStatus("SUCC");
			jsonData.addFields("unassignedDeptRoleList", unassignedDeptRoleList);
			
			jsonData.setRows(unassignedDeptRoleList);
			
		} catch (Exception e) {
		    logger.error("com/sys/selectUnassignedDeptRoleList.do 중 오류 발생", e);
			jsonData.setErrMsg(e.getMessage());
		}

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
		return jsonData;
	}
	
	/**
	 * 부서별 할당 권한 조회
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/com/sys/selectAssignedDeptRoleList.do")
	@ResponseBody
	public JsonData selectAssignedDeptRoleList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();

		try {
			List<Map<String, Object>> assignedDeptRoleList = roleService.selectAssignedDeptRoleList(paramMap);
			
			jsonData.setStatus("SUCC");
			jsonData.addFields("assignedDeptRoleList", assignedDeptRoleList);
			
			jsonData.setRows(assignedDeptRoleList);
			
		} catch (Exception e) {
		    logger.error("com/sys/selectAssignedDeptRoleList.do 중 오류 발생", e);
			jsonData.setErrMsg(e.getMessage());
		}

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
		return jsonData;
	}
	
	/**
	 * 부서별 권한 수정
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/com/sys/updateDeptRole.do")
	@ResponseBody
	public JsonData updateDeptRole(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();

		try {
			Map<String, Object> responseMap = roleService.updateDeptRole(paramMap);
			
			jsonData.setStatus("SUCC");
			jsonData.addFields("result", responseMap);
			
		} catch (Exception e) {
		    logger.error("com/sys/updateDeptRole.do 중 오류 발생", e);
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
     * 부서 검색 팝업
     * @param paramMap
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/com/sys/sysDeptSearchPop.do")
    public String sysDeptSearchPop(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, Model model) {
        
        return "com/sys/sysDeptSearchPop";
    }
    
    
	/**
	 * 사용자별 화면 권한 설정화면으로 이동
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/com/sys/userViewPopup.do")
	public String userViewPopup(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
     	try {
			model.addAttribute("PARAM", paramMap);
			model.putAll(commonSelectService.selectCodeList(new String[]{"E102"}));
		} catch (ServiceException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "com/sys/sysUserViewPopup";
	}
	

	/**
	 * 사용자별 화면 권한 저장
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/com/sys/updateUserMenuList.do")
	@ResponseBody
	public JsonData updateUserMenuList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();

		try {
			Map<String, Object> responseMap = roleService.updateUserMenuList(paramMap);
			
			jsonData.setStatus("SUCC");
            jsonData.addFields("RESULT", "S");
			
		} catch (Exception e) {
		    logger.error("com/sys/updateRoleMenuList.do 중 오류 발생", e);
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
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/com/sys/selectUserViewList.do")
	@ResponseBody
	public JsonData selectUserViewList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();

		try {
			List<Map<String, Object>> menuList = roleService.selectUserViewList(paramMap);
			jsonData.setRows(menuList);
			
		} catch (Exception e) {
			logger.error("com/sys/selectMenuList.do 오류 발생", e);
			jsonData.setErrMsg(e.getMessage());
		}

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}
		return jsonData;
	}

	/**
	 * 사용자별 화면 초기화
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/com/sys/resetUserMenuList.do")
	@ResponseBody
	public JsonData resetUserMenuList(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();

		try {
			Map<String, Object> responseMap = roleService.resetUserMenuList(paramMap);
			
			jsonData.setStatus("SUCC");
            jsonData.addFields("RESULT", "S");
			
		} catch (Exception e) {
		    logger.error("com/sys/updateRoleMenuList.do 중 오류 발생", e);
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
	
}
