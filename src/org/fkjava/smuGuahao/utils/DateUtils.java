package org.fkjava.smuGuahao.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class DateUtils {
	
	public static String getDate(Date date) throws Exception{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd EEE");
		return sdf.format(date);
	}
	
	public static Date getDateEEE(String date) throws Exception{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd EEE");
		return sdf.parse(date);
	}
	
	public static Date getDate(String date) throws Exception{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		return sdf.parse(date);
	}
	
	
	
	public static void main(String[] args) {
		System.out.println(get8FutureSevenDates());
	}
	
	// 从未来的第八天开始 
	public static List<String> get8FutureSevenDates() {
		// 查询出未来七天的日期
		// List<String>
		List<String> dates = new ArrayList<>();
		// 定义一个日历对象
		Calendar calendar = Calendar.getInstance();
		System.out.println(calendar);
		System.out.println(calendar.getTimeInMillis()); // 就是当前时间
		// 先定位到第8天 
		calendar.set(Calendar.DAY_OF_YEAR,
				calendar.get(Calendar.DAY_OF_YEAR) + 7);
		
		long timer = calendar.getTimeInMillis();
		// 转成标准时间格式
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd EEE");
		dates.add(sdf.format(timer));
		for (int i = 0; i < 6; i++) {
			calendar.set(Calendar.DAY_OF_YEAR,
					calendar.get(Calendar.DAY_OF_YEAR) + 1);
			long timer1 = calendar.getTimeInMillis();
			dates.add(sdf.format(timer1));
		}
		return dates;
	}
	
	// 从第二天开始 的未来7天
		public static List<String> get2FutureSevenDates() {
			// 查询出未来七天的日期
			// List<String>
			List<String> dates = new ArrayList<>();
			// 定义一个日历对象
			Calendar calendar = Calendar.getInstance();
			System.out.println(calendar);
			System.out.println(calendar.getTimeInMillis()); // 就是当前时间
			// 先定位到第2天 
			calendar.set(Calendar.DAY_OF_YEAR,
					calendar.get(Calendar.DAY_OF_YEAR) + 1);
			
			long timer = calendar.getTimeInMillis();
			// 转成标准时间格式
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd EEE");
			dates.add(sdf.format(timer));
			for (int i = 0; i < 6; i++) {
				calendar.set(Calendar.DAY_OF_YEAR,
						calendar.get(Calendar.DAY_OF_YEAR) + 1);
				long timer1 = calendar.getTimeInMillis();
				dates.add(sdf.format(timer1));
			}
			return dates;
		}
	
	public static List<String> getFutureSevenDates() {
		// 查询出未来七天的日期
		// List<String>
		List<String> dates = new ArrayList<>();
		// 定义一个日历对象
		Calendar calendar = Calendar.getInstance();
		System.out.println(calendar);
		System.out.println(calendar.getTimeInMillis()); // 就是当前时间
		long timer = calendar.getTimeInMillis();
		// 转成标准时间格式
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd EEE");
		dates.add(sdf.format(timer));
		for (int i = 0; i < 6; i++) {
			calendar.set(Calendar.DAY_OF_YEAR,
					calendar.get(Calendar.DAY_OF_YEAR) + 1);
			long timer1 = calendar.getTimeInMillis();
			dates.add(sdf.format(timer1));
		}
		return dates;
	}

	
}
