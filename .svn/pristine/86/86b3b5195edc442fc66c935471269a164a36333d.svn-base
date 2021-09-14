package com.app.ildong.common.util;

import java.util.Comparator;
import java.util.Map;

import org.apache.commons.collections.MapUtils;

public class MapComparator implements Comparator<Map<String, Object>> {

	private String sortKey;
	
	public MapComparator(String sortKey) {
		this.sortKey = sortKey;
	}
	
	@Override
	public int compare(Map<String, Object> o1, Map<String, Object> o2) {
		
		String s1 = MapUtils.getString(o1, sortKey, "");
		String s2 = MapUtils.getString(o2, sortKey, "");
				
		return s1.compareTo(s2);
	}

}
