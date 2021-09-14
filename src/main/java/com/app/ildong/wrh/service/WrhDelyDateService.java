package com.app.ildong.wrh.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.wrh.dao.WrhDelyDateDAO;

@Service("wrhDelyDateService")
public class WrhDelyDateService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private WrhDelyDateDAO wrhDelyDateDAO;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectDelyDateList(Map<String, Object> paramMap){
		return wrhDelyDateDAO.selectDelyDateList(paramMap);
	}
}