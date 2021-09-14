package com.app.ildong.sys.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.app.ildong.common.model.JsonData;
import com.app.ildong.common.model.mvc.BaseController;
import com.app.ildong.sys.service.JCoProcessService;
import com.app.ildong.sys.service.SysRfcService;

@Controller
public class SysRfcController extends BaseController{
protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private SysRfcService sysRfcService;
	
	@Autowired
	private JCoProcessService jCoProcessService;
	
	/**
	 * GL정보수신
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/com/sys/receiveGLInfo.do")
	@ResponseBody
	public JsonData receiveGLInfo(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();
		try {
			paramMap.put("FUNC_NAME", "ZFI_WITHUS_GL_ACCOUNT_LIST");
			
			Map<String, Object> result = jCoProcessService.processJCoExecute(paramMap);
			
			if(result.get("T_RESULT") != null) {
				sysRfcService.receiveGLInfo(result);
			}
			
			jsonData.addFields("result", result);
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.setErrMsg(e.getMessage());
		}

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}

		return jsonData;
	}
	
	/**
	 * WBS 정보 수신
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/com/sys/receiveWBSInfo.do")
	@ResponseBody
	public JsonData receiveWBSInfo(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();
		try {
			paramMap.put("FUNC_NAME", "ZFI_WITHUS_WBS_LIST");
			
			//후에 정해지면 넣을것 ! 
			paramMap.put("I_POSID", "%");
			
			//paramMap.put("I_POST1", "%");
			/*
			 * paramMap.put("TABLE_LIST","TABLE_NAME1,TABLE_NAME2");
			 * paramMap.put("TABLE_NAME1",  "리스트맵");
			 * 
			 */
			
			Map<String, Object> result = jCoProcessService.processJCoExecute(paramMap);

			if(result.get("T_RESULT") != null)
			{
				sysRfcService.receiveWBSInfo(result);
			}
			
			jsonData.addFields("result", result);
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.setErrMsg(e.getMessage());
		}

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}

		return jsonData;
	}
	
	/**
	 * 실시간 투자예산 조회
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/com/sys/checkWBSInfo.do")
	@ResponseBody
	public JsonData checkWBSInfo(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();
		try {
			paramMap.put("FUNC_NAME", "ZFI_WITHUS_PR_CREATE");
			
			/*paramMap.put("I_ZDOCNUM",	"1111");
			paramMap.put("I_ZDOCCNT",	"1");
			paramMap.put("I_BSART",		"NB");
			paramMap.put("I_ERNAM",		"1109419");
			paramMap.put("I_WF_IND",	"X");
			paramMap.put("I_CMD",		"C");*/
			
			/**
			 * ZDOCNUM	: 표준구매문서번호
			 * ZDOCCNT	: 표준구매관리차수
			 * BNFPO	: 구매요청품목번호
			 * MENGE	: 수량
			 * PREIS	: 가격(단가)
			 * WAERS	: 통화키(KRW)
			 * KNTTP	: 계정지정범주(K/A)
			 * SAKTO	: 원가요소(GL계정)
			 * POSID	: 작업분석구조요소(WBS 코드)
			 */
			
			List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
			
			Map<String, Object> pMap = new HashMap<String, Object>();
			
			pMap.put("ZDOCNUM", "1-1111");
			pMap.put("ZDOCCNT", "1");
			pMap.put("BNFPO", "10");
			pMap.put("MENGE", "1");
			pMap.put("PREIS", "50,000");
			pMap.put("WAERS", "KRW");
			pMap.put("KNTTP", "A");
			pMap.put("SAKTO", "GL");
			pMap.put("POSID", "201760-01-01");
			
			list.add(pMap);
			
			pMap.put("ZDOCNUM", "2-2222");
			pMap.put("ZDOCCNT", "2");
			pMap.put("BNFPO", "20");
			pMap.put("MENGE", "1");
			pMap.put("PREIS", "20,000");
			pMap.put("WAERS", "KRW");
			pMap.put("KNTTP", "A");
			pMap.put("SAKTO", "GL");
			pMap.put("POSID", "201760-01-02");
			
			list.add(pMap);
			
			paramMap.put("T_LIST_IT",  list);
			
			paramMap.put("TABLE_LIST", "T_LIST_IT");
			
			
			Map<String, Object> result = jCoProcessService.processJCoExecute(paramMap);
			
			//결과가 있을 경우
			if(result.get("T_LIST_MSG") != null)
			{
				List<Map<String, Object>> resultList = (List<Map<String, Object>>) result.get("T_LIST_MSG");
				Map<String, Object> resultMap = resultList.get(0);
				
				String rtnMsg  = resultMap.get("MESSAGE").toString();
				String rtnFlag = resultMap.get("MSGTY").toString();
				
				jsonData.addFields("RTN_MSG", rtnMsg);
				jsonData.addFields("RTN_FLAG", rtnFlag);
			}
			else
			{
				jsonData.addFields("RTN_MSG" , "");
				jsonData.addFields("RTN_FLAG", "");
			}
			
			jsonData.addFields("result", result);
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.setErrMsg(e.getMessage());
		}

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}

		return jsonData;
	}
	
	/**
	 * 인사정보 수신
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/com/sys/receiveEmpInfo.do")
	@ResponseBody
	public JsonData receiveEmpInfo(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();
		try {
			paramMap.put("FUNC_NAME", "Z_HR_EAC_EMP");
			//paramMap.put("I_DATE", "20171106");
			//paramMap.put("I_EMP_NO", "1102382");
			
			Map<String, Object> result = jCoProcessService.processJCoExecute(paramMap);
			
			//OUTTAB에 데이터가 있을 경우.
			if(!"[]".equals(result.get("OUTTAB").toString()))
			{
				sysRfcService.receiveEmpInfo(result);
			}
			
			jsonData.addFields("result", result);
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.setErrMsg(e.getMessage());
		}

		if (logger.isDebugEnabled()) {
			logger.debug("jsonData = " + jsonData);
		}

		return jsonData;
	}
	
	/**
	 * 부서정보 수신
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/com/sys/receiveDeptInfo.do")
	@ResponseBody
	public JsonData receiveDeptInfo(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, ModelMap model) {
		JsonData jsonData = new JsonData();
		try {
			paramMap.put("FUNC_NAME", "Z_HR_EAC_DEPT");
			//paramMap.put("I_DATE", "20171106");
			//paramMap.put("I_DEPT_CD", "50000009");
			
			Map<String, Object> result = jCoProcessService.processJCoExecute(paramMap);
			
			//OUTTAB에 데이터가 있을 경우.
			if(!"[]".equals(result.get("OUTTAB").toString()))
			{
				sysRfcService.receiveDeptInfo(result);
			}
			
			jsonData.addFields("result", result);
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
