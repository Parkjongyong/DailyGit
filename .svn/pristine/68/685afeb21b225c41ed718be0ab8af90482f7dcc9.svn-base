package com.app.ildong.common.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("CommonSelectDAO")
public class CommonSelectDAO {
	
	
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
	
	public List<Map<String, Object>> selectPlantCodeList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("common.CommonSelect.selectPlandCodeList", paramMap);
	}
	
	public List<Map<String, Object>> selectOpAccountCodeList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("common.CommonSelect.selectOpAccountCodeList", paramMap);
	}
	
	public List<Map<String, Object>> selectOpAccountCodeList2(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("common.CommonSelect.selectOpAccountCodeList2", paramMap);
	}	
	
	public List<Map<String, Object>> selectUserDeptCodeList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("common.CommonSelect.selectUserDeptCodeList", paramMap);
	}	
	
	public List<Map<String, Object>> selectOpDistribList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("common.CommonSelect.selectOpDistribList", paramMap);
	}	
	
	public List<Map<String, Object>> selectStorageCodeList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("common.CommonSelect.selectStorageCodeList", paramMap);
	}
	
	public Map<String, Object> selectDocNo(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("common.CommonSelect.selectDocNo", paramMap);
    }	
	
	public List<Map<String, Object>> selectCostList( Map<String, Object> paramMap ) throws Exception {
		return sqlSessionTemplate.selectList("common.CommonSelect.selectCostList", paramMap);
	}
	
	public List<Map<String, Object>> selectCompList( Map<String, Object> paramMap ) throws Exception {
		return sqlSessionTemplate.selectList("common.CommonSelect.selectCompList", paramMap);
	}
	
	public Map<String, Object> selectCheckEndData( Map<String, Object> paramMap ) throws Exception {
		return sqlSessionTemplate.selectOne("common.CommonSelect.selectCheckEndData", paramMap);
	}
	
	public List<Object> selectRequestItemList1( Map<String, Object> paramMap ) throws Exception {
		return sqlSessionTemplate.selectList("common.CommonSelect.selectRequestItemList1", paramMap);
	}
	
	public List<Object> selectRequestItemList2( Map<String, Object> paramMap ) throws Exception {
		return sqlSessionTemplate.selectList("common.CommonSelect.selectRequestItemList2", paramMap);
	}
	
	public List<Object> selectRequestItemList3( Map<String, Object> paramMap ) throws Exception {
		return sqlSessionTemplate.selectList("common.CommonSelect.selectRequestItemList3", paramMap);
	}

	public List<Map<String, Object>> selectStorageCompList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("common.CommonSelect.selectStorageCompList", paramMap);
	}
	
	public List<Map<String, Object>> selectStoragePlantList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("common.CommonSelect.selectStoragePlantList", paramMap);
	}
	
	public List<Map<String, Object>> selectStorageList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("common.CommonSelect.selectStorageList", paramMap);
	}
	
	
}
