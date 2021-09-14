package com.app.ildong.mai.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.ecbank.framework.exception.BizException;
import com.app.ildong.common.dao.MessageSendDAO;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.common.service.MessageSendService;
import com.app.ildong.mai.dao.MainRoleViewDAO;
import com.app.ildong.sys.service.JCoProcessService;

@Service("MainRoleViewService")
public class MainRoleViewService extends BaseService {
	
	@Autowired
	private MainRoleViewDAO mainRoleViewDAO;
	
	@Autowired
	private MessageSendDAO msgSendDAO;
	
	@Autowired
	private JCoProcessService jCoProcessService;
	
	@Autowired
	private MessageSendService messageSendService;
	
	
	public List<Map<String,Object>> selectPopupMgmtListMain(Map<String,Object> paramMap) throws BizException, Exception {
		return mainRoleViewDAO.selectPopupMgmtListMain(paramMap);
	}
	
	public Map<String, Object> selectPopupMgmtMain(Map<String, Object> paramMap) throws BizException, Exception {
		return mainRoleViewDAO.selectPopupMgmtMain(paramMap);
	}
    

}
