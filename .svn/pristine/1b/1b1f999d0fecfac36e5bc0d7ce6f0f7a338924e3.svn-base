package com.app.ildong.sap;


import com.sap.conn.jco.JCoDestination;
import com.sap.conn.jco.JCoDestinationManager;
import com.sap.conn.jco.JCoException;
import com.sap.conn.jco.ext.DataProviderException;
import com.sap.conn.jco.ext.DestinationDataEventListener;
import com.sap.conn.jco.ext.DestinationDataProvider;
import com.sap.conn.jco.ext.Environment;

import java.util.HashMap;
import java.util.Properties;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class JCoDestinationDataProvider {
	public static class MyDestinationDataProvider implements DestinationDataProvider {

		////////////////////////////////////////////////////////////////////
		// The following lines convert MyDestinationDataProvider into a singleton.
		//////////////////////////////////////////////////////////////////// Notice
		// that the MyDestinationDataProvider class has now been declared as static.
		private static MyDestinationDataProvider myDestinationDataProvider = null;

		private MyDestinationDataProvider() {
		}

		public static MyDestinationDataProvider getInstance() {
			if (myDestinationDataProvider == null) {
				myDestinationDataProvider = new MyDestinationDataProvider();
			}
			return myDestinationDataProvider;
		}
	
	
		protected final Log logger = LogFactory.getLog(getClass());
		
		private DestinationDataEventListener eL;
		private HashMap<String, Properties> secureDBStorage = new HashMap<String, Properties>();
		private String _DEST_NAME	= "PARUCNC";

		

		public Properties getDestinationProperties(String destinationName) {
			try {
				Properties p = secureDBStorage.get(destinationName);
				if (p != null) {
					if (p.isEmpty())
						throw new DataProviderException(DataProviderException.Reason.INVALID_CONFIGURATION,
								"destination configuration is incorrect", null);
					return p;
				}
				return null;
			} catch (RuntimeException re) {
				throw new DataProviderException(DataProviderException.Reason.INTERNAL_ERROR, re);
			}
		}

		public void setDestinationDataEventListener(DestinationDataEventListener eventListener) {
			this.eL = eventListener;
		}

		public boolean supportsEvents() {
			return true;
		}

		public void changeProperties(String destName, Properties properties) {
			synchronized (secureDBStorage) {
				if (properties == null) {
					if (secureDBStorage.remove(destName) != null) {
						eL.deleted(destName);
					}
				} else {
					secureDBStorage.put(destName, properties);
					if(eL != null) {
						eL.updated(destName); // create or updated
					}
				}
			}
		}
	}
	public JCoDestination getDestination(String destName, Properties connectProperties) throws Exception {
		MyDestinationDataProvider myProvider = MyDestinationDataProvider.getInstance();
		boolean destinationDataProviderRegistered = com.sap.conn.jco.ext.Environment
				.isDestinationDataProviderRegistered();
		if (!destinationDataProviderRegistered) {
			try {
				com.sap.conn.jco.ext.Environment.registerDestinationDataProvider(myProvider);
			} catch (IllegalStateException providerAlreadyRegisteredException) {
				throw new Error(providerAlreadyRegisteredException);
			} 
		}
		
		myProvider.changeProperties(destName, connectProperties);
		JCoDestination dest = null;
		try {
			dest = JCoDestinationManager.getDestination(destName);
		} catch (JCoException ex) {
			ex.printStackTrace();
			throw ex;
		} catch (Exception ex) {
			ex.printStackTrace();
			throw ex;
		}
		return dest;
	}

}	

