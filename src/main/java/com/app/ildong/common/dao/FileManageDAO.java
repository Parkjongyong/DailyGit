package com.app.ildong.common.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("FileManageDAO")
public class FileManageDAO {

	@Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    /**
     * 파일관리번호를 채번한다. APP_SEQ
     */
    public String selectAppSeq(Map<String,Object> paramMap) throws Exception {
        return sqlSessionTemplate.selectOne("common.FileManage.selectAppSeq", paramMap);
    }
    
    /**
     * 파일업로드 목록을 조회한다.
     */
    public List<Map<String,Object>> selectFileUploadList(Map<String,Object> paramMap) {
        return sqlSessionTemplate.selectList("common.FileManage.selectFileUploadList", paramMap);
    }


    /**
     * 파일정보를 등록한다.
     */
    public int insertFileInfo(Map<String,Object> paramMap) throws Exception {
    	return sqlSessionTemplate.insert("common.FileManage.insertFileInfo", paramMap);
    }
    
    /**
     * 파일정보를 삭제한다.
     */
    public int deleteFileInfo(Map<String,Object> paramMap) throws Exception {
    	return sqlSessionTemplate.delete("common.FileManage.deleteFileInfo", paramMap);
    }
    
    /**
     * 파일정보를 복사한다.
     */
    public int copyFilesInfo(Map<String,Object> paramMap) throws Exception {
    	return sqlSessionTemplate.insert("common.FileManage.copyFilesInfo", paramMap);
    }
    

	/**
	 * 파일다운로드 이력테이블에 추가한다.
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public int insertFileDownLog(Map<String, Object> paramMap) throws Exception {
		return sqlSessionTemplate.insert("common.FileManage.insertFileDownLog", paramMap);
	}

}
