package com.app.ildong.bdg.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("vacationMgmtDAO")
public class BdgVacationMgmtDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate2;
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate3;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectVacationMgmt(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.VacationMgmt.selectVacationMgmt", paramMap);
	}

	public List<Map<String, Object>> selectVacationDetail(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.VacationMgmt.selectVacationDetail", paramMap);
	}
	
	public List<Map<String, Object>> receptionTravel(Map<String, Object> paramMap){
		return sqlSessionTemplate3.selectList("interface.receptionTravel", paramMap);
	}
	
	public void deleteTravel(Map<String, Object> paramMap){
		sqlSessionTemplate.insert("com.bdg.VacationMgmt.deleteTravel", paramMap);
	}
	
	public void insertMisoTrip(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.VacationMgmt.insertMisoTrip", paramMap);
	}

	public List<Map<String, Object>> receptionVacationH(Map<String, Object> paramMap){
		return sqlSessionTemplate2.selectList("interface.receptionVacationH", paramMap);
	}
	
	public List<Map<String, Object>> receptionVacationD(Map<String, Object> paramMap){
		return sqlSessionTemplate2.selectList("interface.receptionVacationD", paramMap);
	}
	
	public void insertVacationH(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.VacationMgmt.insertVacationH", paramMap);
	}

	public void insertVacationD(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.VacationMgmt.insertVacationD", paramMap);
	}

	public void confirmVacation(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.VacationMgmt.confirmVacation", paramMap);
	}

	public void deleteVacationH(Map<String, Object> paramMap){
		sqlSessionTemplate.insert("com.bdg.VacationMgmt.deleteVacationH", paramMap);
	}
	
	public void deleteVacationD(Map<String, Object> paramMap){
		sqlSessionTemplate.insert("com.bdg.VacationMgmt.deleteVacationD", paramMap);
	}
	
	public Map<String, Object> chkChcEtcGubn( Map<String, Object> paramMap ) throws Exception {
		return sqlSessionTemplate.selectOne("com.bdg.VacationMgmt.chkChcEtcGubn", paramMap);
	}
	
	public void deleteSendTrip(Map<String, Object> paramMap){
		sqlSessionTemplate.insert("com.bdg.VacationMgmt.deleteSendTrip", paramMap);
	}
		
	
}
