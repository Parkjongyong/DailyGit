package com.app.ildong.bat.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.bat.dao.BatDeptDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;

@Service("BatDeptService")
public class BatDeptService extends BaseService {
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BatDeptDAO batDeptDAO;
	
	public void makeInterfaceDeptData(Map<String, Object> paramMap) throws ServiceException, Exception {
		
		List<Map<String, Object>> selectList = batDeptDAO.selectDeptData(paramMap);
		
		int updateCnt = 0;
		int insertCnt = 0;
		int totalCnt = 0;
		
		// 데이터가 존재하는  경우만 부서테이블에 반영!
        if (null != selectList && 0 < selectList.size()) {
            for (Map<String, Object> data: selectList) {
            	
            	// 데이터 존재유무 확인
            	Map<String,Object> deptInfoCnt = batDeptDAO.selectCountDeptInfo(data);
            	
            	// 신규 데이터  insert 
            	if ("0".equals(String.valueOf(deptInfoCnt.get("CNT")))) {
            		insertCnt += batDeptDAO.insertDeptIfData(data);
            	// 기등록 데이터  update
            	} else {
            		updateCnt += batDeptDAO.updateDeptIfData(data);
            	}
            }
            
            totalCnt = insertCnt + updateCnt;
        }
        
        // 부서정보에도 UPDATE
        if (totalCnt > 0) {
        	batDeptDAO.makeDeptData();
        }
	}	
}
