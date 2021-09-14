package com.app.ildong.cmn.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.cmn.dao.CmnCustomerDAO;
import com.app.ildong.common.model.mvc.BaseService;

@Service("cmnCustomerService")
public class CmnCustomerService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private CmnCustomerDAO cmnCustomerDAO;
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectCustomerList(Map<String, Object> paramMap){
		return cmnCustomerDAO.selectCustomerList(paramMap);
	}
	
}