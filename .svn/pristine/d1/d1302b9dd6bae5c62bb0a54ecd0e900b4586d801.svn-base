package com.app.ildong.common.util;


import java.io.IOException;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.ObjectUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;

public class ExcelUtil {
	
	private String[] excelHeader; //= {};
	private String[] columnKey;
	private String[] dataType;
	private String[] dataFormat;
	
	private ServletOutputStream out;
	private int rowCnt = 0;
	private int pageSize = 10000;
	private SXSSFWorkbook workbook;
	private int totalCnt = 0;
	private Sheet sheet;
	private Row headerRow;
	private List<Map<String,Object>> dataList;
	private Map<String,Object> partData;
	
	
	Map<Integer,Integer> sizeMap = new HashMap<Integer,Integer>();
		
	public ExcelUtil(){
		this.workbook = new SXSSFWorkbook(this.pageSize);
	}
	
	public ExcelUtil(int pageSize){
		this.workbook = new SXSSFWorkbook(pageSize);
	}
	
	public void setHeader(String[] header){
		this.excelHeader = header;
	}
	
	public void setCoulumn(String[] column){
		this.columnKey = column;
	}
	
	public void setHeaderData(String[][] headerData) {
		
		this.excelHeader = headerData[0];
		this.columnKey = headerData[1];
	}
	
	public void setFormatData(String[][] headerData) {
		this.dataType = headerData[2];
	}
	
	
	public void setRowNumber(int rowCnt){
		this.rowCnt = rowCnt;
	}
	
	public void setTotalCnt(int totalCnt){
		this.totalCnt = totalCnt;		
	}
	
	public void createSheet(){
		sheet = this.workbook.createSheet();
	}
	
	@SuppressWarnings("deprecation")
	public void createWorkSheetHeader(int rowCnt){
		 
		XSSFColor grey =new XSSFColor(new java.awt.Color(192,192,192));
		
		XSSFCellStyle style = (XSSFCellStyle) workbook.createCellStyle();
		
		style.setAlignment(HorizontalAlignment.CENTER);		//헤더 가운데 정렬
		
		style.setFillForegroundColor(grey);					//헤더 색 채우기 
		style.setFillPattern(CellStyle.SOLID_FOREGROUND);

		setRowNumber(rowCnt);
		
		headerRow = sheet.createRow(this.rowCnt++);
		
		for (int j=0;j<excelHeader.length;j++) {
			Cell headerCell = headerRow.createCell(j);
			headerCell.setCellValue(excelHeader[j]);
			headerCell.setCellStyle(style);
			
			String str = excelHeader[j];
			int columnSize = 0;
			for (int i = 0; i < str.length(); i++) {
			      String strValue = Character.toString(str.charAt(i)) ;
			      if(Pattern.matches("[가-힣]", strValue)){		//한글일경우 +2
			    	  columnSize = columnSize + 2;
			      }else{										//한글아닐경우 +1
			    	  columnSize = columnSize + 1;
			      }
			}
			
			sizeMap.put(j, columnSize);							// *번째 컬럼에 컬럼사이즈 설정
			sheet.setColumnWidth(j, (columnSize +3) * 256);
		}
	}
	
	public void setExcelDataList(List<Map<String,Object>> dataList){
		this.dataList = dataList;
		
		for (Map<String,Object> itemMap : dataList) {

			Row bodyRow = sheet.createRow(this.rowCnt++);
			
			for (int c=0;c<columnKey.length;c++) {
				Cell cell = bodyRow.createCell(c);
				
				//if (itemMap.get(columnKey[c]) instanceof BigDecimal) {
				if (itemMap.get(columnKey[c]) instanceof BigDecimal || itemMap.get(columnKey[c]) instanceof BigInteger || itemMap.get(columnKey[c]) instanceof Long) {
					cell.setCellValue(Double.parseDouble(ObjectUtils.toString(itemMap.get(columnKey[c]), "")));
					
					sheet.setColumnWidth(c, ((itemMap.get(columnKey[c])).toString().length()+3) * 256);
					
				} else {
					cell.setCellValue( ObjectUtils.toString(itemMap.get(columnKey[c]), "") );
					
					if(itemMap.get(columnKey[c]) != null ){
						
						int columnSize = 0;
						
						String str = (itemMap.get(columnKey[c])).toString();
						for (int i = 0; i < str.length(); i++) {
						      String strValue = Character.toString(str.charAt(i)) ;
						      if(Pattern.matches("[가-힣]", strValue)){		//한글일경우 +2
						    	  columnSize = columnSize + 2;
						      }else{										//한글아닐경우 +1
						    	  columnSize = columnSize + 1;
						      }
						}
						
						if(sizeMap.get(c) < columnSize){					//이전 사이즈 보다 현재 사이즈가 더 클경우 컬럼 사이즈 조절 (이전사이즈는 헤더에서 설정)
							if(columnSize > 40){							//최대 사이즈가 40(글자수)보다 클경우 40으로 제한
								columnSize = 40;
							}
							
							sizeMap.put(c, columnSize);
							sheet.setColumnWidth(c, (columnSize +3) * 256);
						}
					}
				}
			}
		}
		
	}
	
