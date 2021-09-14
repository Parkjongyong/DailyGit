package com.app.ildong.sys.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("sysUserDAO")
public class SysUserDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectUserList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.sys.User.selectUserList", paramMap);
	}
	
	public Integer selectUserListCount( Map<String,Object> paramMap ) throws Exception {
		return sqlSessionTemplate.selectOne("com.sys.User.selectUserListCount", paramMap);
	}
	
	/*부서권한은 사용하지 않는것으로 변경.*/
	public List<Map<String, Object>> selectUsersList(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectList("com.sys.User.selectUsersList", paramMap);
	}
	
	/**/
    public List<Map<String, Object>> selectPerUsersList(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectList("com.sys.User.selectPerUsersList", paramMap);
    }
    
    public Map<String, Object> sendUserInfo(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.sys.User.sendUserInfo", paramMap);
    }
    
	public void saveInitPw(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.sys.User.saveInitPw", paramMap);
	}
    
}
