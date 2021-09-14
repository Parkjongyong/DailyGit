package com.app.ildong.bdg.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("bdgOpModifyMgtDAO")
public class BdgOpModifyMgtDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectOpModifyMgtList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.OpModifyMgt.selectOpModifyMgtList", paramMap);
	}
	
	public List<Map<String, Object>> selectOpModifyMgtTargetList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.OpModifyMgt.selectOpModifyMgtTargetList", paramMap);
	}	
	
	public Map<String, Object> selectFlagYn(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.OpModifyMgt.selectFlagYn", paramMap);
    }
	
	public Map<String, Object> selectStatusHeader(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.OpModifyMgt.selectStatusHeader", paramMap);
    }	
	
	public Map<String, Object> selectBugtDataCount(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.OpModifyMgt.selectBugtDataCount", paramMap);
    }	
	
	public List<Map<String, Object>> selectProjList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.OpModifyMgt.selectProjList", paramMap);
	}
	
	public void confirmOpModifyMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpModifyMgt.confirmOpModifyMgt", paramMap);
	}
	
	public void cancelOpModifyMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpModifyMgt.cancelOpModifyMgt", paramMap);
	}	
	
	public void updateOpModifyMgtStatus2(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpModifyMgt.updateOpModifyMgtStatus2", paramMap);
	}	
	
	public void saveOpBugtModifyMgmt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpModifyMgt.saveOpBugtModifyMgmt", paramMap);
	}
	
	public void deleteOpBugtModifyMgmt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpModifyMgt.deleteOpBugtModifyMgmt", paramMap);
	}	
	
	public void deleteOpBugtModifyHead(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpModifyMgt.deleteOpBugtModifyHead", paramMap);
	}
	
	public void deleteOpBugtModifyDetail(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpModifyMgt.deleteOpBugtModifyDetail", paramMap);
	}
	
	public void insertOpBugtModifyHead(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpModifyMgt.insertOpBugtModifyHead", paramMap);
	}
	
	public void insertOpBugtModifyDetail(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpModifyMgt.insertOpBugtModifyDetail", paramMap);
	}	

	public List<Map<String, Object>> selectOpModifyMgtExcel(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.OpModifyMgt.selectOpModifyMgtExcel", paramMap);
	}

	public void insertOpModifyMgtExcel(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpModifyMgt.insertOpModifyMgtExcel", paramMap);
	}
	
	public void deleteOpModifyMgtExcel(Map<String, Object> paramMap) {
		sqlSessionTemplate.delete("com.bdg.OpModifyMgt.deleteOpModifyMgtExcel", paramMap);
	}
	
	
}
