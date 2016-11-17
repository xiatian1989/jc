package com.rwkj.jc.util;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.UUID;

public class CommonUtils {
	
	public static String getMD5Pssword(String password) {
		MessageDigest md;
		   try {
		    // 生成一个MD5加密计算摘要
		    md = MessageDigest.getInstance("MD5");
		    // 计算md5函数
		    md.update(password.getBytes());
		    // digest()最后确定返回md5 hash值，返回值为8为字符串。因为md5 hash值是16位的hex值，实际上就是8位的字符
		    // BigInteger函数则将8位的字符串转换成16位hex值，用字符串来表示；得到字符串形式的hash值
		    String pwd = new BigInteger(1, md.digest()).toString(16);
		    return pwd;
		   } catch (Exception e) {
		    e.printStackTrace();
		   }
		   return password;
		}
	
	public static String getUUID() {  
        UUID uuid = UUID.randomUUID();  
        String str = uuid.toString();  
        // 去掉"-"符号  
        String temp = str.substring(0, 8) + str.substring(9, 13) + str.substring(14, 18) + str.substring(19, 23) + str.substring(24);  
        return temp;
	}
	
	public static String getyyyymmddHHmmssTime() {
		
		//使用默认时区和语言环境获得一个日历  
		Calendar cale = Calendar.getInstance();  
		//将Calendar类型转换成Date类型  
		Date tasktime=cale.getTime();  
		//设置日期输出的格式  
		SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
		//格式化输出  
		return df.format(tasktime);  
	}
	public static String getyyyymmddHHmmssTime(Date date) {
		
		//设置日期输出的格式  
		SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
		//格式化输出  
		return df.format(date);  
	}
	
	public static boolean isValidDate(String str) {
	      boolean convertSuccess=true;
	      // 指定日期格式为四位年/两位月份/两位日期，注意yyyy/MM/dd区分大小写；
	       SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	       try {
	    // 设置lenient为false. 否则SimpleDateFormat会比较宽松地验证日期，比如2007/02/29会被接受，并转换成2007/03/01
	          format.setLenient(false);
	          format.parse(str);
	       } catch (ParseException e) {
	          // e.printStackTrace();
	// 如果throw java.text.ParseException或者NullPointerException，就说明格式不对
	           convertSuccess=false;
	       } 
	       return convertSuccess;
	}  
	public static boolean isValidDouble(String str) {
		boolean convertSuccess=true;
		try {
			Double.parseDouble(str);
		} catch (Exception e) {
			convertSuccess=false;
		} 
		return convertSuccess;
	}  
}
