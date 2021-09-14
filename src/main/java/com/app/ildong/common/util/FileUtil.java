package com.app.ildong.common.util;


import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.nio.charset.Charset;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.util.HtmlUtils;

import com.app.ildong.common.crypt.DigestUtil;
import com.app.ildong.common.exception.ServiceException;

/**
 * 
 * @version 1.0
 * @see
 */
public class FileUtil {
	/** Buffer size */
	public static final int BUFFER_SIZE = 8192;

	public static final String SEPERATOR = File.separator;
	
	public static final String FILE_BASE_PATH = PropertiesUtil.getProperty("FILE.UPLOAD.PATH");
	
	public static final String ACCEPT_FILE_TYPES = "bmp|gif|jpg|jpeg|png|pdf|xls|xlsx|xlsb|xps|ppt|pptx|doc|docx|hwp|txt|pdf|zip|htx|mht|msg";
	
	protected final static Log logger = LogFactory.getLog(FileUtil.class);

	/**
	 * 오늘 날짜 문자열 취득.
	 * ex) 20090101
	 * @return
	 */
	public static String getTodayString() {
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd", Locale.getDefault());

		return format.format(new Date());
	}

	/**
	 * 물리적 파일명 생성.
	 * @return
	 */
	public static String getPhysicalFileName() {
		return UUID.randomUUID().toString().replaceAll("-", "").toUpperCase();
	}

	/**
	 * 파일명 변환.
	 * @param filename String
	 * @return
	 * @throws Exception
	 */
	protected static String convert(String filename) throws Exception {
		String encfname = java.net.URLEncoder.encode(filename, "UTF-8");
        return encfname.replaceAll("%28", "(").replaceAll("%29", ")").replaceAll("\\+", " ");
	}
	
	
	
	public static boolean isValidContentType(String contentType) {
		String strFileAllowTypes = FILE_BASE_PATH;

		
        if (!Arrays.asList(strFileAllowTypes).contains(contentType)) {
            return false;
        }
        
        return true;
    }
    
	
	public static boolean belowMaxFileSize(Long fileSize) {
		String strFileUploadMaxSize = PropertiesUtil.getProperty("FILE.UPLOAD.MAXSIZE");
		Long lMaxSize = Long.parseLong(strFileUploadMaxSize);
		
        if (fileSize > lMaxSize) {
            return false;
        }
        
        return true;
    }
	
	

	/**
	 * Stream으로부터 파일을 저장함.
	 * @param is InputStream
	 * @param file File
	 * @throws IOException
	 */
	public static long saveFile(InputStream is, File file) throws IOException {
		// 디렉토리 생성
		if (!file.getParentFile().exists()) {
			file.getParentFile().mkdirs();
		}

		OutputStream os = null;
		long size = 0L;

		try {
			os = new FileOutputStream(file);

			int bytesRead = 0;
			byte[] buffer = new byte[BUFFER_SIZE];

			while ((bytesRead = is.read(buffer, 0, BUFFER_SIZE)) != -1) {
				size += bytesRead;
				os.write(buffer, 0, bytesRead);
			}
		} finally {
			if (os != null) {
				try {
					os.close();
				} catch (Exception ignore) {
					logger.warn("Occurred Exception to close resource is ingored!!");
				}
			}

		}

		return size;
	}
	

