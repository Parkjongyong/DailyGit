package com.app.ildong.bat.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("BatLogDAO")
public class BatLogDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public void insertBatchLogOnStart(Map<String,Object> paramMap) {
		sqlSessionTemplate.insert("com.bat.BatchLog.insertBatchLogOnStart", paramMap);
	}
	
	public void updateBatchLogOnEnd(Map<String,Object> paramMap) {
		sqlSessionTemplate.update("com.bat.BatchLog.updateBatchLogOnEnd", paramMap);
	}
	
}
