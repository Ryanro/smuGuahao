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
	public List<Part> findAllParts(String parentCode) {
		// 拿持久层对象去查询数据库
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSession();
		
		PartMapper partMapper = sqlSession.getMapper(PartMapper.class);
		
		List<Part> parts = partMapper.selectAllSon(parentCode);
		
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

	@Override
	public String findNameByCode(String parentCode) {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSession();
		
		PartMapper partMapper = sqlSession.getMapper(PartMapper.class);
		
		String name = partMapper.findNameByCode(parentCode);
		sqlSession.close();
		return name;
	}

	@Override
	public void deletePartsByCode(String ids) {
		// [ 0001 , 0003 , 0004 ]
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSession();
		PartMapper partMapper = sqlSession.getMapper(PartMapper.class);
		String[] codes = ids.split(",");
		for(String code : codes){
			partMapper.delete(code+"%"); //子科室一起删除
		}
		sqlSession.commit();
		sqlSession.close();
	}
	
	@Override
	public String getNextSonCode(String parentCode) {
		parentCode = parentCode==null ? "" : parentCode;
		// 1.查询出当前最大的儿子编号 
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSession();
		PartMapper partMapper = sqlSession.getMapper(PartMapper.class);
		String currentMaxSonCode = partMapper.getMaxSonCode(parentCode);
		sqlSession.close();
		// 分别分析null ""0004 00010007 00010024 00019999
		//System.out.println("当前最大儿子节点编号："+currentMaxSonCode);
		// 2.判断当前最大儿子节点编号是否为空 
		if(currentMaxSonCode!=null){
			// 截取编号的后4位
			String sonCodeStr = currentMaxSonCode.substring(parentCode.length());
			// 转成编号整形形式 
			// 
			int sonCodeInt = Integer.valueOf(sonCodeStr);
			// 下一级编号 
			sonCodeInt++;  // 8 25 ...
			// 判断是否越界了 
			if(sonCodeInt > 9999){
				throw new RuntimeException("您的编号用完了！");
			}else{
				// 编号 ： 父节点编号 + 补0 + 下一级编号  40
				String preZero = "" ;
				for(int i = 0 ; i < 4 - (sonCodeInt+"").length() ; i++ ){
					preZero+="0"; // preZero = preZero + 0;
				}
				return parentCode + preZero + sonCodeInt;
			}
			
		}else{
			// 父节点编号+0001
			return parentCode + "0001";
		}
	}
	
	@Override
	public void save(Part part) {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSession();
		PartMapper partMapper = sqlSession.getMapper(PartMapper.class);
		partMapper.save(part);
		sqlSession.commit();
		sqlSession.close();
	}

}
