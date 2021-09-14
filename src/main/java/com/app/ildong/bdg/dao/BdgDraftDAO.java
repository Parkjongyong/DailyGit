package com.app.ildong.bdg.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("DraftDAO")
public class BdgDraftDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectDraft(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.Draft.selectDraft", paramMap);
	}
	
	public void insertDraft(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.Draft.insertDraft", paramMap);
	}
	
	public void updateDraft(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.Draft.updateDraft", paramMap);
	}
	
	public void delDraft(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.Draft.delDraft", paramMap);
	}
}
