package com.app.ildong.bat.service;

import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.bat.dao.BatMaterialsDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;

@Service("BatMaterialsService")
public class BatMaterialsService extends BaseService {
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BatMaterialsDAO batMaterialsDAO;
	
	public void makeMaterialsData(Map<String, Object> paramMap) throws ServiceException, Exception {
        batMaterialsDAO.makeMaterialsHeadData(paramMap);
        batMaterialsDAO.updateMaterialsHeadFlag();
        
        batMaterialsDAO.makeMaterialsPlantData(paramMap);
        batMaterialsDAO.updateMaterialsPlantFlag();        
	}	
}
