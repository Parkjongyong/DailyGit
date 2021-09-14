package com.app.ildong.bdg.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("bdgBugtTermDAO")
public class BdgBugtTermDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectBugtTermList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.BugtTerm.selectBugtTermList", paramMap);
	}
	
	public void updateBugtTerm(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.BugtTerm.updateBugtTerm", paramMap);
	}
	
	public void insertBugtTerm(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.BugtTerm.insertBugtTerm", paramMap);
	}
	
	public void deleteBugtTerm(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.BugtTerm.deleteBugtTerm", paramMap);
	}	
	
}
