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

@Repository("SysCmmLogMgmtDAO")
public class SysCmmLogMgmtDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectRfcLogMgmtList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.sys.SysCmmLogMgmt.selectRfcLogMgmtList", paramMap);
	}
	
	public Map<String, Object> selectRfcLogMgmtDetail(Map<String, Object> paramMap){
        return sqlSessionTemplate.selectOne("com.sys.SysCmmLogMgmt.selectRfcLogMgmtDetail", paramMap);
    }
	
	public List<Map<String, Object>> selectAlarmLogMgmtList(Map<String, Object> paramMap){
        return sqlSessionTemplate.selectList("com.sys.SysCmmLogMgmt.selectAlarmLogMgmtList", paramMap);
    }
    
	public Map<String, Object> selectAlarmLogMgmtDetail(Map<String, Object> paramMap){
        return sqlSessionTemplate.selectOne("com.sys.SysCmmLogMgmt.selectAlarmLogMgmtDetail", paramMap);
    }
	
	public List<Map<String, Object>> selectBatchLogMgmtList(Map<String, Object> paramMap){
        return sqlSessionTemplate.selectList("com.sys.SysCmmLogMgmt.selectBatchLogMgmtList", paramMap);
    }
	
	public List<Map<String, Object>> selectBatchLogMgmtDetailList(Map<String, Object> paramMap){
        return sqlSessionTemplate.selectList("com.sys.SysCmmLogMgmt.selectBatchLogMgmtDetailList", paramMap);
    }
	
	public Map<String, Object> selectBatchLogMgmtErrDetail(Map<String, Object> paramMap){
        return sqlSessionTemplate.selectOne("com.sys.SysCmmLogMgmt.selectBatchLogMgmtErrDetail", paramMap);
    }
	
	public int updateBatchMaster(Map<String, Object> paramMap){
		return sqlSessionTemplate.update("com.sys.SysCmmLogMgmt.updateBatchMaster", paramMap);
	}
	
	public int updateParamBatchMaster(Map<String, Object> paramMap){
		return sqlSessionTemplate.update("com.sys.SysCmmLogMgmt.updateParamBatchMaster", paramMap);
	}	
}

