package com.app.ildong.bat.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.bat.dao.BatItemDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;

@Service("batItemService")
public class BatItemService extends BaseService {
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BatItemDAO batItemDAO;
	
	public void makeInterfaceItemData(List<Map<String, Object>> itemList) throws ServiceException, Exception {
		
		int cnt1 = 0;
		// 데이터가 존재하는  경우만 IV_HEAD 테이블에 반영!
        if (null != itemList && 0 < itemList.size()) {
            for (Map<String, Object> item: itemList) {
            	batItemDAO.mergeItemData(item);
            	cnt1++;
            }
            System.out.println("itemList cnt::" + cnt1);
        }
	}	
}
