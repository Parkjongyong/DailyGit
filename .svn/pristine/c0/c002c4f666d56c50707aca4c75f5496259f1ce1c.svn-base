package com.app.ildong.cmn.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.cmn.dao.CmnItemMgmtDAO;
import com.app.ildong.common.model.mvc.BaseService;

@Service("cmnItemMgmtService")
public class CmnItemMgmtService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private CmnItemMgmtDAO cmnItemMgmtDAO;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectItemMgmtList(Map<String, Object> paramMap){
		return cmnItemMgmtDAO.selectItemMgmtList(paramMap);
	}
	
	public List<Map<String, Object>> selectPlantItemList(Map<String, Object> paramMap){
		return cmnItemMgmtDAO.selectPlantItemList(paramMap);
	}
	
}