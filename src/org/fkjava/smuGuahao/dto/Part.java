package org.fkjava.smuGuahao.dto;

/**
 * Part 数据传输类
 * @author xlei @qq 251425887 @tel 13352818008
 * @Email dlei0009@163.com
 * @date 2018-01-08 17:23:36
 * @version 1.0
 */
public class Part implements java.io.Serializable{

	private static final long serialVersionUID = 1L;
	private String partCode;
	private String name;
	private String remark;

	/** setter and getter method */
	public void setPartCode(String partCode){
		this.partCode = partCode;
	}
	public String getPartCode(){
		return this.partCode;
	}
	public void setName(String name){
		this.name = name;
	}
	public String getName(){
		return this.name;
	}
	public void setRemark(String remark){
		this.remark = remark;
	}
	public String getRemark(){
		return this.remark;
	}
	@Override
	public String toString() {
		return "Part [partCode=" + partCode + ", name=" + name + ", remark="
				+ remark + "]\n";
	}
	
}