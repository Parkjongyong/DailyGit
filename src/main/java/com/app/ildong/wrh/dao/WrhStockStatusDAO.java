package com.app.ildong.wrh.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("wrhStockStatusDAO")
public class WrhStockStatusDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectStockStatusList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.wrh.StockStatus.selectStockStatusList", paramMap);
	}
	
	public Map<String, Object> selectTotalGrAmt(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectOne("com.wrh.StockStatus.selectTotalGrAmt", paramMap);
	}	
	
}
