/**
 * 메인 이미지관리 DAO
 * @author 길용덕
 * @since 2020.09.23
 * 
 * << 개정이력(Modification Information) >>
 *  ------------------------------------------------- 
 *  수정일                    수정자            수정내용
 *  ----------   -------- ---------------------------
 *  2020.09.23   길용덕            최초생성
 *  -------------------------------------------------
 */
package com.app.ildong.sys.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("sysMainImageDAO")
public class SysMainImageDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectMainImageList(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectList("com.sys.MainImage.selectMainImageList", paramMap);
	}
	
	public List<Map<String, Object>> selectInImageList(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectList("com.sys.MainImage.selectInImageList", paramMap);
	}
	
	public List<Map<String, Object>> selectOutImageList(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectList("com.sys.MainImage.selectOutImageList", paramMap);
	}
	
	public void saveMainImage(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.sys.MainImage.saveMainImage", paramMap);
	}
	
}
