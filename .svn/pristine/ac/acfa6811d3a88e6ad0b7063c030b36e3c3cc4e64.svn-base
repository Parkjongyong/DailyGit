package com.app.ildong.bat.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.bat.dao.BatPurchOrderDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;

@Service("BatPurchOrderService")
public class BatPurchOrderService extends BaseService {
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BatPurchOrderDAO batPurchOrderDAO;
	
	public void makePurchOrderData(Map<String, Object> paramMap) throws ServiceException, Exception {
		
		
    	// PO_HEAD에 MERGE!
    	batPurchOrderDAO.makePOHederData(paramMap);
        
    	// PO_HEAD_REMK에 MERGE!
    	batPurchOrderDAO.makePOHederRemkData(paramMap);
        
    	// PO_ITEM에 MERGE!
    	batPurchOrderDAO.makePOItemData(paramMap);
        
    	// PO_ITEM_REMK에 MERGE!
    	batPurchOrderDAO.makePOItemRemkData(paramMap);
    	
    	
    	// PO_HEAD_IF에 UPDATE!
    	batPurchOrderDAO.updatePOHederFlag();
    	
    	// PO_HEAD_REMK_IF에 UPDATE!
    	batPurchOrderDAO.updatePOHederRemkFlag(); 
    	
    	// PO_ITEM_IF에 UPDATE!
    	batPurchOrderDAO.updatePOItemFlag(); 
    	
    	// PO_ITEM_REMK_IF에 UPDATE!
    	batPurchOrderDAO.updatePOItemRemkFlag();     	
	}
}
