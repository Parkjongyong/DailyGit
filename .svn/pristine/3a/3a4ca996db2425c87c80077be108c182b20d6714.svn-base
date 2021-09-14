package com.app.ildong.bat.service;

import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.bat.dao.BatCustomerInfoDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;

@Service("batCustomerInfoService")
public class BatCustomerInfoService extends BaseService {
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BatCustomerInfoDAO batCustomerInfoDAO;
	
	public void makeCustomerInfoData(Map<String, Object> paramMap) throws ServiceException, Exception {
		
		
    	// PO_HEAD에 MERGE!
		batCustomerInfoDAO.makeCustomerInfoData(paramMap);
        
    	// PO_HEAD_IF에 UPDATE!
		batCustomerInfoDAO.updateCustomerInfoFlag();
    	
	}
}
