package org.fkjava.smuGuahao.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.fkjava.smuGuahao.dto.Doctor;
import org.fkjava.smuGuahao.dto.Part;
import org.fkjava.smuGuahao.dto.User;
import org.fkjava.smuGuahao.repository.DoctorMapper;
import org.fkjava.smuGuahao.repository.PartMapper;
import org.fkjava.smuGuahao.repository.UserMapper;
import org.fkjava.smuGuahao.service.GuahaoService;
import org.fkjava.smuGuahao.utils.Constants;
import org.fkjava.smuGuahao.utils.MybatisSqlSessionFactory;
import org.fkjava.smuGuahao.utils.PageModel;

public class GuahaoServiceImpl implements GuahaoService {
	@Override
	public List<Part> findAllParts() {
		//拿持久层对象去查询数据库
		//拿数据库连接
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSession();
		PartMapper partMapper = sqlSession.getMapper(PartMapper.class);
		
		List<Part> parts = partMapper.selectAll();
		//查询出来后释放链接
		sqlSession.close();
		return parts;
		
	}


	@Override
	public Map<String, Object> login(String userId, String passWord, String vcode, HttpSession session) {		
		//{key=value, key=value}
		//{code=0,msg=""} 
		Map<String, Object> params = new HashMap<>();
		// 首先判断参数是否合法
		//判断验证码是否正确
		String sysCode = (String) session.getAttribute(Constants.SESSION_CODE);
		if(vcode.equalsIgnoreCase(sysCode)) { //忽略大小写的比较
			//取用户名去数据库查询用户,判断用户名是否存在
			//1.拿数据库连接
			SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSession();
			//2.拿持久层对象去查询数据库
			UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
			User user = userMapper.selectUserByUserId(userId);
			
			if(user != null) {
				//This userId has been registered.
				//Judege the user's password
				if(user.getPassWord().equals(passWord)) {
					//Login successful, deposit this userId into the current client's session
					session.setAttribute(Constants.USER_SESSION, user);
					params.put("code",0);
				}else {
					//Login failed
					params.put("code",1);
					params.put("msg","密码错误了" );
				}
			}else {
				//Login failed, this userId has not been registered.
				//return to the login.jsp
				params.put("code",2);
				params.put("msg","该用户名没有注册" );
			}
			sqlSession.close();//连接池用完后释放 
		}else {
			 //验证码错了
			params.put("code",3);
			params.put("msg","验证码错了" );
		}
		
		return params;
	}


	@Override
	public List<Doctor> findAllDocs(Doctor doctor, PageModel pageModel) {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSession();
		DoctorMapper doctorMapper = sqlSession.getMapper(DoctorMapper.class);
		// 查询当前总的数据量注入给pageModel
		int count = doctorMapper.count(doctor);
		pageModel.setTotalCount(count);
		// pageModel : 控制当前查询第几页数据
 		List<Doctor> doctors = doctorMapper.findAll(doctor ,pageModel);
		sqlSession.close();
		return doctors;
	}


	@Override
	public void deleteDocById(String id) {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSession();
		DoctorMapper doctorMapper = sqlSession.getMapper(DoctorMapper.class);
		doctorMapper.deleteDocById(id);
		sqlSession.commit();//删完信息需要提交（事物的概念）
		sqlSession.close();
		
	}


	@Override
	public void setNewPageSize(User user) {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSession();
		UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
		userMapper.setNewPageSize(user);
		sqlSession.commit();//更新信息需要提交
		sqlSession.close();
	}

}
