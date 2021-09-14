package com.app.ildong.bdg.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("PromDetailDAO")
public class BdgPromDetailDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate3;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectPromDetail(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.PromDetail.selectPromDetail", paramMap);
	}

	public List<Map<String, Object>> selectPromDetailExcel(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.PromDetail.selectPromDetailExcel", paramMap);
	}
	
	public List<Map<String, Object>> selectOpAccountList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.PromDetail.selectPromDetailAmt", paramMap);
	}
	
	public List<Map<String, Object>> selectOpDeptList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.PromDetail.selectOpDeptList", paramMap);
	}
	
	public List<Map<String, Object>> promDetailUserList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.PromDetail.promDetailUserList", paramMap);
	}
	
	public void insertPromDetail(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.PromDetail.insertPromDetail", paramMap);
	}
	
	public void insertPromDetailExcel(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.PromDetail.insertPromDetailExcel", paramMap);
	}
	
	public void savePromDetailUpload(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.PromDetail.savePromDetailUpload", paramMap);
	}
	
	public void updatePromDetail(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.PromDetail.updatePromDetail", paramMap);
	}
	
	public void delPromDetail(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.PromDetail.delPromDetail", paramMap);
	}
	
	public void delPromDetailExcel(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.PromDetail.delPromDetailExcel", paramMap);
	}
	
	public void delPromDetailUpload(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.PromDetail.delPromDetailUpload", paramMap);
	}
	
	public void sendPromDetail(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.PromDetail.sendPromDetail", paramMap);
	}
	
	public Map<String, Object> receptionPromDetail(Map<String, Object> paramMap){
		return sqlSessionTemplate3.selectOne("interface.receptionPromDetail", paramMap);
	}
	
	public void updatePromDetail2(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.PromDetail.updatePromDetail2", paramMap);
	}
	
	
}