	/**
	 * 파일을 Upload 처리한다.
	 *
	 * @param request
	 * @param where
	 * @param maxFileSize
	 * @return
	 * @throws Exception
	 */
	public static List<Map<String,Object>> uploadFiles_(HttpServletRequest request) throws ServiceException, Exception {
		
		
    	String strFileUploadPath = FILE_BASE_PATH;
    	String strFileUploadMaxSize = PropertiesUtil.getProperty("FILE.UPLOAD.MAXSIZE");
    	
		List<Map<String,Object>> resultList = new ArrayList<Map<String,Object>>();
		
		MultipartHttpServletRequest mptRequest = (MultipartHttpServletRequest) request;
		Iterator<?> fileIter = mptRequest.getFileNames();
	
		String strServerSubPath = getTodayString();
		String strUPloadDirPath = WebUtil.filePathBlackList(strFileUploadPath + SEPERATOR + strServerSubPath);
		
		// 디레토리가 없다면 생성
		File dir = new File(strUPloadDirPath);
		if (!dir.isDirectory()) {
			dir.mkdirs();
		}
		
		while (fileIter.hasNext()) {
			
			MultipartFile mFile = mptRequest.getFile((String) fileIter.next());


				
			Map<String,Object> dataMap = new HashMap<String,Object>();
	
			String tmp = mFile.getOriginalFilename();
	
			if (tmp.lastIndexOf("\\") >= 0) {
				tmp = tmp.substring(tmp.lastIndexOf("\\") + 1);
			}
	
			if ("".equals(tmp)) { // 파일명이 없다면
				continue;
			}
			
			String strOrgFileName = HtmlUtils.htmlEscape(tmp); // fileName Xss 처리
			String strContentType = mFile.getContentType().toString().toLowerCase();
			String strPhyFileName = getPhysicalFileName();
			
			int extIndex = strOrgFileName.lastIndexOf(".");
			
			String strFileExt = strOrgFileName.substring(extIndex+1).toLowerCase();
			
			String[] extList = ACCEPT_FILE_TYPES.split("\\|");
			
			boolean acceptFileType = false;
			for (String extItem:extList) {
				
				if (strFileExt.equals(extItem)) {
					acceptFileType = true;
				}
			}
			
			if (!acceptFileType) {
				throw new ServiceException("업로드 가능한 파일이 아닙니다.\n업로드 가능한 파일형식을 확인해주세요.");
			}
			
			/* **********************************************************************
			 * DRM 파일 여부 체크
			 * **********************************************************************/
			
			String sendOutFlag = StringUtil.nvl(request.getParameter("SEND_OUT_FLAG"), "N");
			sendOutFlag = StringUtil.nvl(request.getParameter("sendOutFlag"), sendOutFlag);
				    	
			if ("Y".equals(sendOutFlag)) {
				boolean drmExist	= false;
				
				InputStream inputStream = mFile.getInputStream();
				BufferedInputStream bs = new BufferedInputStream(inputStream);
				byte [] b = new byte [46];//임시로 읽는데 쓰는 공간
				
				//파일 read
				String receiveVal = "";
				String receiveValSoft = "";
	
				int read = 0;
				int cnt = 0 ;
				while ((read = bs.read(b,0,b.length)) != -1) {
					if(0 == cnt){
						for (int e = 0; e < 17; e++) { // byte[] 버퍼 내용 출력
							receiveVal += (String.format("%02X ", b[e]));
						}
	   
					}
					cnt++;
				}
				
				bs.close();
				receiveVal =  receiveVal.substring(0, 47);
				receiveValSoft =  receiveVal.substring(0, 29);
				
				//MS 형식의 파일 포맷
				String cryptMs = "D0 CF 11 E0 A1 B1 1A E1 00 00 00 00 00 00 00 00";
				//pfile 파일 포맷 
				String cryptOther = "2E 70 66 69 6C 65 02 00 00 00 01 00 00 00 8D 01";
				//SoftCamp 파일 포맷 
				String cryptSoftCamp = "53 43 44 53 41 30 30 32 00 00";
				
				//MS 형식 파일암호화
				if(strFileExt.equals("pptx") || strFileExt.equals("docx") || strFileExt.equals("doc") || strFileExt.equals("xlsx") ){
					if(cryptMs.equals(receiveVal) || cryptSoftCamp.equals(receiveValSoft)){
						drmExist = true;
					}
				}
				
				//pfile 파일암호화 여부
				if(strFileExt.equals("txt") || strFileExt.equals("hwp") || strFileExt.equals("jpg") || strFileExt.equals("png") ){
					if(cryptOther.equals(receiveVal) || cryptSoftCamp.equals(receiveValSoft)){
						drmExist = true;
					}
				}
			
				if (drmExist) {
					throw new ServiceException("["+strOrgFileName + "]은/는\n문서보안이 적용된 파일입니다.\n암호화 해제후 업로드 하세요.");
				}
				
			}
			
			/* **********************************************************************
			 * DRM 파일 여부 체크 END
			 * **********************************************************************/
			
			
			String fileHash = DigestUtil.extractByteHashSHA256(mFile.getBytes());
			
			/*MessageDigest md = MessageDigest.getInstance("SHA-256");
			md.update(mFile.getBytes());
			byte[] hashbytes = md.digest();
			// 보기 좋게 16진수로 만드는 작업
	        StringBuilder sbuilder = new StringBuilder();
	        for (int i = 0; i < hashbytes.length; i++) {
	            // %02x 부분은 0 ~ f 값 까지는 한자리 수이므로 두자리 수로 보정하는 역할을 한다.
	            sbuilder.append(String.format("%02x", hashbytes[i] & 0xff));
	        }*/
//	            sbuilder.toString();
	 
			
			if( ! belowMaxFileSize( mFile.getSize()) ) {
				throw new Exception( "Error. " + strOrgFileName + " file size (" + mFile.getSize() + ") exceeds " + strFileUploadMaxSize + " limit.");
			}

			
			if (mFile.getSize() > 0) {
				// 설정한 path에 파일저장
				File serverFile = new File(WebUtil.filePathBlackList(strUPloadDirPath + SEPERATOR + strPhyFileName));
				mFile.transferTo(serverFile);
				
				dataMap.put("ATTACHMENT_SEQ", strPhyFileName);
				dataMap.put("REAL_FILE_NAME", strPhyFileName);	//서버에 저장되는 파일명
				//dataMap.put("FILE_EXT_NAME", getFileExtension(strOrgFileName));
				dataMap.put("FILE_PATH", strServerSubPath);
				dataMap.put("FILE_NAME", setFileNameForSafe(strOrgFileName));  //사용자 선택한 파일명
				dataMap.put("FILE_SIZE", mFile.getSize());
				dataMap.put("FILE_HASH", fileHash);
				
				
				resultList.add(dataMap);
			}

		}
	
		return resultList;
	}

