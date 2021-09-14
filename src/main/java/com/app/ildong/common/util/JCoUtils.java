package com.app.ildong.common.util;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.sap.conn.jco.JCoField;
import com.sap.conn.jco.JCoFieldIterator;
import com.sap.conn.jco.JCoFunction;
import com.sap.conn.jco.JCoMetaData;
import com.sap.conn.jco.JCoParameterFieldIterator;
import com.sap.conn.jco.JCoParameterList;
import com.sap.conn.jco.JCoRecordMetaData;
import com.sap.conn.jco.JCoStructure;
import com.sap.conn.jco.JCoTable;

public class JCoUtils {

	private static final Logger logger = LoggerFactory.getLogger(JCoUtils.class);
	
	/**
     * SimpleDateFormat
     */
    private static SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");

    
    /**
     * convertImportParameterListToDataSet
     * 
     * @param function
     * @return
     */
    public static Map<String,Object> convertImportParameterListToListMap(JCoFunction function) {

    	Map<String,Object> mapData = JCoUtils.convertParameterListToListMap(function, function.getImportParameterList());
        return mapData;
    }
    
    /**
     * convertExportParameterListToDataSet
     * 
     * @param function
     * @return
     */
    public static Map<String,Object> convertExportParameterListToListMap(JCoFunction function) {

    	Map<String,Object> mapData = JCoUtils.convertParameterListToListMap(function, function.getExportParameterList());
        return mapData;
    }

    /**
     * convertParameterListToDataSet
     * 
     * @param function
     * @param parameterList
     * @return
     */
    public static Map<String,Object> convertParameterListToListMap(JCoFunction function, JCoParameterList parameterList) {

        Map<String,Object> mapData = new HashMap<>();;

        JCoFieldIterator jCoFieldIterator = null;

        JCoParameterList tableParameterList = null;

        JCoParameterFieldIterator tableParameterIterator = null;

        try {

            if (parameterList != null) {
                jCoFieldIterator = parameterList.getFieldIterator();

                if (jCoFieldIterator != null) {
                    while (jCoFieldIterator.hasNextField() == true) {

                        Object fieldValue = null;

                        JCoField jCoField = jCoFieldIterator.nextField();

                        int fieldType = jCoField.getType();

                        String fieldName = jCoField.getName();

                        if (fieldType == JCoMetaData.TYPE_STRUCTURE) {

                        	Map<String,Object> mapStrt = JCoUtils.convertJCoStructureToMap(parameterList, jCoField);

                            mapData.put(fieldName,mapStrt);

                        } else if (fieldType == JCoMetaData.TYPE_DATE) {

                            fieldValue = parameterList.getValue(fieldName);

                            if (fieldValue instanceof java.util.Date) {
                                fieldValue = dateFormat.format((Date) fieldValue);
                            }

                            mapData.put(fieldName, fieldValue);

                        } else if (fieldType == JCoMetaData.TYPE_TIME) {

                            fieldValue = parameterList.getValue(fieldName);

                            mapData.put(fieldName, fieldValue);

                        //20190903 IMS OTY유형으로 export 파라미터에 테이블 유형이 넘어옴
                        } else if (fieldType == JCoMetaData.TYPE_TABLE) {
                        	JCoTable jCoTable = (JCoTable) parameterList.getValue(fieldName);

                            List<Map<String,Object>> listMap = convertJCoTableToList(jCoTable, fieldName);

                            mapData.put(fieldName, listMap);
                        }else {

                            fieldValue = parameterList.getValue(fieldName);

                            mapData.put(fieldName, fieldValue);
                        }
                    }
                }
            }

            tableParameterList = function.getTableParameterList();

            if (tableParameterList != null) {

                tableParameterIterator = tableParameterList.getParameterFieldIterator();

                while (tableParameterIterator.hasNextField() == true) {

                    JCoField jCoField = tableParameterIterator.nextField();

                    String tableName = jCoField.getName();

                    JCoTable jCoTable = tableParameterList.getTable(tableName);

                    List<Map<String,Object>> listMap = convertJCoTableToList(jCoTable, tableName);

                    mapData.put(tableName, listMap);
                }

            }

        } catch (Exception exception) {

            throw exception;
        }

        return mapData;
    }
    
    
    /**
     * convertDataSetToExportParameterList
     * 
     * @param function
     * @param mapData
     */
    public static void convertMapToExportParameterList(JCoFunction function, Map<String,Object> mapData) throws Exception{

        convertMapToParameterList(function, mapData, function.getExportParameterList());

    }

