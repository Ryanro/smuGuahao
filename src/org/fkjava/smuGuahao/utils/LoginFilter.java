package org.fkjava.smuGuahao.utils;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.fkjava.smuGuahao.dto.User;

/**
 * Servlet Filter implementation class LoginFilter
 */
@WebFilter("/LoginFilter")
public class LoginFilter implements Filter {

    /**
     * Default constructor. 
     */
    public LoginFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
	
		// 比如说:访问医生模块的，科室模块的请求都应该拦截
		
		// 判断请求的地址
		String url = ((HttpServletRequest)request).getRequestURL().toString();
		if(url.contains("LoginServlet")||url.contains("createCode.action")){
			chain.doFilter(request, response); 
			System.out.println("请求被拦截了！但是放行了:"+url);
		}else{
			// 必须登陆以后才可以放行 
			// 判断session中是否存在用户对象 
			User user = (User) ((HttpServletRequest)request).getSession().getAttribute(Constants.USER_SESSION);
			if(user!=null){
				chain.doFilter(request, response); 
				System.out.println("请求被拦截了！但是放行了:"+url);
			}else{
				System.out.println("请求被拦截了！:"+url);
				// 响应到登陆界面去
				((HttpServletResponse)response).sendRedirect(((HttpServletRequest)request).getContextPath()+"/LoginServlet?method=getLoginJsp");
			}
		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
