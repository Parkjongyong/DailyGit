package com.app.ildong.common.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("MessageSendDAO")
public class MessageSendDAO {
	
	
	@Autowired
    private SqlSessionTemplate sqlSessionTemplate;

	
	/**
	 * MAIL_ID로 정보를 조회한다. 
	 * @param 
	 * @return
	 */
	public Map<String, Object> selectMailSmsInfo( Map<String, Object> paramMap ) throws Exception {
		return sqlSessionTemplate.selectOne("common.MessageSend.selectMailSmsInfo", paramMap);
	}
}