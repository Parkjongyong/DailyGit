package com.app.ildong.sys.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("SysRfcDAO")
public class SysRfcDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * 마스터정보가 있는지 체크
	 * @param paramMap
	 * @return
	 */
	public int selectMasterInfoExist(Map<String,Object> paramMap) {
		return sqlSessionTemplate.selectOne("com.sys.Rfc.selectMasterInfoExist", paramMap);
	}
	
	/**
	 * 마스터정보 수정
	 * @param paramMap
	 */
	public void updateMasterInfo(Map<String, Object> paramMap) {
		sqlSessionTemplate.update("com.sys.Rfc.updateMasterInfo", paramMap);
	}
	
	/**
	 * 마스터정보 추가
	 * @param paramMap
	 */
	public void insertMasterInfo(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.sys.Rfc.insertMasterInfo", paramMap);
	}
	
	/**
	 * I/F 인사정보 로그테이블에 저장
	 * @param paramMap
	 */
	public void insertUserIfInfo(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.sys.Rfc.insertUserIfInfo", paramMap);
	}
	
	/**
	 * 사용자 데이터 유무 확인
	 * @param paramMap
	 * @return
	 */
	public int selectUserInfoExist(Map<String,Object> paramMap) {
		return sqlSessionTemplate.selectOne("com.sys.Rfc.selectUserInfoExist", paramMap);
	}

	/**
	 * 사용자 정보 추가
	 * @param paramMap
	 */
	public void insertUserInfoByIF(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.sys.Rfc.insertUserInfoByIF", paramMap);
	}
	
	/**
	 * 사용자 정보 수정
	 * @param paramMap
	 */
	public void updateUserInfoByIF(Map<String, Object> paramMap) {
		sqlSessionTemplate.update("com.sys.Rfc.updateUserInfoByIF", paramMap);
	}
	
	/**
	 * 상세 사용자 정보 조회
	 * @param paramMap
	 * @return
	 */
	public Map<String, Object> selectDetailUserInfo(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectOne("com.sys.Rfc.selectDetailUserInfo", paramMap);
	}
	
	/**
	 * I/F 부서정보 로그테이블에 저장
	 * @param paramMap
	 */
	public void insertDeptIfInfo(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.sys.Rfc.insertDeptIfInfo", paramMap);
	}
	
	/**
	 * 부서데이터 유무 확인
	 * @param paramMap
	 * @return
	 */
	public int selectDeptInfoExist(Map<String,Object> paramMap) {
		return sqlSessionTemplate.selectOne("com.sys.Rfc.selectDeptInfoExist", paramMap);
	}
	
	/**
	 * 부서정보 추가
	 * @param paramMap
	 */
	public void insertDeptInfoByIF(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.sys.Rfc.insertDeptInfoByIF", paramMap);
	}
	
	/**
	 * 부서정보 수정
	 * @param paramMap
	 */
	public void updateDeptInfoByIF(Map<String, Object> paramMap) {
		sqlSessionTemplate.update("com.sys.Rfc.updateDeptInfoByIF", paramMap);
	}
	
	/**
	 * 상세 부서정보 조회
	 * @param paramMap
	 * @return
	 */
	public Map<String, Object> selectDetailDeptInfo(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectOne("com.sys.Rfc.selectDetailDeptInfo", paramMap);
	}
	
	/**
	 * 신규 사용자 권한 추가
	 * @param paramMap
	 */
	public void insertUserRoleByIF(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.sys.Rfc.insertUserRoleByIF", paramMap);
	}
	
	/**
	 * 사용자 권한 체크
	 * @param paramMap
	 * @return
	 */
	public int selectRoleInfoExist(Map<String,Object> paramMap) {
		return sqlSessionTemplate.selectOne("com.sys.Rfc.selectRoleInfoExist", paramMap);
	}
	
	/**
	 * 상위부서 정보 조회
	 * @param paramMap
	 * @return
	 */
	public Map<String, Object> selectUpDetpInfo(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectOne("com.sys.Rfc.selectUpDeptInfo", paramMap);
	}
	
}

