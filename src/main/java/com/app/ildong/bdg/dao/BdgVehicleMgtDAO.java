package com.app.ildong.bdg.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("bdgVehicleMgtDAO")
public class BdgVehicleMgtDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectVehicleMgtList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.VehicleMgt.selectVehicleMgtList", paramMap);
	}
	
	public List<Map<String, Object>> selectVehicleOpList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.VehicleMgt.selectVehicleOpList", paramMap);
	}
	
	public void insertVehicleMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.VehicleMgt.insertVehicleMgt", paramMap);
	}
	
	public void updateVehicleMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.VehicleMgt.updateVehicleMgt", paramMap);
	}	
	
	public void deleteVehicleMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.VehicleMgt.deleteVehicleMgt", paramMap);
	}
	
	public void insertVehicleOp(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.VehicleMgt.insertVehicleOp", paramMap);
	}
	
	public void updateVehicleOp(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.VehicleMgt.updateVehicleOp", paramMap);
	}	
	
	public void deleteVehicleOp(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.VehicleMgt.deleteVehicleOp", paramMap);
	}	
	
}
