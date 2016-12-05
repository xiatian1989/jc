package com.rwkj.jc.controller;

import java.io.File;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.mysql.jdbc.StringUtils;
import com.rwkj.jc.domain.Depart;
import com.rwkj.jc.domain.User;
import com.rwkj.jc.service.DepartService;
import com.rwkj.jc.service.UserService;
import com.rwkj.jc.util.CommonUtils;
import com.rwkj.jc.util.ExcelUtil;

import jxl.write.WritableWorkbook;

@Controller
public class RelationManageController {
	
	@Resource
	private UserService userService;
	@Resource
	private DepartService departService;
	
	@InitBinder("user")    
	public void initBinder2(WebDataBinder binder) {    
		binder.setFieldDefaultPrefix("user.");    
	}    
	
	@RequestMapping("userList")
	public @ResponseBody Object getuserList(HttpServletRequest request, 
			@RequestParam(required = false, defaultValue = "1") Integer page, //第几页  
            @RequestParam(required = false, defaultValue = "10") Integer rows){
		Map<String, Object> result = new HashMap<String, Object>(2) ;
		int total = 0;
		Depart depart = null;
		List<User> parentUsers = null;
		String column= request.getParameter("column");
		String value = request.getParameter("value");
		List<User> users = null;
		if(StringUtils.isNullOrEmpty(value)){
			users = userService.getAllUsersForPage((page-1)*rows, rows);
			total = userService.getAllUsersCount();
		}else{
			if("depart_No".equals(column)) {
				depart = departService.getDepartByDepartName(value);
				if(depart == null){
					users = new ArrayList<User>();
				}else{
					value = depart.getDepartNo();
					users = userService.getUserByColumnValue(column, value, (page-1)*rows, rows);
					total = userService.getUserCountByColumnValue(column, value);
				}
			}else if("leader_No".equals(column)){
				parentUsers = userService.getUsersByUserName(value);
				if(CollectionUtils.isEmpty(parentUsers)) {
					users = new ArrayList<User>();
				}else{
					StringBuffer tempValue=new StringBuffer("(");
					for(User user:parentUsers) {
						tempValue.append(user.getUserno());
						tempValue.append(",");
					}
					users = userService.getUserByColumnValues(column, tempValue.substring(0, tempValue.length()-1)+")", (page-1)*rows, rows);
					total = userService.getUserCountByColumnValue(column, tempValue.substring(0, tempValue.length()-1)+")");
				}
			}else{
				users = userService.getUserByColumnValue(column, value, (page-1)*rows, rows);
				total = userService.getUserCountByColumnValue(column, value);
			}
		}
		
		JSONArray jsonArray = new JSONArray();  
        for(User user:users){  
             JSONObject jsonObject = new JSONObject();  
             jsonObject.put("id",user.getId());
             jsonObject.put("departName",user.getDepart()==null?"":user.getDepart().getDepartName());
             jsonObject.put("truename",user.getTruename());
             jsonObject.put("userno",user.getUserno());
             jsonObject.put("password",user.getPassword());
             jsonObject.put("leaderName",user.getLeader()==null?"":user.getLeader().getTruename());
             jsonObject.put("sex",user.getSex());
             jsonObject.put("phone",user.getPhone());
             jsonObject.put("webchat",user.getWebchat());
             jsonObject.put("createtime",new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(user.getCreatetime()));
             jsonObject.put("status",user.getStatus());
             jsonArray.add(jsonObject) ;  
        }  
		result.put("total", total);  
	    result.put("rows",jsonArray);
		return result;
	}
	
	@RequestMapping("addUser")
	public @ResponseBody Map<String,String> addUser(@ModelAttribute User user){
		Map<String, String> result = new HashMap<String,String>();
		int count = 0;
		user.setId(CommonUtils.getUUID());
		String password = user.getPassword();
		user.setPassword(CommonUtils.getMD5Pssword(password));
		user.setCreatetime(new Date(System.currentTimeMillis()));
		count = userService.addUser(user);
		
		if(count>0){
			result.put("result", "success");
		}else{
			result.put("result", "failed");
			result.put("errorMsg", "添加失败，请联系管理员！");
		}
		return result;
	}
	
	@RequestMapping("updateUser")
	public @ResponseBody Map<String,String> updateUser(@ModelAttribute User user){
		int count = 0;
		Map<String, String> result = new HashMap<String,String>();
		count = userService.updateUser(user);
		if(count>0){
			result.put("result", "success");
		}else{
			result.put("result", "failed");
			result.put("errorMsg", "更新失败");
		}
		return result;
	}
	
