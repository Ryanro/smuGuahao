package org.fkjava.smuGuahao.repository;


import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.fkjava.smuGuahao.dto.User;

/**
 * UserMapper 数据访问类
 * @author xlei @qq 251425887 @tel 13352818008
 * @Email dlei0009@163.com
 * @date 2018-01-04 22:05:43
 * @version 1.0
 */
public interface UserMapper {

	@Select("select * from doc_user where LOGIN_NAME = #{xxxx}")
	@ResultMap("userResultMap")
	User selectUserByUserId(String userId);

	
	void setNewPageSize(User user);


	



}