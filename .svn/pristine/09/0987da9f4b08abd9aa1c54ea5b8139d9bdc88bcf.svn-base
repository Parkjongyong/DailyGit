package com.app.ildong.bdg.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("bdgExecBugtMgtDAO")
public class BdgExecBugtMgtDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectExecBugtMgtHeadList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.ExecBudget.selectExecBugtMgtHeadList", paramMap);
	}
	
	public List<Map<String, Object>> selectApprList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.ExecBudget.selectApprList", paramMap);
	}	
	
	public List<Map<String, Object>> selectModifyBudgetDetailList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.ExecBudget.selectModifyBudgetDetailList", paramMap);
	}
	
	public List<Map<String, Object>> selectPreExecBudgetDetailList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.ExecBudget.selectPreExecBudgetDetailList", paramMap);
	}	
	
	public List<Map<String, Object>> selectExecBudgetDetailList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.ExecBudget.selectExecBudgetDetailList", paramMap);
	}
	
	public List<Map<String, Object>> selectModifyBudgetTotalList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.ExecBudget.selectModifyBudgetTotalList", paramMap);
	}
	
	public List<Map<String, Object>> selectPreExecBudgetTotalList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.ExecBudget.selectPreExecBudgetTotalList", paramMap);
	}	
	
	public List<Map<String, Object>> selectExecBudgetTotalList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.ExecBudget.selectExecBudgetTotalList", paramMap);
	}	
	
	public List<Map<String, Object>> selectExecBudgetDetailList2(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.ExecBudget.selectExecBudgetDetailList2", paramMap);
	}
	
	public Map<String, Object> selectStatusHeader(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.ExecBudget.selectStatusHeader", paramMap);
    }
	
	public Map<String, Object> selectStatusHeader2(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.ExecBudget.selectStatusHeader2", paramMap);
    }	
	
	public Map<String, Object> selectFlagYn(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.ExecBudget.selectFlagYn", paramMap);
    }	
	
	public void saveExecBugtMgtDetail(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ExecBudget.saveExecBugtMgtDetail", paramMap);
	}
	
	public void rejectExecBugtMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ExecBudget.rejectExecBugtMgt", paramMap);
	}
	
	public void apprExecBugtMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ExecBudget.apprExecBugtMgt", paramMap);
	}	
	
	public void updateHeader(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ExecBudget.updateHeader", paramMap);
	}	
	
	public void deletExecBugtMgtHead(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ExecBudget.deletExecBugtMgtHead", paramMap);
	}
	
	public void deletExecBugtMgtDetail(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ExecBudget.deletExecBugtMgtDetail", paramMap);
	}
	
	public void createExecBugtMgtHead(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ExecBudget.createExecBugtMgtHead", paramMap);
	}
	
	public void createExecBugtMgtDetail(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ExecBudget.createExecBugtMgtDetail", paramMap);
	}
	
	public void updateExecMaster(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ExecBudget.updateExecMaster", paramMap);
	}
	
	public List<Map<String, Object>> selectExecBugtMgtHeadListPop(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.ExecBudget.selectExecBugtMgtHeadListPop", paramMap);
	}
	
	public Map<String, Object> selectEpsInfoData(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.ExecBudget.selectEpsInfoData", paramMap);
    }	

}