	@RequestMapping("deleteUser")
	public @ResponseBody Map<String,String> deleteUser(@RequestParam("id") String id){
		
		String[] idArr = id.split(",");
		int count = 0;
		Map<String,String> map = new HashMap<String,String>();
		for(String tempId:idArr) {
			User user = userService.getUserByUserId(tempId);
			userService.deleteConnectionByLeaderNo(user.getUserno());
			count += userService.deleteUser(tempId);
		}
		
		if(count==idArr.length){
			map.put("result", "success");
		}else {
			map.put("result", "failed");
		}
		return map;
	}
	
	@RequestMapping("getUsersByDepartNo")
	public @ResponseBody JSONArray getUsersByDepartNo(@RequestParam("departNo") String departNo){
		List<User> users = userService.getUsersByDepartNo(departNo);
		JSONArray jsonArray = new JSONArray();  
        for(User user:users){  
             JSONObject jsonObject = new JSONObject();  
             jsonObject.put("truename",user.getTruename());
             jsonObject.put("userno",user.getUserno());
             jsonArray.add(jsonObject) ;  
        }  
		return jsonArray;
	}
	
	@RequestMapping("checkUserNoUnique")
	public @ResponseBody Map<String,String> checkUserNoUnique(@RequestParam("userNo") String userNo){
		Map<String,String> map = new HashMap<String,String>();
		if(userService.checkUserNoUnique(userNo)){
			map.put("result", "failed");
		}else{
			map.put("result", "success");
		}
		return map;
	}
	
	@RequestMapping("exportExcelForUser")
	public void exportExcel(HttpServletResponse response) throws Exception{
		String fileName = "人员信息表";
		List<User> users = userService.getAllUsers();
		ExcelUtil<User> excelUtil = new ExcelUtil<User>(User.class);
		List<Map<String,Object>> list = excelUtil.createExcelRecord(users, "人员信息一览");
		
		String columnNames[]={"部门编号","真实姓名","用户编号","上级领导编号","性别","电话号码","微信号","创建时间","状态"};//列名
		String keys[]={"departNo","truename","userno","leaderNo","sex","phone","webchat","createtime","status"};//map中的key
		
		ServletOutputStream out = response.getOutputStream();

		// 设置response参数，可以打开下载页面
        response.reset();
        response.setContentType("application/vnd.ms-excel;charset=utf-8");
		response.addHeader("Content-Disposition", "attachment;filename="+new String(fileName.getBytes("gbk"),"iso-8859-1")+".xls");
		WritableWorkbook workbook = excelUtil.createWorkBook(list, keys, columnNames, out);
		workbook.write();   
        workbook.close();   
        out.close();  
	}
	
	 @RequestMapping("uploadExcelForUser")  
	 public @ResponseBody Map<String,String> upload(HttpServletRequest request, HttpServletResponse response)  
    {
		 int count = 0;
		 Map<String,String> result = new HashMap<String,String>();
	 	//创建一个通用的多部分解析器  
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext());  
        //判断 request 是否有文件上传,即多部分请求  
        if(multipartResolver.isMultipart(request)){  
            //转换成多部分request    
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest)request;  
            //取得request中的所有文件名  
            Iterator<String> iter = multiRequest.getFileNames();  
            while(iter.hasNext()){  
                //记录上传过程起始时的时间，用来计算上传时间  
                int pre = (int) System.currentTimeMillis();  
                //取得上传文件  
                MultipartFile file = multiRequest.getFile(iter.next());  
                if(file != null){  
                    //取得当前上传文件的文件名称  
                    String myFileName = file.getOriginalFilename();  
                    //如果名称不为“”,说明该文件存在，否则说明该文件不存在  
                    if(myFileName.trim() !=""){  
                        System.out.println(myFileName);  
                        //重命名上传后的文件名  
                        String fileName = pre+""+file.getOriginalFilename();
                        String path=request.getSession().getServletContext().getRealPath("upload")+"/"+fileName;
                        File localFile = new File(path);
                        try {
							file.transferTo(localFile);
							List<User> users = new ExcelUtil<User>(User.class).readDataFromXls(path);
							for(User user:users) {
								user.setId(CommonUtils.getUUID());
								user.setPassword(CommonUtils.getMD5Pssword(user.getPassword()==null?"123456":user.getPassword()));
								user.setCreatetime(new Date(System.currentTimeMillis()));
							}
							
							count = userService.batchInsert(users);
						} catch (Exception e) {
							result.put("result", "failed");
							result.put("errorMsg", "导入发生异常，请联系管理员！");
							e.printStackTrace();
							return result;
						}  
                    }  
                }  
                //记录上传该文件后的时间  t
                result.put("result", "success");
                result.put("count", count+"");
            }  
        }  
        return result;  
    } 
}
