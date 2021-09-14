package com.app.ildong.bat.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("batOderMstDAO")
public class BatOderMstDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public int mergeOrderMastData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchOrderMst.mergeOrderMastData", paramMap);
	}	
}
