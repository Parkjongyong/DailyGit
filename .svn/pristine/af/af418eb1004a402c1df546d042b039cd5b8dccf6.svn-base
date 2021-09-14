package com.app.ildong.wrh.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("orderStatusDAO")
public class WrhOrderStatusDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectOrderStatusList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.wrh.OrderStatus.selectOrderStatusList", paramMap);
	}
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectOrderStatusDetail(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.wrh.OrderStatus.selectOrderStatusDetail", paramMap);
	}
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectOrderStatusDetailOne(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.wrh.OrderStatus.selectOrderStatusDetailOne", paramMap);
	}
	
	public int wrhOrderStatusHeaderConfirm(Map<String,Object> paramMap) {
		return sqlSessionTemplate.insert("com.wrh.OrderStatus.wrhOrderStatusHeaderConfirm", paramMap);
	}
	
	public int wrhOrderStatusItemConfirm(Map<String,Object> paramMap) {
		return sqlSessionTemplate.insert("com.wrh.OrderStatus.wrhOrderStatusItemConfirm", paramMap);
	}	
	
	public int wrhOrderStatusDetailConfirmCancel(Map<String,Object> paramMap) {
		return sqlSessionTemplate.insert("com.wrh.OrderStatus.wrhOrderStatusDetailConfirmCancel", paramMap);
	}	
	
	
	
}
