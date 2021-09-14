package com.app.ildong.bdg.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("bdgOpBasicMgtDAO")
public class BdgOpBasicMgtDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectOpBasicMgtList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.OpBasicMgt.selectOpBasicMgtList", paramMap);
	}
	
	public Map<String, Object> selectFlagYn(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.OpBasicMgt.selectFlagYn", paramMap);
    }
	
	public Map<String, Object> selectBugtDataCount(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.OpBasicMgt.selectBugtDataCount", paramMap);
    }	
	
	public List<Map<String, Object>> selectProjList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.OpBasicMgt.selectProjList", paramMap);
	}
	
	public void updateOpBasicMgtStatus(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpBasicMgt.updateOpBasicMgtStatus", paramMap);
	}
	
	public void cancelOpBasicMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpBasicMgt.cancelOpBasicMgt", paramMap);
	}
	
	public void updateOpBasicMgtStatus2(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpBasicMgt.updateOpBasicMgtStatus2", paramMap);
	}	
	
	public void saveOpBugtBasicMgmt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpBasicMgt.saveOpBugtBasicMgmt", paramMap);
	}
	
	public void deleteOpBugtBasicMgmt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpBasicMgt.deleteOpBugtBasicMgmt", paramMap);
	}	
	
	public void deleteOpBugtBasicgHead(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpBasicMgt.deleteOpBugtBasicgHead", paramMap);
	}
	
	public void deleteOpBugtBasicgDetail(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpBasicMgt.deleteOpBugtBasicgDetail", paramMap);
	}
	
	public void insertOpBugtBasicgHead(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpBasicMgt.insertOpBugtBasicgHead", paramMap);
	}
	
	public void insertOpBugtBasicgDetail(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpBasicMgt.insertOpBugtBasicgDetail", paramMap);
	}	

	public Map<String, Object> selectStatusHeader(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.OpBasicMgt.selectStatusHeader", paramMap);
    }
	
	public List<Map<String, Object>> selectOpBasicMgtCode1(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.OpBasicMgt.selectOpBasicMgtCode1", paramMap);
	}

	public List<Map<String, Object>> selectOpBasicMgtCode2(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.OpBasicMgt.selectOpBasicMgtCode2", paramMap);
	}
	
	public List<Map<String, Object>> selectOpBasicMgtCode3(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.OpBasicMgt.selectOpBasicMgtCode3", paramMap);
	}
	
	public List<Map<String, Object>> selectOpBasicMgtCode4(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.OpBasicMgt.selectOpBasicMgtCode4", paramMap);
	}
	
	public List<Map<String, Object>> selectOpBasicMgtData(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.OpBasicMgt.selectOpBasicMgtData", paramMap);
	}
	
	public void insertOpBasicMgtExcel(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpBasicMgt.insertOpBasicMgtExcel", paramMap);
	}
	
	public void deleteOpBasicMgtExcel(Map<String, Object> paramMap) {
		sqlSessionTemplate.delete("com.bdg.OpBasicMgt.deleteOpBasicMgtExcel", paramMap);
	}
	
	public List<Map<String, Object>> selectOpBasicMgtExcel(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.OpBasicMgt.selectOpBasicMgtExcel", paramMap);
	}
	
}
