package com.app.ildong.bat.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("batApmCancelDAO")
public class BatApmCancelDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public void updateBugtApmData(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bat.ApmCancel.updateBugtApmData", paramMap);
	}
	
	public void updateBugtApmTransData(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bat.ApmCancel.updateBugtApmTransData", paramMap);
	}	
}
