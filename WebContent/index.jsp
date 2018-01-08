<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  


<!-- JSTL c标签：做自动跳转，跳转到登录界面  -->
<c:redirect url="LoginServlet?method=getLoginJsp"></c:redirect>