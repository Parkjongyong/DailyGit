package com.app.ildong.common.util;

import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;

public abstract class WebUtil {

    public static String clearXSSMinimum(String value) {
        if (value == null || value.trim().equals("")) {
            return "";
        }

        String returnValue = value;

        returnValue = returnValue.replaceAll("&", "&amp;");
        returnValue = returnValue.replaceAll("<", "&lt;");
        returnValue = returnValue.replaceAll(">", "&gt;");
        returnValue = returnValue.replaceAll("\"", "&#34;");
        returnValue = returnValue.replaceAll("\'", "&#39;");
        return returnValue;
    }

    public static String clearXSSMaximum(String value) {
        String returnValue = value;
        returnValue = clearXSSMinimum(returnValue);

        returnValue = returnValue.replaceAll("%00", null);

        returnValue = returnValue.replaceAll("%", "&#37;");

        // \\. => .

        returnValue = returnValue.replaceAll("\\.\\./", ""); // ../
        returnValue = returnValue.replaceAll("\\.\\.\\\\", ""); // ..\
        returnValue = returnValue.replaceAll("\\./", ""); // ./
        returnValue = returnValue.replaceAll("%2F", "");

        return returnValue;
    }

    public static String filePathBlackList(String value) {
        String returnValue = value;
        if (returnValue == null || returnValue.trim().equals("")) {
            return "";
        }

        returnValue = returnValue.replaceAll("\\.\\./", ""); // ../
        returnValue = returnValue.replaceAll("\\.\\.\\\\", ""); // ..\

        return returnValue;
    }

    /**
     * 행안부 보안취약점 점검 조치 방안.
     *
     * @param value
     * @return
     */
    public static String filePathReplaceAll(String value) {
        String returnValue = value;
        if (returnValue == null || returnValue.trim().equals("")) {
            return "";
        }

        returnValue = returnValue.replaceAll("/", "");
        returnValue = returnValue.replaceAll("\\", "");
        returnValue = returnValue.replaceAll("\\.\\.", ""); // ..
        returnValue = returnValue.replaceAll("&", "");

        return returnValue;
    }

    public static String filePathWhiteList(String value) {
        return value; // TODO
    }

    public static boolean isIPAddress(String str) {
        Pattern ipPattern = Pattern.compile("\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}");

        return ipPattern.matcher(str).matches();
    }

    public static String removeCRLF(String parameter) {
        return parameter.replaceAll("\r", "").replaceAll("\n", "");
    }

    public static String removeSQLInjectionRisk(String parameter) {
        return parameter.replaceAll("\\p{Space}", "").replaceAll("\\*", "").replaceAll("%", "").replaceAll(";", "").replaceAll("-", "").replaceAll("\\+", "").replaceAll(",", "");
    }

    public static String removeOSCmdRisk(String parameter) {
        return parameter.replaceAll("\\p{Space}", "").replaceAll("\\*", "").replaceAll("|", "").replaceAll(";", "");
    }

    
    
    /**
     * 클라이언트(Client)의 IP주소를 구한다.
     * @param request
     * @return
     */
	public static String getClientIP( HttpServletRequest request){
        
        String ip = request.getHeader("X-Forwarded-For");
        
        if( StringUtils.isEmpty(ip) || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        
        if(StringUtils.isEmpty(ip) || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        
        if(StringUtils.isEmpty(ip) || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_CLIENT_IP");
        }
        
        if(StringUtils.isEmpty(ip) || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        
        if(StringUtils.isEmpty(ip) || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
     
        return ip;
    }
    
}