    /**
     * convertDataSetToJCoParameterList
     * 
     * @param function
     * @param mapData
     */
    public static void convertMapToImportParameterList(JCoFunction function, Map<String,Object> mapData) throws Exception {

    	convertMapToParameterList(function, mapData, function.getImportParameterList());
    }

    /**
     * convertDataSetToParameterList
     * 
     * @param function
     * @param mapData
     * @param parameterList
     */
    public static void convertMapToParameterList(JCoFunction function, Map<String,Object> mapData, JCoParameterList parameterList) throws Exception{

        JCoFieldIterator jCoFieldIterator = null;

        try {

            if (parameterList != null) {
                jCoFieldIterator = parameterList.getFieldIterator();

                while (jCoFieldIterator.hasNextField() == true) {

                    Object fieldValue = null;
                    JCoField jCoField = jCoFieldIterator.nextField();
                    int fieldType = jCoField.getType();
                    String fieldName = jCoField.getName();
                    /*if (fieldName.equals("ZBD1T")) {
                    	logger.debug(fieldName);
                    }*/
                    if (fieldType == JCoMetaData.TYPE_STRUCTURE) {
//                    	logger.debug("[TYPE_STRUCTURE] " + fieldName);
                    	JCoUtils.convertMapToJCoStructure(parameterList, jCoField, mapData);
                    } else {
                        fieldValue = JCoUtils.getFieldData(mapData, fieldName, fieldType);
                        parameterList.setValue(fieldName, fieldValue);
//                        logger.debug("["+fieldType+"] " + fieldName + ":" + fieldValue);
                    }
                }
            }

            // set table parameter
            if (null!=mapData.get("TABLE_LIST") && !"".equals((String)mapData.get("TABLE_LIST"))) {
            	String [] listTable = ((String)mapData.get("TABLE_LIST")).split(",");
            	for (String tableName : listTable) {
            		
            		@SuppressWarnings("unchecked")
					List<Map<String,Object>> listMap = (List<Map<String,Object>>)mapData.get(tableName);
	
	                JCoTable jCoTable = null;
	
	                try {
	                    jCoTable = function.getTableParameterList().getTable(tableName);
/*	                	if() {
		                    jCoTable = function.getExportParameterList().getTable(tableName);
	                	}else {
		                    jCoTable = function.getTableParameterList().getTable(tableName);
	                	}
*/	                } catch (Exception e) {
	                    continue;	
	                }
	
	                JCoUtils.convertListMapToJCoTable(jCoTable, listMap);
	            }
            }

        } catch (Exception exception) {

            throw exception;
        }
    }

    /**
     * 
     * convertMapToJCoStructure
     * 
     * @param parameterList
     * @param jCoField
     * @param recordSet
     *            void
     */
    private static void convertMapToJCoStructure(JCoParameterList parameterList, JCoField jCoField,  Map<String, Object> mapData) throws Exception{

        if (mapData == null) {
            return;
        }

        JCoStructure structure = parameterList.getStructure(jCoField.getName());

        JCoRecordMetaData recordMetaData = jCoField.getRecordMetaData();

        int recordMetaDataFieldCount = recordMetaData.getFieldCount();

        for (int i = 0; i < recordMetaDataFieldCount; i++) {
            String fieldName = recordMetaData.getName(i);
//            if (fieldName.equals("ZBD1T") || fieldName.equals("ZBD1P")) {
//            	logger.debug(fieldName);
//            }
            String fieldValue = null;
            try {
            	fieldValue = mapData.get(fieldName)!=null?mapData.get(fieldName).toString():"";
            } catch (Exception e) {
            	throw e;
                //fieldValue = "";
            }

            if (StringUtils.isEmpty(fieldValue) == true) {
                structure.setValue(fieldName, "");
            } else {
                structure.setValue(fieldName, fieldValue);
            }
//            logger.debug("[field] " + fieldName + ":" + fieldValue);
            
        }
    }

    /**
     * convertListMapToJCoTable
     * 
     * @param function
     * @param recordSet
     */
    private static void convertListMapToJCoTable(JCoTable jCoTable, List<Map<String,Object>> listMap) {

        int recordCount = 0;

        try {

            recordCount = listMap.size();

            for (int i = 0; i < recordCount; i++) {

            	Map<String,Object> mapItem = listMap.get(i);

                jCoTable.insertRow(i);

                jCoTable.setRow(i);

                JCoFieldIterator jCoFieldIterator = jCoTable.getFieldIterator();

                while (jCoFieldIterator.hasNextField() == true) {

                    JCoField jCoField = jCoFieldIterator.nextField();

                    String fieldName = jCoField.getName();

                    int fieldType = jCoField.getType();

                    Object value = JCoUtils.getFieldData(mapItem, fieldName, fieldType);

                    jCoTable.setValue(fieldName, value);
//                    logger.debug("[jcoTable][" + fieldType + "] " + fieldName + ":" + value);
                }
            }

        } catch (Exception exception) {

            throw exception;
        }
    }

