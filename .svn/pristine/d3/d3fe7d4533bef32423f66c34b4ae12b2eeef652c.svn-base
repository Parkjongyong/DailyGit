/**
 * 시스템관리 > 공통코드 관리 DAO
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
package com.app.ildong.sys.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("SysCmmCodeMgmtDAO")
public class SysCmmCodeMgmtDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectGrpCdList(Map<String, Object> paramMap)
	{
		return sqlSessionTemplate.selectList("com.sys.SysCmmCodeMgmtDAO.selectGrpCdList", paramMap);
	}
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectDetlCdList(Map<String, Object> paramMap)
	{
		return sqlSessionTemplate.selectList("com.sys.SysCmmCodeMgmtDAO.selectDetlCdList", paramMap);
	}
	
	public int selectCheckGrpCdExist(Map<String,Object> paramMap) {
		return sqlSessionTemplate.selectOne("com.sys.SysCmmCodeMgmtDAO.selectCheckGrpCdExist", paramMap);
	}
	
	public int selectCheckDetlCdExist(Map<String,Object> paramMap) {
		return sqlSessionTemplate.selectOne("com.sys.SysCmmCodeMgmtDAO.selectCheckDetlCdExist", paramMap);
	}
	
	public void insertGrpCd(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.sys.SysCmmCodeMgmtDAO.insertGrpCd", paramMap);
	}

	public void updateGrpCd(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.sys.SysCmmCodeMgmtDAO.updateGrpCd", paramMap);
	}
	
	public void deleteGrpCd(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.sys.SysCmmCodeMgmtDAO.deleteGrpCd", paramMap);
	}

	public void insertDetlCd(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.sys.SysCmmCodeMgmtDAO.insertDetlCd", paramMap);
	}

	public void updateDetlCd(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.sys.SysCmmCodeMgmtDAO.updateDetlCd", paramMap);
	}
	
	public void deleteDetlCd(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.sys.SysCmmCodeMgmtDAO.deleteDetlCd", paramMap);
	}

	public void deleteDetlGrp(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.sys.SysCmmCodeMgmtDAO.deleteDetlGrp", paramMap);
	}
	
}

