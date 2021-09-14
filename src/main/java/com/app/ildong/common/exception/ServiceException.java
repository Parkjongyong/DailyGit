package com.app.ildong.common.exception;

public class ServiceException extends Exception {

    /**
	 * 
	 */
	private static final long serialVersionUID = -2324093093438191014L;
	
	public ServiceException() {
    }

    public ServiceException(String message) {
        super(message);
    }

    public ServiceException(Throwable cause) {
        super(cause);
    }

    public ServiceException(String message, Throwable cause) {
        super(message, cause);
    }

}
