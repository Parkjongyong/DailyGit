package com.app.ildong.common.xss;

//import java.util.regex.Pattern;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.util.HtmlUtils;



public class XSSRequestWrapper extends HttpServletRequestWrapper {

	protected final Log logger = LogFactory.getLog(getClass());
	
	/*
  private static Pattern[] patterns = new Pattern[]{
      // Script fragments
      Pattern.compile("<script>(.*?)</script>", Pattern.CASE_INSENSITIVE),
      // src='...'
      Pattern.compile("src[\r\n]*=[\r\n]*\\\'(.*?)\\\'", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
      Pattern.compile("src[\r\n]*=[\r\n]*\\\"(.*?)\\\"", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
      // lonely script tags
      Pattern.compile("</script>", Pattern.CASE_INSENSITIVE),
      Pattern.compile("<script(.*?)>", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
      // eval(...)
      Pattern.compile("eval\\((.*?)\\)", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
      // expression(...)
      Pattern.compile("expression\\((.*?)\\)", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
      // javascript:...
      Pattern.compile("javascript:", Pattern.CASE_INSENSITIVE),
      // vbscript:...
      Pattern.compile("vbscript:", Pattern.CASE_INSENSITIVE),
      // onload(...)=...
      Pattern.compile("onload(.*?)=", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL)
  };
	*/

  public XSSRequestWrapper(HttpServletRequest servletRequest) {
      super(servletRequest);
  }

  @Override
  public String[] getParameterValues(String parameter) {
      String[] values = super.getParameterValues(parameter);

      if (values == null) {
          return null;
      }

      int count = values.length;
      String[] encodedValues = new String[count];
      for (int i = 0; i < count; i++) {
          encodedValues[i] = cleanXSS(values[i]);
      }

      return encodedValues;
  }

  @Override
  public String getParameter(String parameter) {
      String value = super.getParameter(parameter);
      if (value == null) {
			return null;
		}
      return cleanXSS(value);
  }

  @Override
  public String getHeader(String name) {
      String value = super.getHeader(name);
      
      if (value == null)
			return null;
      
      return cleanXSS(value);
  }
	
	private String cleanXSS(String orgValue) {
  	
  	String value = orgValue;
      if (value != null ) {
          value = HtmlUtils.htmlEscape(value);

      }
      return value;
  }	
}