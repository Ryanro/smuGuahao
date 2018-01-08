package org.fkjava.smuGuahao.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.fkjava.smuGuahao.dto.Doctor;
import org.fkjava.smuGuahao.dto.Part;
import org.fkjava.smuGuahao.utils.PageModel;

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
}
