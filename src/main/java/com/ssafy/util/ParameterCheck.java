package com.ssafy.util;

public class ParameterCheck {
	private static boolean isNumber(String str) {
		boolean isNum = true;
		if(str == null || str.length() == 0)
			isNum = false;
		else {
			for (int i = 0; i < str.length(); i++) {
				int num = str.charAt(i) - 48;
				if(num < 0 || num > 9) {
					isNum = false;
					break;
				}
			}
		}
		return isNum;
	}
	
	public static String nullToBlank(String str) {
		return str == null ? "" : str;
	}
	
	public static int notNumberToOne(String str) {
		if(isNumber(str))
			return Integer.parseInt(str);
		else
			return 1;
	}
}