	public void setExcelDataListWithFormat(List<Map<String,Object>> dataList){
		this.dataList = dataList;
		
		for (Map<String,Object> itemMap : dataList) {

			Row bodyRow = sheet.createRow(this.rowCnt++);
			
			for (int c=0;c<columnKey.length;c++) {
				Cell cell = bodyRow.createCell(c);
				
				//if (itemMap.get(columnKey[c]) instanceof BigDecimal) {
				if (itemMap.get(columnKey[c]) instanceof BigDecimal || itemMap.get(columnKey[c]) instanceof BigInteger || itemMap.get(columnKey[c]) instanceof Long) {
					
					CellStyle cellStyle = workbook.createCellStyle();

					if(dataType[c].equals("currency")) {
					
						DataFormat cellFormat = workbook.createDataFormat();
						cellStyle.setDataFormat(cellFormat.getFormat("#,##0"));
					
					}
					
					cell.setCellValue(Double.parseDouble(ObjectUtils.toString(itemMap.get(columnKey[c]), "")));
					cell.setCellStyle(cellStyle);
					
					sheet.setColumnWidth(c, ((itemMap.get(columnKey[c])).toString().length()+3) * 256);
					
				} else {
					
					String cellVal = ObjectUtils.toString(itemMap.get(columnKey[c]), "");
					
					if(cellVal != null && !cellVal.trim().equals("")) {
						if(dataType[c].equals("currency")) {
							DecimalFormat formatter = new DecimalFormat("###,###");
							
							try {
								cellVal = formatter.format(Long.parseLong(cellVal));
							} catch (Exception e) {
								e.printStackTrace();
							}
							
						}else if(dataType[c].equals("datetime")) {
							SimpleDateFormat orgFormatter = new SimpleDateFormat("yyyyMMdd");
							SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
							
							try {
								cellVal = formatter.format(orgFormatter.parse(cellVal));
							} catch (Exception e) {
								e.printStackTrace();
							}
							
						}
					}
					cell.setCellValue(cellVal);
					
					if(itemMap.get(columnKey[c]) != null ){
						
						int columnSize = 0;
						
						String str = (itemMap.get(columnKey[c])).toString();
						for (int i = 0; i < str.length(); i++) {
						      String strValue = Character.toString(str.charAt(i)) ;
						      if(Pattern.matches("[가-힣]", strValue)){		//한글일경우 +2
						    	  columnSize = columnSize + 2;
						      }else{										//한글아닐경우 +1
						    	  columnSize = columnSize + 1;
						      }
						}
						
						if(sizeMap.get(c) < columnSize){					//이전 사이즈 보다 현재 사이즈가 더 클경우 컬럼 사이즈 조절 (이전사이즈는 헤더에서 설정)
							if(columnSize > 40){							//최대 사이즈가 40(글자수)보다 클경우 40으로 제한
								columnSize = 40;
							}
							
							sizeMap.put(c, columnSize);
							sheet.setColumnWidth(c, (columnSize +3) * 256);
						}
					}
				}
			}
		}
		
	}
	
	public void writeWorkbook(ServletOutputStream stream) throws IOException{
		this.workbook.write(stream);
		closeWorkbook();
		
	}
	
	public void writeWorkbook(HttpServletRequest request, HttpServletResponse response, String fileName) throws IOException{
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Content-Disposition","attachment; filename=\"" + URLEncoder.encode(fileName, "UTF-8") + ".xlsx\"");
		//response.setContentType("application/vnd.ms-excel");
		response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
		 
		ServletOutputStream out = response.getOutputStream();
		
		try {

			this.workbook.write(out);
			closeWorkbook();
		} catch( Exception e) {
			throw e;
		} finally {
			if( out != null ) {
		        try {
		        	out.close();
		        } catch (Exception fex) {
		        }
			}
	    }
		
	}
	
	public void closeWorkbook() throws IOException{
		
		if( this.workbook != null ) {
			this.workbook.close();
		}
	}
	
	
	public ServletOutputStream getOuputStream(HttpServletResponse response) throws IOException{
		out = response.getOutputStream();
		return out;
	}
	
	public void excelDownload(){
		
	}
	 
}

