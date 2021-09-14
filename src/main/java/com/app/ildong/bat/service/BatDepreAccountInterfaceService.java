package com.app.ildong.bat.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.bat.dao.BatDepreAccountDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;

@Service("batDepreAccountInterfaceService")
public class BatDepreAccountInterfaceService extends BaseService {
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BatDepreAccountDAO batDepreAccountDAO;
	
	public void makeDepreAccountData(Map<String, Object> paramMap, List<Map<String, Object>> depreAccountList) throws ServiceException, Exception {
		
		// CO_DEPRE_ACCOUNT 테이블에 반영!
        if (null != depreAccountList && 0 < depreAccountList.size()) {
            for (Map<String, Object> depreAccount: depreAccountList) {
            	// 신규 데이터  insert
            	depreAccount.put("TRANSACTION_NO", paramMap.get("TRANSACTION_NO"));
            	batDepreAccountDAO.insertOrderMastData(depreAccount);
            }
            
            System.out.println(paramMap.get("VERSION").toString().substring(0, 1));
            // 기본 예산 신청 정보 생성 처리
        	// 신규 데이터  insert or 기등록 데이터 update 처리
            if ("A".equals(paramMap.get("VERSION").toString().substring(0, 1))) {
            	batDepreAccountDAO.mergeBasicHeadData(paramMap);
            	batDepreAccountDAO.mergeBasicDetailData(paramMap);
            } else if ("B".equals(paramMap.get("VERSION").toString().substring(0, 1))) {
            	batDepreAccountDAO.mergeModifyHeadData(paramMap);
            	batDepreAccountDAO.mergeModifyDetailData(paramMap);           	
            }
        }
	}	
}
