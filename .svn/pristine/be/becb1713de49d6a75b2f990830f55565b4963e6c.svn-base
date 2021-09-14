package com.app.ildong.bdg.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("bdgOpExecBugtMgtDAO")
public class BdgOpExecBugtMgtDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectOpExec(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.OpExecBudget.selectOpExec", paramMap);
	}
	
	public Map<String, Object> selectModifyHeadCountData(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.OpExecBudget.selectModifyHeadCountData", paramMap);
    }
	
	public Map<String, Object> selectOpModifyData(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.OpExecBudget.selectOpModifyData", paramMap);
    }	
	
	public void updateOpExec(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpExecBudget.updateOpExec", paramMap);
	}
	
	public void insertModifyData(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpExecBudget.insertModifyData", paramMap);
	}
	
	public void insertOpModifyData(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpExecBudget.insertOpModifyData", paramMap);
	}	
	
	public void insertOpExec(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpExecBudget.insertOpExec", paramMap);
	}

	public void deleteOpExec(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpExecBudget.deleteOpExec", paramMap);
	}
	
	public void deleteModifyData(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpExecBudget.deleteModifyData", paramMap);
	}
	
	public void deleteOpModifyData(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpExecBudget.deleteOpModifyData", paramMap);
	}	
	
	public void confirmOpExec(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpExecBudget.confirmOpExec", paramMap);
	}
	
	public void confirmCancelOpExec(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpExecBudget.confirmCancelOpExec", paramMap);
	}
	
	public int sendCheckCnt(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectOne("com.bdg.OpExecBudget.sendCheckCnt", paramMap);
	}
	
	public void sendOpExecHead(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpExecBudget.sendOpExecHead", paramMap);
	}
	
	public void sendOpExecDetail(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpExecBudget.sendOpExecDetail", paramMap);
	}
	
	public void sendCancelOpExecHead(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpExecBudget.sendCancelOpExecHead", paramMap);
	}
	
	public void sendCancelOpExecDetail(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpExecBudget.sendCancelOpExecDetail", paramMap);
	}
	
	public void updatCancelOpExecBudgetMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpExecBudget.updatCancelOpExecBudgetMgt", paramMap);
	}
	
	public void updatSendOpExecBudgetMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpExecBudget.updatSendOpExecBudgetMgt", paramMap);
	}	
	
	public Map<String, Object> selectStatusHeader(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.OpExecBudget.selectStatusHeader", paramMap);
    }
	
	public void createOpExecBugtMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpExecBudget.createOpExecBugtMgt", paramMap);
	}	

}
