package com.app.ildong.bat.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("BatDeptDAO")
public class BatDeptDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate2;	
	
	public List<Map<String, Object>> selectDeptData(Map<String, Object> paramMap) {
		return sqlSessionTemplate2.selectList("interface.selectDeptData", paramMap);
	}
	
	public Map<String, Object> selectCountDeptInfo(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectOne("com.bat.BatchDept.selectCountDeptInfo", paramMap);
	}	
	
	public int insertDeptIfData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchDept.insertDeptIfData", paramMap);
	}	
	
	public int updateDeptIfData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchDept.updateDeptIfData", paramMap);
	}
	
	public void makeDeptData() {
		sqlSessionTemplate.insert("com.bat.BatchDept.makeDeptData");
	}		
}
