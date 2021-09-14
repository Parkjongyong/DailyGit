package com.app.ildong.bdg.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("bdgCostMgtDAO")
public class BdgCostMgtDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectCostMgtList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.CostMgt.selectCostMgtList", paramMap);
	}
	
	public List<Map<String, Object>> selectCostMgtListPop(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.CostMgt.selectCostMgtListPop", paramMap);
	}
	
	public void updateCostMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.CostMgt.updateCostMgt", paramMap);
	}
	
	public void insertCostMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.CostMgt.insertCostMgt", paramMap);
	}
	
	public void deleteCostMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.CostMgt.deleteCostMgt", paramMap);
	}	
	
	public void updatCostMgtStatus(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.CostMgt.updatCostMgtStatus", paramMap);
	}
	
}
