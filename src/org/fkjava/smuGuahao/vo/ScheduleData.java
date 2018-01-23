package org.fkjava.smuGuahao.vo;

import java.util.List;

import org.fkjava.smuGuahao.dto.Doctor;

//排珍信息
public class ScheduleData {
	// 医生
	private Doctor doctor; 
	// 未来七天的排诊信息
	private List<WorkInfo> workInfos ;
	private List<RegisterInfo> RegisterInfos ;
	
	public List<RegisterInfo> getRegisterInfos() {
		return RegisterInfos;
	}
	public void setRegisterInfos(List<RegisterInfo> registerInfos) {
		RegisterInfos = registerInfos;
	}
	public Doctor getDoctor() {
		return doctor;
	}
	public void setDoctor(Doctor doctor) {
		this.doctor = doctor;
	}
	public List<WorkInfo> getWorkInfos() {
		return workInfos;
	}
	public void setWorkInfos(List<WorkInfo> workInfos) {
		this.workInfos = workInfos;
	}	
}
