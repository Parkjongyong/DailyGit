/**
 * 시스템관리 > 비밀번호 변경 Service
 * @author 박종용
 * @since 2020.06.22
 *
 * << 개정이력(Modification Information) >>
 *  -------------------------------------------------
 *  수정일                    수정자            수정내용
 *  ----------   -------- ---------------------------
 *  2020.06.22   박종용            최초생성
 *  -------------------------------------------------
 */
package com.app.ildong.sys.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.sys.dao.SysPwChangeDAO;

@Service("SysPwChangeService")
public class SysPwChangeService extends BaseService {
    private static final Logger logger = LoggerFactory.getLogger(SysPwChangeService.class);
	
	@Autowired
	private SysPwChangeDAO SysPwChangeDAO;	

	
    public Map<String,Object> updatePw(Map<String,Object> paramMap) throws ServiceException, Exception {
    	SysPwChangeDAO.updatePw(paramMap);
    	return paramMap;
    }
    
    public Map<String,Object> checkPw(Map<String,Object> paramMap) throws ServiceException, Exception {
    	paramMap = SysPwChangeDAO.checkPw(paramMap);
    	return paramMap;
    }
    
}
