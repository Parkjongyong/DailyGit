/**
 * 시스템관리 > 배치 관리 DAO
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

@Repository("SysPwChangeDAO")
public class SysPwChangeDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public int updatePw(Map<String, Object> paramMap){
		return sqlSessionTemplate.update("com.sys.User.updatePw", paramMap);
	}
	
	public Map<String, Object> checkPw(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectOne("com.sys.User.checkPw", paramMap);
    }

}

