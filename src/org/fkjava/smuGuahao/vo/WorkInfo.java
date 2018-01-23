package org.fkjava.smuGuahao.vo;

import java.util.Date;

import org.fkjava.smuGuahao.utils.DateUtils;

public class WorkInfo {
	private Date date ;
    private int num ; // 这一天的接诊量 
    private String work_timer ; // 1 - 8 ;
    
    public String getDateStr(){
    	try {
			return DateUtils.getDate(date);
		} catch (Exception e) {
			e.printStackTrace();
			return null ;
		}
    }
	
    public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getWork_timer() {
		return work_timer;
	}
	public void setWork_timer(String work_timer) {
		this.work_timer = work_timer;
	}
    
    
}