	/**
	 * 파일을 Upload 처리한다.
	 *
	 * @param request
	 * @param where
	 * @param maxFileSize
	 * @return
	 * @throws Exception
	 */
	public static List<Map<String,Object>> uploadFiles(HttpServletRequest request,String appType) throws ServiceException, Exception {
		
		
    	String strFileUploadPath = FILE_BASE_PATH;
    	
    	//루트/업무구분/일자로 폴더 생성
    	if(!"".equals(appType)) {
    		strFileUploadPath = strFileUploadPath + SEPERATOR + appType;
    	}
    	
    	String strFileUploadMaxSize = PropertiesUtil.getProperty("FILE.UPLOAD.MAXSIZE");
    	
		List<Map<String,Object>> resultList = new ArrayList<Map<String,Object>>();
		
		MultipartHttpServletRequest mptRequest = (MultipartHttpServletRequest) request;
		Iterator<?> fileIter = mptRequest.getFileNames();
	
		String strServerSubPath = getTodayString();
		String strUPloadDirPath = "";
		
		if(strFileUploadPath.indexOf("sysMainImage") > -1) {
			strUPloadDirPath = WebUtil.filePathBlackList(strFileUploadPath + SEPERATOR);
		} else {
			strUPloadDirPath = WebUtil.filePathBlackList(strFileUploadPath + SEPERATOR + strServerSubPath);
		}
		
		// 디레토리가 없다면 생성
		File dir = new File(strUPloadDirPath);
		if (!dir.isDirectory()) {
			dir.mkdirs();
		}
		
		while (fileIter.hasNext()) {
			
			MultipartFile mFile = mptRequest.getFile((String) fileIter.next());


				
			Map<String,Object> dataMap = new HashMap<String,Object>();
	
			String tmp = mFile.getOriginalFilename();
	
			if (tmp.lastIndexOf("\\") >= 0) {
				tmp = tmp.substring(tmp.lastIndexOf("\\") + 1);
			}
	
			if ("".equals(tmp)) { // 파일명이 없다면
				continue;
			}
			
			String strOrgFileName = HtmlUtils.htmlEscape(tmp); // fileName Xss 처리
			String strContentType = mFile.getContentType().toString().toLowerCase();
			String strPhyFileName = getPhysicalFileName();
			
			int extIndex = strOrgFileName.lastIndexOf(".");
			
			String strFileExt = strOrgFileName.substring(extIndex+1).toLowerCase();
			
			String[] extList = ACCEPT_FILE_TYPES.split("\\|");
			
			boolean acceptFileType = false;
			for (String extItem:extList) {
				
				if (strFileExt.equals(extItem)) {
					acceptFileType = true;
				}
			}
			
			if (!acceptFileType) {
				throw new ServiceException("업로드 가능한 파일이 아닙니다.\n업로드 가능한 파일형식을 확인해주세요.");
			}
			
			/* **********************************************************************
			 * DRM 파일 여부 체크
			 * **********************************************************************/
			
			String sendOutFlag = StringUtil.nvl(request.getParameter("SEND_OUT_FLAG"), "N");
			sendOutFlag = StringUtil.nvl(request.getParameter("sendOutFlag"), sendOutFlag);
				    	
			if ("Y".equals(sendOutFlag)) {
				boolean drmExist	= false;
				
				InputStream inputStream = mFile.getInputStream();
				BufferedInputStream bs = new BufferedInputStream(inputStream);
				byte [] b = new byte [46];//임시로 읽는데 쓰는 공간
				
				//파일 read
				String receiveVal = "";
				String receiveValSoft = "";
	
				int read = 0;
				int cnt = 0 ;
				while ((read = bs.read(b,0,b.length)) != -1) {
					if(0 == cnt){
						for (int e = 0; e < 17; e++) { // byte[] 버퍼 내용 출력
							receiveVal += (String.format("%02X ", b[e]));
						}
	   
					}
					cnt++;
				}
				
				bs.close();
				receiveVal =  receiveVal.substring(0, 47);
				receiveValSoft =  receiveVal.substring(0, 29);
				
				//MS 형식의 파일 포맷
				String cryptMs = "D0 CF 11 E0 A1 B1 1A E1 00 00 00 00 00 00 00 00";
				//pfile 파일 포맷 
				String cryptOther = "2E 70 66 69 6C 65 02 00 00 00 01 00 00 00 8D 01";
				//SoftCamp 파일 포맷 
				String cryptSoftCamp = "53 43 44 53 41 30 30 32 00 00";
				
				//MS 형식 파일암호화
				if(strFileExt.equals("pptx") || strFileExt.equals("docx") || strFileExt.equals("doc") || strFileExt.equals("xlsx") ){
					if(cryptMs.equals(receiveVal) || cryptSoftCamp.equals(receiveValSoft)){
						drmExist = true;
					}
				}
				
				//pfile 파일암호화 여부
				if(strFileExt.equals("txt") || strFileExt.equals("hwp") || strFileExt.equals("jpg") || strFileExt.equals("png") ){
					if(cryptOther.equals(receiveVal) || cryptSoftCamp.equals(receiveValSoft)){
						drmExist = true;
					}
				}
			
				if (drmExist) {
					throw new ServiceException("["+strOrgFileName + "]은/는\n문서보안이 적용된 파일입니다.\n암호화 해제후 업로드 하세요.");
				}
				
			}
			
			/* **********************************************************************
			 * DRM 파일 여부 체크 END
			 * **********************************************************************/
			
			
			String fileHash = DigestUtil.extractByteHashSHA256(mFile.getBytes());
			
			/*MessageDigest md = MessageDigest.getInstance("SHA-256");
			md.update(mFile.getBytes());
			byte[] hashbytes = md.digest();
			// 보기 좋게 16진수로 만드는 작업
	        StringBuilder sbuilder = new StringBuilder();
	        for (int i = 0; i < hashbytes.length; i++) {
	            // %02x 부분은 0 ~ f 값 까지는 한자리 수이므로 두자리 수로 보정하는 역할을 한다.
	            sbuilder.append(String.format("%02x", hashbytes[i] & 0xff));
	        }*/
//	            sbuilder.toString();
	 
			
			if( ! belowMaxFileSize( mFile.getSize()) ) {
				throw new Exception( "Error. " + strOrgFileName + " file size (" + mFile.getSize() + ") exceeds " + strFileUploadMaxSize + " limit.");
			}

			
			if (mFile.getSize() > 0) {
				// 설정한 path에 파일저장
				File serverFile = new File(WebUtil.filePathBlackList(strUPloadDirPath + SEPERATOR + strPhyFileName));
				
				if(strFileUploadPath.indexOf("sysMainImage") > -1) {
					serverFile = new File(WebUtil.filePathBlackList(strUPloadDirPath + SEPERATOR + setFileNameForSafe(strOrgFileName)));
				}
				
				mFile.transferTo(serverFile);
				
				dataMap.put("ATTACHMENT_SEQ", strPhyFileName);
				dataMap.put("REAL_FILE_NAME", strPhyFileName);	//서버에 저장되는 파일명
				//dataMap.put("FILE_EXT_NAME", getFileExtension(strOrgFileName));
				dataMap.put("FILE_PATH", strServerSubPath);
				dataMap.put("FILE_NAME", setFileNameForSafe(strOrgFileName));  //사용자 선택한 파일명
				dataMap.put("FILE_SIZE", mFile.getSize());
				dataMap.put("FILE_HASH", fileHash);
				
				resultList.add(dataMap);
			}

		}
	
		return resultList;
	}
	
