package com.app.ildong.bat.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.bat.dao.BatSendBugtDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;

@Service("batSendBugtInterfaceService")
public class BatSendBugtInterfaceService extends BaseService {
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BatSendBugtDAO batSendBugtDAO;
	
	public Map<String, Object> selectSendBugtList(Map<String, Object> paramMap) throws ServiceException, Exception {
		
		List<Map<String,Object>> dataList1 = new ArrayList<Map<String, Object>>();
		List<Map<String,Object>> dataList2 = new ArrayList<Map<String, Object>>();
		Map<String,Object> returnParam = new HashMap<>();
		if ("A".equals(paramMap.get("ZBUDCA"))) {
			dataList1 = batSendBugtDAO.selectSendBasicBugtList(paramMap);
			dataList2 = batSendBugtDAO.selectSendBugtBasicMgmtList(paramMap);
			returnParam.put("IFCO008", dataList1);
			returnParam.put("IFCO014", dataList2);
		} else if ("B".equals(paramMap.get("ZBUDCA"))) {
			dataList1 = batSendBugtDAO.selectSendModifyBugtList(paramMap);
			dataList2 = batSendBugtDAO.selectSendBugtModifyBasicMgmtList(paramMap);
			returnParam.put("IFCO008", dataList1);
			returnParam.put("IFCO014", dataList2);			
		}
		return returnParam;
	}	
}
