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

import jxl.write.WritableWorkbook;

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
import com.rwkj.jc.domain.PaperDetail;
import com.rwkj.jc.service.PaperDetailService;
import com.rwkj.jc.util.CommonUtils;
import com.rwkj.jc.util.ExcelUtil;

@Controller
public class PaperDetailManageController {
	
	@Resource
	private PaperDetailService paperDetailService;
	
	@InitBinder("paperDetail")    
	public void initBinder2(WebDataBinder binder) {    
		binder.setFieldDefaultPrefix("paperDetail.");    
	}    
	
	@RequestMapping("/admin/paperPreview")
	public ModelAndView paperPreview(HttpServletRequest request){
		
		ModelAndView modelAndView = new ModelAndView();
		String paperId = request.getParameter("paperId");
		List<PaperDetail> paperDetails = paperDetailService.getPaperDetailsByPaperId(paperId);
		modelAndView.addObject("paperDetails",paperDetails);
		modelAndView.setViewName("admin/DataManage/paperPreview");
		return modelAndView;
	}
	@RequestMapping("/admin/paperTest")
	public ModelAndView paperTest(HttpServletRequest request){
		
		ModelAndView modelAndView = new ModelAndView();
		String paperId = request.getParameter("paperId");
		String relationId = request.getParameter("relationId");
		String type = request.getParameter("type");
		List<PaperDetail> paperDetails = paperDetailService.getPaperDetailsByPaperId(paperId);
		modelAndView.addObject("paperDetails",paperDetails);
		modelAndView.addObject("relationId",relationId);
		modelAndView.addObject("type",type);
		modelAndView.setViewName("client/main/paperTest");
		return modelAndView;
	}
	@RequestMapping("/admin/paperDetailList")
	public @ResponseBody Object getPaperDetailList(HttpServletRequest request, 
			@RequestParam(required = false, defaultValue = "1") Integer page, //第几页  
            @RequestParam(required = false, defaultValue = "10") Integer rows){
		Map<String, Object> result = new HashMap<String, Object>(2) ;
		int total = 0;
		String column = "question";
		String value = request.getParameter("value");
		String paperId = request.getParameter("paperId");
		HttpSession session = request.getSession(true);
		if(StringUtils.isNullOrEmpty(paperId)) {
			paperId = (String)session.getAttribute("paperId");
		}else{
			session.setAttribute("paperId", paperId);
		}
		
		List<PaperDetail> paperDetails = null;
		
		if(StringUtils.isNullOrEmpty(value)){
			paperDetails = paperDetailService.getPaperDetails(paperId, (page-1)*rows, rows);
			total = paperDetailService.getPaperDetailsCount(paperId);
		}else{
			value = "%"+value+"%";
			paperDetails = paperDetailService.getPaperDetailsByColumnValue(paperId, column, value, (page-1)*rows, rows);
			total = paperDetailService.getPaperDetailsCountByColumnValue(paperId, column, value);
		}
		
		JSONArray jsonArray = new JSONArray();  
        for(PaperDetail paperDetail:paperDetails){  
             JSONObject jsonObject = new JSONObject();  
             jsonObject.put("id",paperDetail.getId());
             jsonObject.put("PaperId",paperDetail.getPaperId());
             jsonObject.put("question",paperDetail.getQuestion());
             jsonObject.put("questionno",paperDetail.getQuestionno());
             jsonObject.put("optiona",paperDetail.getOptiona());
             jsonObject.put("optionascore",paperDetail.getOptionascore());
             jsonObject.put("optionb",paperDetail.getOptionb());
             jsonObject.put("optionbscore",paperDetail.getOptionbscore());
             jsonObject.put("optionc",paperDetail.getOptionc());
             jsonObject.put("optioncscore",paperDetail.getOptioncscore());
             jsonObject.put("optiond",paperDetail.getOptiond());
             jsonObject.put("optiondscore",paperDetail.getOptiondscore());
             jsonObject.put("optione",paperDetail.getOptione());
             jsonObject.put("optionescore",paperDetail.getOptionescore());
             jsonObject.put("optionf",paperDetail.getOptionf());
             jsonObject.put("optionfscore",paperDetail.getOptionfscore());
             jsonObject.put("issuggest",paperDetail.getIssuggest());
             jsonArray.add(jsonObject) ;  
        }  
		result.put("total", total);  
	    result.put("rows",jsonArray);
		return result;
	}
	
