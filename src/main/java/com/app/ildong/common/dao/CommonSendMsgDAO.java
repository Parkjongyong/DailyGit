package com.app.ildong.common.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("CommonSendMsgDAO")
public class CommonSendMsgDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public int insertMailSmsLog(Map<String, Object> paramMap) throws Exception {
		return sqlSessionTemplate.insert("common.CommonSendMsg.insertMailSmsLog", paramMap);
	}
	
}
