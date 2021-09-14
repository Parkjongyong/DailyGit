package com.app.ildong.bat.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.bat.dao.BatDHdateDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;

@Service("BatDHdateService")
public class BatDHdateService extends BaseService {
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BatDHdateDAO batDHdateDAO;
	
	public void updateDeliveryHeadDate() throws ServiceException, Exception {
    	batDHdateDAO.updateDeliveryHeadDate();
	}	
}
