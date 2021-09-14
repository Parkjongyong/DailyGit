package com.app.ildong.bat.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.bat.dao.BatUserDAO;
import com.app.ildong.common.crypt.DigestUtil;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;

@Service("batUserInterfaceService")
public class BatUserInterfaceService extends BaseService {
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BatUserDAO batUserDAO;
	
	@Autowired
    private DigestUtil digestUtil;		
	
	public void makeInterfaceUserData(Map<String, Object> paramMap) throws ServiceException, Exception {
		
		List<Map<String, Object>> selectList = batUserDAO.selectUserData(paramMap);
		List<Map<String, Object>> insertList = new ArrayList<Map<String, Object>>();
		
		// 초기화
		batUserDAO.deleteUserIfData();
		
		int cCnt = 0;
		System.out.println("selectList.size::" + selectList.size());
		for (Map<String, Object> data: selectList) {
			
        	String userId = (String) data.get("SABUN");
        	String encryptedPwd = digestUtil.digest("#"+userId, userId);
        	
        	data.put("PWD", encryptedPwd);
    		
			insertList.add(data);
			cCnt++;
			if (cCnt % 500 == 0 || selectList.size() == cCnt) {
				System.out.println("cCnt::" + cCnt);
				// 일괄 등록
				batUserDAO.batchUserIfData(insertList);
				//초기화
				insertList = new ArrayList<Map<String, Object>>();
			}
		}
	}	
}
