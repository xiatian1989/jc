package com.rwkj.jc.util;

import java.io.File;
import java.io.OutputStream;
import java.lang.reflect.Field;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.mysql.jdbc.StringUtils;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.format.VerticalAlignment;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

public class ExcelUtil<E> {
	
	private Class<E> EntityClass; // 获取实体类
	
	public ExcelUtil(Class<E> cla){
		EntityClass = cla;
	}
	
	@SuppressWarnings("unchecked")
	public List<E> readDataFromXls(String path) throws Exception{
		Workbook book = Workbook.getWorkbook(new File(path));
		 // 获得第一个工作表对象
        Sheet sheet = book.getSheet(0);
        int rows=sheet.getRows();
        int columns=sheet.getColumns();
        Field[] fields = EntityClass.getDeclaredFields();
        List<E> objects = new ArrayList<E>();
        Object object = null;
        Cell cell = null;
        String value="";
        a:for(int i = 1;i<rows;i++){
        	object = EntityClass.newInstance();
        	for(int j = 0;j<columns;j++){
        		if(fields[j+1].getName().equals("templetId") || fields[j+1].getName().equals("paperId")){
        			continue;
        		}
        		cell = sheet.getCell(j, i);
        		value = cell.getContents();
        		if(StringUtils.isNullOrEmpty(value) && j==0) {
        			break a;
        		}else if(StringUtils.isNullOrEmpty(value)){
        			continue;
        		}
        		fields[j+1].setAccessible(true);
        		if("女".equals(value.trim())){
        			fields[j+1].set(object, true);
        		}else if("男".equals(value.trim())){
        			fields[j+1].set(object, false);
        		}else if("是".equals(value.trim())) {
        			fields[j+1].set(object, true);
        		}else if("否".equals(value.trim())){
        			fields[j+1].set(object, false);
        		}else if(CommonUtils.isValidDate(value)){
        			fields[j+1].set(object, new SimpleDateFormat("yyyy-MM-dd").parse(value));
        		}else if(fields[j+1].getType().equals(Double.class)){
        			fields[j+1].set(object, Double.valueOf(value));
        		}else if(fields[j+1].getType().equals(Integer.class)){
        			fields[j+1].set(object, Integer.valueOf(value));
        		}else if(fields[j+1].getType().equals(Short.class)){
        			fields[j+1].set(object, Short.valueOf(value));
        		}else{
        			fields[j+1].set(object, value);
        		}
        	}
        	objects.add((E) object);
        }
		return objects;
	}
	
	public List<Map<String, Object>> createExcelRecord(List<E> objects,String sheetName) throws Exception{
        List<Map<String, Object>> listmap = new ArrayList<Map<String, Object>>();
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("sheetName", sheetName);
        listmap.add(map);
        Field[] fields = EntityClass.getDeclaredFields();
        Object object=null;
        for (int j = 0; j < objects.size(); j++) {
        	object=objects.get(j);
            Map<String, Object> mapValue = new HashMap<String, Object>();
            for(int i = 1 ;i < fields.length ;i++ ){
            	fields[i].setAccessible(true);
            	mapValue.put(fields[i].getName(), fields[i].get(object));
            }
            listmap.add(mapValue);
        }
        return listmap;
    }
	
	public WritableWorkbook createWorkBook(List<Map<String, Object>> list,String []keys,String columnNames[],OutputStream os) throws Exception{
		WritableWorkbook  book = Workbook.createWorkbook(os);
		WritableSheet sheet = book.createSheet(list.get(0).get("sheetName").toString(), 0);
		for(int i=0;i<keys.length;i++){
            sheet.setColumnView(i, 20);
        }
		WritableCellFormat headFormat = getHeadFormat();
		Label titleLabel = null;
		for(int i= 0; i<columnNames.length;i++) {
			titleLabel = new Label(i, 0, columnNames[i], headFormat);
			sheet.addCell(titleLabel);
		}
		Label valueLabel = null;
		Object obj = null;
		for(int i = 1;i<list.size();i++){
			for(int j=0;j<keys.length;j++){
				obj = list.get(i).get(keys[j]);
				if(obj == null){
					continue;
				}
				if(obj instanceof Boolean){
					if(keys[j].equals("sex")) {
						if((Boolean)obj){
							valueLabel = new Label(j, i, "女");
						}else{
							valueLabel = new Label(j, i, "男");
						}
					}else{
						if((Boolean)obj){
							valueLabel = new Label(j, i, "是");
						}else{
							valueLabel = new Label(j, i, "否");
						}
					}
				}else if(obj instanceof Date) {
					valueLabel = new Label(j, i, new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format((Date)obj));
				}else {
					valueLabel = new Label(j, i,obj.toString());
				}
				sheet.addCell(valueLabel);
			}
		}
		return book;
	}
	private WritableCellFormat getHeadFormat() throws Exception {   
        //设置字体   
        WritableFont wf = new WritableFont(WritableFont.ARIAL, 8, WritableFont.BOLD);   
           
        //创建单元格FORMAT   
        WritableCellFormat wcf = new WritableCellFormat(wf);   
        wcf.setAlignment(Alignment.CENTRE);                            
        wcf.setVerticalAlignment(VerticalAlignment.CENTRE);            
        wcf.setLocked(true);   
        wcf.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);   
        wcf.setBackground(Colour.GREY_25_PERCENT);   
        return wcf;   
    }   
}
