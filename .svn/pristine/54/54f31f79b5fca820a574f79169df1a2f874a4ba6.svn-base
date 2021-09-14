package com.app.ildong.common.util;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang3.StringUtils;


public class MapUtil {

	/**
	 * map2의 field 값이 map1의 field 값과 다르면 map1의 값 리턴, 아니면 "" 리턴
	 * @param map1
	 * @param map2
	 * @param field
	 * @return
	 */
	public static String getChangeStringValue(Map<String, Object> map1, Map<String, Object> map2, String field) {
		if (MapUtils.getString(map1, field,"").equals(MapUtils.getString(map2, field,""))) {
			return "";
		}else {
			return MapUtils.getString(map1, field);
		}
	}
	
	/**
	 * map2의 field 값이 map1의 field 값과 다르면 map1의 값 리턴, 아니면 0 리턴
	 * @param map1
	 * @param map2
	 * @param field
	 * @return
	 */
	public static double getChangeDoubleValue(Map<String, Object> map1, Map<String, Object> map2, String field) {
		if (MapUtils.getDoubleValue(map1, field, 0) == MapUtils.getDoubleValue(map2, field, 0) ) {
			return 0;
		}else {
			return MapUtils.getDoubleValue(map1, field, 0);
		}
	}
	/**
	 * map2의 field 값이 map1의 field 값과 다르면 map1의 값 리턴, 아니면 0 리턴
	 * @param map1
	 * @param map2
	 * @param field
	 * @return
	 */
	public static int getChangeIntValue(Map<String, Object> map1, Map<String, Object> map2, String field) {
		if (MapUtils.getIntValue(map1, field, 0) == MapUtils.getIntValue(map2, field, 0) ) {
			return 0;
		}else {
			return MapUtils.getIntValue(map1, field, 0);
		}
	}
	
	/**
	 * Map 리스트에서 findKey 키의 값이 findValue인 Map을 리턴
	 * @param mapList
	 * @param findKey
	 * @param findValue
	 * @return
	 */
	public static Map<String, Object> findMap(List<Map<String,Object>> mapList, String findKey, String findValue){
		if (mapList != null) {
			for(Map<String, Object> map : mapList) {
				if (MapUtils.getString(map, findKey,"").equals(findValue)) {
					return map;
				}
			}
		}
		return null;
	}
	
	/**
	 * Map 리스트에서 findKey 키의 값이 findValue인 List<Map>을 리턴
	 * @param mapList
	 * @param findKey
	 * @param findValue
	 * @return
	 */
	public static List<Map<String, Object>> findMapList(List<Map<String,Object>> mapList, String findKey, String findValue){
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		if (mapList != null) {
			for(Map<String, Object> map : mapList) {
				if (MapUtils.getString(map, findKey,"").equals(findValue)) {
					list.add(map);
				}
			}
		}
		return list;
	}
	
	/**
	 * Map 리스트에서 findKey,findKey2 카 값이 findValue, findValue2인 Map을 리턴
	 * @param mapList
	 * @param findKey
	 * @param findValue
	 * @param findKey2
	 * @param findValue2
	 * @return
	 */
	public static Map<String, Object> findMap(List<Map<String,Object>> mapList, String findKey, String findValue, String findKey2, String findValue2){
		if (mapList != null) {
			for(Map<String, Object> map : mapList) {
				if (MapUtils.getString(map, findKey,"").equals(findValue)) {
					if (MapUtils.getString(map, findKey2,"").equals(findValue2)) {
						return map;
					}
				}
			}
		}
		return null;
	}
	
	/**
	 * Map 리스트에서 findKey,findKey2 카 값이 findValue, findValue2인 List<Map>을 리턴
	 * @param mapList
	 * @param findKey
	 * @param findValue
	 * @param findKey2
	 * @param findValue2
	 * @return
	 */
	public static List<Map<String, Object>> findMapList(List<Map<String,Object>> mapList, String findKey, String findValue, String findKey2, String findValue2){
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		if (mapList != null) {
			for(Map<String, Object> map : mapList) {
				if (MapUtils.getString(map, findKey,"").equals(findValue)) {
					if (MapUtils.getString(map, findKey2,"").equals(findValue2)) {
						list.add(map);
					}
				}
			}
		}
		return list;
	}
	
	/**
	 * map key값으로 정렬(TreeMap사용) 후 key.value 문자열을 합쳐서 리턴.
	 * @param map
	 * @param tarketKeys 대상 key 값들 (,) 구분
	 * @return
	 */
	public static String getKeyValueConcatString(Map map, String tarketKeys) {
		StringBuffer sb = new StringBuffer();
		
		TreeMap<String, Object> tm = new TreeMap<String, Object>(map);
		
		for( Object key : map.keySet() ){
			if (StringUtils.contains(tarketKeys, key.toString())) {
				sb.append(key+":"+MapUtils.getString(map, key,"")+",");
			}				
        }

		return sb.toString();
	}
}
