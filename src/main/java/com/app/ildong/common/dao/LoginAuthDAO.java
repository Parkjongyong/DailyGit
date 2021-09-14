package com.app.ildong.common.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("LoginAuthDAO")
public class LoginAuthDAO {

	@Autowired
    private SqlSessionTemplate sqlSessionTemplate;

	/**
	 * 사용자 정보
	 */
	public Map<String,Object> selectUserLoginInfo( Map<String,Object> paramMap ) throws Exception {
		return sqlSessionTemplate.selectOne("common.LoginAuth.selectUserLoginInfo", paramMap);
	}
	
	/**
	 * 사용자 정보
	 */
	public Map<String,Object> selectSsoUserLoginInfo( Map<String,Object> paramMap ) throws Exception {
		return sqlSessionTemplate.selectOne("common.LoginAuth.selectSsoUserLoginInfo", paramMap);
	}
	
	/**
	 * 사용자 수정
	 */
	public int updateUserLoginDt( Map<String,Object> paramMap ) throws Exception {
		return sqlSessionTemplate.update("common.LoginAuth.updateUserLoginDt", paramMap);
	}
		
	/**
	 * 사용자 Role 목록 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<String> selectUserRoleListForLogin( Map<String,Object> paramMap ) throws Exception {
        return sqlSessionTemplate.selectList("common.LoginAuth.selectUserRoleListForLogin", paramMap);
    }
	
	/**
	 * 사용자 Role 목록 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<String> selectDeptRoleListForLogin( Map<String,Object> paramMap ) throws Exception {
        return sqlSessionTemplate.selectList("common.LoginAuth.selectDeptRoleListForLogin", paramMap);
    }

	/**
	 * 사용자 메뉴 목록 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<Map<String,Object>> selectUserMenuList( Map<String,Object> paramMap ) throws Exception {
        return sqlSessionTemplate.selectList("common.LoginAuth.selectUserMenuList", paramMap);
    }

	/**
	 * 사용자 로그인 이력 등록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public int insertAccessHist(Map<String,Object> paramMap) throws Exception {
		return sqlSessionTemplate.insert("common.LoginAuth.insertAccessHist", paramMap);
	}

	public List<Map<String, Object>> selectUserFavoriteMenuList(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectList("common.LoginAuth.selectUserFavoriteMenuList", paramMap);
	}
	
	public int insertUserFavoriteMenu(Map<String,Object> paramMap) throws Exception {
		return sqlSessionTemplate.insert("common.LoginAuth.insertUserFavoriteMenu", paramMap);
	}
	
	public int deleteUserFavoriteMenu(Map<String,Object> paramMap) throws Exception {
		return sqlSessionTemplate.insert("common.LoginAuth.deleteUserFavoriteMenu", paramMap);
	}
	
	public int allDeleteUserFavoriteMenu(Map<String,Object> paramMap) throws Exception {
		return sqlSessionTemplate.insert("common.LoginAuth.allDeleteUserFavoriteMenu", paramMap);
	}
	
	public List<Map<String, Object>> selectNoticeList(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectList("common.LoginAuth.selectNoticeList", paramMap);
	}
	
	public List<Map<String, Object>> selectTodoInfoList(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectList("common.LoginAuth.selectTodoInfoList", paramMap);
	}
	
}
