package com.app.ildong.common.model;

import java.io.Serializable;

import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 모델에 해당하는 Java Bean 클래스들은 기본적으로 BaseObject를 상속받아야한다.<br/>
 * toString(), equals(), hashCode() 에 대한 재정의 리플렉팅을 자동으로 수행한다.
 */
public class BaseObject implements Serializable {

	private static final long serialVersionUID = 8819880562867698806L;
	
	public String toString()
	{
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}
	
	public boolean equals(Object o)
	{	
		return EqualsBuilder.reflectionEquals(this, 0);
	}
	
	public int hashCode()
	{
		return HashCodeBuilder.reflectionHashCode(this);
	}
}
