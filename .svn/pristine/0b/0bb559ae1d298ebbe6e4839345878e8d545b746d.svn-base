package com.app.ildong.wrh.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.wrh.dao.WrhDeliveryHistoryDAO;

@Service("wrhDeliveryHistoryService")
public class WrhDeliveryHistoryService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private WrhDeliveryHistoryDAO wrhDeliveryHistoryDAO;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectDeliveryHistoryList(Map<String, Object> paramMap){
		return wrhDeliveryHistoryDAO.selectDeliveryHistoryList(paramMap);
	}
}