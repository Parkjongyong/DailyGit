package com.app.ildong.bdg.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("bdgApmTransMgtDAO")
public class BdgApmTransMgtDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectApmTransMgtHeadList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.ApmTransMgt.selectApmTransMgtHeadList", paramMap);
	}
	
	public List<Map<String, Object>> selectApmTransMgtDetailList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.ApmTransMgt.selectApmTransMgtDetailList", paramMap);
	}
	
	public List<Map<String, Object>> selectSendApmTransData(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.ApmTransMgt.selectSendApmTransData", paramMap);
	}
	
	public Map<String, Object> selectFlagYn(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.ApmTransMgt.selectFlagYn", paramMap);
    }
	
	public Map<String, Object> selectStatusHeader(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.ApmTransMgt.selectStatusHeader", paramMap);
    }
	
	public Map<String, Object> selectStatusCnt(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.ApmTransMgt.selectStatusCnt", paramMap);
    }	
	
	public void apprApmTransMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ApmTransMgt.apprApmTransMgt", paramMap);
	}	
	
	public void updatApmTransMgtStatus(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ApmTransMgt.updatApmTransMgtStatus", paramMap);
	}
	
	public void updatApmTransMgtStatus2(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ApmTransMgt.updatApmTransMgtStatus2", paramMap);
	}
	
	public void updatApmTransMgtStatus3(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ApmTransMgt.updatApmTransMgtStatus3", paramMap);
	}	
	
	public void saveApmTransHeadMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ApmTransMgt.saveApmTransHeadMgt", paramMap);
	}
	
	public void saveApmTransDetailMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ApmTransMgt.saveApmTransDetailMgt", paramMap);
	}	
	
	public void deleteApmTransHeadMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ApmTransMgt.deleteApmTransHeadMgt", paramMap);
	}
	
	public void deleteApmTransDetailMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ApmTransMgt.deleteApmTransDetailMgt", paramMap);
	}
	
	public void updateStatus(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ApmTransMgt.updateStatus", paramMap);
	} 
	
	public List<Map<String, Object>> selectApmTransMgtPop(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.ApmTransMgt.selectApmTransMgtPop", paramMap);
	}
	
	public void rejectApmTransMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ApmTransMgt.rejectApmTransMgt", paramMap);
	}	
}
