package org.fkjava.smuGuahao.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.fkjava.smuGuahao.dto.Doctor;
import org.fkjava.smuGuahao.dto.Part;
import org.fkjava.smuGuahao.dto.Register;
import org.fkjava.smuGuahao.dto.Schedule;
import org.fkjava.smuGuahao.dto.User;
import org.fkjava.smuGuahao.utils.PageModel;

import org.fkjava.smuGuahao.vo.ScheduleData;

public interface GuahaoService {
	/**
	 * 查询所有科室
	 * @return
	 */
	List<Part> findAllParts();

	/**
	 * 查询登录信息
	 * @param userId
	 * @param passWord
	 * @param vcode
	 * @param session
	 * @return
	 */
	Map<String, Object> login(String userId, String passWord, String vcode, HttpSession session);

	/**
	 * 分页查询所有的医生信息 
	 * @return
	 */
	List<Doctor> findAllDocs(Doctor doctor,PageModel pageModel);

	/**
	 * 根据医生的编号删除医生信息
	 * @param id
	 */
	void deleteDocById(String id);

	/**
	 * 更新用户的pagesize信息
	 * @param user
	 */
	void setNewPageSize(User user);

	/**
	 * 根据父节点查询科室信息
	 * @param parentCode
	 * @return
	 */
	List<Part> findAllParts(String parentCode);

	/**
	 * 查询父节点科室名字
	 * @param parentCode
	 * @return
	 */
	String findNameByCode(String parentCode);

	void deletePartsByCode(String ids);
	
	/**
	 * 根据父节点获取它的下一个最大儿子节点编号 
	 * @param parentCode
	 * @return
	 */
	String getNextSonCode(String parentCode);

	void save(Part part);

	

	List<ScheduleData> loadDocscheduleDatas(Doctor doctor , List<String> dates,PageModel pageModel) throws Exception;

	Doctor getDocById(String id);

	/**
	 * 更新user基本信息
	 * @param user
	 */
	void UpdateMessage(User user);

	/**
	 * 查找user信息
	 * @param user
	 * @return 
	 */
	User SelectMessagebyId(int id);

	void saveScheduleData(ScheduleData scheduleData) throws Exception;

	void addNewRegister(Register register);



	void decnum(String date, int doctorId);
}
