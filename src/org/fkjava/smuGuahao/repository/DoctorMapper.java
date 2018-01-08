package org.fkjava.smuGuahao.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.annotations.Select;
import org.fkjava.smuGuahao.dto.Doctor;
import org.fkjava.smuGuahao.utils.PageModel;

/**
 * DoctorMapper 数据访问类
 * @author xlei @qq 251425887 @tel 13352818008
 * @Email dlei0009@163.com
 * @date 2018-01-04 22:05:43
 * @version 1.0
 */
public interface DoctorMapper {
	// 定义动态Sql语句查询数据
		List<Doctor> findAll(@Param("doc")Doctor doctor , @Param("pageModel")PageModel pageModel);
	    
		@Delete("delete from doc_doctor where id = #{id}")
		void deleteDocById(String id);

		int count(@Param("doc")Doctor doctor);



}