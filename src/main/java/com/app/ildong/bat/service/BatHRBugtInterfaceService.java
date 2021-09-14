package com.app.ildong.bat.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.bat.dao.BatHRBugtDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;

@Service("batHRBugtInterfaceService")
public class BatHRBugtInterfaceService extends BaseService {
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BatHRBugtDAO batHRBugtDAO;
	
	public void makeInterfaceHRBugtData(Map<String, Object> paramMap) throws ServiceException, Exception {
		
		List<Map<String, Object>> selectList = batHRBugtDAO.selectHRBugtIfData(paramMap);
		
		for (Map<String, Object> data: selectList) {
			batHRBugtDAO.mergeHRBugtIfData(data);
		}
	}	
}
