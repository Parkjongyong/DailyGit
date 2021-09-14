package com.app.ildong.sys.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("SysBoardDAO")
public class SysBoardDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public Map<String, Object> selectBoardInfo(Map<String,Object> paramMap) {
		return sqlSessionTemplate.selectOne("com.sys.SysBoardDAO.selectBoardInfo", paramMap);
	}
	
	public List<Map<String,Object>> selectBoardList(Map<String,Object> paramMap) {
		return sqlSessionTemplate.selectList("com.sys.SysBoardDAO.selectBoardList", paramMap);
	}
	
	public List<Map<String,Object>> selectSysOutBoardList(Map<String,Object> paramMap) {
        return sqlSessionTemplate.selectList("com.sys.SysBoardDAO.selectSysOutBoardList", paramMap);
    }
	
	public List<Map<String,Object>> selectSysOutVosBoardList(Map<String,Object> paramMap) {
        return sqlSessionTemplate.selectList("com.sys.SysBoardDAO.selectSysOutVosBoardList", paramMap);
    }
	
	public Integer selectBoardListCount( Map<String,Object> paramMap ) throws Exception {
		return sqlSessionTemplate.selectOne("com.sys.SysBoardDAO.selectBoardListCount", paramMap);
	}
	
	public List<Map<String, Object>> selectBoardInfoAll(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectList("com.sys.SysBoardDAO.selectBoardInfoAll", paramMap);
	}
	
	public Map<String, Object> selectBoard(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectOne("com.sys.SysBoardDAO.selectBoard", paramMap);
	}
	
	
	public Map<String, Object> selectSubBoard(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.sys.SysBoardDAO.selectSubBoard", paramMap);
    }
	
	public Map<String, Object> selectPrevBoard(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectOne("com.sys.SysBoardDAO.selectPrevBoard", paramMap);
	}
	
	public Map<String, Object> selectNextBoard(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectOne("com.sys.SysBoardDAO.selectNextBoard", paramMap);
	}
	
	public int updateBoardHit(Map<String, Object> paramMap) {
		return sqlSessionTemplate.update("com.sys.SysBoardDAO.updateBoardHit", paramMap);
	}
	
	public int deleteBoard(Map<String, Object> paramMap) {
		return sqlSessionTemplate.update("com.sys.SysBoardDAO.deleteBoard", paramMap);
	}
	
	public int insertBoard(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.sys.SysBoardDAO.insertBoard", paramMap);
	}
	
	public int applyBoard(Map<String, Object> paramMap) {
		return sqlSessionTemplate.update("com.sys.SysBoardDAO.applyBoard", paramMap);
	}
	
	public int updateBoard(Map<String, Object> paramMap) {
		return sqlSessionTemplate.update("com.sys.SysBoardDAO.updateBoard", paramMap);
	}
	
	public int insertReply(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.sys.SysBoardDAO.insertReply", paramMap);
	}
	
	public int updateReply(Map<String, Object> paramMap) {
		return sqlSessionTemplate.update("com.sys.SysBoardDAO.updateReply", paramMap);
	}
	
	public int deleteReply(Map<String, Object> paramMap) {
		return sqlSessionTemplate.update("com.sys.SysBoardDAO.deleteReply", paramMap);
	}
	
	public List<Map<String,Object>> selectFaqGrp(Map<String,Object> paramMap) {
		return sqlSessionTemplate.selectList("com.sys.SysBoardDAO.selectFaqGrp", paramMap);
	}
	
	public List<Map<String,Object>> selectAccessLogList(Map<String,Object> paramMap) {
		return sqlSessionTemplate.selectList("com.sys.SysBoardDAO.selectAccessLogList", paramMap);
	}

	public Integer selectBoardListCountFaq(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectOne("com.sys.SysBoardDAO.selectBoardListCountFaq", paramMap);
	}

	public List<Map<String, Object>> selectBoardListFaq(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectList("com.sys.SysBoardDAO.selectBoardListFaq", paramMap);
	}
	
	public List<Map<String, Object>> selectNoticeList(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectList("com.sys.SysBoardDAO.selectNoticeList", paramMap);
    }
    
    public Map<String, Object> selectSubNotice(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.sys.SysBoardDAO.selectSubNotice", paramMap);
    }

}
