package com.app.ildong.wrh.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("matlConfirmDAO")
public class WrhMatlConfirmDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectMatlConfirm(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.wrh.MatlConfirm.selectMatlConfirm", paramMap);
	}
	
	public void updateMatlConfirm(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.wrh.MatlConfirm.updateMatlConfirm", paramMap);
	}
	
    
}
