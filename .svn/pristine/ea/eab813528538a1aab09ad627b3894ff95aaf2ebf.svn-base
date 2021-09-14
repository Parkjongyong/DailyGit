package com.app.ildong.bat.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.bat.dao.BatVendorDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;

@Service("batVendorInterfaceService")
public class BatVendorInterfaceService extends BaseService {
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BatVendorDAO batVendorDAO;
	
	public void makeInterfaceVendorData(Map<String, Object> paramMap, List<Map<String, Object>> vendorList, List<Map<String, Object>> vendPurchorgList) throws ServiceException, Exception {
		
		// 데이터가 존재하는  경우만 VENDOR_INFO_IF 테이블에 반영!
        if (null != vendorList && 0 < vendorList.size()) {
            for (Map<String, Object> vendor: vendorList) {
            	
            	// IF KEY를 TO_DATE로 셋팅
            	vendor.put("TRANSACTION_NO", paramMap.get("TRANSACTION_NO"));
            	// 신규 데이터  insert or 기등록데이터  update 
            	batVendorDAO.mergeVendorIfData(vendor);
            }
            
        	// VENDOR_INFO_IF에 UPDATE!
            //batVendorDAO.updateVendorFlag();            
        }
        
		// 데이터가 존재하는  경우만 VENDOR_PURCHORG_IF테이블에 반영!
        if (null != vendPurchorgList && 0 < vendPurchorgList.size()) {
            for (Map<String, Object> vendPurchorg: vendPurchorgList) {
            	
            	// IF KEY를 TO_DATE로 셋팅
            	vendPurchorg.put("TRANSACTION_NO", paramMap.get("TRANSACTION_NO"));
            	// 신규 데이터  insert or 기등록데이터  update 
            	batVendorDAO.mergeVendPurchorgIfData(vendPurchorg);
            }
            
        	// VENDOR_PURCHORG_IF에 UPDATE!
            //batVendorDAO.updateVendPurchorgFlag();             
        }
	}	
}
