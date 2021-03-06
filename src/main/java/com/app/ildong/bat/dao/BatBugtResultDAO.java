package com.app.ildong.bat.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("batBugtResultDAO")
public class BatBugtResultDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public int mergeBugtResultData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchBugtResult.mergeBugtResultData", paramMap);
	}	
	
	public int deleteBugtResultData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchBugtResult.deleteBugtResultData", paramMap);
	}	
	
	
}
