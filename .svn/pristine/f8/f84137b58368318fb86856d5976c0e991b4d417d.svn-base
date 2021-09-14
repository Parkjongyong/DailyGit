package com.app.ildong.wrh.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("wrhDelyDateDAO")
public class WrhDelyDateDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectDelyDateList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.wrh.DelyDate.selectDelyDateList", paramMap);
	}
}
