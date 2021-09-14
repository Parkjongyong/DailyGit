package com.app.ildong.common.util;


import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.List;

import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;

public abstract class UnZip {
	private static final int BUFFER_SIZE = 1024 * 4;

    /**
     * Zip 내부의  파일 체크
     */
    public static boolean checkZipFile(File zipFile) throws Exception {
        FileInputStream fis = null;
        ZipInputStream zis = null;
        ZipEntry zentry;
        boolean result = true;
        String fileNameToUnzip;

        try {

            fis = new FileInputStream(zipFile);
            zis = new ZipInputStream(fis);

            while ((zentry = zis.getNextEntry()) != null) {
                fileNameToUnzip = zentry.getName();
//                if (!checkFileExt(fileNameToUnzip.toLowerCase())) {
//                    result = false;
//                    break;
//                }
            }
        } finally {
            if (zis != null) {
                zis.close();
            }
            if (fis != null) {
                fis.close();
            }
        }
        return result;
    }

    public static boolean checkFileExt(String str) {
//        String allowPattern = ".+\\.(" + IpsProperties.getProperty(IpsSrmConstants.IPS_SRM_FILE_UPLOAD_ALLOW_TYPE) + ")$";
//        Pattern p = Pattern.compile(allowPattern);
//        Matcher m = p.matcher(str);
//        return m.matches();
    	return false;
    }

    public static int zipEntry(List<File> sourceFiles, List<String> originalFilenames, ZipOutputStream zos) throws Exception {
        BufferedInputStream bis = null;
        int size = 0;
        try {
            for (int i = 0; i < sourceFiles.size(); i++) {
                File file = sourceFiles.get(i);
                String filename = originalFilenames.get(i);
                bis = new BufferedInputStream(new FileInputStream(file));
                ZipEntry ze = new ZipEntry(String.format("%02d.%s", i + 1, filename));
                zos.putNextEntry(ze);

                byte[] buffer = new byte[BUFFER_SIZE];
                int length;
                while ((length = bis.read(buffer, 0, BUFFER_SIZE)) != -1) {
                    zos.write(buffer, 0, length);
                    size += length;
                }
                zos.closeEntry();
                bis.close();
            }
        } finally {
            if (bis != null) {
                bis.close();
            }
        }
        return size;
    }
    
}
