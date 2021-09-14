package com.app.ildong.bat.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("batDepreAccountDAO")
public class BatDepreAccountDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public int insertOrderMastData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchDepreAccount.insertOrderMastData", paramMap);
	}	
	
	public int mergeBasicHeadData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchDepreAccount.mergeBasicHeadData", paramMap);
	}
	
	public int mergeModifyHeadData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchDepreAccount.mergeModifyHeadData", paramMap);
	}	
	
	public int mergeBasicDetailData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchDepreAccount.mergeBasicDetailData", paramMap);
	}
	
	public int mergeModifyDetailData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchDepreAccount.mergeModifyDetailData", paramMap);
	}	
	
}
