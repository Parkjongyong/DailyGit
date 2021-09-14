package com.app.ildong.common.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("CommonDAO")
public class CommonDAO {
	
	
	@Autowired
    private SqlSessionTemplate sqlSessionTemplate;

	
	/**
	 * 특정 codeId에 의 코드 목록을 조회한다.
	 * 
	 * @param codeId
	 * @return
	 */
	public List<Map<String, Object>> selectCodeList( Map<String, Object> paramMap ) throws Exception {
		return sqlSessionTemplate.selectList("common.CommonSelect.selectCodeList", paramMap);
	}
	
	/**
     * 특정 codeId에 의 코드 목록을 조회한다.
     * 
     * @param codeId
     * @return
     */
    public List<Map<String, Object>> selectCodeNmList( Map<String, Object> paramMap ) throws Exception {
        return sqlSessionTemplate.selectList("common.CommonSelect.selectCodeNmList", paramMap);
    }
	/**
	 * 특정 code그룹의 전체 코드 목록을 조회한다.
	 * 
	 * @param codeId
	 * @return
	 */
	public List<Map<String, Object>> selectCodeListAll( Map<String, Object> paramMap ) throws Exception {
		return sqlSessionTemplate.selectList("common.CommonSelect.selectCodeListAll", paramMap);
	}
	
	/**
	 * Role을 가진 사용자를 구한다.
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectRoleUserList( Map<String, Object> paramMap) throws Exception {

		return sqlSessionTemplate.selectList("common.CommonSelect.selectRoleUserList", paramMap);
	}

	
	/**
	 * 지정 Role 권한을 가진 부서목록을 조회
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectRoleDeptList(Map<String, Object> paramMap) throws Exception {
		return sqlSessionTemplate.selectList("common.CommonSelect.selectRoleDeptList", paramMap);
	}
	
	public String selectDbTime() throws Exception {
		return sqlSessionTemplate.selectOne("common.CommonSelect.selectDbTime");
	}
	
	/*
	 * CODE_CODE 'A021'
	 * 단위 검색 팝업
	 */
	public List<Map<String, Object>> selectUnitList(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectList("common.CommonSelect.selectUnitList", paramMap);
    }
	
	/**
	 * 사용자 ID(임직원) 배열로 메일정보 조회
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectUsersMailInfoList(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectList("common.CommonSelect.selectUsersMailInfoList", paramMap);
    }
	
	/**
	 * 사용자 ID(임직원)로 정보 조회
	 * @param paramMap
	 * @return
	 */
	public Map<String, Object> selectUserInfo(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("common.CommonSelect.selectUserInfo", paramMap);
    }
	
	/**
	 * 전자결재 정보  등록
	 * @param paramMap
	 * @return
	 */
	public void insertEpsHistory(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("common.CommonSelect.insertEpsHistory", paramMap);
	}
	
	/**
	 * 전자결재 정보  등록
	 * @param paramMap
	 * @return
	 */
	public void insertDeliveryHistory(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("common.CommonSelect.insertDeliveryHistory", paramMap);
	}	
	
	
}
