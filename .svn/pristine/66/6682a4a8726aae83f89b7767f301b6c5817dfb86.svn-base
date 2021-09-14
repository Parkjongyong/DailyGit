package com.app.ildong.bdg.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("bdgDeptSampleMgtDAO")
public class BdgDeptSampleMgtDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectDeptSampleMgtList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.DeptSampleMgt.selectDeptSampleMgtList", paramMap);
	}
	
	public List<Map<String, Object>> selectDeptSampleMgtListPop(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.DeptSampleMgt.selectDeptSampleMgtListPop", paramMap);
	}
	
	public List<Map<String, Object>> selectSendDeptSampleMgtList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.DeptSampleMgt.selectSendDeptSampleMgtList", paramMap);
	}	
	
	public List<Map<String, Object>> selectMatList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.DeptSampleMgt.selectMatList", paramMap);
	}	
	
	public Map<String, Object> selectFlagYn(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.DeptSampleMgt.selectFlagYn", paramMap);
    }
	
	public Map<String, Object> selectCctrCode(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.DeptSampleMgt.selectCctrCode", paramMap);
    }	
	
	public void saveDeptSampleMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.DeptSampleMgt.saveDeptSampleMgt", paramMap);
	}
	
	public void deleteDeptSampleMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.DeptSampleMgt.deleteDeptSampleMgt", paramMap);
	}	
	
	public void updatDeptSampleMgtStatus(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.DeptSampleMgt.updatDeptSampleMgtStatus", paramMap);
	}
	
	public void updatDeptSampleMgtStatus6(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.DeptSampleMgt.updatDeptSampleMgtStatus6", paramMap);
	}
	
	public void updatDeptSampleMgtStatus6All(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.DeptSampleMgt.updatDeptSampleMgtStatus6All", paramMap);
	}	
	
	public void updatSendFlag(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.DeptSampleMgt.updatSendFlag", paramMap);
	}	
	
	public void updatDeptSampleMgtEpsStatus(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.DeptSampleMgt.updatDeptSampleMgtEpsStatus", paramMap);
	}	
	
	public Map<String, Object> selectSendNo(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.DeptSampleMgt.selectSendNo", paramMap);
    }
	
	public Map<String, Object> selectDeptSampleStatus(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.DeptSampleMgt.selectDeptSampleStatus", paramMap);
    }
	
}
