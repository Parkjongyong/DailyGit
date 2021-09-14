package com.app.ildong.cmn.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("cmnMenuDAO")
public class CmnMenuDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectMenuList(Map<String, Object> paramMap)
	{
		return sqlSessionTemplate.selectList("com.cmn.Menu.selectMenuList", paramMap);
	}
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectMenuDetailList(Map<String, Object> paramMap)
	{
		return sqlSessionTemplate.selectList("com.cmn.Menu.selectMenuDetailList", paramMap);
	}
	
	/**
	 * @param paramMap
	 * @return
	 */
	public int updateMenuDetail(Map<String, Object> paramMap){
		return sqlSessionTemplate.update("com.cmn.Menu.updateMenuDetail", paramMap);
	}
	
	/**
	 * @param paramMap
	 * @return
	 */
	public int insertMenuDetail(Map<String, Object> paramMap){
		return sqlSessionTemplate.update("com.cmn.Menu.insertMenuDetail", paramMap);
	}

	/**
	 * @param paramMap
	 * @return
	 */
	public Map<String, Object> checkDeleteMenuList(Map<String, Object> paramMap)
	{
		return sqlSessionTemplate.selectOne("com.cmn.Menu.checkDeleteMenuList", paramMap);
	}
	/**
	 * @param paramMap
	 * @return
	 */
	public int deleteMenu(Map<String, Object> paramMap){
		return sqlSessionTemplate.update("com.cmn.Menu.deleteMenu", paramMap);
	}
}
