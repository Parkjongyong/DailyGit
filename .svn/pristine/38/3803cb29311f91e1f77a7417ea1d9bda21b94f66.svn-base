package com.app.ildong.bat.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("BatMaterialsDAO")
public class BatMaterialsDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public void makeMaterialsHeadData(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bat.Materials.makeMaterialsHeadData", paramMap);
	}
	
	public void updateMaterialsHeadFlag() {
		sqlSessionTemplate.insert("com.bat.Materials.updateMaterialsHeadFlag");
	}
	
	public void makeMaterialsPlantData(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bat.Materials.makeMaterialsPlantData", paramMap);
	}
	
	public void updateMaterialsPlantFlag() {
		sqlSessionTemplate.insert("com.bat.Materials.updateMaterialsPlantFlag");
	}	
}
