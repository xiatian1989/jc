package com.rwkj.jc.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.mysql.jdbc.StringUtils;
import com.rwkj.jc.domain.TestForMessage;
import com.rwkj.jc.domain.User;
import com.rwkj.jc.service.TestForMessageService;
import com.rwkj.jc.service.UserService;

@Controller
public class TestForMessageController {
	
	@Resource
	private TestForMessageService testForMessageService;
	@Resource
	private UserService userService;
	
	
	@RequestMapping("/admin/smsList")
	public @ResponseBody Object getTempletList(HttpServletRequest request, 
			@RequestParam(required = false, defaultValue = "1") Integer page, //第几页  
            @RequestParam(required = false, defaultValue = "10") Integer rows){
		Map<String, Object> result = new HashMap<String, Object>(2) ;
		int total = 0;
		String value = request.getParameter("value");
		List<TestForMessage> testForMessages = null;
		if(StringUtils.isNullOrEmpty(value)){
			testForMessages = testForMessageService.getTestForMessages((page-1)*rows, rows);
			total = testForMessageService.getTestForMessagesCount();
		}else{
			List<User> users = userService.getUsersByUserName(value);
			StringBuffer userIds = new StringBuffer();
			for(User user:users) {
				userIds.append(",");
				userIds.append("'"+user.getId()+"'");
			}
			testForMessages = testForMessageService.getTestForMessagesByColumnValue(userIds.substring(1), (page-1)*rows, rows);
			total = testForMessageService.getTestForMessagesCountByColumnValue(value);
		}
		
		JSONArray jsonArray = new JSONArray();  
        for(TestForMessage testForMessage:testForMessages){  
             JSONObject jsonObject = new JSONObject();  
             jsonObject.put("id",testForMessage.getId());
             jsonObject.put("plantitle",testForMessage.getPlan().getPlantitle());
             jsonObject.put("testPerson",testForMessage.getRelation().getBeTestedUser().getTruename());
             jsonObject.put("testObject",testForMessage.getRelation().getIsperson()?testForMessage.getRelation().getBeTestedUser().getTruename():testForMessage.getRelation().getTestedDepart().getDepartName());
             jsonObject.put("isuse",testForMessage.getIsuse());
             jsonObject.put("createtime",new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(testForMessage.getCreatetime()));
             jsonArray.add(jsonObject) ;  
        }  
		result.put("total", total);  
	    result.put("rows",jsonArray);
		return result;
	}
	
	@RequestMapping("/admin/sendMessage")
	public @ResponseBody Map<String,String> sendMessage(@RequestParam("id") String id){
		
		Map<String,String> map = new HashMap<String,String>();
		int count = testForMessageService.sendMessage(id.substring(1), new Date());
		
		if(count>0){
			map.put("result", "success");
		}else {
			map.put("result", "failed");
		}
		return map;
	}
}
