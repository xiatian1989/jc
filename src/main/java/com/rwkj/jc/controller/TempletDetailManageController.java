package com.rwkj.jc.controller;

import java.io.File;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.mysql.jdbc.StringUtils;
import com.rwkj.jc.domain.TempletDetail;
import com.rwkj.jc.service.TempletDetailService;
import com.rwkj.jc.util.CommonUtils;
import com.rwkj.jc.util.ExcelUtil;

import jxl.write.WritableWorkbook;

@Controller
public class TempletDetailManageController {
	
	@Resource
	private TempletDetailService templetDetailService;
	
	@InitBinder("templetDetail")    
	public void initBinder2(WebDataBinder binder) {    
		binder.setFieldDefaultPrefix("templetDetail.");    
	}    
	
	@RequestMapping("templetPreview")
	public ModelAndView templetPreview(HttpServletRequest request){
		
		ModelAndView modelAndView = new ModelAndView();
		String templetId = request.getParameter("templetId");
		List<TempletDetail> templetDetails = templetDetailService.getTempletDetailsByTempletId(templetId);
		modelAndView.addObject("templetDetails",templetDetails);
		modelAndView.setViewName("admin/SystemManage/templetPreview");
		return modelAndView;
	}
	@RequestMapping("templetDetailList")
	public @ResponseBody Object getTempletList(HttpServletRequest request, 
			@RequestParam(required = false, defaultValue = "1") Integer page, //第几页  
            @RequestParam(required = false, defaultValue = "10") Integer rows){
		Map<String, Object> result = new HashMap<String, Object>(2) ;
		int total = 0;
		String column = "question";
		String value = request.getParameter("value");
		String templetId = request.getParameter("templetId");
		HttpSession session = request.getSession(true);
		if(StringUtils.isNullOrEmpty(templetId)) {
			templetId = (String)session.getAttribute("templetId");
		}else{
			session.setAttribute("templetId", templetId);
		}
		
		List<TempletDetail> templetDetails = null;
		
		if(StringUtils.isNullOrEmpty(value)){
			templetDetails = templetDetailService.getTempletDetails(templetId, (page-1)*rows, rows);
			total = templetDetailService.getTempletDetailsCount(templetId);
		}else{
			value = "%"+value+"%";
			templetDetails = templetDetailService.getTempletDetailsByColumnValue(templetId, column, value, (page-1)*rows, rows);
			total = templetDetailService.getTempletDetailsCountByColumnValue(templetId, column, value);
		}
		
		JSONArray jsonArray = new JSONArray();  
        for(TempletDetail templetDetail:templetDetails){  
             JSONObject jsonObject = new JSONObject();  
             jsonObject.put("id",templetDetail.getId());
             jsonObject.put("templetId",templetDetail.getTempletId());
             jsonObject.put("question",templetDetail.getQuestion());
             jsonObject.put("questionno",templetDetail.getQuestionno());
             jsonObject.put("optiona",templetDetail.getOptiona());
             jsonObject.put("optionascore",templetDetail.getOptionascore());
             jsonObject.put("optionb",templetDetail.getOptionb());
             jsonObject.put("optionbscore",templetDetail.getOptionbscore());
             jsonObject.put("optionc",templetDetail.getOptionc());
             jsonObject.put("optioncscore",templetDetail.getOptioncscore());
             jsonObject.put("optiond",templetDetail.getOptiond());
             jsonObject.put("optiondscore",templetDetail.getOptiondscore());
             jsonObject.put("optione",templetDetail.getOptione());
             jsonObject.put("optionescore",templetDetail.getOptionescore());
             jsonObject.put("optionf",templetDetail.getOptionf());
             jsonObject.put("optionfscore",templetDetail.getOptionfscore());
             jsonArray.add(jsonObject) ;  
        }  
		result.put("total", total);  
	    result.put("rows",jsonArray);
		return result;
	}
	
	@RequestMapping("addTempletDetail")
	public @ResponseBody Map<String,String> addTempletDetail(HttpServletRequest request,@ModelAttribute TempletDetail templetDetail){
		Map<String, String> result = new HashMap<String,String>();
		int count = 0;
		templetDetail.setId(CommonUtils.getUUID());
		HttpSession session = request.getSession(true);
		String templetId = (String)session.getAttribute("templetId");
		templetDetail.setTempletId(templetId);
		count = templetDetailService.addTempletDetail(templetDetail);
		
		if(count>0){
			result.put("result", "success");
		}else{
			result.put("result", "failed");
			result.put("errorMsg", "添加失败，请联系管理员！");
		}
		return result;
	}
	
	@RequestMapping("updateTempletDetail")
	public @ResponseBody Map<String,String> updateTempletDetail(@ModelAttribute TempletDetail templetDetail){
		int count = 0;
		Map<String, String> result = new HashMap<String,String>();
		count = templetDetailService.updateTempletDetail(templetDetail);
		if(count>0){
			result.put("result", "success");
		}else{
			result.put("result", "failed");
			result.put("errorMsg", "更新失败");
		}
		return result;
	}
	
	@RequestMapping("deleteTempletDetail")
	public @ResponseBody Map<String,String> deleteTempletDetail(@RequestParam("id") String id){
		Map<String,String> map = new HashMap<String,String>();
		int count = templetDetailService.deleteTempletDetails(id);
		if(count>0){
			map.put("result", "success");
		}else {
			map.put("result", "failed");
		}
		return map;
	}
	
	@RequestMapping("checkTempletDetailNameUnique")
	public @ResponseBody Map<String,String> checkTempletDetailNameUnique(HttpServletRequest request,@RequestParam("name") String name){
		Map<String,String> map = new HashMap<String,String>();
		HttpSession session = request.getSession(true);
		String templetId = (String)session.getAttribute("templetId");
		if(templetDetailService.checkTempletDetailQuestionName(templetId, name)){
			map.put("result", "failed");
		}else{
			map.put("result", "success");
		}
		return map;
	}
	
	@RequestMapping("exportExcelForTempletDetail")
	public void exportExcel(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String fileName = "模板题目一览表";
		HttpSession session = request.getSession(true);
		String templetId = (String)session.getAttribute("templetId");
		List<TempletDetail> templetDetails = templetDetailService.getTempletDetailsByTempletId(templetId);
		ExcelUtil<TempletDetail> excelUtil = new ExcelUtil<TempletDetail>(TempletDetail.class);
		List<Map<String,Object>> list = excelUtil.createExcelRecord(templetDetails, "模板题目一览");
		
		String columnNames[]={"题号","题目","选项A","选项A分数","选项B","选项B分数","选项C","选项C分数","选项D","选项D分数","选项E","选项E分数","选项F","选项F分数"};//列名
		String keys[]={"questionno","question","optiona","optionascore","optionb","optionbscore","optionc","optioncscore","optiond","optiondscore","optione","optionescore","optionf","optionfscore"};//map中的key
		
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
	
	 @RequestMapping("uploadExcelForTempletDetail")  
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
							List<TempletDetail> templetDetails = new ExcelUtil<TempletDetail>(TempletDetail.class).readDataFromXls(path);
							HttpSession session = request.getSession(true);
							String templetId = (String)session.getAttribute("templetId");
							for(TempletDetail templetDetail:templetDetails) {
								templetDetail.setId(CommonUtils.getUUID());
								templetDetail.setTempletId(templetId);
							}
							
							count = templetDetailService.batchInsert(templetDetails);
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
