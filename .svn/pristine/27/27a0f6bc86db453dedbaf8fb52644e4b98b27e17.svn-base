package com.app.ildong.bat.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.bat.dao.BatOderMstDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;

@Service("batOrderMstInterfaceService")
public class BatOrderMstInterfaceService extends BaseService {
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BatOderMstDAO batOderMstDAO;
	
	public void makeOrderMstData(Map<String, Object> paramMap, List<Map<String, Object>> orderMstList) throws ServiceException, Exception {
		
		// 데이터가 존재하는  경우만 CO_ORDER_MST 테이블에 반영!
        if (null != orderMstList && 0 < orderMstList.size()) {
            for (Map<String, Object> orderMst: orderMstList) {
            	
            	// 신규 데이터  insert or 기등록데이터  update 
            	batOderMstDAO.mergeOrderMastData(orderMst);
            }
        }
	}	
}
