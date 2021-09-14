package com.app.ildong.wrh.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("wrhDeliveryHistoryDAO")
public class WrhDeliveryHistoryDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectDeliveryHistoryList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.wrh.DeliveryHistory.selectDeliveryHistoryList", paramMap);
	}
}
