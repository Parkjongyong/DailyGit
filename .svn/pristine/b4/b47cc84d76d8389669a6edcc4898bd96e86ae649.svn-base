/**
 * 시스템관리 > 배치 관리 Service
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

import org.apache.commons.lang.ObjectUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.sys.controller.SysCmmLogMgmtController;
import com.app.ildong.sys.dao.SysCmmCodeMgmtDAO;
import com.app.ildong.sys.dao.SysCmmLogMgmtDAO;
import com.ecbank.framework.exception.BizException;

@Service("SysCmmLogMgmtService")
public class SysCmmLogMgmtService extends BaseService {
    private static final Logger logger = LoggerFactory.getLogger(SysCmmLogMgmtService.class);
	
	@Autowired
	private SysCmmLogMgmtDAO sysCmmLogMgmtDAO;	
	
    public List<Map<String,Object>> selectRfcLogMgmtList(Map<String,Object> paramMap) throws ServiceException, Exception{
        return sysCmmLogMgmtDAO.selectRfcLogMgmtList(paramMap);
    }
    
    public Map<String,Object> selectRfcLogMgmtDetail(Map<String,Object> paramMap) throws ServiceException, Exception{
        return sysCmmLogMgmtDAO.selectRfcLogMgmtDetail(paramMap);
    }
    
    public List<Map<String,Object>> selectAlarmLogMgmtList(Map<String,Object> paramMap) throws ServiceException, Exception{
        return sysCmmLogMgmtDAO.selectAlarmLogMgmtList(paramMap);
    }
    
    public Map<String,Object> selectAlarmLogMgmtDetail(Map<String,Object> paramMap) throws ServiceException, Exception{
        return sysCmmLogMgmtDAO.selectAlarmLogMgmtDetail(paramMap);
    }
    
    public List<Map<String,Object>> selectBatchLogMgmtList(Map<String,Object> paramMap) throws ServiceException, Exception{
        return sysCmmLogMgmtDAO.selectBatchLogMgmtList(paramMap);
    }
    
    public List<Map<String,Object>> selectBatchLogMgmtDetailList(Map<String,Object> paramMap) throws ServiceException, Exception{
        return sysCmmLogMgmtDAO.selectBatchLogMgmtDetailList(paramMap);
    }
    
    public Map<String,Object> selectBatchLogMgmtErrDetail(Map<String,Object> paramMap) throws ServiceException, Exception{
        return sysCmmLogMgmtDAO.selectBatchLogMgmtErrDetail(paramMap);
    }
    
	public int updateBatchMaster(Map<String,Object> paramMap) throws BizException, Exception {
		return sysCmmLogMgmtDAO.updateBatchMaster(paramMap);
	}
	
	public int updateParamBatchMaster(Map<String,Object> paramMap) throws BizException, Exception {
		return sysCmmLogMgmtDAO.updateParamBatchMaster(paramMap);
	} 	
}
