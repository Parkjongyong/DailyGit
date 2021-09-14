package com.app.ildong.wrh.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("wrhStorageSpaceMgmtDAO")
public class WrhStorageSpaceMgmtDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectWhrStorageSpaceMgmtList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.wrh.StorageSpace.selectWhrStorageSpaceMgmtList", paramMap);
	}
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectwrhStorageSpacePopList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.wrh.StorageSpace.selectwrhStorageSpacePopList", paramMap);
	}	
	
	public void saveWhrStorageSpace(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.wrh.StorageSpace.saveWhrStorageSpace", paramMap);
	}	
	
}
