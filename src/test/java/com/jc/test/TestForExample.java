package com.jc.test;

import java.io.IOException;
import java.security.interfaces.RSAPrivateKey;
import java.security.interfaces.RSAPublicKey;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;

import org.codehaus.jackson.JsonEncoding;
import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.map.ObjectMapper;
import org.junit.Test;

import com.rwkj.jc.util.CommonUtils;

public class TestForExample {
	@Test
	public void testPassword(){
		System.out.println(CommonUtils.getMD5Pssword("123456"));
	}
	@Test
	public void testuuid(){
		System.out.println(CommonUtils.getUUID());
	}
	
	@Test	
	public void writeListJSON() {
		
	    try {
	    	ObjectMapper objectMapper = new ObjectMapper();
		    JsonGenerator jsonGenerator = objectMapper.getJsonFactory().createJsonGenerator(System.out, JsonEncoding.UTF8);
	        List<AccountBean> list = new ArrayList<AccountBean>();
	        
	        AccountBean bean = new AccountBean();
	        bean.setId(2);
	        bean.setAddress("address2");
	        bean.setEmail("email2");
	        bean.setName("haha2");
	        list.add(bean);
	        
	        System.out.println("jsonGenerator");
	        //list转换成JSON字符串
	        jsonGenerator.writeObject(list);
	        System.out.println();
	        System.out.println("ObjectMapper");
	        //用objectMapper直接返回list转换成的JSON字符串
	        System.out.println("1###" + objectMapper.writeValueAsString(list));
	        System.out.print("2###");
	        //objectMapper list转换成JSON字符串
	       
	        
	        Map<String, Object> map = new HashMap<String, Object>();  
	        map.put("studentList", list);  
	        map.put("class", "ClassName"); 
	        String jsonfromMap =  objectMapper.writeValueAsString(map);  
	        System.out.println(jsonfromMap); 
	        objectMapper.writeValue(System.out, list);
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	}
	
	@Test	
	public void testRsa() throws Exception {  
        // TODO Auto-generated method stub  
        HashMap<String, Object> map = RSAUtils.getKeys();  
        //生成公钥和私钥  
        RSAPublicKey publicKey = (RSAPublicKey) map.get("public");  
        RSAPrivateKey privateKey = (RSAPrivateKey) map.get("private");  
          
        //模  
        String modulus = publicKey.getModulus().toString();  
        //公钥指数  
        String public_exponent = publicKey.getPublicExponent().toString();  
        //私钥指数  
        String private_exponent = privateKey.getPrivateExponent().toString();  
        //明文  
        String ming = "123456789";  
        //使用模和指数生成公钥和私钥  
        RSAPublicKey pubKey = RSAUtils.getPublicKey(modulus, public_exponent);  
        RSAPrivateKey priKey = RSAUtils.getPrivateKey(modulus, private_exponent);  
        //加密后的密文  
        String mi = RSAUtils.encryptByPublicKey(ming, pubKey);
        System.out.println(1);
        System.err.println(mi);  
        //解密后的明文  
        ming = RSAUtils.decryptByPrivateKey(mi, priKey);
        System.out.println(2);
        System.err.println(ming);  
    }
	
	@Test
	public void testCpuId() throws IOException{
		 long start = System.currentTimeMillis();  
	        Process process = Runtime.getRuntime().exec(  
	                new String[] { "wmic", "cpu", "get", "ProcessorId" });  
	        process.getOutputStream().close();  
	        Scanner sc = new Scanner(process.getInputStream());  
	        String property = sc.next();  
	        String serial = sc.next();  
	        System.out.println(property + ": " + serial);  
	           
	        System.out.println("time:" + (System.currentTimeMillis() - start));  
	}
}
