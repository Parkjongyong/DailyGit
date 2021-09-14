package com.app.ildong.common.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ecbank.framework.exception.BizException;
import com.app.ildong.common.dao.FileManageDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.common.util.FileUtil;
import com.app.ildong.common.util.PropertiesUtil;
import com.app.ildong.common.util.StringUtil;


@Service("FileManageService")
public class FileManageService extends BaseService {
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
    FileManageDAO fileManageDAO;
	
    /**
     * 파일을 업로드 한다
     */
    public List<Map<String,Object>> uploadFile(HttpServletRequest request, String appSeq,String appType) throws ServiceException, Exception {
    	//List<Map<String,Object>> resultList = filesUtil.uploadFiles(request);
    	List<Map<String,Object>> resultList = FileUtil.uploadFiles(request,appType);
    	
    	if (1==resultList.size()) {
    		Map<String, Object> itemFile = resultList.get(0);
    		itemFile.put("APP_SEQ", appSeq);
    		fileManageDAO.deleteFileInfo(itemFile);
    	} 
    	
    	for (Map<String,Object> itemFile:resultList) {
    		itemFile.put("APP_SEQ"	, appSeq);
    		itemFile.put("APP_TYPE"	, appType);
    		itemFile.put("REG_ID"	, getUserId());
    		itemFile.put("MOD_ID"	, getUserId());
    		itemFile.put("COMP_CD"	, PropertiesUtil.getProperty("COMP_CD"));
    		
    		fileManageDAO.insertFileInfo(itemFile);
    	}   	
    	return resultList;
    }
    
    
    /**
     * 업로드된 파일 리스트를 구한다
     */
    public List<Map<String,Object>> selectUploadedFileList(Map<String,Object> paramMap) throws Exception {
    	return fileManageDAO.selectFileUploadList(paramMap);
    }

    /**
     * 파일관리번호(APP_SEQ)를 채번한다.
     */
    public String processAppSeq(Map<String,Object> paramMap) throws Exception {
        return fileManageDAO.selectAppSeq(paramMap);
    }
    
    
    /**
     * 파일정보를 삭제한다.
     */
    public List<Map<String,Object>> deleteFileInfo(Map<String,Object> paramMap) throws Exception {
    	List<Map<String,Object>> results = new ArrayList<>();
    	Map<String,Object> success = new HashMap<>();

        List<Map<String,Object>> files = selectUploadedFileList(paramMap);
        if (files.size() > 1) { // all files
        	FileUtil.deleteFile(files);
        	success.put("success", true);
            results.add(success);
        } else { // each files
        	for (Map<String, Object> file : files) {
	        	FileUtil.deleteFile(file);
	        	success.put("success", true);
	            results.add(success);
        	}
        }
        fileManageDAO.deleteFileInfo(paramMap);
        
        return results;
    }
    
    /**
     * 업로드된 파일 리스트를 구한다
     */
    public Map<String,Object> selectUploadedFileForSingle(String appSeq) throws Exception {
    	
    	if( StringUtils.isNotEmpty(appSeq)) {
	    	Map<String,Object> paramMap = new HashMap<>();
	    	paramMap.put("FILE_MNG_KEY", appSeq);
	    	List<Map<String,Object>> fileList = fileManageDAO.selectFileUploadList(paramMap);
	    	
	    	if( fileList != null && fileList.size() > 0 ) {
	    		return fileList.get(0);
	    	}
    	}
    	
    	return null;
    }
    
    /**
     * 파일을 복사하고 APP_SEQ를 리턴함
     */
    public Map<String,Object> copyFiles(String oldAppSeq) throws BizException, Exception {
    	String newAppSeq =  fileManageDAO.selectAppSeq(null);
    	
    	return copyFiles(oldAppSeq, newAppSeq);
    }
    
    public Map<String,Object> copyFiles(String oldAppSeq, String newAppSeq) throws ServiceException, Exception {
    	Map<String,Object> responseData = new HashMap<>();
    	
    	if (null==oldAppSeq || "".equals(oldAppSeq)) {
    		responseData.put("RESULT", "E");
    		responseData.put("RESULT_MSG", "APP_SEQ IS NOT EXIST.");
    		
    		return responseData;
    	}
    	
    	Map<String,Object> paramMap = new HashMap<>();
    	paramMap.put("APP_SEQ"		, oldAppSeq);
    	
    	List<Map<String,Object>> mapFileList = fileManageDAO.selectFileUploadList(paramMap);
    	
    	try {
	    	for (Map<String,Object> mapFile:mapFileList) {
	    		
	    		boolean migYn = false;
	    		
	    		if(StringUtil.nvl(mapFile.get("REG_ID"),"").indexOf("MIG") == 0) {
	    			migYn = true;
	    		}
	    		
	    		HashMap<String,Object> rtnCopyInfo = FileUtil.copyFile((String)mapFile.get("APP_TYPE"),(String)mapFile.get("FILE_PATH"), (String)mapFile.get("REAL_FILE_NAME"), migYn);
	    		
	    		rtnCopyInfo.put("OLD_APP_SEQ"		, mapFile.get("APP_SEQ"));
	    		rtnCopyInfo.put("OLD_ATTACHMENT_SEQ", mapFile.get("ATTACHMENT_SEQ"));
	    		rtnCopyInfo.put("COMP_CD"			, getCompCd());
	    		rtnCopyInfo.put("APP_SEQ"			, newAppSeq);
	    		rtnCopyInfo.put("USER_ID"			, getUserId());
	    		
	    		fileManageDAO.copyFilesInfo(rtnCopyInfo);
	    	}
    	} catch (Exception e) {
    		throw new ServiceException("파일복사에 실패했습니다.\n" + e.getMessage());
    	}
    	
    	responseData.put("RESULT"		, "S");
    	responseData.put("FILE_MNG_KEY"	, newAppSeq);
    	
    	return responseData;
    }
    
	/**
	 * 파일다운로드 이력테이블에 추가한다.
	 * @param paramMap
	 * @return
	 */
	public int insertFileDownLog(Map<String, Object> paramMap){
		int cnt = 0;
		
		try {
			//파일다운로드 이력테이블에 데이터 추가.
			cnt = fileManageDAO.insertFileDownLog(paramMap);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return cnt;
	}
}
