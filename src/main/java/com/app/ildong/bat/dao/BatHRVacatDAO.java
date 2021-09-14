package com.app.ildong.bat.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("batHRVacatDAO")
public class BatHRVacatDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate2;	
	
	public List<Map<String, Object>> selectHRVacatHeadData(Map<String, Object> paramMap) {
		return sqlSessionTemplate2.selectList("interface.selectHRVacatHeadData", paramMap);
	}
	
	public List<Map<String, Object>> selectHRVacatDetailData(Map<String, Object> paramMap) {
		return sqlSessionTemplate2.selectList("interface.selectHRVacatDetailData", paramMap);
	}	
	
	public int mergeHRVacatHeadData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchHRVacat.mergeHRVacatHeadData", paramMap);
	}
	
	public int mergeHRVacatDetailData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchHRVacat.mergeHRVacatDetailData", paramMap);
	}	
}
