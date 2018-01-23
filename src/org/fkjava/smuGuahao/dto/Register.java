package org.fkjava.smuGuahao.dto;

/**
 * Register 数据传输类
 * @author xlei @qq 251425887 @tel 13352818008
 * @Email dlei0009@163.com
 * @date 2018-01-08 17:23:36
 * @version 1.0
 */
public class Register implements java.io.Serializable{

	private static final long serialVersionUID = 1L;
	private int id;
	private int userId;
	private int doctorId;
	private String date;

	/** setter and getter method */
	public void setId(int id){
		this.id = id;
	}
	public int getId(){
		return this.id;
	}
	public void setUserId(int userId){
		this.userId = userId;
	}
	public int getUserId(){
		return this.userId;
	}
	public void setDoctorId(int doctorId){
		this.doctorId = doctorId;
	}
	public int getDoctorId(){
		return this.doctorId;
	}
	public void setDate(String date){
		this.date = date;
	}
	public String getDate(){
		return this.date;
	}

}