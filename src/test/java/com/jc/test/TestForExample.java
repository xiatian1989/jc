package com.jc.test;

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
}
