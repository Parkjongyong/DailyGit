/**
 * 알림팝업 조회/등록/수정 DAO
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
package com.app.ildong.sys.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("SysPopupMgmtDAO")
public class SysPopupMgmtDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public List<Map<String,Object>> selectSysPopupMgmtList(Map<String,Object> paramMap) {
		return sqlSessionTemplate.selectList("com.sys.SysPopupMgmt.selectSysPopupMgmtList", paramMap);
	}
	
	public int insertPopupMgmt(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.sys.SysPopupMgmt.insertPopupMgmt", paramMap);
	}
	
	public int updatePopupMgmt(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.sys.SysPopupMgmt.updatePopupMgmt", paramMap);
	}
	
	public Map<String, Object> selectPopupMgmt(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectOne("com.sys.SysPopupMgmt.selectPopupMgmt", paramMap);
	}
	
	public List<Map<String,Object>> selectSysPopupMgmtListMain(Map<String,Object> paramMap) {
		return sqlSessionTemplate.selectList("com.sys.SysPopupMgmt.selectSysPopupMgmtListMain", paramMap);
	}
	
	public Map<String, Object> selectPopupMgmtMain(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectOne("com.sys.SysPopupMgmt.selectPopupMgmtMain", paramMap);
	}
}
