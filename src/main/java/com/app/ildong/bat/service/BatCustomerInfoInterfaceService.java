package com.app.ildong.bat.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.bat.dao.BatCustomerInfoDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;

@Service("batCustomerInfoInterfaceService")
public class BatCustomerInfoInterfaceService extends BaseService {
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BatCustomerInfoDAO batCustomerInfoDAO;
	
	public void makeCustomerInfoInterfaceData(List<Map<String, Object>> customerInfoList, Map<String, Object> paramMap) throws ServiceException, Exception {
		
		int cCnt = 0;
		System.out.println("customerInfoList.size::" + customerInfoList.size());
		List<Map<String, Object>> insertList = new ArrayList<Map<String, Object>>();
		
		// 데이터가 존재하는  경우만  SD_CUSTOMER_INFO_IF 테이블에 반영!
        if (null != customerInfoList && 0 < customerInfoList.size()) {
            for (Map<String, Object> customerInfo: customerInfoList) {
            	customerInfo.put("TRANSACTION_NO", paramMap.get("TRANSACTION_NO"));
            	insertList.add(customerInfo);
            	cCnt++;
            	
    			if (cCnt % 500 == 0 || customerInfoList.size() == cCnt) {
    				System.out.println("cCnt::" + cCnt);
    				// SD_CUSTOMER_INFO_IF 생성
    				batCustomerInfoDAO.makeCustomerInfoInterfaceData(insertList);
    				//초기화
    				insertList = new ArrayList<Map<String, Object>>();
    			}            	
            }
        }
        
        System.out.println("TOTAL CNT:::: "+ cCnt);
	}
}
