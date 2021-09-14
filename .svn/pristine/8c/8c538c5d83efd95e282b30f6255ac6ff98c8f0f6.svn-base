package com.app.ildong.wrh.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("matInfoDAO")
public class WrhMatInfoDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectMatInfo(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.wrh.MatInfo.selectMatInfo", paramMap);
	}

}
