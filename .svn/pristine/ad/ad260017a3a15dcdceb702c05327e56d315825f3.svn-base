package com.app.ildong.bat.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.bat.dao.BatAccountNoDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;

@Service("batAccountNoInterfaceService")
public class BatAccountNoInterfaceService extends BaseService {
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BatAccountNoDAO batAccountNoDAO;
	
	public void makeAccountNoData(Map<String, Object> paramMap, List<Map<String, Object>> accountNoList) throws ServiceException, Exception {
		
		// 데이터가 존재하는  경우만 VENDOR_INFO_IF 테이블에 반영!
        if (null != accountNoList && 0 < accountNoList.size()) {
            for (Map<String, Object> accountNo: accountNoList) {
            	
            	// 신규 데이터  insert or 기등록데이터  update 
            	batAccountNoDAO.mergeAccountNoData(accountNo);
            }
        }
	}	
}
