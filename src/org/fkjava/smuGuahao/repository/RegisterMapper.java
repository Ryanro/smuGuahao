package org.fkjava.smuGuahao.repository;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.ResultMap;
import org.fkjava.smuGuahao.dto.Register;

/**
 * RegisterMapper 数据访问类
 * @author xlei @qq 251425887 @tel 13352818008
 * @Email dlei0009@163.com
 * @date 2018-01-08 17:23:36
 * @version 1.0
 */
public interface RegisterMapper {
	
	
	@Insert("insert into doc_register(user_ID , doctor_ID ,DATE ) values(#{userId} , #{doctorId} , #{date})")
	@ResultMap("registerResultMap")
	void addNewRegister(Register register);



}