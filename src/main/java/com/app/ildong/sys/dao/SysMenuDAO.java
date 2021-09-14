/**
 * 메뉴 조회/등록/삭제 DAO
 * @author 길용덕
 * @since 2020.06.17
 * 
 * << 개정이력(Modification Information) >>
 *  ------------------------------------------------- 
 *  수정일                    수정자            수정내용
 *  ----------   -------- ---------------------------
 *  2020.06.17   길용덕            최초생성
 *  -------------------------------------------------
 */
package com.app.ildong.sys.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("sysMenuDAO")
public class SysMenuDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectMenuList(Map<String, Object> paramMap)
	{
		return sqlSessionTemplate.selectList("com.sys.Menu.selectMenuList", paramMap);
	}
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectMenuDetailList(Map<String, Object> paramMap)
	{
		return sqlSessionTemplate.selectList("com.sys.Menu.selectMenuDetailList", paramMap);
	}
	
	/**
	 * @param paramMap
	 * @return
	 */
	public int updateMenuDetail(Map<String, Object> paramMap){
		return sqlSessionTemplate.update("com.sys.Menu.updateMenuDetail", paramMap);
	}
	
	/**
	 * @param paramMap
	 * @return
	 */
	public int insertMenuDetail(Map<String, Object> paramMap){
		return sqlSessionTemplate.update("com.sys.Menu.insertMenuDetail", paramMap);
	}

	/**
	 * @param paramMap
	 * @return
	 */
	public Map<String, Object> checkDeleteMenuList(Map<String, Object> paramMap)
	{
		return sqlSessionTemplate.selectOne("com.sys.Menu.checkDeleteMenuList", paramMap);
	}
	/**
	 * @param paramMap
	 * @return
	 */
	public int deleteMenu(Map<String, Object> paramMap){
		return sqlSessionTemplate.update("com.sys.Menu.deleteMenu", paramMap);
	}
}
