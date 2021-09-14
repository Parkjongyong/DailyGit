package com.app.ildong.bdg.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.bdg.dao.BdgResultDAO;

@Service("BdgResultService")
public class BdgResultService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BdgResultDAO bdgResultDAO;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectBasicResult(Map<String, Object> paramMap){
		return bdgResultDAO.selectBasicResult(paramMap);
	}

	public List<Map<String, Object>> selectModifyResult(Map<String, Object> paramMap){
		return bdgResultDAO.selectModifyResult(paramMap);
	}
	
	public List<Map<String, Object>> selectExecResult(Map<String, Object> paramMap){
		return bdgResultDAO.selectExecResult(paramMap);
	}
	
	public List<Map<String, Object>> selectSuppleResult(Map<String, Object> paramMap){
		return bdgResultDAO.selectSuppleResult(paramMap);
	}
	
	public List<Map<String, Object>> selectResultPop(Map<String, Object> paramMap){
		return bdgResultDAO.selectResultPop(paramMap);
	}
	

}