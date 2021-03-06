<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>	
<body>
	<input type="text" id="planId" style="display: none">
	<input type="text" id="paperId" style="display: none">
	<input type="text" id="type" style="display: none">
	<input type="text" id="ruleId" style="display: none">
	<div class="easyui-layout" style="width:970px;height:100%;overflow: hidden;">
		<div data-options="region:'east',split:true" title="" style="width:350px;">
			&nbsp;部门:<select id="departNoRight" name="departNoRight" style="width:140px;" onchange="changeDepartRight()">
			</select>
			&nbsp;&nbsp;对象类型:
			<select id="beTestedType" name="beTestedType" style="width:100px;" onchange="changeDepartRight()">
				<option value="0">人员</option>
				<option value="1">部门</option>
			</select>
			<ul class="easyui-tree" data-options="url:'${pageContext.request.contextPath}/admin/departListForUser',checkbox:true,lines:true" id="ttRight" ></ul>
		</div>
		<div data-options="region:'west',split:true" title="" style="width:350px;">
			&nbsp;部门:<select id="departNoLeft" name="departNoLeft" style="width:140px;" onchange="changeDepartLeft()">
			</select>
			<ul class="easyui-tree" data-options="url:'${pageContext.request.contextPath}/admin/departListForUser',checkbox:true,lines:true" id="ttLeft" ></ul>
		</div>
		<div data-options="region:'center',title:'',iconCls:'icon-ok'">
			<div style="text-align: center;margin-top: 50px">
				<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="choosePlan()">选择测评计划</a><br><br>
				<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="choosePaper()">选择测评试卷</a><br><br>
				<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addRelationRule()" id="addRelationRule" style="display: none">添加测评规则</a><br><br>
				<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="createRelation()">建立测评关系</a><br><br>
			</div>
		</div>
	</div>
	<div id="winForPlan" class="easyui-window" title="选择测评计划" style="width:900px;height:460px"
   	 	data-options="iconCls:'icon-save',modal:true,closed:true,cache: false">
	</div>
	<div id="winForpaper" class="easyui-window" title="添加测评试卷" style="width:900px;height:460px"
   	 	data-options="iconCls:'icon-save',modal:true,closed:true,cache: false">
	</div>
	<div id="dlgForRule" class="easyui-dialog"
		style="width: 450px; height: 418px; padding: 10px 20px" closed="true" buttons="#dlg-buttonsForRule">
		
		<form id="fmForRule" method="post">
			<input id=id name=id  style="display:none">
			<table>
				<tr>
					<td style="height: 28px" width=130>第一档次描述：</td>
					<td style="height: 28px" width=300>
						<input id=firstname style="width: 255px" name=firstname class="easyui-validatebox" required="true">
					</td>
				</tr>
				<tr>
					<td style="height: 28px" width=120>第一档次范围：</td>
					<td style="height: 28px" width=300>
						<input class="easyui-numberspinner" value="100" data-options="min:0,max:200,required:true,onChange:function(value){changeFirst(value)}" style="width:120px;" name="first" id="first"></input>
						~ 满分
					</td>
				</tr>
				<tr>
					<td style="height: 28px" width=130>第二档次描述：</td>
					<td style="height: 28px" width=300>
						<input id=secondname style="width: 255px" name=secondname class="easyui-validatebox" required="true">
					</td>
				</tr>
				<tr>
					<td style="height: 28px" width=130>第二档次范围：</td>
					<td style="height: 28px" width=300>
						<input class="easyui-numberspinner" value="80" data-options="min:0,max:200,required:true,onChange:function(value){changeSecond(value)}" style="width:120px;"name="second" id="second"></input> ~ 
						<input class="easyui-numberbox" value="" id="firstCopy" style="width:120px;" readonly="readonly"></input>
					</td>
				</tr>
				<tr>
					<td style="height: 28px" width=130>第三档次描述：</td>
					<td style="height: 28px" width=300>
						<input id=thirdname style="width: 255px" name=thirdname class="easyui-validatebox" required="true">
					</td>
				</tr>
				<tr>
					<td style="height: 28px" width=130>第三档次范围：</td>
					<td style="height: 28px" width=300>
						<input class="easyui-numberspinner" value="60" data-options="min:0,max:200,required:true,onChange:function(value){changeThird(value)}" style="width:120px;" name="third" id="third"></input> ~ 
						<input class="easyui-numberbox" value="" style="width:120px;" id="secondCopy" readonly="readonly"></input>
					</td>
				</tr>
				<tr>
					<td style="height: 28px" width=130>第四档次描述：</td>
					<td style="height: 28px" width=300>
						<input id=forthname style="width: 255px" name=forthname class="easyui-validatebox">
					</td>
				</tr>
				<tr>
					<td style="height: 28px" width=130>第四档次范围：</td>
					<td style="height: 28px" width=300>
						<input class="easyui-numberspinner" value="40" data-options="min:0,max:200,onChange:function(value){changeForth(value)}" style="width:120px;" name="forth" id="forth"></input> ~ 
						<input class="easyui-numberbox" value="" style="width:120px;" id="thirdCopy" readonly="readonly"></input>
					</td>
				</tr>
				<tr>
					<td style="height: 28px" width=130>第五档次描述：</td>
					<td style="height: 28px" width=300>
						<input id=fifthname style="width: 255px" name=fifthname class="easyui-validatebox">
					</td>
				</tr>
				<tr>
					<td style="height: 28px" width=130>第五档次范围：</td>
					<td style="height: 28px" width=300>
						<input class="easyui-numberspinner" value="20" data-options="min:0,max:200" style="width:120px;" name="fifth" id="fifth"></input> ~ 
						<input class="easyui-numberbox" value="" style="width:120px;" id="forthCopy" readonly="readonly"></input>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div id="dlg-buttonsForRule">
		<a href="#" class="easyui-linkbutton" iconCls="icon-ok"
			onclick="saveRule()">保存</a> <a href="#" class="easyui-linkbutton"
			iconCls="icon-cancel" onclick="cancelForRule();">取消</a>
	</div>
</body>
</html>