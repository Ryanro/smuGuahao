package org.fkjava.smuGuahao.utils;

import java.io.InputStream;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class MybatisSqlSessionFactory {
	// 1.得到Mybatis框架的连接工厂：生产连接  
	public static SqlSessionFactory sqlSessionFactory ;
	// 2.静态代码块 类加载的时候就执行的
	static{
		try {
			String resource = "mybatis-config.xml";
			// 3.把配置加载到内存中，转成一个字节输入流
			InputStream inputStream = Resources.getResourceAsStream(resource);
			// 4.再把mybatis的配置文件转换成mybatis的连接工厂
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 5生产连接 
	public static SqlSession getSqlSession(){
		 try {
			return sqlSessionFactory.openSession();
		} catch (Exception e) {
			e.printStackTrace();
			return null ;
		}
	}
	
	
}
