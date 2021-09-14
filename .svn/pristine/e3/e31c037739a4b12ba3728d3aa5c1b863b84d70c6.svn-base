package com.app.ildong.sys.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ecbank.framework.exception.BizException;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.sys.dao.SysBoardDAO;

@Service("SysBoardService")
public class SysBoardService extends BaseService {
    
    @Autowired
    private SysBoardDAO sysBoardDAO;

    public Map<String, Object> selectBoardInfo(Map<String,Object> paramMap) throws BizException, Exception {
        return sysBoardDAO.selectBoardInfo(paramMap);
    }
    
    public List<Map<String,Object>> selectBoardList(Map<String,Object> paramMap) throws BizException, Exception {
        return sysBoardDAO.selectBoardList(paramMap);
    }
    
    public List<Map<String,Object>> selectSysOutBoardList(Map<String,Object> paramMap) throws BizException, Exception {
        return sysBoardDAO.selectSysOutBoardList(paramMap);
    }
    
    public List<Map<String,Object>> selectSysOutVosBoardList(Map<String,Object> paramMap) throws BizException, Exception {
        return sysBoardDAO.selectSysOutVosBoardList(paramMap);
    }
    
    public int selectBoardListCount( Map<String,Object> paramMap ) throws BizException, Exception {
        return sysBoardDAO.selectBoardListCount(paramMap);
    }
    
    public List<Map<String, Object>> selectBoardInfoAll(Map<String, Object> paramMap) throws BizException, Exception {
        return sysBoardDAO.selectBoardInfoAll(paramMap);
    }
    
    public Map<String, Object> selectBoard(Map<String, Object> paramMap) throws BizException, Exception {
        return sysBoardDAO.selectBoard(paramMap);
    }
    
    public Map<String, Object> selectSubBoard(Map<String, Object> paramMap) {
        return sysBoardDAO.selectSubBoard(paramMap);
    }
    
    public Map<String, Object> selectPrevBoard(Map<String, Object> paramMap) throws BizException, Exception {
        return sysBoardDAO.selectPrevBoard(paramMap);
    }
    
    public Map<String, Object> selectNextBoard(Map<String, Object> paramMap) throws BizException, Exception {
        return sysBoardDAO.selectNextBoard(paramMap);
    }
    
    public int updateBoardHit(Map<String, Object> paramMap) throws BizException, Exception {
        return sysBoardDAO.updateBoardHit(paramMap);
    }
    
    public int deleteBoard(Map<String, Object> paramMap) throws BizException, Exception {
        return sysBoardDAO.deleteBoard(paramMap);
    }
    
    public int insertBoard(Map<String, Object> paramMap) throws BizException, Exception {
        return sysBoardDAO.insertBoard(paramMap);
    }

    public int applyBoard(Map<String, Object> paramMap) throws BizException, Exception {
        return sysBoardDAO.applyBoard(paramMap);
    }
    
    public int updateBoard(Map<String, Object> paramMap) throws BizException, Exception {
        return sysBoardDAO.updateBoard(paramMap);
    }
    
    public int insertReply(Map<String, Object> paramMap) throws BizException, Exception {
        return sysBoardDAO.insertReply(paramMap);
    }
    
    public int updateReply(Map<String, Object> paramMap) throws BizException, Exception {
        return sysBoardDAO.updateReply(paramMap);
    }
    
    public int deleteReply(Map<String, Object> paramMap) throws BizException, Exception {
        return sysBoardDAO.deleteReply(paramMap);
    }

    public List<Map<String,Object>> selectFaqGrp(Map<String,Object> paramMap) throws BizException, Exception {
        return sysBoardDAO.selectFaqGrp(paramMap);
    }
    
    public List<Map<String,Object>> selectAccessLogList(Map<String,Object> paramMap) throws BizException, Exception {
        return sysBoardDAO.selectAccessLogList(paramMap);
    }

    public int selectBoardListCountFaq(Map<String, Object> paramMap) throws BizException, Exception {
        return sysBoardDAO.selectBoardListCountFaq(paramMap);
    }

    public List<Map<String, Object>> selectBoardListFaq(Map<String, Object> paramMap) throws BizException, Exception {
        return sysBoardDAO.selectBoardListFaq(paramMap);
    }
    
    public List<Map<String, Object>> selectNoticeList(Map<String, Object> paramMap) {
        return sysBoardDAO.selectNoticeList(paramMap);
    }
    
    public Map<String, Object> selectSubNotice(Map<String, Object> paramMap) {
        return sysBoardDAO.selectSubNotice(paramMap);
    }

}
