package com.app.ildong.wrh.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("wareHouseDAO")
public class WrhMgmtWareHouseDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectPlantList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.wrh.WareHouse.selectPlantList", paramMap);
	}
	
	public void updatePlant(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.wrh.WareHouse.updatePlant", paramMap);
	}
	
	public void insertPlant(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.wrh.WareHouse.insertPlant", paramMap);
	}
	
	public void deletePlant(Map<String, Object> paramMap) {
		sqlSessionTemplate.delete("com.wrh.WareHouse.deletePlant", paramMap);
	}
	
	public List<Map<String, Object>> selectWareHouseList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.wrh.WareHouse.selectWareHouseList", paramMap);
	}
	
	public void updateWareHouse(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.wrh.WareHouse.updateWareHouse", paramMap);
	}
	
	public void insertWareHouse(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.wrh.WareHouse.insertWareHouse", paramMap);
	}
	
	public void deleteWareHouse(Map<String, Object> paramMap) {
		sqlSessionTemplate.delete("com.wrh.WareHouse.deleteWareHouse", paramMap);
	}
	
	public void deletePlantStorage(Map<String, Object> paramMap) {
		sqlSessionTemplate.delete("com.wrh.WareHouse.deletePlantStorage", paramMap);
	}
	
    
}
