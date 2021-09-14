package com.app.ildong.cmn.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.cmn.dao.CmnPlantStorageDAO;
import com.app.ildong.common.model.mvc.BaseService;

@Service("CmnPlantStorageService")
public class CmnPlantStorageService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private CmnPlantStorageDAO cmnPlantStorageDAO;

	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectPlantStorageList(Map<String, Object> paramMap){
		return cmnPlantStorageDAO.selectPlantStorageList(paramMap);
	}
	
}