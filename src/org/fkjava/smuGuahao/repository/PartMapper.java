package org.fkjava.smuGuahao.repository;

import java.util.List;

import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.annotations.Select;
import org.fkjava.smuGuahao.dto.Part;

/**
 * PartMapper 数据访问类
 * @author xlei @qq 251425887 @tel 13352818008
 * @Email dlei0009@163.com
 * @date 2018-01-04 22:05:43
 * @version 1.0
 */
public interface PartMapper {
	
	@Select("select * from doc_part ")
	@ResultMap("partResultMap")
	List<Part> selectAll();



}