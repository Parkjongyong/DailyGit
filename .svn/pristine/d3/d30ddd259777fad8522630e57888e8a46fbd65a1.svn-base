package com.app.ildong.common.model.json;


import java.io.IOException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonToken;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.deser.std.UntypedObjectDeserializer;

@SuppressWarnings("deprecation")
public class CustomObjectDeserializer extends UntypedObjectDeserializer{

	/**
	 * 
	 */
	private static final long serialVersionUID = -1110546696399840385L;
	
	protected static final Log logger = LogFactory.getLog(CustomObjectDeserializer.class);
	
	@Override
    public Object deserialize(JsonParser jp, DeserializationContext ctxt) throws IOException {
		//logger.debug("getCurrentName= " + jp.getCurrentName() + ",token_Id = " + jp.getCurrentTokenId() + ",token = " + jp.getCurrentToken() + ",value: " + jp.getText());

	
		JsonToken currentToken = jp.getCurrentToken();
        if( currentToken == JsonToken.VALUE_STRING) {
        	String value = String.valueOf(jp.getText());
        	//String encodedValue = HtmlUtils.htmlEscape(value);
        	//return encodedValue;
        	return value;
        } else if( currentToken == JsonToken.VALUE_NUMBER_INT) {
        	return String.valueOf(jp.getText());
        } else if( currentToken == JsonToken.VALUE_NUMBER_FLOAT) {
        	return String.valueOf(jp.getText());        	
        } else {
        	return super.deserialize(jp, ctxt);
        }

    }

}
