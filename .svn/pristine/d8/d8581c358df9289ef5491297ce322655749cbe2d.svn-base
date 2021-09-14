package com.app.ildong.cmn.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.app.ildong.common.model.mvc.BaseController;

@Controller
public class CmnFileDownController extends BaseController {
   
	private static final Logger logger = LoggerFactory.getLogger(CmnFileDownController.class);
	
	/**
	 * 공통 파일 다운로드 팝업
	 * - app_seq 값을 받아 해당 첨부파일을 조회
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/com/cmn/cmnFileDownPop.do")
	public String cmnFileDownPop(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, Model model) throws Exception {
		return "com/cmn/cmnFileDownPop";
	}
	
	
	
	
}
