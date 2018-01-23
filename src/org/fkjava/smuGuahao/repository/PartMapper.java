package org.fkjava.smuGuahao.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
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

	@Select("SELECT * FROM doc_part WHERE PART_CODE LIKE CONCAT(#{xxxx},'%') AND LENGTH(PART_CODE) =  (LENGTH(#{xxxx}) + 4) ")
	@ResultMap("partResultMap")
	List<Part> selectAllSon(String parentCode);
	
    @Select("select NAME from doc_part where PART_CODE = #{xxds}")
	String findNameByCode(String parentCode);
    
    @Select("select * from doc_part where PART_CODE = #{xxds}")
    @ResultMap("partResultMap")
   	String findByCode(String parentCode);

    @Delete("delete from doc_part where PART_CODE like #{xxxx}")
	void delete(String code);
    
	@Select("SELECT MAX(PART_CODE) FROM doc_part WHERE PART_CODE LIKE CONCAT(#{xxxx},'%','') AND LENGTH(PART_CODE) =  (LENGTH(#{xxx}) + 4) ")
	String getMaxSonCode(String parentCode);
    
	@Insert("insert into doc_part(part_code , name ,remark ) values(#{partCode} , #{name} , #{remark})")
	void save(Part part);

}



