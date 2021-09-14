package com.app.ildong.bdg.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.bdg.dao.BdgYearResultMgtDAO;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.common.util.StringUtil;

@Service("bdgYearResultService")
public class BdgYearResultService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BdgYearResultMgtDAO bdgYearResultMgtDAO;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectYearResultMgt(Map<String, Object> paramMap){
		List<Map<String, Object>> returnList  = new ArrayList<Map<String, Object>>();
		String dataGubn = StringUtil.isNullToString(paramMap.get("SB_BUGT_CD"));
		if ("1".equals(dataGubn)) {
			returnList = bdgYearResultMgtDAO.selectBasicYearResult(paramMap);
		} else if ("2".equals(dataGubn)) {
			returnList = bdgYearResultMgtDAO.selectModifyYearResult(paramMap);
		} else if ("3".equals(dataGubn)) {
			returnList = bdgYearResultMgtDAO.selectExecYearResult(paramMap);
		} else if ("4".equals(dataGubn)) {
			returnList = bdgYearResultMgtDAO.selectSuppleYearResult(paramMap);
		}
		
		return returnList;
	}

}