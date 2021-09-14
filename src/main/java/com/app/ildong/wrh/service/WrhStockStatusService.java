package com.app.ildong.wrh.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.wrh.dao.WrhStockStatusDAO;

@Service("wrhStockStatusService")
public class WrhStockStatusService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private WrhStockStatusDAO wrhStockStatusDAO;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectStockStatusList(Map<String, Object> paramMap){
		return wrhStockStatusDAO.selectStockStatusList(paramMap);
	}
	
	public Map<String, Object> selectTotalGrAmt(Map<String, Object> paramMap){
		return wrhStockStatusDAO.selectTotalGrAmt(paramMap);
	}	
	
	
}