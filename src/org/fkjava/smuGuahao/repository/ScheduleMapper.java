package org.fkjava.smuGuahao.repository;

import java.util.Date;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.fkjava.smuGuahao.dto.Schedule;
import org.fkjava.smuGuahao.vo.ScheduleData;

/**
 * ScheduleMapper 数据访问类
 * @author xlei @qq 251425887 @tel 13352818008
 * @Email dlei0009@163.com
 * @date 2018-01-08 17:23:36
 * @version 1.0
 */
public interface ScheduleMapper {
	   
	@Select("select * from doc_schedule where DATE = #{date} and doctor_id = #{id}")
	@ResultMap("resultRegister")
	Schedule getWorkInfo(@Param("date")Date date, @Param("id")int id);

	void deteleSchedule(@Param("scheduleData")ScheduleData scheduleData, @Param("date")Date d);

	void save(Map<String,Object> params);

	@Update("update doc_schedule set num = num - 1 where DATE = #{date} and doctor_id = #{doctorId}")
	@ResultMap("resultRegister")
	void decnum(@Param("date")String date, @Param("doctorId")int doctorId);


}