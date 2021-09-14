package com.app.ildong.cmn.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("cmnItemMgmtDAO")
public class CmnItemMgmtDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectItemMgmtList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.cmn.cmnItemMgmt.selectItemMgmtList", paramMap);
	}
	
	public List<Map<String, Object>> selectPlantItemList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.cmn.cmnItemMgmt.selectPlantItemList", paramMap);
	}
	
}
