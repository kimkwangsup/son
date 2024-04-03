package com.human.son.controller;

import java.util.*;

import javax.servlet.http.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.*;
import org.springframework.web.servlet.view.*;

import com.human.son.dao.MemberDao;
import com.human.son.vo.MemberVO;

@Controller
@RequestMapping("/member")
public class Member {
	@Autowired
	MemberDao mDao;
	/**
	 * 로그인 화면 보기 요청 전담 처리함수
	 */
	@RequestMapping("/login.son")
	public ModelAndView login(HttpSession session, ModelAndView mv, RedirectView rv) {
		String view = "/member/login";
		if(session.getAttribute("SID") != null) {
			view = "/main.son";
			rv.setUrl(view);
			mv.setView(rv); // 리다이렉트
		} else {
			mv.setViewName(view); // 포워드
		}
		return mv;
	}
	@RequestMapping("/loginProc.son")
	public ModelAndView loginProc(HttpSession session, ModelAndView mv, RedirectView rv, MemberVO mVO/*, String id, String pw*/) {
		String view = "/main.son";
		if(session.getAttribute("SID") != null) {
			// 이미 로그인 한 경우
			rv.setUrl(view);
			mv.setView(rv);
			return mv;
		}
		// 로그인 안된경우
		// 데이터베이스조회
		int cnt = mDao.getLogin(mVO);
		if(cnt != 1) {
			view = "/member/login.son";
		}else {
			session.setAttribute("SID", mVO.getId());
		}
		rv.setUrl(view);
		mv.setView(rv);
		return mv;
	}
//	@RequestMapping("/logoutProc.son")
//	public String logoutProc(HttpSession session) {
//		String view = "/main";
//		if(session.getAttribute("SID") != null) {
//			session.removeAttribute("SID");
//		}
//		return view;
//	}
	/**
	 * 로그아웃 요청 전담 처리 함수
	 */
	@RequestMapping("/logoutProc.son")
	public ModelAndView logoutProc(ModelAndView mv, HttpSession session, RedirectView rv) {
		String view = "/main.son";
		if(session.getAttribute("SID") != null) {
			session.removeAttribute("SID");
		}
		rv.setUrl(view);
		mv.setView(rv);
		return mv;
	}
	/**
	 * 회원가입 폼보기 요청 전담 처리함수
	 */
	@RequestMapping("/join.son")
	public ModelAndView join(ModelAndView mv, HttpSession session, RedirectView rv) {
		String view = "/main.son";
		// 세션검사
		if(session.getAttribute("SID") != null) {
			// 이미 로그인 되어있는 경우
			rv.setUrl(view);
			mv.setView(rv); // 리다이렉트
		}else {
			// 로그인 안된 경우
			mv.setViewName("member/join"); // 포워드
		}
		return mv;
	}
	/**
	 * 아이디체크 처리요청 함수
	 */
	@RequestMapping("/idCheck.son")
	@ResponseBody
	public HashMap idCheck(String id) {
		HashMap map = new HashMap();
		// 데이터베이스 조회
		int cnt = mDao.idCheck(id);
		String result = "NO";
		if(cnt == 0) {
			result = "YES";
		}
		map.put("result", result);
		return map;
	}
	/**
	 * 회원가입 처리 요청 전담 처리함수
	 */
	@RequestMapping("/joinProc.son")
	public ModelAndView joinProc(HttpSession session, ModelAndView mv, RedirectView rv, MemberVO mVO) {
		String view = "/main.son";
		if(session.getAttribute("SID") != null) {
			rv.setUrl(view);
			mv.setView(rv);
		}else {
			// 데이터베이스 작업
			int cnt = mDao.addMemb(mVO);
			// 뷰 세팅하고
			if(cnt == 1) {
				// 회원가입에 성공한 경우
				// 세션에 아이디 기억시키고 
				session.setAttribute("SID", mVO.getId());
				rv.setUrl(view);
			}else {
				
				// 회원가입에 실패한 경우
				rv.setUrl("/member/join.son");
			}
			mv.setView(rv);
		}
		return mv;
	}
}
