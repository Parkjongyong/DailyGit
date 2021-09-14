package com.app.ildong.bdg.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("bdgYearResultMgtDAO")
public class BdgYearResultMgtDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectBasicYearResult(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.BdgYearResult.selectBasicYearResult", paramMap);
	}
	
	public List<Map<String, Object>> selectModifyYearResult(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.BdgYearResult.selectModifyYearResult", paramMap);
	}
	
	public List<Map<String, Object>> selectExecYearResult(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.BdgYearResult.selectExecYearResult", paramMap);
	}
	
	public List<Map<String, Object>> selectSuppleYearResult(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.BdgYearResult.selectSuppleYearResult", paramMap);
	}
	
}
