package com.app.ildong.wrh.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.wrh.dao.WrhScheduledArrivalDAO;

@Service("WrhScheduledArrivalService")
public class WrhScheduledArrivalService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private WrhScheduledArrivalDAO scheduledArrivalDAO;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectScheduledArrival(Map<String, Object> paramMap){
		return scheduledArrivalDAO.selectScheduledArrival(paramMap);
	}
	
}