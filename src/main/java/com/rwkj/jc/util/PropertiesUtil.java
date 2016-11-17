package com.rwkj.jc.util;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Properties;

public class PropertiesUtil{
    
    public int getleaveDays(){
    	Properties properties = loadProperties();
    	return Integer.parseInt(properties.getProperty("useDays"));
    }
    
    public void reduceleaveDays(int leaveDays) throws Exception{
    	Properties properties = new Properties(); 
    	properties.setProperty("useDays", String.valueOf(leaveDays));
    	String path = System.getProperty("evan.webapp") +"WEB-INF\\classes\\license.properties";
    	OutputStream os = new FileOutputStream(path);
    	properties.store(os, null);
    }
	
	private Properties loadProperties() {

		   // 使用InputStream得到一个资源文件
		   String path = System.getProperty("evan.webapp") +"WEB-INF\\classes\\license.properties";
		   FileInputStream inputstream = null;
			try {
				inputstream = new FileInputStream(path);
			} catch (FileNotFoundException e1) {
				e1.printStackTrace();
			}

		   // new 一个Properties

		   Properties properties = new Properties();

		   try {

		   // 加载配置文件

		      properties.load(inputstream);

		      return properties;

		   } catch (IOException e) {

		      throw new RuntimeException(e);

		   } finally {

		      try {

		         inputstream.close();

		      } catch (IOException e) {

		         throw new RuntimeException(e);

		      }

		   }

		}

}
