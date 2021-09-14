package com.app.ildong.common.controller;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.JsonData;
import com.app.ildong.common.model.mvc.BaseController;
import com.app.ildong.common.service.FileManageService;
import com.app.ildong.common.util.FileUtil;
import com.app.ildong.common.util.StringUtilEx;

@Controller
public class FileManageController extends BaseController{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	FileManageService fileManageService;
	
    @RequestMapping(value = "/upload.do")
    public String link(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws Exception {
        final String[] required_params = new String[]{"APP_SEQ", "DATA_FORMAT", "CALLBACK", "KEY_ID", "READ_ONLY","SEND_OUT_FLAG","APP_TYPE"};
        for (String required : required_params) {
        	model.put(required, paramMap.get(required));
        }
        return "fileupload/upload";
    }
    
    @RequestMapping(value = "/upload/keygen.do")
    @ResponseBody
    public JsonData processAppSeq(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	JsonData jsonData = new JsonData();
        try {
            String fileMngKey = fileManageService.processAppSeq(paramMap);
            jsonData.addFields("status", "SUCC");
            jsonData.addFields("APP_SEQ", fileMngKey);
        } catch (Exception _e) {
            _e.printStackTrace();
            jsonData.addFields("status", "FAILURE");
            jsonData.addFields("ERR_MSG", "업로드 파일 관리번호 채번에 실패하였습니다.");
        }
        return jsonData;
    }
    
    @RequestMapping(value = "/upload/file.do" , method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> list(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) {
    	Map<String, Object> resFiles = new HashMap<String, Object>();
        try {
            List<Map<String, Object>> uploadedFiles = fileManageService.selectUploadedFileList(paramMap);
            resFiles.put("files",  FileUtil.convertForFileView(uploadedFiles));
            
        } catch (Exception _e) {
            _e.printStackTrace();
        }
        return resFiles;
    }
    
    @RequestMapping(value = "/upload/singlefile.do", method = RequestMethod.POST)
    @ResponseBody
    public void uploadSingle(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, HttpServletResponse response, ModelMap model) {
    	Map<String, Object> resFiles = new HashMap<String, Object>();
        List<Map<String,Object>> uploadedFiles;
        try {
        	String fileMngKey 	= "";
        	if (null==paramMap.get("APP_SEQ") || "".equals(paramMap.get("APP_SEQ").toString())) {
        		fileMngKey = fileManageService.processAppSeq(null);
        	} else {
        		fileMngKey = paramMap.get("APP_SEQ").toString();
        	}
        	//20190920 파일업로드 업구 구분 추가
        	String appType = "";
        	if (null==paramMap.get("APP_TYPE") || "".equals(paramMap.get("APP_TYPE").toString())) {
        		appType = "";
        	} else {
        		appType = paramMap.get("APP_TYPE").toString();
        	}
        	
        	
        	/*
        	 * TODO
             * 2019. 10. 23
             * 
             * 두가지 방법으로 작업 가능 DB 조회 후 변환 또는 아래 처럼 세팅 후 변환
             * 
             * String 변환 예시
             * 
             * Parameter로 받은 String 내용을 SAP 주소 코드로 변환 작업
             * jcoItemMap.put("REGIO", StringUtilEx.formatRegion((String) paramMap.get( "LINK_ADDR_1" ))); 
             */
        	
        	uploadedFiles = fileManageService.uploadFile(request, fileMngKey,appType);

            resFiles.put("files"		, FileUtil.convertForFileView(uploadedFiles));
            resFiles.put("APP_SEQ"		, fileMngKey);

            // IpsMap을 직접 리턴하지 않는 이유는 IE9에서 인식하지 못하기 때문에
            //response.setCharacterEncoding("utf-8");
            if (request.getHeader("accept").contains("application/json")) {
                response.setContentType("application/json");
            } else {
                response.setContentType("text/plain");
            }
            response.getWriter().println(new ObjectMapper().writeValueAsString(resFiles));
//            response.getWriter().println(resFiles);
        } catch (ServiceException se) {
        	se.printStackTrace();
        	try {
	        	//response.setCharacterEncoding("utf-8");
	        	response.setContentType("text/plain");
	        	response.getWriter().print("error|" + se.getMessage());
        	} catch (Exception e) {
        		e.printStackTrace();
        	}
        } catch (Exception _e) {
        	_e.printStackTrace();
        	try {
	        	//response.setCharacterEncoding("utf-8");
	        	response.setContentType("text/plain");
	        	response.getWriter().print("error");
        	} catch (Exception e) {
        		e.printStackTrace();
        	}
        }
    }
    
    @RequestMapping(value = "/upload/file.do", method = RequestMethod.POST)
    @ResponseBody
    public void upload(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, HttpServletResponse response, ModelMap model) {
    	Map<String, Object> resFiles = new HashMap<String, Object>();
        List<Map<String,Object>> uploadedFiles;
        try {
        	String appSeq 	= "";
        	if (null==paramMap.get("APP_SEQ") || "".equals(paramMap.get("APP_SEQ").toString())) {
        		appSeq = fileManageService.processAppSeq(null);
        	} else {
        		appSeq = paramMap.get("APP_SEQ").toString();
        	}

        	//20190920 파일업로드 업구 구분 추가
        	String appType = "";
        	if (null==paramMap.get("APP_TYPE") || "".equals(paramMap.get("APP_TYPE").toString())) {
        		appType = "";
        	} else {
        		appType = paramMap.get("APP_TYPE").toString();
        	}
        	
        	/*
        	 * TODO
             * 2019. 10. 23
             * 
             * 두가지 방법으로 작업 가능 DB 조회 후 변환 또는 아래 처럼 세팅 후 변환
             * 
             * String 변환 예시
             * 
             * Parameter로 받은 String 내용을 SAP 주소 코드로 변환 작업
             * jcoItemMap.put("REGIO", StringUtilEx.formatRegion((String) paramMap.get( "LINK_ADDR_1" ))); 
             */
        	
        	synchronized (this) {
                uploadedFiles = fileManageService.uploadFile(request, appSeq, appType);
            }
            
            resFiles.put("files"			, FileUtil.convertForFileView(uploadedFiles));
            resFiles.put("APP_SEQ"			, appSeq);
            resFiles.put("result"			, "succ");
            
            // IpsMap을 직접 리턴하지 않는 이유는 IE9에서 인식하지 맛하기 때문에
            response.setCharacterEncoding("utf-8");
            if (request.getHeader("accept").contains("application/json")) {
                response.setContentType("application/json");
            } else {
                response.setContentType("text/plain");
            }
            response.getWriter().println(new ObjectMapper().writeValueAsString(resFiles));
//            response.getWriter().println(resFiles);
        } catch (ServiceException se) {
        	se.printStackTrace();
        	try {
				resFiles.put("files"			, "");
				resFiles.put("APP_SEQ"			, "");
				resFiles.put("result"			, "fail");
				resFiles.put("err_msg"			, se.getMessage());
				 
	        	//response.setCharacterEncoding("utf-8");
	        	response.setContentType("application/json");
	        	response.getWriter().println(new ObjectMapper().writeValueAsString(resFiles));
        	} catch (Exception e) {
        		e.printStackTrace();
        	}
        } catch (Exception _e) {
        	_e.printStackTrace();
        	try {
        		resFiles.put("files"			, "");
				resFiles.put("APP_SEQ"			, "");
				resFiles.put("result"			, "fail");
				resFiles.put("err_msg"			, "common");
				
				//response.setCharacterEncoding("utf-8");
	        	response.setContentType("application/json");
	        	response.getWriter().println(new ObjectMapper().writeValueAsString(resFiles));
        	} catch (Exception e) {
        		e.printStackTrace();
        	}
        }
    }
  
    @RequestMapping(value = "/download.do", method = RequestMethod.GET)
    public void download(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
    	try {
            List<Map<String,Object>> files;
            
//            String uploadPath = PropertiesUtil.getProperty("FILE.UPLOAD.PATH");
            
            String fileMngKey	= paramMap.get("APP_SEQ").toString();
            String repFileName	= "";
            
            if (fileMngKey.contains(",")) {
                files = new ArrayList<>();
                String[] fileKeys = fileMngKey.split(",");
                for (String fileKey : fileKeys) {
                	Map<String, Object> itemParam = new HashMap<>();
                	itemParam.put("APP_SEQ", fileKey);
                	List<Map<String,Object>> uploadedFiles = fileManageService.selectUploadedFileList(itemParam);
                	files.addAll(FileUtil.convertForFileView(uploadedFiles));
                	if ("".equals(repFileName)) repFileName = uploadedFiles.get(0).get("FILE_NAME").toString();
                }
                FileUtil.downloadFile(response, files);
            } else {
                files = FileUtil.convertForFileView(fileManageService.selectUploadedFileList(paramMap));
                if (files.size()>1) {
                	FileUtil.downloadFile(response, files);
                } else {
                	FileUtil.downloadFile(response, files.get(0));
                }	
            }
    	}catch(java.io.FileNotFoundException ee) {
    		response.setCharacterEncoding("utf-8"); 
    		response.setContentType("text/html");
    		response.getWriter().println("<script>alert('File not found');window.close();</script>");

    	}catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    @RequestMapping(value = "/delete.do", method = RequestMethod.GET)
    @ResponseBody
    public List<Map<String, Object>> delete(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
    	List<Map<String,Object>> results = new ArrayList<>();
    	try {
    		results = fileManageService.deleteFileInfo(paramMap);
    		
    	} catch (Exception e) {
            e.printStackTrace();
        }
		return results;
    }
    
    @RequestMapping(value = "/upload/fileAttachInc.do")
    public String fileAttachInc(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws Exception {
        final String[] required_params = new String[]{"formName", "APP_SEQ", "READ_ONLY" ,"FILE_NAME", "SEND_OUT_FLAG"};
        model.put("paramMap", paramMap);
        for (String required : required_params) {
            model.put(required, paramMap.get(required));
            //if (logger.isTraceEnabled()) {
            //logger.error("Requried Param ["+required+"] : '["+paramMap.get(required)+"]'");
//            if ("FILE_NAME".equals(required)) {
//            	logger.error("UTF-8:" + URLDecoder.decode((String)paramMap.get(required), "UTF-8"));
//            	logger.error("EUC-KR:" + URLDecoder.decode((String)paramMap.get(required), "EUC-KR"));
//            }
            
            //}
        }
        if (null == paramMap.get("READ_ONLY") || "".equals(paramMap.get("READ_ONLY"))) {
            model.put("READ_ONLY", "N");
        }
        if (null == paramMap.get("SEND_OUT_FLAG") || "".equals(paramMap.get("SEND_OUT_FLAG"))) {
            model.put("SEND_OUT_FLAG", "N");
        }
        return "fileupload/fileAttachInc";
    }
    
    @RequestMapping(value = "/image.do", method = RequestMethod.GET)
    public void image(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
    	try {
            List<Map<String,Object>> files;
            files = FileUtil.convertForFileView(fileManageService.selectUploadedFileList(paramMap));
            FileUtil.imageFile(response, files.get(0));
            
    	} catch (Exception e) {
            e.printStackTrace();
        }
    }  
    
   /**
    * 첨부파일 목록을 새로운 첨부파일 목록으로 복사
    * @param paramMap
    * @param request
    * @param model
    * @return
    * @throws Exception
    */
   @RequestMapping(value = "/bbid/copyAttchFile.do")
   @ResponseBody
   public JsonData copyAttchFile(@RequestBody Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws Exception {
   	JsonData jsonData = new JsonData();
   	try {
   		String oldAppSeq = StringUtils.defaultIfBlank((String) paramMap.get("ATTCH_FILE_ID"), "");
   		
   		if(!"".equals(oldAppSeq)){
   			Map<String,Object> newFileInfoOut = fileManageService.copyFiles(oldAppSeq);
   			jsonData.addFields("ATTCH_FILE_ID", newFileInfoOut.get("APP_SEQ"));
   		}
   		
    } catch (Exception e) {
        e.printStackTrace();
    }
   	
   	return jsonData;
   }
   

   
	/**
	 * 외부에서 파일 다운로드
	 * FILE_KEY : APP_SEQ(18자리) + ATTACHMENT_SEQ(32자리)
	 * @param paramMap
	 * @param request
	 * @param response
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping(value = "/downloadEx.do", method = RequestMethod.GET)
	public void downloadEx(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		try {
			
			String fileMngKey = paramMap.get("FILE_KEY").toString();
			
			if(fileMngKey.length() == 50)
			{
				String appSeq 		 = "";
				String attachmentSeq = "";
				
				appSeq = fileMngKey.substring(0, 18);
				attachmentSeq = fileMngKey.substring(18, fileMngKey.length());
				
				Map<String, Object> attParam = new HashMap<String, Object>();
				attParam.put("APP_SEQ", appSeq);
				attParam.put("ATTACHMENT_SEQ", attachmentSeq);
				
				List<Map<String, Object>> fileList = fileManageService.selectUploadedFileList(attParam);
				
				if(fileList.size() > 0)
				{
					FileUtil.downloadFile(response, fileList.get(0));
					Map<String, Object> fileMap = new HashMap<String, Object>();
					fileMap = fileList.get(0);
					fileMap.put("DOWNLOAD_IP", request.getRemoteAddr());
					fileMap.put("RESULT", "S");
					fileManageService.insertFileDownLog(fileMap);
				}
				else
				{
					Map<String, Object> fileMap = new HashMap<String, Object>();
					fileMap.put("APP_SEQ", appSeq);
					fileMap.put("ATTACHMENT_SEQ", attachmentSeq);
					fileMap.put("DOWNLOAD_IP", request.getRemoteAddr());
					fileMap.put("RESULT", "F");
					
					fileManageService.insertFileDownLog(fileMap);	
				}
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			
		}
	}
	
	@RequestMapping(value = "/uploadForm.do")
    public String uploadForm(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws Exception {
        final String[] required_params = new String[]{"APP_SEQ", "DATA_FORMAT", "CALLBACK", "KEY_ID", "READ_ONLY","SEND_OUT_FLAG", "TABLE_ID"};
        for (String required : required_params) {
            model.put(required, paramMap.get(required));
        }
        return "fileupload/uploadForm";
    }
	
	@RequestMapping(value = "/downForm.do")
    public String downForm(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws Exception {
        final String[] required_params = new String[]{"APP_SEQ", "DATA_FORMAT", "CALLBACK", "KEY_ID", "READ_ONLY","SEND_OUT_FLAG", "TABLE_ID"};
        for (String required : required_params) {
            model.put(required, paramMap.get(required));
        }
        return "fileupload/downForm";
    }
	
	/**
	 * APP_SEQ 별 파일목록 및 다운로드 팝업
	 * @param paramMap
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/downloadFilePop.do")
    public String downloadFilePop(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, ModelMap model) throws Exception {
        String appSeq = MapUtils.getString(paramMap, "APP_SEQ");
        logger.debug("첨부파일 일련번호:" + appSeq);
        
        List<Map<String, Object>> fileList = fileManageService.selectUploadedFileList(paramMap);
        model.put("FILE_LIST", fileList);
        
        return "fileupload/downloadFilePop";
    }
	 
}
