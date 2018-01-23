package org.fkjava.smuGuahao.utils;

public class Constants {
	public static final String SESSION_CODE = "SESSION_CODE";
	
	public static final String USER_SESSION = "user_session";
	
	/**
	 * @param morning
	 * @param after
	 * @param night
	 * @return
	 */
	public static String getWorkTimerStatus(String morning ,String after , String night){
		 // 101 111 101
		 String status = "" ;
		 if("on".equals(morning)){
			 if("on".equals(after)){
				 if("on".equals(night)){
					 status = "3" ;
				 }else{
					 status = "2" ;
				 }
			 }else{
				 if("on".equals(night)){
					 status = "4" ;
				 }else{
					 status = "1" ;
				 }
			 }
		 }else{
			 if("on".equals(after)){
				 if("on".equals(night)){
					 status = "7" ;
				 }else{
					 status = "6" ;
				 }
			 }else{
				 if("on".equals(night)){
					 status = "8" ;
				 }else{
					 status = "5" ;
				 }
			 }
		 }
		 return status;
	}
	
//	   1  上午工作 下午休息 晚上休息  001
//     2 上午工作 下午工作 晚上休息 
//     3 上午工作 下午工作 晚上工作
//     4 上午工作 下午休息 晚上工作
//     5 上午休息 下午休息 晚上休息   这一天休息
//     6 上午休息 下午工作 晚上休息 
//     7 上午休息 下午工作 晚上工作
//     8 上午休息 下午休息 晚上工作
	
}
