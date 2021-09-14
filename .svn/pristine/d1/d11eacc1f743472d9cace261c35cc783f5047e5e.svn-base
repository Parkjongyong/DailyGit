package com.app.ildong.wrh.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.wrh.dao.WrhMatInfoDAO;

@Service("WrhMatInfoService")
public class WrhMatInfoService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private WrhMatInfoDAO matInfoDAO;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectMatInfo(Map<String, Object> paramMap){
		return matInfoDAO.selectMatInfo(paramMap);
	}

}