package org.fkjava.smuGuahao.dto;

/**
 * Schedule 数据传输类
 * @author xlei @qq 251425887 @tel 13352818008
 * @Email dlei0009@163.com
 * @date 2018-01-04 22:05:43
 * @version 1.0
 */
public class Schedule implements java.io.Serializable{

	private static final long serialVersionUID = 1L;
	private int id;
	private int doctorId;
	private java.util.Date date;
	private int num;

	/** setter and getter method */
	public void setId(int id){
		this.id = id;
	}
	public int getId(){
		return this.id;
	}
	public void setDoctorId(int doctorId){
		this.doctorId = doctorId;
	}
	public int getDoctorId(){
		return this.doctorId;
	}
	public void setDate(java.util.Date date){
		this.date = date;
	}
	public java.util.Date getDate(){
		return this.date;
	}
	public void setNum(int num){
		this.num = num;
	}
	public int getNum(){
		return this.num;
	}

}