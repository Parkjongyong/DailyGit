package com.app.ildong.bat.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("batSendInvestDAO")
public class BatSendInvestDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public List<Map<String, Object>> selectSendAssetList(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectList("com.bat.BatchSendInvest.selectSendAssetList", paramMap);
	}
	
}
