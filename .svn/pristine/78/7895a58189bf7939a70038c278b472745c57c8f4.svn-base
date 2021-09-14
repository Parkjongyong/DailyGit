package com.app.ildong.bat.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("batAccountNoDAO")
public class BatAccountNoDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public int mergeAccountNoData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchAccountNo.mergeAccountNoData", paramMap);
	}	
}
