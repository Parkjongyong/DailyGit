package com.app.ildong.bat.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("BatMasterDAO")
public class BatMasterDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public Map<String,Object> selectBatchMaster(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectOne("com.bat.BatchMaster.selectBatchMaster", paramMap);
	}
	
	public List<Map<String, Object>> selectCompCd(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectList("com.bat.BatchMaster.selectCompCd", paramMap);
	}
	
}
