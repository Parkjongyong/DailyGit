/**
 * 부서 조회 DAO
 * @author 길용덕
 * @since 2020.07.08
 * 
 * << 개정이력(Modification Information) >>
 *  ------------------------------------------------- 
 *  수정일                    수정자            수정내용
 *  ----------   -------- ---------------------------
 *  2020.07.08   길용덕            최초생성
 *  -------------------------------------------------
 */
package com.app.ildong.cmn.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("cmnCctrDAO")
public class CmnCctrDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectCctrList(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectList("com.cmn.Cctr.selectCctrList", paramMap);
	}
	
	public List<Map<String, Object>> selectCctrListA(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectList("com.cmn.Cctr.selectCctrListA", paramMap);
	}
	
	public List<Map<String, Object>> selectCctrListB(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectList("com.cmn.Cctr.selectCctrListB", paramMap);
	}	
}
