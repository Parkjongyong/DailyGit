/**
 * 알림팝업 조회/등록/수정 서비스
 * @author 길용덕
 * @since 2020.06.17
 * 
 * << 개정이력(Modification Information) >>
 *  ------------------------------------------------- 
 *  수정일                    수정자            수정내용
 *  ----------   -------- ---------------------------
 *  2020.06.18   길용덕            최초생성
 *  -------------------------------------------------
 */
package com.app.ildong.sys.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.sys.dao.SysPopupMgmtDAO;

@Service("SysPopupMgmtService")
public class SysPopupMgmtService extends BaseService {
	
	@Autowired
	private SysPopupMgmtDAO sysPopupMgmtDAO;

	public List<Map<String,Object>> selectSysPopupMgmtList(Map<String,Object> paramMap) {
		return sysPopupMgmtDAO.selectSysPopupMgmtList(paramMap);
	}
	
	public int insertPopupMgmt(Map<String, Object> paramMap) throws Exception {
	    paramMap.put("INS_ID", getUserId());
	    
		return sysPopupMgmtDAO.insertPopupMgmt(paramMap);
	}
	
	public int updatePopupMgmt(Map<String, Object> paramMap) throws Exception {
	    paramMap.put("MOD_ID", getUserId());
	    
		return sysPopupMgmtDAO.updatePopupMgmt(paramMap);
	}
	
	public Map<String, Object> selectPopupMgmt(Map<String, Object> paramMap) {
		return sysPopupMgmtDAO.selectPopupMgmt(paramMap);
	}
	
	public List<Map<String,Object>> selectSysPopupMgmtListMain(Map<String,Object> paramMap) {
		return sysPopupMgmtDAO.selectSysPopupMgmtListMain(paramMap);
	}
	
	public Map<String, Object> selectPopupMgmtMain(Map<String, Object> paramMap) {
		return sysPopupMgmtDAO.selectPopupMgmtMain(paramMap);
	}
}
