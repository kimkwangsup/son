package com.human.home;

import java.util.*;

public class Test01 {
	public Test01() {
		int[] nums = {1,2,3,4,5};
		List list = Arrays.asList(nums);
		for(int i = 0 ; i < list.size(); i++) {
			System.out.println(list.get(i));
		}
	}
	public static void main(String[] args) {
		new Test01();
	}
}
