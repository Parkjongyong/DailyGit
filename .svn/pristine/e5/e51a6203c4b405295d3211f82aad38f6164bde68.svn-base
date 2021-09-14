package com.app.ildong.wrh.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("vendorScheduledDAO")
public class WrhVendorScheduledDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectVendorScheduled(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.wrh.VendorScheduled.selectVendorScheduled", paramMap);
	}

}