	private static boolean isDRMExist() {
		boolean drmExist	= false;
		
		
		
		
		
		return drmExist;
	}
	
	public static String setFileNameForSafe(String fileName) {
		String safeFileName = fileName;
		
		safeFileName = safeFileName.replaceAll("\\;", "");
		safeFileName = safeFileName.replaceAll("\\%", "");
		safeFileName = safeFileName.replaceAll("\\?", "");
		
		return safeFileName;
	}
		
	
	public static HashMap<String,Object> copyFile(String appType,String srcFilePath, String srcFile, boolean migYn) throws Exception {
		HashMap<String,Object> responseData = new HashMap<>();
		
		String strAppType = appType;
		
		
		
    	String strSrcFilePath = FILE_BASE_PATH;
    	String strDesFilePath = FILE_BASE_PATH;
    	
    	String strSrcServerSubPath = strAppType + SEPERATOR + srcFilePath;
    	
    	if(strAppType == null || strAppType.equals("")) {
    		strSrcServerSubPath = srcFilePath;
    	}
    	
    	if(migYn) {
    		strSrcServerSubPath = srcFilePath;
    	}
    	
    	String strDesServerSubPath = getTodayString();
    	
    	String strDesServerSubPathReal = strAppType + SEPERATOR + strDesServerSubPath;
    	
		String strUPloadDirPath = WebUtil.filePathBlackList(strDesFilePath + SEPERATOR + strDesServerSubPathReal);
		
		// 디레토리가 없다면 생성
		File dir = new File(strUPloadDirPath);
		if (!dir.isDirectory()) {
			dir.mkdirs();
		}
				
		String targetFile = getPhysicalFileName();
		
		FileInputStream fis	= new FileInputStream(WebUtil.filePathBlackList(strSrcFilePath+SEPERATOR+strSrcServerSubPath+SEPERATOR+srcFile));
		FileOutputStream fos = new FileOutputStream(WebUtil.filePathBlackList(strDesFilePath+SEPERATOR+strDesServerSubPathReal+SEPERATOR+targetFile));
		
		int tmpRead = 0;
		while ((tmpRead=fis.read())!=-1) {
			fos.write(tmpRead);
		}
		fis.close();
		fos.close();
			
		responseData.put("FILE_PATH"		, strDesServerSubPath);
		responseData.put("ATTACHMENT_SEQ"	, targetFile);
		responseData.put("APP_TYPE"	, appType);
		
		return responseData;
	}

	public static HashMap<String,Object> copyFormFile(String srcFile) throws Exception {
		return copyFormFile("FORMS", srcFile);
	}
	
