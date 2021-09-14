package com.app.ildong.bat.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("BatGRItemDAO")
public class BatGRItemDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public Map<String, Object> selectCountGRItemInfo(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectOne("com.bat.BatchGRItem.selectCountGRItemInfo", paramMap);
	}	
	
	public int insertGRItemIfData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchGRItem.insertGRItemIfData", paramMap);
	}	
	
	public int updateGRItemIfData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchGRItem.updateGRItemIfData", paramMap);
	}
	
	public int mergeGRItemIfData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchGRItem.mergeGRItemIfData", paramMap);
	}	
	
}
