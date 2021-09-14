package com.app.ildong.bat.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("batItemDAO")
public class BatItemDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public int mergeItemData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchItem.mergeItemData", paramMap);
	}	
	
}
