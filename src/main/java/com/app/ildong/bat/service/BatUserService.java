package com.app.ildong.bat.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.bat.dao.BatUserDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;

@Service("BatUserService")
public class BatUserService extends BaseService {
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BatUserDAO batUserDAO;
	
	public void makeUserData(Map<String, Object> paramMap) throws ServiceException, Exception {
		
        batUserDAO.makeUserData();
	}	
}
