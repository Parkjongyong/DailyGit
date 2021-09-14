package com.app.ildong.bdg.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("bdgAccRateMgtDAO")
public class BdgAccRateMgtDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectAccRateAMgtLeftList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.AccRateMgt.selectAccRateAMgtLeftList", paramMap);
	}
	
	public List<Map<String, Object>> selectAccRateAMgtRightList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.AccRateMgt.selectAccRateAMgtRightList", paramMap);
	}
	
	public Map<String, Object> selectDataCount(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.AccRateMgt.selectDataCount", paramMap);
    }
	
	public void insertAccRateMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.AccRateMgt.insertAccRateMgt", paramMap);
	}
	
	public void deleteAccRateMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.AccRateMgt.deleteAccRateMgt", paramMap);
	}	
	
	public void mergeAccRateReason(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.AccRateMgt.mergeAccRateReason", paramMap);
	}
	
}