	public static HashMap<String,Object> copyFormFile(String srcFilePath, String srcFile) throws Exception {
		HashMap<String,Object> responseData = new HashMap<>();
		
    	String strFileUploadPath = FILE_BASE_PATH;
		
    	String strServerSubPath = getTodayString();
		String strUPloadDirPath = WebUtil.filePathBlackList(strFileUploadPath + SEPERATOR + strServerSubPath);
		
		// 디레토리가 없다면 생성
		File dir = new File(strUPloadDirPath);
		if (!dir.isDirectory()) {
			dir.mkdirs();
		}
				
		String targetFile = getPhysicalFileName();
		
		FileInputStream fis	= new FileInputStream(WebUtil.filePathBlackList(strFileUploadPath+SEPERATOR+srcFilePath+SEPERATOR+srcFile));
		FileOutputStream fos = new FileOutputStream(WebUtil.filePathBlackList(strFileUploadPath+SEPERATOR+strServerSubPath+SEPERATOR+targetFile));
		
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		byte[] dataBytes = new byte[1024];
		
		int tmpRead = 0;
		int fileSize = 0;
		
		while ((tmpRead=fis.read())!=-1) {
			fos.write(tmpRead);
			fileSize++;
			md.update(dataBytes, 0, tmpRead);
		}
				
		byte[] hashbytes = md.digest();
		// 보기 좋게 16진수로 만드는 작업
        StringBuilder sbuilder = new StringBuilder();
        for (int i = 0; i < hashbytes.length; i++) {
            // %02x 부분은 0 ~ f 값 까지는 한자리 수이므로 두자리 수로 보정하는 역할을 한다.
            sbuilder.append(String.format("%02x", hashbytes[i] & 0xff));
        }
		
		fis.close();
		fos.close();
			
		responseData.put("FILE_PATH"		, strServerSubPath);
		responseData.put("ATTACHMENT_SEQ"	, targetFile);
		responseData.put("FILE_SIZE"		, fileSize);
		responseData.put("FILE_HASH"		, sbuilder.toString());
		
		return responseData;
	}
	
	public static void downloadFile(HttpServletResponse response, List<Map<String, Object>> mapFiles) throws Exception {
		downloadFileZip(response, mapFiles);
	}
	
	public static void downloadFile(HttpServletResponse response, Map<String, Object> mapFile) throws Exception {
		//MIGRATION EPRO 파일
		String strFilePath = FILE_BASE_PATH.concat(SEPERATOR)
				                           .concat(StringUtil.isEmpty(mapFile.get("APP_TYPE")) ? "" : String.valueOf(mapFile.get("APP_TYPE")).concat(SEPERATOR))
				                           .concat(mapFile.get("FILE_PATH").toString());
		logger.debug("파일경로:" + strFilePath);
		downloadFile(response, strFilePath, mapFile.get("REAL_FILE_NAME").toString(), mapFile.get("FILE_NAME").toString());
	}
	

	public static void imageFile(HttpServletResponse response, Map<String, Object> mapFile) throws Exception {
		String strFilePath = FILE_BASE_PATH.concat(SEPERATOR).concat(mapFile.get("FILE_PATH").toString());
		logger.debug("파일경로:" + strFilePath);
		imageFile(response, strFilePath, mapFile.get("REAL_FILE_NAME").toString(), mapFile.get("FILE_NAME").toString());
	}

	
	/**
	 * 이미지 파일을 View 처리한다.
	 *
	 * @param response
	 * @param where
	 * @param serverSubPath
	 * @param physicalName
	 * @param original
	 * @throws Exception
	 */
	public static void imageFile(HttpServletResponse response, String serverFilePath, String physicalName, String original) throws Exception {
		String downFileName = serverFilePath + SEPERATOR + physicalName;

		File file = new File(WebUtil.filePathBlackList(downFileName));

		if (!file.exists()) {
			throw new FileNotFoundException(downFileName);
		}

		if (!file.isFile()) {
			throw new FileNotFoundException(downFileName);
		}

		byte[] b = new byte[BUFFER_SIZE];

		original = original.replaceAll("\r", "").replaceAll("\n", "");
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Disposition", "inline; filename=\"" + convert(original) + "\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Expires", "0");

		BufferedInputStream fin = null;
		BufferedOutputStream outs = null;

