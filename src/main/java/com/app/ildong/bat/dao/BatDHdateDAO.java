package com.app.ildong.bat.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("BatDHdateDAO")
public class BatDHdateDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public int updateDeliveryHeadDate() {
		return sqlSessionTemplate.update("com.bat.BatchDHdate.updateDeliveryHeadDate");
	}
	
}
