package com.app.ildong.bat.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.bat.dao.BatGRItemDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;

@Service("BatGRItemService")
public class BatGRItemService extends BaseService {
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BatGRItemDAO bBatGRItemDAO;
	
	public void makeInterfaceGRItemData(List<Map<String, Object>> grItemList) throws ServiceException, Exception {
		
		// 데이터가 존재하는  경우만  PO_HEAD_IF 테이블에 반영!
        if (null != grItemList && 0 < grItemList.size()) {
        	int cnt = 0;
            for (Map<String, Object> grItem: grItemList) {
            	
            	bBatGRItemDAO.mergeGRItemIfData(grItem);
            	cnt++;
            	System.out.println("cnt::" + cnt);
            }
        }
	}
}
