package com.app.ildong.cmn.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("CmnMsgDAO")
public class CmnMsgDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	
	/**
	 * SMS/메일 문구 조회
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectMsgList(Map<String, Object> paramMap)
	{
		return sqlSessionTemplate.selectList("com.cmn.Msg.selectMsgList", paramMap);
	}
	
	/**
	 * MSG 상세내용 수정
	 * @param paramMap
	 * @return
	 */
	public int updateMsgDetail(Map<String, Object> paramMap)
	{
		return sqlSessionTemplate.update("com.cmn.Msg.updateMsgDetail", paramMap);
	}
	
	/**
	 * SMS/메일 정보 삭제
	 * @param paramMap
	 * @return
	 */
	public int deleteMsgInfo(Map<String, Object> paramMap)
	{
		return sqlSessionTemplate.update("com.cmn.Msg.deleteMsgInfo", paramMap);
	}
	
	/**
	 * SMS/메일 정보 기록 조회
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectMsgLogInfo(Map<String, Object> paramMap)
	{
		return sqlSessionTemplate.selectList("com.cmn.Msg.selectMsgLogInfo", paramMap);
	}
	
	/**
	 * SMS/메일 정보 기록 조회2
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectMsgLogInfo2(Map<String, Object> paramMap)
	{
		return sqlSessionTemplate.selectList("com.cmn.Msg.selectMsgLogInfo2", paramMap);
	}
	
	/**
	 * SMS/MAIL 로그 조회
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectMsgLogList(Map<String, Object> paramMap)
	{
		return sqlSessionTemplate.selectList("com.cmn.Msg.selectMsgLogList", paramMap);
	}
	
	/**
	 * 메일ID 리스트 조회(조회조건)
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectMailIdList(Map<String, Object> paramMap)
	{
		return sqlSessionTemplate.selectList("com.cmn.Msg.selectMailIdList", paramMap);
	}
	
	/**
	 * SMS/MAIL 로그 상세보기 조회
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectMsgLogDetailInfo(Map<String, Object> paramMap)
	{
		return sqlSessionTemplate.selectList("com.cmn.Msg.selectMsgLogDetailInfo", paramMap);
	}
	
	/**
	 * 전송로그 추가
	 * @param paramMap
	 * @return
	 */
	public int insertMsgLogInfo(Map<String, Object> paramMap)
	{
		return sqlSessionTemplate.insert("com.cmn.Msg.insertMsgLogInfo", paramMap);
	}
	
	
	/**
	 * 메일전송 배치대상 등록
	 * @param paramMap
	 * @return
	 */
	public int insertBatchMailInfo(Map<String, Object> paramMap)
	{
		return sqlSessionTemplate.insert("com.cmn.Msg.insertBatchMailInfo", paramMap);
	}
	
	/**
	 * 업무구분 리스트 조회
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectTaskList(Map<String, Object> paramMap)
	{
		return sqlSessionTemplate.selectList("com.cmn.Msg.selectTaskList", paramMap);
	}
	
	/**
	 * 수신자 리스트
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectReceiverNameList(Map<String, Object> paramMap)
	{
		return sqlSessionTemplate.selectList("com.cmn.Msg.selectReceiverNameList", paramMap);
	}

	/**
	 * 메일 배치 일괄전송
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectMailBatchList(Map<String, Object> paramMap) {
		
		return sqlSessionTemplate.selectList("com.cmn.Msg.selectMailBatchList", paramMap);
	}

	/**
	 * 메일 전송일자 업데이트
	 * @param mailParam
	 * @return
	 */
	public int updateMailSendDate(Map<String, Object> mailParam) {
		return sqlSessionTemplate.insert("com.cmn.Msg.updateMailSendDate", mailParam);
	}
	
}
