package com.app.ildong.cmn.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("cmnPlantStorageDAO")
public class CmnPlantStorageDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectPlantStorageList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.cmn.PlantStorage.selectPlantStorageList", paramMap);
	}
	
}