	@RequestMapping("/admin/addPaperDetail")
	public @ResponseBody Map<String,String> addPaperDetail(HttpServletRequest request,@ModelAttribute PaperDetail paperDetail){
		Map<String, String> result = new HashMap<String,String>();
		int count = 0;
		paperDetail.setId(CommonUtils.getUUID());
		HttpSession session = request.getSession(true);
		String paperId = (String)session.getAttribute("paperId");
		paperDetail.setPaperId(paperId);
		count = paperDetailService.addPaperDetail(paperDetail);
		
		if(count>0){
			result.put("result", "success");
		}else{
			result.put("result", "failed");
			result.put("errorMsg", "添加失败，请联系管理员！");
		}
		return result;
	}
	
	@RequestMapping("/admin/getPaperDetailNo")
	public @ResponseBody Map<String,String> getTempletDetailNo(HttpServletRequest request){
		Map<String, String> result = new HashMap<String,String>();
		HttpSession session = request.getSession(true);
		String paperId = (String)session.getAttribute("paperId");
		int total = paperDetailService.getPaperDetailsCount(paperId);
		result.put("total", String.valueOf(total+1));
		return result;
	}
	
	@RequestMapping("/admin/updatePaperDetail")
	public @ResponseBody Map<String,String> updatePaperDetail(@ModelAttribute PaperDetail paperDetail){
		int count = 0;
		Map<String, String> result = new HashMap<String,String>();
		count = paperDetailService.updatePaperDetail(paperDetail);
		if(count>0){
			result.put("result", "success");
		}else{
			result.put("result", "failed");
			result.put("errorMsg", "更新失败");
		}
		return result;
	}
	
	@RequestMapping("/admin/deletePaperDetail")
	public @ResponseBody Map<String,String> deletePaperDetail(HttpServletRequest request,@RequestParam("id") String id){
		Map<String,String> map = new HashMap<String,String>();
		List<PaperDetail> deletePaperDetails = paperDetailService.getPaperDetailByIds("("+id.substring(1)+")");
		int questionNo= deletePaperDetails.get(deletePaperDetails.size()-1).getQuestionno();
		HttpSession session = request.getSession(true);
		String paperId = (String)session.getAttribute("paperId");
		List<PaperDetail> paperDetails = paperDetailService.getPaperDetailsByPaperId(paperId);
		int count = paperDetailService.deletePaperDetails("("+id.substring(1)+")");
		if(count>0){
			map.put("result", "success");
			for(PaperDetail tempPaperDetail:paperDetails) {
				if(tempPaperDetail.getQuestionno()>questionNo) {
					tempPaperDetail.setQuestionno(tempPaperDetail.getQuestionno()-deletePaperDetails.size());
					paperDetailService.updatePaperDetail(tempPaperDetail);
				}
			}
		}else {
			map.put("result", "failed");
		}
		return map;
	}
	
	@RequestMapping("/admin/checkPaperDetailNameUnique")
	public @ResponseBody Map<String,String> checkPaperDetailNameUnique(HttpServletRequest request,@RequestParam("name") String name){
		Map<String,String> map = new HashMap<String,String>();
		HttpSession session = request.getSession(true);
		String paperId = (String)session.getAttribute("paperId");
		if(paperDetailService.checkPaperDetailQuestionName(paperId, name)){
			map.put("result", "failed");
		}else{
			map.put("result", "success");
		}
		return map;
	}
	
	@RequestMapping("/admin/exportExcelForPaperDetail")
	public void exportExcel(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String fileName = "模板题目一览表";
		HttpSession session = request.getSession(true);
		String paperId = (String)session.getAttribute("paperId");
		List<PaperDetail> paperDetails = paperDetailService.getPaperDetailsByPaperId(paperId);
		ExcelUtil<PaperDetail> excelUtil = new ExcelUtil<PaperDetail>(PaperDetail.class);
		List<Map<String,Object>> list = excelUtil.createExcelRecord(paperDetails, "模板题目一览");
		
		String columnNames[]={"题号","题目","选项A","选项A分数","选项B","选项B分数","选项C","选项C分数","选项D","选项D分数","选项E","选项E分数","选项F","选项F分数","是否添加建议项"};//列名
		String keys[]={"questionno","question","optiona","optionascore","optionb","optionbscore","optionc","optioncscore","optiond","optiondscore","optione","optionescore","optionf","optionfscore","issuggest"};//map中的key
		
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
	
	 @RequestMapping("/admin/uploadExcelForPaperDetail")  
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
							List<PaperDetail> paperDetails = new ExcelUtil<PaperDetail>(PaperDetail.class).readDataFromXls(path);
							HttpSession session = request.getSession(true);
							String paperId = (String)session.getAttribute("paperId");
							for(PaperDetail paperDetail:paperDetails) {
								paperDetail.setId(CommonUtils.getUUID());
								paperDetail.setPaperId(paperId);
							}
							
							count = paperDetailService.batchInsert(paperDetails);
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
