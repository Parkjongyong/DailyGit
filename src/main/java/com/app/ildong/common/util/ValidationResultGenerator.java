package com.app.ildong.common.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.validation.FieldError;

import com.ecbank.framework.constants.EcbankConstants;

@Service("validationResultGenerator")
public class ValidationResultGenerator {
    
    @Autowired
    private MessageSource messageSource;
    
    /**
     * getErrorMessages
     * Validtion을 통과하지 못한 Error목록을
     * Field, Rejected Valud, Message로 구성하여 List형태로 반환한다.
     *  
     * @param errors
     * @return List<Map<String,Object>>
     */
    public List<Map<String, Object>> getErrorMessages(List<FieldError> errors) {
        List<Map<String, Object>> errorMessageList = new ArrayList<Map<String, Object>>();
        
        for(FieldError error: errors) {
            Map<String, Object> errorMessage = new HashMap<String, Object>();
            errorMessage.put(EcbankConstants.VALID_REJECTED_FIELD, error.getField());
            errorMessage.put(EcbankConstants.VALID_REJECTED_VALUE, error.getRejectedValue());
            errorMessage.put(EcbankConstants.VALID_ERROR_MESSAGE, messageSource.getMessage(error, LocaleContextHolder.getLocale()));
            errorMessageList.add(errorMessage);
        }
        
        return errorMessageList;
    }

}
