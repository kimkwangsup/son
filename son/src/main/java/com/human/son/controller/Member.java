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
	 * 濡쒓렇�씤 �솕硫� 蹂닿린 �슂泥� �쟾�떞 泥섎━�븿�닔
	 */
	@RequestMapping("/login.son")
	public ModelAndView login(HttpSession session, ModelAndView mv, RedirectView rv) {
		String view = "/member/login";
		if(session.getAttribute("SID") != null) {
			view = "/main.son";
			rv.setUrl(view);
			mv.setView(rv); // 由щ떎�씠�젆�듃
		} else {
			mv.setViewName(view); // �룷�썙�뱶
		}
		return mv;
	}
	@RequestMapping("/loginProc.son")
	public ModelAndView loginProc(HttpSession session, ModelAndView mv, RedirectView rv, MemberVO mVO/*, String id, String pw*/) {
		String view = "/main.son";
		if(session.getAttribute("SID") != null) {
			// �씠誘� 濡쒓렇�씤 �븳 寃쎌슦
			rv.setUrl(view);
			mv.setView(rv);
			return mv;
		}
		// 濡쒓렇�씤 �븞�맂寃쎌슦
		// �뜲�씠�꽣踰좎씠�뒪議고쉶
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
	 * 濡쒓렇�븘�썐 �슂泥� �쟾�떞 泥섎━ �븿�닔
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
	 * �쉶�썝媛��엯 �뤌蹂닿린 �슂泥� �쟾�떞 泥섎━�븿�닔
	 */
	@RequestMapping("/join.son")
	public ModelAndView join(ModelAndView mv, HttpSession session, RedirectView rv) {
		String view = "/main.son";
		// �꽭�뀡寃��궗
		if(session.getAttribute("SID") != null) {
			// �씠誘� 濡쒓렇�씤 �릺�뼱�엳�뒗 寃쎌슦
			rv.setUrl(view);
			mv.setView(rv); // 由щ떎�씠�젆�듃
		}else {
			// 濡쒓렇�씤 �븞�맂 寃쎌슦
			mv.setViewName("member/join"); // �룷�썙�뱶
		}
		return mv;
	}
	/**
	 * �븘�씠�뵒泥댄겕 泥섎━�슂泥� �븿�닔
	 */
	@RequestMapping("/idCheck.son")
	@ResponseBody
	public HashMap idCheck(String id) {
		HashMap map = new HashMap();
		// �뜲�씠�꽣踰좎씠�뒪 議고쉶
		int cnt = mDao.idCheck(id);
		String result = "NO";
		if(cnt == 0) {
			result = "YES";
		}
		map.put("result", result);
		return map;
	}
	/**
	 * �쉶�썝媛��엯 泥섎━ �슂泥� �쟾�떞 泥섎━�븿�닔
	 */
	@RequestMapping("/joinProc.son")
	public ModelAndView joinProc(HttpSession session, ModelAndView mv, RedirectView rv, MemberVO mVO) {
		String view = "/main.son";
		if(session.getAttribute("SID") != null) {
			rv.setUrl(view);
			mv.setView(rv);
		}else {
			// �뜲�씠�꽣踰좎씠�뒪 �옉�뾽
			int cnt = mDao.addMemb(mVO);
			// 酉� �꽭�똿�븯怨�
			if(cnt == 1) {
				// �쉶�썝媛��엯�뿉 �꽦怨듯븳 寃쎌슦
				// �꽭�뀡�뿉 �븘�씠�뵒 湲곗뼲�떆�궎怨� 
				session.setAttribute("SID", mVO.getId());
				rv.setUrl(view);
			}else {
				
				// �쉶�썝媛��엯�뿉 �떎�뙣�븳 寃쎌슦
				rv.setUrl("/member/join.son");
			}
			mv.setView(rv);
		}
		return mv;
	}
	public ModelAndView memberList(HttpSession session, ModelAndView mv, RedirectView rv, MemberVO mVO) {
		// 할일
		// 뷰 정하고
		String view = "member/memberList";
		// 로그인 검사
		if(session.getAttribute("SID") == null) {
			// 로그인 안한경우
			rv.setUrl("/member/login.son");
			mv.setView(rv);
		}else {
			// 데이터베이스 조회
			
		}
		return mv;
	}
}
