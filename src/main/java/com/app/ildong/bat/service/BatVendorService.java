package com.app.ildong.bat.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.bat.dao.BatVendorDAO;
import com.app.ildong.common.crypt.DigestUtil;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;

@Service("batVendorService")
public class BatVendorService extends BaseService {
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BatVendorDAO batVendorDAO;
	
	@Autowired
    private DigestUtil digestUtil;	
	
	public void makeVendorData(Map<String, Object> paramMap) throws ServiceException, Exception {
		
		
    	// VENDOR_INFO에 MERGE!
    	batVendorDAO.makeVendorData();

    	// 신규 USER 생성 데이터
    	List<Map<String, Object>> vendorList = batVendorDAO.selectVendorUserCreateList(paramMap);
        
		// 데이터가 존재하는  경우만 VENDOR_INFO_IF 테이블에 반영!
        if (null != vendorList && 0 < vendorList.size()) {
            for (Map<String, Object> vendor: vendorList) {
            	
            	String userId = (String) vendor.get("POBUSI_NO");
            	String encryptedPwd = digestUtil.digest("#"+userId, userId);
            	
        		vendor.put("USER_PW", encryptedPwd);
        		batVendorDAO.insertSysUserData(vendor);            	
        		
        		batVendorDAO.insertSysUserRoleData(vendor);
            }
        }
        
    	// VENDOR_INFO_IF에 UPDATE!
    	batVendorDAO.updateVendorFlag();
		
    	// VENDOR_PURCHORG에 MERGE!
    	batVendorDAO.makeVendPurchorgData();

    	// VENDOR_USER에 MERGE!
    	batVendorDAO.makeVendUserData();
    	
    	// VENDOR_PURCHORG_IF에 UPDATE!
    	batVendorDAO.updateVendPurchorgFlag();        	
	}	
}
