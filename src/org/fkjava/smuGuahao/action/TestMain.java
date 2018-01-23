package org.fkjava.smuGuahao.action;

import java.text.SimpleDateFormat;
import java.util.Calendar;

public class TestMain {
	public static void main(String[] args) {
		Calendar calendar = Calendar.getInstance();
		System.out.println(calendar);
		System.out.println(calendar.getTimeInMillis()); // ���ǵ�ǰʱ�� 
		long timer = calendar.getTimeInMillis();
		// ת�ɱ�׼ʱ���ʽ
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd EEE");
		System.out.println(sdf.format(timer));
		for(int i = 0 ; i < 6 ; i++ ){
			calendar.set(Calendar.DAY_OF_YEAR, calendar.get(Calendar.DAY_OF_YEAR) +  1);
			long timer1 = calendar.getTimeInMillis();
			System.out.println(sdf.format(timer1));
		}
	}
}

