package com.app.ildong.common.crypt;

import java.io.FileNotFoundException;
import java.io.RandomAccessFile;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.apache.commons.codec.binary.Base64;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Component;

@Component("DigestUtil")
public class DigestUtil {

	
	private static final Log logger = LogFactory.getLog(DigestUtil.class);
	
	private static String algorithm = "SHA-256";

    /**
     * 비밀번호를 암호화하는 기능(복호화가 되면 안되므로 SHA-256 인코딩 방식 적용)
     * 
     * @param password 암호화될 패스워드
     * @param id salt로 사용될 사용자 ID 지정
     * @return
     * @throws Exception
     */
    public static String digest(String data, String salt) throws Exception {

    	if (data == null) {
		    return "";
		}
	
		byte[] hashValue = null; // 해쉬값
	
		MessageDigest md = MessageDigest.getInstance(algorithm);
		
		md.reset();
		md.update(salt.getBytes());
		
		hashValue = md.digest(data.getBytes());
		if( logger.isDebugEnabled() ) {
			logger.debug("Digested DATA = [" + hashValue + "]");
		}
		return new String(Base64.encodeBase64(hashValue));
    }
	
    
    /**
     * 비밀번호를 암호화된 패스워드 검증(salt가 사용된 경우만 적용).
     * 
     * @param data 원 패스워드
     * @param encoded 해쉬처리된 패스워드(Base64 인코딩)
     * @return
     * @throws Exception
     */
    public static boolean matches(String data, String encoded, String salt) throws Exception {
    	byte[] hashValue = null; // 해쉬값
    	
    	MessageDigest md = MessageDigest.getInstance(algorithm);
    	
    	md.reset();
    	md.update(salt.getBytes());
    	hashValue = md.digest(data.getBytes());
    	
		if( logger.isDebugEnabled() ) {
			logger.debug("hashValue Byte DATA = [" + hashValue + "]" );
			logger.debug("hashValue String DATA = [" + new String(Base64.encodeBase64(hashValue)) + "]" );
			//logger.debug("encoded byte DATA = [" + Base64.decodeBase64(encoded.getBytes()) + "]");
			//logger.debug("encoded String DATA = [" + encoded + "]");
		}
    	return MessageDigest.isEqual(hashValue, Base64.decodeBase64(encoded.getBytes()));
    }
    
    public static String extractStringHashSHA256(String str){
        String SHA = "";
        try{
            MessageDigest sh = MessageDigest.getInstance("SHA-256");
            sh.update(str.getBytes());
            byte byteData[] = sh.digest();
            StringBuffer sb = new StringBuffer();
            for(int i = 0 ; i < byteData.length ; i++){
                sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
            }
            SHA = sb.toString();
             
        }catch(NoSuchAlgorithmException e){
            e.printStackTrace();
            SHA = null;
        }
        return SHA;
    }
    
    public static String extractByteHashSHA256(byte[] str){
        String SHA = "";
        try{
            MessageDigest sh = MessageDigest.getInstance("SHA-256");
            sh.update(str);
            byte byteData[] = sh.digest();
            StringBuffer sb = new StringBuffer();
            for(int i = 0 ; i < byteData.length ; i++){
                sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
            }
            SHA = sb.toString();
             
        }catch(NoSuchAlgorithmException e){
            e.printStackTrace();
            SHA = null;
        }
        return SHA;
    }
    
    public static String extractFileHashSHA256(String filename) throws Exception {
        
        String SHA = "";
        int buff = 16384;
        try {
            RandomAccessFile file = new RandomAccessFile(filename, "r");
 
            MessageDigest hashSum = MessageDigest.getInstance("SHA-256");
 
            byte[] buffer = new byte[buff];
            byte[] partialHash = null;
 
            long read = 0;
 
            // calculate the hash of the hole file for the test
            long offset = file.length();
            int unitsize;
            while (read < offset) {
                unitsize = (int) (((offset - read) >= buff) ? buff : (offset - read));
                file.read(buffer, 0, unitsize);
 
                hashSum.update(buffer, 0, unitsize);
 
                read += unitsize;
            }
 
            file.close();
            partialHash = new byte[hashSum.getDigestLength()];
            partialHash = hashSum.digest();
             
            StringBuffer sb = new StringBuffer();
            for(int i = 0 ; i < partialHash.length ; i++){
                sb.append(Integer.toString((partialHash[i]&0xff) + 0x100, 16).substring(1));
            }
            SHA = sb.toString();
 
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
         
        return SHA;
    }
    
}