		try {
			fin = new BufferedInputStream(new FileInputStream(file));
			outs = new BufferedOutputStream(response.getOutputStream());

			int read = 0;

			while ((read = fin.read(b)) != -1) {
				outs.write(b, 0, read);
			}
		} finally {
			try {
				outs.close();
			} catch (Exception ignore) {
				logger.warn("Occurred Exception to close resource is ingored!!");
			}
			
			try {
				fin.close();
			} catch (Exception ignore) {
				logger.warn("Occurred Exception to close resource is ingored!!");
			}
		}
	}

	
	
	/**
	 * 파일을 Download 처리한다.
	 *
	 * @param response
	 * @param where
	 * @param serverSubPath
	 * @param physicalName
	 * @param original
	 * @throws Exception
	 */
	public static void downloadFile(HttpServletResponse response, String serverFilePath, String physicalName, String original) throws Exception {
		String downFileName = serverFilePath + SEPERATOR + physicalName;
		logger.debug("다운로드파일명: " + downFileName);
		File file = new File(WebUtil.filePathBlackList(downFileName));

		if (!file.exists()) {
			throw new FileNotFoundException(downFileName);
		}

		if (!file.isFile()) {
			throw new FileNotFoundException(downFileName);
		}

		byte[] b = new byte[BUFFER_SIZE];

		original = original.replaceAll("\r", "").replaceAll("\n", "");
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Disposition", "attachment; filename=\"" + convert(original) + "\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Expires", "0");

		BufferedInputStream fin = null;
		BufferedOutputStream outs = null;

		try {
			fin = new BufferedInputStream(new FileInputStream(file));
			outs = new BufferedOutputStream(response.getOutputStream());

			int read = 0;

			while ((read = fin.read(b)) != -1) {
				outs.write(b, 0, read);
			}
		} finally {
			try {
				outs.close();
			} catch (Exception ignore) {
				logger.warn("Occurred Exception to close resource is ingored!!");
			}
			
			try {
				fin.close();
			} catch (Exception ignore) {
				logger.warn("Occurred Exception to close resource is ingored!!");
			}
		}
	}
	/**
	 * 파일을 Download 처리한다.
	 * 
	 * @param response
	 * @param where
	 * @param serverSubPath 파일명까지 포함한 풀경로임(EPRO 마이그레이션 파일)
	 * @param original
	 * @throws Exception
	 */
	public static void downloadFile(HttpServletResponse response, String serverFilePath, String original) throws Exception {
		String downFileName = serverFilePath;
		logger.debug("다운로드파일명: " + downFileName);
		File file = new File(WebUtil.filePathBlackList(downFileName));

		if (!file.exists()) {
			throw new FileNotFoundException(downFileName);
		}

		if (!file.isFile()) {
			throw new FileNotFoundException(downFileName);
		}

		byte[] b = new byte[BUFFER_SIZE];

		original = original.replaceAll("\r", "").replaceAll("\n", "");
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Disposition", "attachment; filename=\"" + convert(original) + "\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Expires", "0");

		BufferedInputStream fin = null;
		BufferedOutputStream outs = null;

		try {
			fin = new BufferedInputStream(new FileInputStream(file));
			outs = new BufferedOutputStream(response.getOutputStream());

			int read = 0;

			while ((read = fin.read(b)) != -1) {
				outs.write(b, 0, read);
			}
		} finally {
			try {
				outs.close();
			} catch (Exception ignore) {
				logger.warn("Occurred Exception to close resource is ingored!!");
			}
			
			try {
				fin.close();
			} catch (Exception ignore) {
				logger.warn("Occurred Exception to close resource is ingored!!");
			}
		}
	}

	
	public static void downloadFileZip(HttpServletResponse response, List<Map<String, Object>> mapFiles) throws Exception {
		String downFileName = "";
		String uploadPath = FILE_BASE_PATH;
		byte[] b = new byte[BUFFER_SIZE];
		
		File f ;
		
		downFileName = mapFiles.get(0).get("FILE_NAME").toString().concat("_외_").concat(String.valueOf(mapFiles.size() - 1)).concat("건.zip");
		
		List<File> dFiles = new ArrayList();
        List<String> originalFilenames = new ArrayList();
        for (Map<String, Object> file : mapFiles) {
            String fileSavePath = file.get("FILE_PATH").toString();
            fileSavePath = uploadPath.concat(SEPERATOR).concat(fileSavePath);
            String srvFileName = file.get("REAL_FILE_NAME").toString();
            String orgFileName = file.get("FILE_NAME").toString();
            f = new File(fileSavePath, srvFileName);
            if (f.exists()) {
                dFiles.add(f);
                originalFilenames.add(orgFileName);
            } else {
                throw new Exception("파일이 존재하지 않습니다.");
            }
        }
        
        response.setContentType("application/octet-stream; charset=UTF-8");
		response.setHeader("Content-Disposition", "attachment; filename=\"" + convert(downFileName) + "\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Expires", "0");
		if (0 < dFiles.size()) {
            try (ZipOutputStream zos = new ZipOutputStream(response.getOutputStream(), Charset.forName("UTF-8"))) {
                int size = UnZip.zipEntry(dFiles, originalFilenames, zos);
                response.setContentLength(size);
                zos.flush();
                zos.close();
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();
        }
				
	}

	public static List<Map<String,Object>> convertForFileView(List<Map<String,Object>> fileList) throws Exception {
		List<Map<String,Object>> convertedFileList = new ArrayList<Map<String,Object>>();
		for (Map<String, Object> fileMap:fileList) {
			convertedFileList.add(convertForFileView(fileMap));
		}
		
		return convertedFileList;
	}
	
	public static boolean deleteFile(Map<String,Object> fileMap) throws Exception {
		String strFilePath = FILE_BASE_PATH.concat(SEPERATOR).concat(StringUtil.isEmpty(fileMap.get("APP_TYPE")) ? "" : String.valueOf(fileMap.get("APP_TYPE")).concat(SEPERATOR)).concat(fileMap.get("FILE_PATH").toString());
		new File(strFilePath.concat(SEPERATOR).concat(fileMap.get("REAL_FILE_NAME").toString())).delete();
        return true;
	}
	
	public static boolean deleteFile(List<Map<String,Object>> fileList) throws Exception {
		for(Map<String,Object> file:fileList) {
			deleteFile(file);
		}
		return true;
	}
	
	public static Map<String, Object> convertForFileView(Map<String,Object> fileMap) throws Exception {
		fileMap.put("name"			, fileMap.get("FILE_NAME"));
		fileMap.put("size"			, fileMap.get("FILE_SIZE"));
		fileMap.put("url"			, "download.do".concat("?APP_SEQ=").concat(fileMap.get("APP_SEQ").toString()).concat("&ATTACHMENT_SEQ=").concat(fileMap.get("ATTACHMENT_SEQ").toString()));
		fileMap.put("thumbnailUrl"	, "");
		//fileMap.put("deleteUrl"		, fileMap.get("url"));
		fileMap.put("deleteUrl"		, "delete.do".concat("?APP_SEQ=").concat(fileMap.get("APP_SEQ").toString()).concat("&ATTACHMENT_SEQ=").concat(fileMap.get("ATTACHMENT_SEQ").toString()));
		fileMap.put("deleteType"	, "GET");
		fileMap.put("inputDt"		, fileMap.get("REG_DATE"));
		fileMap.put("REG_ID"		, fileMap.get("REG_ID"));
		
		fileMap.put("appSeq"		, fileMap.get("APP_SEQ").toString());
		fileMap.put("attachmentSeq"	, fileMap.get("ATTACHMENT_SEQ").toString());
		
		return fileMap;
	}
	
    public static String getFileExtension(String filename) {
        int pos = filename.lastIndexOf(".");
        if (-1 == pos) return "";
        return filename.substring(pos + 1);
    }

    public static String encodeFilenameForDownload(String filename) throws UnsupportedEncodingException {
        String encfname = java.net.URLEncoder.encode(filename, "UTF-8");
        return encfname.replaceAll("%28", "(").replaceAll("%29", ")").replaceAll("\\+", " ");
    }
    
	public static boolean isDirectory(String dirName) {
		return new File(dirName).isDirectory();
	}

	public static boolean isFile(String dirName, String fileName) {
		return new File(dirName).isFile();
	}

	public static boolean deleteFile(String dirName, String fileName) {
		return new File(dirName + fileName).delete();
	}

	private static byte[] appendByte(byte[] obyte, byte[] dbyte, int dlen) {
		byte[] nbyte = null;
		if (obyte == null) {
			nbyte = new byte[dlen];
			System.arraycopy(dbyte, 0, nbyte, 0, dlen);
			return nbyte;
		}

		int olen = obyte.length;
		int nlen = olen + dlen;
		nbyte = new byte[nlen];
		System.arraycopy(obyte, 0, nbyte, 0, olen);
		System.arraycopy(dbyte, 0, nbyte, olen, dlen);

		return nbyte;
	}

	public static void deleteFile(String filename) throws FileNotFoundException, IOException {
		File f = new File(filename);
		if (f.exists())
			f.delete();
	}

	public static boolean fileExists(String filename) {
		return new File(filename).exists();
	}

	public static boolean fileExists(String dir, String filename) {
		return new File(dir, filename).exists();
	}

	public static byte[] readBytes(InputStream is) throws IOException {
		byte[] nbyte = null;

		BufferedInputStream bis = new BufferedInputStream(is);
		byte[] temp = new byte[1024];
		int capacity = 0;
		while ((capacity = bis.read(temp)) != -1) {
			nbyte = appendByte(nbyte, temp, capacity);
		}

		bis.close();
		bis = null;

		return nbyte;
	}

	public static byte[] readBytes(String filename) throws FileNotFoundException, IOException {
		byte[] nbyte = null;

		FileInputStream fis = new FileInputStream(new File(filename));
		byte[] temp = new byte[1024];
		int capacity = 0;
		while ((capacity = fis.read(temp)) != -1) {
			nbyte = appendByte(nbyte, temp, capacity);
		}

		fis.close();
		fis = null;

		return ((nbyte == null) ? new byte[0] : nbyte);
	}

	public static String readString(InputStream is) throws IOException {
		return new String(readBytes(is));
	}

	public static String readString(String filename) throws FileNotFoundException, IOException {
		return new String(readBytes(filename));
	}

	public static void write(byte[] bytes, String filename) throws FileNotFoundException, IOException {
		FileOutputStream fos = new FileOutputStream(filename, true);
		fos.write(bytes);
		fos.flush();
		fos.close();
		fos = null;
	}

	public static void write(byte[] bytes, String dir, String filename) throws FileNotFoundException, IOException {
		FileOutputStream fos = new FileOutputStream(new File(dir, filename));
		fos.write(bytes);
		fos.flush();
		fos.close();
		fos = null;
	}
	

	public static int getByteArrayLength(byte[] b) {
		if (b != null)
			return b.length;
		return 0;
	}

	public static File[] getFileList(String dir) {
		File fDir = new File(dir.trim());
		if ((fDir.exists()) && (fDir.isDirectory())) {
			return fDir.listFiles();
		}
		return null;
	}

	public static void addAllFiles(File dir, List list, boolean recursive, FilenameFilter filter) {
		File[] files = dir.listFiles(filter);

		for (int i = 0; i < files.length; ++i) {
			File f = files[i];

			if (f.isDirectory()) {
				if (recursive)
					addAllFiles(f, list, recursive, filter);
			} else
				list.add(f);
		}
	}


	public static boolean createDirectory(String pathName) throws IOException {
		File file = new File(pathName);
		if (!(file.exists())) {
			return file.mkdirs();
		}

		return false;
	}

	public static String getParentPath(String filePath) throws IOException {
		return new File(filePath).getParent();
	}

	public static void deleteDir(File file) {
		if (file.isDirectory()) {
			File[] files = file.listFiles();

			for (int i = 0; i < files.length; ++i) {
				File f = files[i];
				deleteDir(f);
			}
		}
		file.delete();
	}

	public static void copyDir(File ofile, File dfile) {
		if (ofile.isDirectory()) {
			dfile.mkdir();
			File[] files = ofile.listFiles();

			for (int i = 0; i < files.length; ++i) {
				File f = files[i];
				copyDir(f, new File(dfile, f.getName()));
			}
		} else {
			copyFile(ofile, dfile);
		}
	}

	public static void copyFile(File ofile, File dfile) {
		BufferedInputStream bis = null;
		BufferedOutputStream bos = null;
		byte[] buffer = new byte[8192];
		try {
			bis = new BufferedInputStream(new FileInputStream(ofile));
			bos = new BufferedOutputStream(new FileOutputStream(dfile));

			int readLength = -1;
			while (true) {
				readLength = bis.read(buffer);
				if (readLength == -1)
					break;
				bos.write(buffer, 0, readLength);
			}
		} catch (Exception e) {
		} finally {
			try {
				if (bis != null)
					bis.close();
			} catch (Exception e) {
			}
			try {
				if (bos != null)
					bos.close();
			} catch (Exception e) {
			}
		}
	}

	public static String readString(String filePath, String charset) throws IOException {
		if ((charset == null) || ("".equals(charset)) || ("null".equals(charset))) {
			charset = "UTF-8";
		}
		StringBuffer sb = new StringBuffer();
		String str = null;
		BufferedReader in = null;
		InputStreamReader isr = null;
		FileInputStream fis = null;
		try {
			fis = new FileInputStream(filePath);
			isr = new InputStreamReader(fis, charset);
			in = new BufferedReader(isr);
			if ((str = in.readLine()) != null) {
				sb.append(str);
			}
			while ((str = in.readLine()) != null)
				sb.append('\n').append(str);
		} finally {
			try {
				in.close();
			} catch (Exception e) {
			}
			try {
				isr.close();
			} catch (Exception e) {
			}
			try {
				fis.close();
			} catch (Exception e) {
			}
		}
		return sb.toString();
	}    
	
    /**
     * 파일을 읽어 내용을 byte 배열로 반환하는 메서드
     * 
     * @param filepath
     * @return byte 배열 타입의 파일 내용
     * @throws IOException
     */
    public byte[] getFileContents(String filepath) throws IOException {
        BufferedInputStream bistream = new BufferedInputStream(
                new FileInputStream(filepath));
 
        byte[] contents = new byte[bistream.available()];
 
        bistream.close();
 
        return contents;
    }
    
    /**
     * 파일의 변경 여부를 판단하는 메서드
     * 
     * @param file
     *            내용의 변경여부를 확인할 파일
     * @return 수정된 경우 true 반환 
 
     *         보존된 경우 false 반환
     * @throws IOException
     * @throws NoSuchAlgorithmException
     */
    public boolean isModified(String filepath) throws NoSuchAlgorithmException,
            IOException {
        File file = new File(filepath);
 
        String filename = file.getName();
        // 확장자 제거
        if (filename.contains("."))
            filename = filename.substring(0, filename.indexOf("."));
 
        String hashcode = getHashcode(getFileContents(filepath));
 
        return !filename.equals(hashcode);
    }
 
    
    /**
     * byte 배열로부터 SHA-256를 이용해 해시된 값을 얻는 메서드
     * 
     * @param message
     *            해시코드를 생성할 byte 배열
     * @return message의 해시된 값으로 16진수 표현의 String으로 반환된다.
     * @throws NoSuchAlgorithmException
     *             getInstance메서드의 인자 전달한 암호화 암고리즘이 존재하지 않을 때 발생
     */
    public String getHashcode(byte[] message) throws NoSuchAlgorithmException {
        // SHA를 사용하기 위해 MessageDigest 클래스로부터 인스턴스를 얻는다.
        MessageDigest md = MessageDigest.getInstance("SHA-256");
 
        // 해싱할 byte배열을 넘겨준다.
        // SHA-256의 경우 메시지로 전달할 수 있는 최대 bit 수는 2^64-1개 이다.
        md.update(message);
 
        // 해싱된 byte 배열을 digest메서드의 반환값을 통해 얻는다.
        byte[] hashbytes = md.digest();
 
        // 보기 좋게 16진수로 만드는 작업
        StringBuilder sbuilder = new StringBuilder();
        for (int i = 0; i < hashbytes.length; i++) {
            // %02x 부분은 0 ~ f 값 까지는 한자리 수이므로 두자리 수로 보정하는 역할을 한다.
            sbuilder.append(String.format("%02x", hashbytes[i] & 0xff));
        }
 
        return sbuilder.toString();
    }
 


	
}

