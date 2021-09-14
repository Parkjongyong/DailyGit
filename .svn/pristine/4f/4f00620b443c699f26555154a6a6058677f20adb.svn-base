package com.app.ildong.bat.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("batCustomerInfoDAO")
public class BatCustomerInfoDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public int makeCustomerInfoInterfaceData( List<Map<String, Object>> list) {
		return sqlSessionTemplate.insert("com.bat.BatchCustomerInfo.makeCustomerInfoInterfaceData", list);
	}	
	
	public void updateCustomerInfoFlag() {
		sqlSessionTemplate.insert("com.bat.BatchCustomerInfo.updateCustomerInfoFlag");
	}
	
	public void makeCustomerInfoData(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bat.BatchCustomerInfo.makeCustomerInfoData", paramMap);
	}	
	
}
