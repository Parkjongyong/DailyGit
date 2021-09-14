package com.app.ildong.bdg.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("travelCalDAO")
public class BdgTravelCalDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectTravelCal(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.TravelCal.selectTravelCal", paramMap);
	}

	public List<Map<String, Object>> selectTravelCalDetail(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.TravelCal.selectTravelCalDetail", paramMap);
	}
	
	public List<Map<String, Object>> createPdf(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.TravelCal.createPdf", paramMap);
	}	

	public List<Map<String, Object>> selectSendTravelCal(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.TravelCal.selectSendTravelCal", paramMap);
	}
	
	public void updateTravelCalSap(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.TravelCal.updateTravelCalSap", paramMap);
	}

	public void updateSendBusin(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.TravelCal.updateSendBusin", paramMap);
	}
	
	public void updateSendCancelBusin(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.TravelCal.updateSendCancelBusin", paramMap);
	}
	
	public List<Map<String, Object>> selectSendTravelCalList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.TravelCal.selectSendTravelCalList", paramMap);
	}

	public List<Map<String, Object>> selectSendTravelCalFirst(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.TravelCal.selectSendTravelCalFirst", paramMap);
	}
	
	public List<Map<String, Object>> selectSendCancelTravelCalFirst(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.TravelCal.selectSendCancelTravelCalFirst", paramMap);
	}
	
	public List<Map<String, Object>> selectSendCancelTravelCal(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.TravelCal.selectSendCancelTravelCal", paramMap);
	}
	
	public List<Map<String, Object>> selectSendTravelCalIndiv(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.TravelCal.selectSendTravelCalIndiv", paramMap);
	}

	public List<Map<String, Object>> selectSendTravelCalDept(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.TravelCal.selectSendTravelCalDept", paramMap);
	}

}
