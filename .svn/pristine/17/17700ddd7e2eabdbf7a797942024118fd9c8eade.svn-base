<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.app.ildong.common.util.PropertiesUtil" %>
<% 
	out.clear();

    java.util.Calendar cal = java.util.Calendar.getInstance();

    String year = Integer.toString (cal.get ( cal.YEAR )); 
    String month = Integer.toString(cal.get ( cal.MONTH ) + 1);
	
	String strFileName = request.getParameter("fileName");
	
	String strFilePath = PropertiesUtil.getProperty("DEXT.FILE.UPLOAD.PATH") + year + "/" + month + "/" + strFileName;
	long lFileLength = 0;
	
	java.io.FileInputStream fis = null;
	
	try {
    	if (strFilePath != null && !strFilePath.equals("") && new java.io.File(strFilePath).exists()) {
    		java.io.InputStream is = null;
    		java.io.OutputStream os = null;
    		
    		java.io.File file = new java.io.File(strFilePath);
   			lFileLength = file.length();
   			fis = new java.io.FileInputStream(file);
   			is = fis;
   			
   			String strFileExt = getFileExtension(strFileName);
   			
	        String strMimiType = "";
	        if(strFileExt.equals("jpeg")) {
	        	strMimiType = "image/jpeg";
	    	} else if(strFileExt.equals("jpg")) {
	    		strMimiType = "image/jpeg";
	    	} else if(strFileExt.equals("png")) {
	    		strMimiType = "image/png";
	    	}  else if(strFileExt.equals("bmp")) {
	    		strMimiType = "image/bmp";
	    	} else if(strFileExt.equals("gif")) {
	    		strMimiType = "image/gif";
	    	} else if(strFileExt.equals("tif")) {
	    		strMimiType = "image/tiff";
	    	} else if(strFileExt.equals("tiff")) {
	    		strMimiType = "image/tiff";
	    	}
	        
	        response.setContentType(strMimiType);
	        response.addHeader("Accept-Ranges", "bytes");
	        response.addHeader("Content-Length", Long.toString(lFileLength));
	        
	        try {
	        	os = response.getOutputStream();
	        	
	    		byte[] buffer = new byte[1024 * 512];
				int iBufferLength = 1024 * 512;
				
				int iReadBytes = 0;
				long lReadTotalBytes = 0;
				while(true) {
	    			if((lFileLength - lReadTotalBytes) < iBufferLength) {
	    				iBufferLength = (int) (lFileLength - lReadTotalBytes);
	    			}
					
	    			if(iBufferLength == 0 || (iReadBytes = is.read(buffer, 0, iBufferLength)) == -1) break;
					
	    			lReadTotalBytes += iReadBytes;
	    			
					os.write(buffer, 0, iReadBytes);
				}
	        } catch(Exception ex) {
	        	
	        } finally {
	        	os.close();
	        	is.close();
	        }
    	}
    } finally {
    	if(fis != null) fis.close();
    }
%><%!
public static String getFileExtension(String pFileName) {
	String strFileExtension = "";
	int iExtensionGubun = pFileName.lastIndexOf(".");
    if(iExtensionGubun > -1) {
    	strFileExtension = pFileName.substring(iExtensionGubun + 1);
    }
    return strFileExtension;
}
%>