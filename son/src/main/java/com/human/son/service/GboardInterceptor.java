package com.human.son.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.human.son.dao.GboardDao;

public class GboardInterceptor implements HandlerInterceptor {
	@Autowired
	GboardDao gDao;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		String sid = (String) session.getAttribute("SID");
		if(sid == null) {
			// 이미 로그인 되어있는 경우
			response.sendRedirect("/member/login.son");
			return false; // 클라이언트의 요청 처리함수를 실행하면 안된다.
		}
		int cnt = gDao.getCnt(sid);
		if(cnt == 1) {
			response.sendRedirect("/gboard/gboard.son");
			return false;
		}
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {}

}
