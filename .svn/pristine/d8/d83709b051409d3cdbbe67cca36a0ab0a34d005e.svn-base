package com.app.ildong.bdg.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("bdgResultDAO")
public class BdgResultDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectBasicResult(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.BdgResult.selectBasicResult", paramMap);
	}

	public List<Map<String, Object>> selectModifyResult(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.BdgResult.selectModifyResult", paramMap);
	}
	
	public List<Map<String, Object>> selectExecResult(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.BdgResult.selectExecResult", paramMap);
	}
	
	public List<Map<String, Object>> selectSuppleResult(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.BdgResult.selectSuppleResult", paramMap);
	}
	
	public List<Map<String, Object>> selectResultPop(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.BdgResult.selectResultPop", paramMap);
	}
	
	
}