    /**
     * 
     * convertJCoStructureToMap
     * 
     * @param parameterList
     * @param jCoField
     * @return Map
     */
    private static Map<String,Object> convertJCoStructureToMap(JCoParameterList parameterList, JCoField jCoField) {

        String structureName = jCoField.getName();

        Map<String,Object> mapStrt = new HashMap<>();

        JCoRecordMetaData recordMetaData = jCoField.getRecordMetaData();

        int recordMetaDataFieldCount = recordMetaData.getFieldCount();

        JCoStructure structure = parameterList.getStructure(structureName);
        for (int i = 0; i < recordMetaDataFieldCount; i++) {
        	String fieldName = recordMetaData.getName(i);
            Object fieldValue = structure.getValue(fieldName);
            if (fieldValue instanceof java.util.Date) {
                fieldValue = dateFormat.format((Date) fieldValue);
            }
            mapStrt.put(fieldName, fieldValue);
        }

        return mapStrt;
    }

    /**
     * convertJCoTableToList
     * 
     * @param jCoTable
     * @param tableName
     * @return
     */
    private static List<Map<String,Object>> convertJCoTableToList(JCoTable jCoTable, String tableName) {
    	List<Map<String,Object>> listMap = new ArrayList<>();
    	
        int numRows = jCoTable.getNumRows();

        JCoFieldIterator jCoFieldIterator = jCoTable.getFieldIterator();

        for (int i = 0; i < numRows; i++) {
            // move ith row
            jCoTable.setRow(i);

            Map<String,Object> mapItem = new HashMap<>();

            jCoFieldIterator = jCoTable.getFieldIterator();

            while (jCoFieldIterator.hasNextField()) {

                JCoField jCoField = jCoFieldIterator.nextField();

                String fieldName = jCoField.getName();

                Object fieldValue = jCoTable.getValue(fieldName);

                if (fieldValue instanceof java.util.Date) {
                    fieldValue = dateFormat.format((Date) fieldValue);
                }
                mapItem.put(fieldName, fieldValue);
            }
            listMap.add(mapItem);

        }
        return listMap;
    }

    /**
     * getFieldData
     * 
     * @param mapData
     * @param fieldName
     * @param fieldType
     * @return
     */
    private static Object getFieldData(Map<String,Object> mapData, String fieldName, int fieldType) {

        Object returnValue = null;

        switch (fieldType) {
        // int
            case JCoMetaData.TYPE_INT: // 4-byte integer .
            case JCoMetaData.TYPE_INT1: // 1-byte integer .
            case JCoMetaData.TYPE_INT2: // 2-byte integer .
                returnValue = mapData.get(fieldName);
                break;
            // double
            case JCoMetaData.TYPE_FLOAT: // Floating point,double precision.
                returnValue = mapData.get(fieldName);
                break;
            // bigdecimal
            case JCoMetaData.TYPE_BCD: // Packed BCD number, any length between
                                       // 1
                                       // and 16 bytes.
            case JCoMetaData.TYPE_DECF16: // decimal floating point.
            case JCoMetaData.TYPE_DECF34: // decimal floating point.
                returnValue = mapData.get(fieldName);
                break;
            // string
            case JCoMetaData.TYPE_CHAR: // 1-byte or multi-byte character.Fixed
                                        // sized, blank padded.
            case JCoMetaData.TYPE_NUM: // Digits, fixed size,'0' padded.
            case JCoMetaData.TYPE_STRING: // UTF8 encoded string of variable
                                          // length.
                returnValue = mapData.get(fieldName);
                break;
            // byte
            case JCoMetaData.TYPE_BYTE: // Raw data, binary, fixed length, zero
                                        // padded.
            case JCoMetaData.TYPE_XSTRING: // Byte array of variable length.
                returnValue = mapData.get(fieldName);
                break;
            // date
            case JCoMetaData.TYPE_DATE: // Date ( YYYYYMMDD ).
            case JCoMetaData.TYPE_TIME: // Time (HHMMSS).
                returnValue = mapData.get(fieldName);
                break;
            default:
                returnValue = mapData.get(fieldName);
                break;
        }

        return returnValue;
    }    
    
    
}
