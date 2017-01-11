package com.rwkj.jc.controller;

import java.text.NumberFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.rwkj.jc.domain.PaperDetail;
import com.rwkj.jc.domain.Relation;
import com.rwkj.jc.domain.Result;
import com.rwkj.jc.service.PaperDetailService;
import com.rwkj.jc.service.RelationService;
import com.rwkj.jc.service.ResultService;
import com.rwkj.jc.util.CommonUtils;

@Controller
public class PaperTestController {
	
	@Resource
	private RelationService relationService;
	@Resource
	private PaperDetailService paperDetailService;
	@Resource
	private ResultService resultService;
	
	
	@RequestMapping("/client/submitPaper")
	public @ResponseBody Map<String,String> addPaperDetail(HttpServletRequest request){
		int count = 0;
		Map<String, String> result = new HashMap<String,String>();
		String total = request.getParameter("total");
		String answerTotal = request.getParameter("answerTotal");
		String relationId = request.getParameter("relationId");
		String type = request.getParameter("type");
		String resultMessage = request.getParameter("resultMessage");
		String extraMeassge = request.getParameter("extraMeassge");
		Result resultForTest = new Result();
		resultForTest.setId(CommonUtils.getUUID());
		resultForTest.setRelationId(relationId);
		NumberFormat numberFormat = NumberFormat.getInstance();
		numberFormat.setMaximumFractionDigits(2);  
		resultForTest.setAnswerproportion(Integer.parseInt(numberFormat.format((float) Integer.parseInt(answerTotal) / (float) Integer.parseInt(total) * 100)));
		resultForTest.setResultmessage(StringUtils.isEmpty(resultMessage)?resultMessage:resultMessage.substring(1));
		resultForTest.setExtrameassge(StringUtils.isEmpty(extraMeassge)?extraMeassge:extraMeassge.substring(1));
		
		Relation relation = relationService.getRelationById(relationId);
		if("true".equals(type)) {
			int score = 0;
			
			String paperId = relation.getPaperId();
			List<PaperDetail> paperDetails = paperDetailService.getPaperDetailsByPaperId(paperId);
			Map<String,Map<String,Short>> scoreMap = new HashMap<String,Map<String,Short>>();
			Map<String,Short> scores = null;
			for(PaperDetail paperDetail:paperDetails) {
				scores = new HashMap<String,Short>();
				scores.put("A", paperDetail.getOptionascore());
				scores.put("B", paperDetail.getOptionbscore());
				scores.put("C", paperDetail.getOptioncscore());
				scores.put("D", paperDetail.getOptiondscore());
				scores.put("E", paperDetail.getOptionescore());
				scores.put("F", paperDetail.getOptionfscore());
				scoreMap.put(String.valueOf(paperDetail.getQuestionno()), scores);
			}
			String[] answerArr = resultMessage.substring(1).split(",");
			for(String str:answerArr) {
				String questionNo = str.split(":")[0];
				String answer = str.split(":")[1];
				score = score + scoreMap.get(questionNo).get(answer);
			}
			resultForTest.setScore(score);
			
		}
		resultForTest.setStatus(true);
		resultForTest.setCreatetime(new Date());
		
		count = resultService.addResult(resultForTest);
		
		if(count>0){
			relation.setIsfinish(true);
			relationService.updateRelation(relation);
			result.put("result", "success");
		}else{
			result.put("result", "failed");
		}
		return result;
	}
	
}
