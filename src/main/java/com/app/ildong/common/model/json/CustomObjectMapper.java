package com.app.ildong.common.model.json;


import com.fasterxml.jackson.core.Version;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.module.SimpleModule;

public class CustomObjectMapper extends ObjectMapper {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1906478274530475276L;

	public CustomObjectMapper() {
        super();

        SimpleModule module = new SimpleModule("HTML XSS Deserializer & Object Deserializer", new Version(1, 0, 0, "FINAL", "dongha.dplis", "web"));
        //module.addSerializer(String.class, new JsonHtmlXssSerializer());
        module.addDeserializer(Object.class, new CustomObjectDeserializer());

        
        
        this.registerModule(module);
    }

}
