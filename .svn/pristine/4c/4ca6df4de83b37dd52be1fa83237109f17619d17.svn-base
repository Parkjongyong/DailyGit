package com.app.ildong.bat.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.bat.dao.BatHRVacatDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;

@Service("batHRVacatInterfaceService")
public class BatHRVacatInterfaceService extends BaseService {
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BatHRVacatDAO batHRVacatDAO;
	
	public void makeInterfaceHRVacatData(Map<String, Object> paramMap) throws ServiceException, Exception {
		
		List<Map<String, Object>> selectList1 = batHRVacatDAO.selectHRVacatHeadData(paramMap);
		List<Map<String, Object>> selectList2 = batHRVacatDAO.selectHRVacatDetailData(paramMap);
		
		for (Map<String, Object> data: selectList1) {
			batHRVacatDAO.mergeHRVacatHeadData(data);
		}
		
		for (Map<String, Object> data: selectList2) {
			batHRVacatDAO.mergeHRVacatDetailData(data);
		}		
	}	
}
