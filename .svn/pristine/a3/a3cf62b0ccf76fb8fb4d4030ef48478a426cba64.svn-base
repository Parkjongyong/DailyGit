/**
 * 시스템관리 > 권한 관리 DAO
 * @author 박종용
 * @since 2020.06.22
 *
 * << 개정이력(Modification Information) >>
 *  -------------------------------------------------
 *  수정일                    수정자            수정내용
 *  ----------   -------- ---------------------------
 *  2020.06.22   박종용            최초생성
 *  -------------------------------------------------
 */
package com.app.ildong.sys.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("sysRoleDAO")
public class SysRoleDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectRoleList(Map<String, Object> paramMap)
	{
		return sqlSessionTemplate.selectList("com.sys.Role.selectRoleList", paramMap);
	}
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectRoleDetailList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.sys.Role.selectRoleDetailList", paramMap);
	}
	
	
	
	/**
	 * @param paramMap
	 * @return
	 */
	public int deleteRoleMenuList(Map<String, Object> paramMap)
	{
		return sqlSessionTemplate.delete("com.sys.Role.deleteRoleMenuList", paramMap);
	}
	
	/**
	 * @param paramMap
	 * @return
	 */
	public int insertRoleMenuList(Map<String, Object> paramMap)
	{
		return sqlSessionTemplate.insert("com.sys.Role.insertRoleMenuList", paramMap);
	}
	
	/**
	 * @param paramMap
	 * @return
	 */
	public int deleteRoleList(Map<String, Object> paramMap)
	{
		return sqlSessionTemplate.update("com.sys.Role.deleteRoleList", paramMap);
	}
	
	/**
	 * @param paramMap
	 * @return
	 */
	public int updateRoleList(Map<String, Object> paramMap)
	{
		return sqlSessionTemplate.update("com.sys.Role.updateRoleList", paramMap);
	}
	
	
	/**
	 * @param paramMap
	 * @return
	 */
	public int insertRoleList(Map<String, Object> paramMap)
	{
		return sqlSessionTemplate.insert("com.sys.Role.insertRoleList", paramMap);
	}
	
	/**
	 * Role 할당 사용자 목록
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectRoleAssignmentUserList(Map<String, Object> paramMap)
	{
		return sqlSessionTemplate.selectList("com.sys.Role.selectRoleAssignmentUserList", paramMap);
	}
	
	/**
	 * Role 비할당 사용자 목록
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectRoleUnassignedUserList(Map<String, Object> paramMap)
	{
		return sqlSessionTemplate.selectList("com.sys.Role.selectRoleUnassignedUserList", paramMap);
	}
	
	
	/**
	 * 권한-사용자 삭제
	 * @param paramMap
	 * @return
	 */
	public int deleteRoleUser(Map<String, Object> paramMap)
	{
		return sqlSessionTemplate.delete("com.sys.Role.deleteRoleUser", paramMap);
	}
	
	
	/**
	 * 권한-사용자 추가
	 * @param paramMap
	 * @return
	 */
	public int insertRoleUser(Map<String, Object> paramMap)
	{
		return sqlSessionTemplate.delete("com.sys.Role.insertRoleUser", paramMap);
	}
	
	/**
	 * Role 비할당 부서목록 조회
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectRoleUnassignedDeptList(Map<String, Object> paramMap)
	{
		return sqlSessionTemplate.selectList("com.sys.Role.selectRoleUnassignedDeptList", paramMap);
	}
	
	/**
	 * Role 할당 부서목록 조회
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectRoleAssignmentDeptList(Map<String, Object> paramMap)
	{
		return sqlSessionTemplate.selectList("com.sys.Role.selectRoleAssignmentDeptList", paramMap);
	}
		
	/**
	 * 권한-부서 삭제
	 * @param paramMap
	 * @return
	 */
	public int deleteRoleDept(Map<String, Object> paramMap)
	{
		return sqlSessionTemplate.delete("com.sys.Role.deleteRoleDept", paramMap);
	}
	
	/**
	 * 권한-부서 추가
	 * @param paramMap
	 * @return
	 */
	public int insertRoleDept(Map<String, Object> paramMap)
	{
		return sqlSessionTemplate.delete("com.sys.Role.insertRoleDept", paramMap);
	}
	
	/**
	 * 비할당 Role 조회
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectUnassignedRoleList(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectList("com.sys.Role.selectUnassignedRoleList", paramMap);
	}
	
	/**
	 * 할당 Role 조회
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectAssignedRoleList(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectList("com.sys.Role.selectAssignedRoleList", paramMap);
	}
	
	/**
	 * 사용자-권한 삭제
	 * @param paramMap
	 * @return
	 */
	public int deleteUserRole(Map<String, Object> paramMap)
	{
		return sqlSessionTemplate.delete("com.sys.Role.deleteUserRole", paramMap);
	}
	
	/**
	 * 사용자-권한 추가
	 * @param paramMap
	 * @return
	 */
	public int insertUserRole(Map<String, Object> paramMap)
	{
		return sqlSessionTemplate.insert("com.sys.Role.insertUserRole", paramMap);
	}
	
	/**
	 * 비할당Role조회(부서별)
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectUnassignedDeptRoleList(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectList("com.sys.Role.selectUnassignedDeptRoleList", paramMap);
	}
	
	/**
	 * 할당Role조회(부서별)
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectAssignedDeptRoleList(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectList("com.sys.Role.selectAssignedDeptRoleList", paramMap);
	}
	
	/**
	 * 부서-권한 삭제
	 * @param paramMap
	 * @return
	 */
	public int deleteDeptRole(Map<String, Object> paramMap)
	{
		return sqlSessionTemplate.delete("com.sys.Role.deleteDeptRole", paramMap);
	}
	
	/**
	 * 부서-권한 추가
	 * @param paramMap
	 * @return
	 */
	public int insertDeptRole(Map<String, Object> paramMap)
	{
		return sqlSessionTemplate.insert("com.sys.Role.insertDeptRole", paramMap);
	}
	
	/*
	 * InsertRoleList ROLE_CD check
	 */
	public int selectCheckRoleCdExist(Map<String,Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.sys.Role.selectCheckRoleCdExist", paramMap);
    }
	
	public List<Map<String, Object>> selectDeptList(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectList("com.sys.Role.selectDeptList", paramMap);
    }

	
	/**
	 * @param paramMap
	 * @return
	 */
	public int updateUserMenuList(Map<String, Object> paramMap)
	{
		return sqlSessionTemplate.delete("com.sys.Role.updateUserMenuList", paramMap);
	}
	
	public List<Map<String, Object>> selectUserViewList(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectList("com.sys.Role.selectUserViewList", paramMap);
	}

	public List<Map<String, Object>> selectDeptViewList(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectList("com.sys.Role.selectDeptViewList", paramMap);
	}
	
	/**
	 * @param paramMap
	 * @return
	 */
	public int resetUserMenuList(Map<String, Object> paramMap)
	{
		return sqlSessionTemplate.delete("com.sys.Role.resetUserMenuList", paramMap);
	}
	
	/**
	 * @param paramMap
	 * @return
	 */
	public Map<String, Object> userMenuCnt(Map<String, Object> paramMap)
	{
		return sqlSessionTemplate.selectOne("com.sys.Role.userMenuCnt", paramMap);
	}

}
